library(sensitivity)
source("fast.rep.R")

#
n <- 100
rep <- 100
set.seed(1234)
x<-fast99(model = NULL, factors = 8, n = n,
          q = "qunif", q.arg = list(min = 0, max = 1))
x<-fast.rep(n, rep) # seed = 1234, convergence index = c(0.3379, 0.2484)


#
set.seed(1234); rep.fast(n=200, rep) # convergence index = c(0.0837, 0.0649)
set.seed(1234); rep.fast(n=400, rep) # convergence index = c(0.0831, 0.0633)
set.seed(1234); rep.fast(n=800, rep) # convergence index = c(0.0692, 0.0516)
set.seed(1234); rep.fast(n=1600, rep) # convergence index = c(0.0324, 0.0265)

#
set.seed(1234); rep.fast(n=200, rep, ci=.99) #  seed = 1234, convergence index = c(0.0969, 0.0698)




plot.rep.fast <- function(x, ylim = c(0, 1), ...) {
  
  plot(Median)
}





library(boot)
n <- 1000
X1 <- data.frame(matrix(runif(8 * n), nrow = n))
X2 <- data.frame(matrix(runif(8 * n), nrow = n))
x <- soboljansen(model = NULL, X1, X2, nboot = 100)
y <- sobol.fun(x$X)
tell(x, y)
x

print(x)