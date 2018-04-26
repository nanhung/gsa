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

par(mar=c(3,5,2,1) ,oma=c(4,1,1,0))

for ( i in 1:dim(y)[3]){
  tell(x, y[,,i]) %>% plot; abline(0.01, 0, lty = 2); abline(0.01, 0, lty = 2); abline(0.05, 0, lty = 3)
  mtext(paste("Time = ", dimnames(y)[[3]][i],"hr")) 
}

tell(x, y[,,i]) %>% plot; abline(0.01, 0, lty = 2); abline(0.01, 0, lty = 2); abline(0.05, 0, lty = 3)
mtext(paste("Time = ", dimnames(y)[[3]][i],"hr")) 


p<-dim(x$a)[3]
mtext(print(round(x$S[,1], digits = 2)), 1, line=3, at=c(1:p), col= "grey50")
mtext(print(round(I, digits = 2)), 1, line=4, at=c(1:p), col= "grey30")
mtext(print(round(x$T[,1], digits = 2)), 1, line=5, at=c(1:p))


mtext("main", side=1, line=0, adj=.0, cex=1, font = 2, outer=TRUE)  
mtext("interaction", side=1, line=1, adj=.0, cex=1, font = 2, outer=TRUE)  
mtext("total", side=1, line=2, adj=.0, cex=1, font = 2, outer=TRUE)  


mtext(print(round(x$S[,1], digits = 2)), 1, line=3, at=c(1,2,3))

mtext(c("A","B","C"),1,line=3,at=c(1,2,3))
mtext(c("A","B","C"),1,line=3,at=c(1,2,3))
mtext(c("A","B","C"),1,line=4,at=c(1,2,3))
mtext(c("A","B","C"),1,line=5,at=c(1,2,3))

##
for ( i in 1:length(times)){
  if ( i == 1) { # initialize
    results <- tell(x, y[,,i])$S[,"original"]
  } else { # accumulate
    results <- rbind(results, tell(x, y[,,i])$S[,"original"])
  }
}
colnames(results) <- names(parameters)
rownames(results) <- times


plot(rownames(results), results[,1], ylim=c(0,1), type="l", xlab="Time", ylab = "Sensitivity index")
lines(rownames(results), results[,2])
lines(rownames(results), results[,3])
abline(0.01, 0, lty = 2)



tell(x, y[,,1]) %>% converge
tell(x, y[,,2]) %>% converge
tell(x, y[,,3]) %>% converge
tell(x, y[,,4]) %>% converge

