library(ViSA)
library(dplyr)
library(deSolve)
library(sensitivity)

####


n <- 4000
set.seed(1234)
X1 <- data.frame(matrix(runif(8 * n), nrow = n))
X2 <- data.frame(matrix(runif(8 * n), nrow = n))
x <- soboljansen(model = NULL, X1, X2, nboot = 100)
y <- sobol.fun(x$X)
tell(x,y) %>% converge

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

tell(x, y[,,1])

x

x %>% plot; abline(0.01, 0, lty = 2)

x %>% converge # broke

##### the Verhulst model of population dynamics

Verhulst <- function(parameters, times)
{
  output <- parameters[1]/(1 + (parameters[1]/parameters[2] - 1) * exp(-parameters[3] * times))
  return(output)
}

#
q = "qunif"
q.arg = list(list(min=100, max=1000), 
             list(min=1, max=40),
             list(min = 0.05, max = 0.2))

set.seed(1234)
x<-rfast99(factors=c("K","Y0","a"),
           n = 400, q = q, q.arg = q.arg, rep = 10, conf = 0.99)

times <- seq(from = 5, to = 100, by = 5)

y<-solve_DE(x, times, model = Verhulst)

tell2(x,y)


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

y<-solve_DE(x, times, parameters = parameters, initState,
             func = "derivs1comp", jacfunc = "jac1comp", initfunc = "initmod1comp", outnames = "Ccompartment")

tell2(x,y)

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

#####

for ( i in 1:dim(y)[3]){
  tell.rfast99(x, y[,,i]) %>% plot; abline(0.01, 0, lty = 2); abline(0.01, 0, lty = 2); abline(0.05, 0, lty = 3)
  mtext(paste("Time = ", dimnames(y)[[3]][i],"hr")) 
}

####
tell(x, y[,,1]) %>% converge
tell(x, y[,,2]) %>% converge
tell(x, y[,,3]) %>% converge
tell(x, y[,,4]) %>% converge

