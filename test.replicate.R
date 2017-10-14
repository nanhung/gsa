library(plyr)

fun <- function(r){
  x <- morris(model = morris.fun, factors = 20, r = r,
              design = list(type = "oat", levels = 5, grid.jump = 3))
  apply(x$ee, 2, function(x) mean(abs(x)))
}

normalize.max<-function(m){ # 1 for each col, 2 for each row
  M<-sweep(m, 1, apply(m, 1, min))/(sweep(m, 1, apply(m, 1, min))-sweep(m, 1, apply(m, 1, max)))
  max(apply(M, 2, max)- apply(M, 2, min)) 
} #Find max # use in GSA convergence test for morris


m<-do.call(rbind, rlply(100, fun(r=3000))) # replicate: 100; r = 1000
normalize.max(m)
