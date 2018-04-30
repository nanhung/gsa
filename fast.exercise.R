library(sensitivity) # sobol.fun
library(ViSA)
library(dplyr)
library(deSolve)


set.seed(1234)
x<-rfast99(factors = 40, n = 100,
           q = "qunif", q.arg = list(min = 0, max = 1), replicate = 10, conf = 0.99)




n <- length(x$s)
factors <- length(x$factors)
replicate <- x$replicate

y <- array(1:replicate*n*factors, dim = c(n * factors, replicate))

for (i in 1 : x$rep) {
  y[,i]<-sensitivity::sobol.fun(x$a[,i,]) 
}

tell(x, y)

x

x %>% plot; abline(0.01, 0, lty = 2)

x %>% converge

#####

source("pbtk1comp_inits.R")

mName <- "pbtk1comp"
system (paste("R CMD SHLIB ", mName, ".c", sep = "")) # create .o and .so files
if (is.loaded("derivs", PACKAGE=mName))
  dyn.unload(paste0(mName,.Platform$dynlib.ext))
dyn.load(paste(mName, .Platform$dynlib.ext, sep=""))


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

y<-solve_ODE(x, times, parameters = parameters, initState,
             func = "derivs1comp", jacfunc = "jac1comp", initfunc = "initmod1comp", outnames = "Ccompartment")

## Check each time point; time = 0.5
# tell(x, y[,,"0.5"]) %>% converge
# x

#####

tell2 <- function(x, y){
  
  id <- deparse(substitute(x))

  for ( i in 1:length(dimnames(y)[[3]])){
    X <- tell(x, y[,,i])
    if ( i == 1) { # initialize
      x$mSI <- X$S[,"original"]
      x$tSI <- X$T[,"original"]
      x$mCI <- X$S[,"max. c.i."] - X$S[,"min. c.i."]
      x$tCI <- X$T[,"max. c.i."] - X$T[,"min. c.i."]
    } else { # accumulate
      x$mSI <- rbind(x$mSI, X$S[,"original"])
      x$tSI <- rbind(x$tSI, X$T[,"original"])
      x$mCI <- rbind(x$mCI, X$S[,"max. c.i."] - X$S[,"min. c.i."])
      x$tCI <- rbind(x$tCI, X$T[,"max. c.i."] - X$T[,"min. c.i."])
    }
  }
  colnames(x$mSI) <- colnames(x$tSI) <- colnames(x$mCI) <- colnames(x$tCI) <- rownames(x$S)
  rownames(x$mSI) <- rownames(x$tSI) <- rownames(x$mCI) <- rownames(x$tCI) <- dimnames(y)[[3]]
  
  x$S<-NULL
  x$I<-NULL
  x$T<-NULL
  
  assign(id, x, parent.frame())
}

a<-tell2(x,y)

plot(rownames(x$mSI), x$mSI[,1], ylim=c(0,1), type="l", xlab="Time", ylab = "Sensitivity index")
lines(rownames(x$mSI), x$mSI[,2])
lines(rownames(x$mSI), x$mSI[,3])
abline(0.05, 0, lty = 2); abline(0.01, 0, lty = 3)

plot(rownames(x$tSI), x$tSI[,1], ylim=c(0,1), type="l", xlab="Time", ylab = "Sensitivity index")
lines(rownames(x$tSI), x$tSI[,2])
lines(rownames(x$tSI), x$tSI[,3])
abline(0.05, 0, lty = 2); abline(0.01, 0, lty = 3)

#####

for ( i in 1:dim(y)[3]){
  tell(x, y[,,i]) %>% plot; abline(0.01, 0, lty = 2); abline(0.01, 0, lty = 2); abline(0.05, 0, lty = 3)
  mtext(paste("Time = ", dimnames(y)[[3]][i],"hr")) 
}

####
tell(x, y[,,1]) %>% converge
tell(x, y[,,2]) %>% converge
tell(x, y[,,3]) %>% converge
tell(x, y[,,4]) %>% converge

