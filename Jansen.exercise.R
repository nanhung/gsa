# rm(list=ls())
# devtools::install_github("nanhung/ViSA")

library(ViSA)
library(sensitivity)
library(tidyverse)

n <- 1000
X1 <- data.frame(matrix(runif(8 * n), nrow = n))
X2 <- data.frame(matrix(runif(8 * n), nrow = n))
x <- soboljansen(model = NULL, X1, X2, nboot = 100)
y <- sobol.fun(x$X)

tell(x,y)

tell(x,y) %>% converge()

#
parameters<-c("k01","k12", "k23", "k34", "k45","k56", "k67", "k78")

tell(x,y) %>% converge(parameters)



#
set.seed(1234)
convergejansen(n = 1000, n.factors = 8, X = sobol.X, fun = sobol.fun) 

set.seed(1234)
convergejansen(n = 1000, n.factors = 8, X = sobol.X, fun = sobol.fun) %>% 
  converge.plot

set.seed(1234)
convergejansen(n = 1000, n.factors = 8, X = sobol.X, fun = sobol.fun, order = "S") %>% 
  converge.plot

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

set.seed(1234)
convergejansen(n = 4000, n.factors = 10, X = test.X, fun = sobol.fun) %>% 
  converge.plot