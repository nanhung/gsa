# devtools::install_github("nanhung/ViSA")

library(rfast99)
library(dplyr)
library(deSolve)
#library(ggplot2)
# sensitivty

#### Sobol model

set.seed(1234)
x<-rfast99(factors = 20, n = 100,
           q = "qunif", q.arg = list(min = 0, max = 1), replicate = 10, conf = 0.99)

n <- length(x$s)
factors <- x$factors
replicate <- x$replicate

out <- 1 # Not time dependent

y <- array(dim = c(n * factors, replicate, out), NA)

for (i in 1 : x$rep) {
  y[,i,]<-sensitivity::sobol.fun(x$a[,i,]) 
}

tell.rfast99(x, y[,,1])

x %>% plot; abline(0.01, 0, lty = 2) 

x %>% ViSA::converge # Not used

####

set.seed(1234)
x<-rfast99(factors = 20, n = 1000,
           q = "qunif", q.arg = list(min = 0, max = 1), replicate = 10, conf = 0.99)

y<-solve_fun(x, model = sobol.fun)

tell2(x, y)


check(x)
check(x, SI = 0.05, CI = 0.05)

## Flip-Flop Kinetics ####
FFPK <- function(parameters, times, dose = 500){
  A <- (dose * parameters[1])/( parameters[3]*( parameters[1]- parameters[2]))
  CONC <- A*exp(- parameters[2] * times) - A*exp(- parameters[1] * times)
  return(CONC)
}

q = "qunif"
q.arg = list(list(min = 0.2, max = 1), 
             list(min = 0.2, max = 1),
             list(min = 1, max = 5))

set.seed(1234)
x<-rfast99(factors=c("KA","KE","V"),
           n = 4000, q = q, q.arg = q.arg, rep = 10, conf = 0.99)

times <- seq(from = 0.5, to = 24, by = 0.5)

y<-solve_fun(x, model = FFPK, times = times)

tell2(x,y)

check.rfast99(x)
check.rfast99(x, SI = 0.05, CI = 0.05)


plot(x)

  

##### MCSim under R (use deSolve package)
# pros: Don't need to create in file
# cons: ?

compile <- function (mName)
  if (.Platform$OS.type == "windows") {
    message("The current function haven't supprot Windows system")
  } else {  # Unix; good luck
    if (is.loaded("derivs", PACKAGE=mName))
      dyn.unload(paste0(mName,.Platform$dynlib.ext))
    if(file.exists(paste0(mName, ".model"))){
      system (paste0("mod -R ", mName, ".model ", mName,".c")) # model to c file
    }
    system (paste0("R CMD SHLIB ", mName, ".c")) # create .o and .so files
    dyn.load(paste(mName, .Platform$dynlib.ext, sep=""))
    
    if(file.exists(paste0(mName, "_inits.R"))){
      source(paste0(mName, "_inits.R"))
    }
  }

mName = "pbtk1comp"
compile(mName)

q = "qunif"
q.arg = list(list(min = 0.7, max = 1.3),
             list(min = 0.1, max = 0.4),
             list(min = 0.9, max = 1.2))

x<-rfast99(factors = c("vdist", "ke", "kgutabs"),
           n = 100, q = q, q.arg = q.arg, rep = 10, conf = 0.99)

times <- seq(from = 0.5, to = 24.5, by = 1)
parameters<-initparms1comp()
initState <- initState1comp(parms=parameters)
initState[1] <- 1

y<-solve_fun(x, times, parameters = parameters, initState, outnames = "Ccompartment",
             dllname = mName, func = "derivs1comp", jacfunc = "jac1comp", initfunc = "initmod1comp")

tell2(x,y)


check(x)
check(x, SI = 0.05, CI = 0.05)


####

q = "qunif"
q.arg = list(list(min = 0.7, max = 1.3),
             list(min = 0.1, max = 0.4),
             list(min = 0.9, max = 1.2))





## Check each time point; time = 0.5
# tell(x, y[,,"0.5"]) %>% converge
# x

#####

plot(rownames(x$mSI), x$mSI[,1], ylim=c(0,1), type="l", xlab="Time", ylab = "Sensitivity index")
lines(rownames(x$mSI), x$mSI[,2])
lines(rownames(x$mSI), x$mSI[,3])
abline(0.05, 0, lty = 2); abline(0.01, 0, lty = 3)

plot(rownames(x$tSI), x$tSI[,1], ylim=c(0,1), type="l", xlab="Time", ylab = "Sensitivity index")
lines(rownames(x$tSI), x$tSI[,2])
lines(rownames(x$tSI), x$tSI[,3])
abline(0.05, 0, lty = 2); abline(0.01, 0, lty = 3)


####
library(ggplot2)


##
# X <- tidy_index(x, index = "SI") 
ggfast(x, index = "SI")
ggfast(x, index = "CI")



###

