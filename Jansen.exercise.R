# rm(list=ls())
# devtools::install_github("nanhung/ViSA")

library(ViSA)
library(sensitivity)
library(tidyverse)

n <- 4000
set.seed(1234)
X1 <- data.frame(matrix(runif(8 * n), nrow = n))
X2 <- data.frame(matrix(runif(8 * n), nrow = n))
x <- soboljansen(model = NULL, X1, X2, nboot = 100)
y <- sobol.fun(x$X)
tell(x,y)
x

#
tell(x,y) %>% plot
abline(0.01, 0 ,lty=2)

#
tell(x,y) %>% converge

#
set.seed(1234)
convergejansen(n = 1000, n.factors = 8, X = sobol.X, fun = sobol.fun) 

set.seed(1234)
convergejansen(n = 1000, n.factors = 8, X = sobol.X, fun = sobol.fun) %>% 
  converge.plot

set.seed(1234)
convergejansen(n = 1000, n.factors = 8, X = sobol.X, fun = sobol.fun) %>% 
  converge.plot(index = "M-ci")
set.seed(1234)
convergejansen(n = 1000, n.factors = 8, X = sobol.X, fun = sobol.fun) %>% 
  converge.plot(index = "M-si")
set.seed(1234)
convergejansen(n = 1000, n.factors = 8, X = sobol.X, fun = sobol.fun) %>% 
  converge.plot(index = "T-si")

#
test.X<- function(n){
  data.frame(k01 = runif(n, 0, 1),
             k12 = runif(n, 0, 1),
             k23 = runif(n, 0, 1),
             k34 = runif(n, 0, 1),
             k45 = runif(n, 0, 1),
             k56 = runif(n, 0, 1),
             k67 = runif(n, 0, 1),
             k78 = runif(n, 0, 1),
             k89 = runif(n, 0, 1),
             k90 = runif(n, 0, 1))
}

#set.seed(1234)
convergejansen(n = 4000, n.factors = 10, X = test.X, fun = sobol.fun) %>% 
  converge.plot()
convergejansen(n = 4000, n.factors = 10, X = test.X, fun = sobol.fun) %>% 
  converge.plot(index = "M-ci")
convergejansen(n = 4000, n.factors = 10, X = test.X, fun = sobol.fun) %>% 
  converge.plot(index = "T-si")
convergejansen(n = 4000, n.factors = 10, X = test.X, fun = sobol.fun) %>% 
  converge.plot(index = "M-si")