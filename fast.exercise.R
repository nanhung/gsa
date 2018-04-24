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
x %>% plot; abline(0.01, 0, lty = 2)

x %>% converge



