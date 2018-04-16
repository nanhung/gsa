# MCSim under R (Delay differentials example) 
# The exercise was sourced from the example file in MCSim 6.0.0. 

library(deSolve)

system("mod -R perc_delay.model perc_delay.c") # create perc_delay.c and perc_delay_inits.R
system("R CMD SHLIB perc_delay.c") # create perc_delay.o and perc_delay_inits.so
dyn.load(paste0("perc_delay",.Platform$dynlib.ext))
source("perc_delay_inits.R") # create Outputs initParms initStats

# Define new parameter / replace the default value
# Use the delayed time = 100 min, inhaled concentration = 72 ppm, exposure duration = 240 min (4 hr)  
newParms <- c(InhMag = 10, Period=1e10, Exposure=240, tau=100) 

parms <- initParms(newParms=newParms)
Y <- initStates(parms=parms) # use the default output variable

# Build Periodic dose

mag <- parms["InhMag"] # Set input
period <- 1e10
inittime <- 0
exposuretime <- 239.99999
times <- c(0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 
             160, 170, 180, 190, 200, 210, 220, 230, 239.99, 240, 250, 260, 270, 
             280, 290, 300, 310, 320, 330, 339.9, 340, 350)

mintime <- min(times)
maxtime <- max(times)
nperiods <- ceiling(maxtime / period) + 1

col1 <- rep(inittime, 2 * nperiods)
I <- 1:length(col1)
J <- which(I %% 2 == 1)
col1[J]  <- col1[J] + (ceiling((J / 2)) - 1) * period
J <- which(I %% 2 == 0)
col1[J] <- col1[J-1] + exposuretime
PerDose <- cbind(col1, rep(c(mag,0), length(col1)/2))

# Plot periodic dose
plot(PerDose[1:2,], type = "s", xlim=c(0,maxtime), main = "C_inh", xlab = "Time (min)")

# Without constant dose
mag1 <- 0
ConstDose1 <- rbind(c(min(times), mag1), c(max(times) + 1, 0))

## Add code to implement in the inputs built into the model.
Forcings1 <- list(PerDose, ConstDose1)

out1 <- dede(Y, times, func="derivs", parms=parms, dllname="perc_delay",
            initfunc="initmod", nout=length(Outputs), outnames=Outputs,
            initforc="initforc",
            fcontrol=list(method="constant", rule=1, f=0),
            forcings=Forcings1)

# With constant dose

# 1 ppm = 0.02846084 mg (1 / 72.0 / 0.488) 72 ppm = .488 mg/l

mag2 <- 10 / 72.0 / 0.488 # Note the unit mag2 is not ppm but mg
ConstDose2 <- rbind(c(min(times), mag2), c(max(times) + 1, 0))
Forcings2 <- list(PerDose, ConstDose2)
out2 <- dede(Y, times, func="derivs", parms=parms, dllname="perc_delay",
            initfunc="initmod", nout=length(Outputs), outnames=Outputs,
            initforc="initforc",
            fcontrol=list(method="constant"),
            forcings=Forcings2)

stop_point <- which(out1[,"time"] == 240)

Q_tot1 <- out1[,"Q_tot"][stop_point]
Q_tot2 <- out2[,"Q_tot"][stop_point] 
(Q_tot2 - Q_tot1)/240

# 1 mg

# Cmompare the simulation result
par(mfrow = c(3,5), mar = c(4,3,3,2))
for(i in 2:ncol(out1)){
  plot(out2[,1], out2[,i], type="l", xlab = "Time", ylab="" , 
       col = 2, main = names(out1[3,i])) 
  lines(out1[,1], out1[,i], type="l", col =3)
}
  