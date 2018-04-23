library(sensitivity) # sobol.fun
library(ViSA)
library(dplyr)

#repfast(fun = sobol.fun, n=100, factors = 8, q = "qunif",
#           q.arg = list(min = 0, max = 1), rep=100, ci=.95) %>% converge

#repfast(fun = NULL, n=100, factors = 8, q = "qunif",
#        q.arg = list(min = 0, max = 1), rep=100, ci=.95)



# library(foreach)
x<-rfast99(factors = 8, n = 1000,
           q = "qunif", q.arg = list(min = 0, max = 1), rep = 10)

n <- length(x$s)
factors <- x$factors
replicate <- x$rep

y <- array(1:replicate*n*factors, dim = c(n * factors, replicate))

for (i in 1 : x$rep) {
  y[,i]<-sensitivity::sobol.fun(x$a[,i,]) 
}

tell(x, y)

x



