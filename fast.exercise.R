library(sensitivity) # sobol.fun
library(ViSA)
library(dplyr)

set.seed(1234)
x<-rfast99(factors = 40, n = 100,
           q = "qunif", q.arg = list(min = 0, max = 1), rep = 10, conf = 0.99)

n <- length(x$s)
factors <- x$factors
replicate <- x$rep

y <- array(1:replicate*n*factors, dim = c(n * factors, replicate))

for (i in 1 : x$rep) {
  y[,i]<-sensitivity::sobol.fun(x$a[,i,]) 
}

tell(x, y)

x

x %>% plot; abline(0.01, 0, lty = 2)

x %>% converge

#####
q = "qunif"
q.arg = list(list(min = 0.7, max = 1.3),
             list(min = 0.1, max = 0.4),
             list(min = 0.1, max = 0.4))

x<-rfast99(factors = c("vdist", "ke", "kgutabs"),
           n = 100, q = q, q.arg = q.arg, rep = 10, conf = 0.99)

n <- length(x$s)
factors <- length(x$factors)
replicate <- x$rep
y <- array(1:replicate*n*factors, 
           dim = c(n * factors, replicate))

#
for (i in 1 : x$rep) { # replicate
  for (j in 1:dim(y)[1]) { # Model evaluation
    
    parameters["vdist"] <- x$a[j,i,"vdist"]
    parameters["ke"] <- x$a[j,i,"ke"]
    parameters["kgutabs"] <- x$a[j,i,"kgutabs"]
    
    # Add time
    input_times = c(0, 1)
    
    # Integrate
    tmp <- ode(Y, input_times, func = "derivs1comp", parms = parameters, 
               jacfunc = "jac1comp", dllname = mName, 
               initfunc = "initmod1comp", nout = 1, outnames = "Ccompartment")
    y[j,i] <- tmp[2, "Ccompartment"]
  }
}

tell(x, y)

x

x %>% plot; abline(0.01, 0, lty = 2)

x %>% converge

