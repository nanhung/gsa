import sys
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

from SALib.analyze import morris
from SALib.sample.morris import sample
from SALib.util import read_param_file
from SALib.plotting.morris import horizontal_bar_plot, covariance_plot, sample_histograms
import numpy as np

problem = read_param_file('apap58.txt')

param_values = sample(problem, N=1000, num_levels=5, grid_jump=3, optimal_trajectories=None) # converge when using 32,000; real 9m19.548s

param_df = np.column_stack((list(range(len(param_values))), param_values))

np.savetxt("apap_setpoint.dat", param_df, delimiter='\t',  header=" ", fmt='%1.4f')

import os
os.system('./mcsim.apap.pbpk_v2 apap.setpoint_v2.in')

import pandas as pd
Y = pd.read_csv("apap_setpoint.csv",delimiter='\t', usecols=['lnCPL_APAP_mcgL_1.1']).as_matrix()
#print Y.dtype.name
#print type(Y)
#print len(Y)
#print Y

Si = morris.analyze(problem, param_values, Y, conf_level=0.95,
                    print_to_console=True,
                    num_levels=5, grid_jump=3, num_resamples=100)
#print type(Si)
#print Si
#print 'Mu star conf:', Si['mu_star_conf']
#print 'Mu star:', Si['mu_star']
print 'Convergence index:', Si['mu_star_conf']/max(Si['mu_star'])
print 'Benchmark convergence index:', max(Si['mu_star_conf']/max(Si['mu_star']))

fig, (ax1, ax2) = plt.subplots(1, 2)
horizontal_bar_plot(ax1, Si,{}, sortby='mu_star', unit=r"tCO$_2$/year")
covariance_plot(ax2, Si, {}, unit=r"tCO$_2$/year")
fig.savefig('morris.png')

#fig2 = plt.figure()
#sample_histograms(fig2, param_values, problem, {'color':'y'})
#fig2.savefig('morris2.png')

# Heat Map
