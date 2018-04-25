library(deSolve)
library(dplyr)
source("pbtk1comp_inits.R")

mName <- "pbtk1comp"
system (paste("R CMD SHLIB ", mName, ".c", sep = "")) # create .o and .so files
dyn.load(paste(mName, .Platform$dynlib.ext, sep=""))


parameters<-initparms1comp()
parameters[1] <- 0.9
parameters[2] <- 0.1
parameters[3] <- 0.5
Y <- initState1comp(parms=parameters)
Y[1] <- 1



times<-c(seq(0.5,24.5,1))

out <- ode(Y, times, func = "derivs1comp", parms = parameters, 
           jacfunc = "jac1comp", dllname = mName, 
           initfunc = "initmod1comp", nout = 1, outnames = "Ccompartment")

for (iteration in 1:100) { # 100 Monte Carlo simulations…
  # Sample randomly some parameters
  parameters["vdist"] = rnorm(1, 1, 0.3)
  parameters["ke"] = rnorm(1, 0.1, 0.04)
  parameters["kgutabs"] = rnorm(1, 0.1, 0.04)
  # Reduce output times eventually. We only care about time 1440,
  # but time zero still needs to be specified
  times = c(0, 1)
  # Integrate
  tmp = out <- ode(Y, times, func = "derivs1comp", parms = parameters, 
                   jacfunc = "jac1comp", dllname = mName, 
                   initfunc = "initmod1comp", nout = 1, outnames = "Ccompartment")
  if (iteration == 1) { # initialize
    results = tmp[2,"Ccompartment"]
    sampled.parms = c(parameters["vdist"],
                      parameters["ke"],
                      parameters["kgutabs"])
  } else { # accumulate
    results = rbind(results, tmp[2,6])
    sampled.parms = rbind(sampled.parms,
                          c(parameters["vdist"],
                            parameters["ke"],
                            parameters["kgutabs"]))
  }
} # end Monte Carlo loop

plot(sampled.parms[,1], results[,1])
