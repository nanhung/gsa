library(sensitivity)
library(ViSA)
library(dplyr)

repfast(fun = sobol.fun, n=100, factors = 8, q = "qunif",
           q.arg = list(min = 0, max = 1), rep=100, ci=.95) %>% converge
