# system.time(source("solvefun.R"))
y<-solve_fun(x, times, parameters = parameters, initParmsfun = "initParms", 
             initState = initState, outnames = outnames, dllname = mName,
             func = "derivs", initfunc = "initmod", output = output, method = "lsode",
             initforc="initforc", forcings=Forcings1)

# user   system  elapsed 
# 4517.225    0.823 4518.596 

y<-solve_MCSim(x, mName = mName, infile.name = infile.name, outfile.name = outfile.name, 
               parameters = factors, output = output, time = times, condition = conditions)

# user   system  elapsed 
# 1267.084  652.133 1917.641 
