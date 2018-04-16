converge <- function(data){
  
  diff <- as.data.frame(matrix(nrow = nrow(data$S), ncol = 2))
  row.names(diff) <- row.names(data$S)
  colnames(diff) <- c("first order","total order")
  diff[,1] <- data$S$`max. c.i.` - data$S$`min. c.i.`
  diff[,2] <- data$T$`max. c.i.` - data$T$`min. c.i.`
  
  data$diff <- diff
  data$S$diff <- data$S$`max. c.i.` - data$S$`min. c.i.`
  data$T$diff <- data$T$`max. c.i.` - data$T$`min. c.i.`
  
  p <- 2
  pch = c(21, 24)
  n <- nrow(data$S)
  at <- 1 : n
  ylim <- c(0, 1)
  xlim <- c(1, n)
  plot(0, xlim = xlim, ylim = ylim, axes = FALSE,
       xlab = "", ylab = "", type = "n")
  axis(side = 1, at = at, labels = rownames(data$S))
  axis(side = 2)
  points(data$S$diff, xlim = c(1, n + 1), ylim = ylim, pch = pch[1])
  points(data$T$diff, xlim = c(1, n + 1), ylim = ylim, pch = pch[2])
  abline(0.1, 0, lty = 2)
  abline(0.05, 0, lty = 3)
  box()
  legend(x = "topright", legend = c("main effect", "total effect"), pch = pch)
  cat("\nConvergence of the sensitivity indices:\n")
  cat("\nMaximum of first order:", row.names(data$diff)[which(data$diff[,1] == max(data$diff[,1]))], max(data$diff[,1]), "\n")
  cat("Maximum of total order:", row.names(data$diff)[which(data$diff[,2] == max(data$diff[,2]))], max(data$diff[,2]), "\n")
  cat("\n")
  print(data$diff)
}

n = 4000 
n.factors = 8
fun = sobol.fun
X<- function(n){
  data.frame(k01 = runif(n, 0, 1),
             k12 = runif(n, 0, 1),
             k23 = runif(n, 0, 1),
             k34 = runif(n, 0, 1),
             k45 = runif(n, 0, 1),
             k56 = runif(n, 0, 1),
             k67 = runif(n, 0, 1),
             k90 = runif(n, 0, 1))
}
nboot = 100
...

convergejansen <- function(n, n.factors, X, fun, nboot = 100){
  
  S_si <- as.data.frame(matrix(nrow = n.factors, ncol=0))
  T_ci <- S_ci <- T_si <- S_si
  
  for (n in seq(n/10, n, n/10)){
    X1 <- X(n)
    X2 <- X(n)
    x <- soboljansen(model = NULL, X1, X2, nboot) #
    y <- fun(x$X)
    tell(x,y)
    
    x$S$diff <- x$S$`max. c.i.` - x$S$`min. c.i.`
    x$T$diff <- x$T$`max. c.i.` - x$T$`min. c.i.`
    
    S_si <- cbind(S_si, x$S$original)
    T_si <- cbind(T_si, x$T$original)
    S_ci <- cbind(S_ci, x$S$diff)
    T_ci <- cbind(T_ci, x$T$diff)
  }
  names(S_si)<-names(T_si)<-names(S_ci)<-names(T_ci)<-seq(n/10, n, n/10)
  row.names(S_si)<-row.names(T_si)<-row.names(S_ci)<-row.names(T_ci)<-row.names(x$S)
  
  return(list(S_si = S_si, T_si = T_si, S_ci = S_ci, T_ci = T_ci))
}



trace <- function(data, index = "T-ci"){
  
  x<-as.numeric(names(data$S_ci))
  
  if (index == "M-ci"){
    plot(x, data$S_ci[1,], type = "b", xlab = "n", 
         ylab = "Convergence index", main = "Main effect", ylim = c(0,1)) 
    abline(0.1, 0, lty = 2)
    abline(0.05, 0, lty = 3)
    for (i in 2:ncol(data$S_si)){
      lines(x, data$S_ci[i,], type = "b", col = i)
    }
  } else if (index == "T-ci"){
    plot(x, data$S_ci[1,], type = "b", xlab = "n", 
         ylab = "Convergence index", main = "Total effect", ylim = c(0,1)) 
    abline(0.1, 0, lty = 2)
    abline(0.05, 0, lty = 3)
    for (i in 2:ncol(data$T_si)){
      lines(x, data$T_ci[i,], type = "b", col = i)
    }
  } else if (index == "M-si"){
    plot(x, data$S_si[1,], type = "b", xlab = "n",
         ylab = "Sensitivity index", main = "Main effect", ylim = c(0,1)) 
    abline(0.05, 0, lty = 2)
    abline(0.01, 0, lty = 3)
    for (i in 2:ncol(data$S_si)){
      lines(x, data$S_si[i,], type = "b", col = i)
    }
  } else if (index == "T-si"){
    plot(x, data$T_si[1,], type = "b", xlab = "n",
         ylab = "Sensitivity index", main = "Total effect", ylim = c(0,1)) 
    abline(0.05, 0, lty = 2)
    abline(0.01, 0, lty = 3)
    for (i in 2:ncol(data$T_si)){
      lines(x, data$S_si[i,], type = "b", col = i)
    }
  }
  
  legend("topright", legend=rownames(data$S_si), lty = 1, col=c(1:nrow(data$S_si)))
}


x.convergejansen(n = 8000, n.factors = 8, X = sobol.X, fun = sobol.fun) %>% 
  x.converge.plot()
x.convergejansen(n = 8000, n.factors = 8, X = sobol.X, fun = sobol.fun) %>% 
  x.converge.plot(index = "M-ci")
x.convergejansen(n = 8000, n.factors = 8, X = sobol.X, fun = sobol.fun) %>% 
  x.converge.plot(index = "T-si")
x.convergejansen(n = 8000, n.factors = 8, X = sobol.X, fun = sobol.fun) %>% 
  x.converge.plot(index = "M-si")


n <- 1000
set.seed(1234)
X1 <- data.frame(matrix(runif(8 * n), nrow = n))
X2 <- data.frame(matrix(runif(8 * n), nrow = n))
x <- soboljansen(model = NULL, X1, X2, nboot = 100)
y <- sobol.fun(x$X)
tell(x,y)
x

tell(x,y) %>% x.converge
