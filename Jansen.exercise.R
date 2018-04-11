library(boot)
library(gsacat)

n <- 4000
X1 <- data.frame(matrix(runif(8 * n), nrow = n))
X2 <- data.frame(matrix(runif(8 * n), nrow = n))
x <- soboljansen(model = NULL, X1, X2, nboot = 100)

y <- sobol.fun(x$X)

tell(x,y)

x$S


