library(boot)
library(sensitivity)
library(gsacat)

n <- 1000
X1 <- data.frame(matrix(runif(8 * n), nrow = n))
X2 <- data.frame(matrix(runif(8 * n), nrow = n))
x <- soboljansen(model = NULL, X1, X2, nboot = 100)
y <- sobol.fun(x$X)

t<-tell(x,y)

a<-converge(t)

a<-c("k11","k12", "k23", "k34", "k45","k56", "k67", "k78")
converge(t,a)


#X3 <- data.frame(matrix(runif(8 * n), nrow = n))
#x <- sobolowen(model = NULL, X1, X2, X3, nboot = 100)
#y <- sobol.fun(x$X)



converge(t)



rm(list=ls())

converge <- function(data, factors = NULL){
  p <- nrow(data$S)
  
  if (length(factors)==nrow(data$S)){
    X.labels <- factors
  } else if (is.null(factors)){
    X.labels <- paste("X", 1 : p, sep = "")
  } else {
    stop("The number of factors is not equal!")
  }
  
  X <- as.data.frame(matrix(nrow = p, ncol = 2))
  row.names(X) <- X.labels
  colnames(X) <- c("first order","total order")
  X[,1] <- data$S$`max. c.i.` - data$S$`min. c.i.`
  X[,2] <- data$T$`max. c.i.` - data$T$`min. c.i.`
  
  cat("\nModel runs: ", nrow(data$X))
  cat("\nConvergence of the sensitivity indices:\n")
  return(print(X))
  cat("\nMaximum of first order:", row.names(X)[which(X[,1] == max(X[,1]))], max(X[,1]), "\n")
  cat("Maximum of total order:", row.names(X)[which(X[,2] == max(X[,2]))], max(X[,2]), "\n")
  
}



sobol.X<- function(n){
  data.frame(X1 = runif(n, 0, 1),
             X2 = runif(n, 0, 1),
             X3 = runif(n, 0, 1),
             X4 = runif(n, 0, 1),
             X5 = runif(n, 0, 1),
             X6 = runif(n, 0, 1),
             X7 = runif(n, 0, 1),
             X8 = runif(n, 0, 1))
}


# dataframe
converge.df <- function(n, n.factors, fun){
  df <- as.data.frame(matrix(nrow = n.factors, ncol=0))
  for (n in seq(n/10, n, n/10)){
    X1 <- sobol.X(n)
    X2 <- sobol.X(n)
    x <- soboljansen(model = NULL, X1, X2, nboot = 100) #
    y <- fun(x$X)
    t <- tell(x,y)
    c <- converge(t)
    df <- cbind(df, c$`first order`)
  }
  names(df)<-seq(n/10, n, n/10)
  row.names(df)<-row.names(c)
  
  return(df)
}


convrge.plot<-function(df){
  x<-as.numeric(names(df))
  plot(x, df[1,], type = "b", xlab = "n", ylab = "Convergence index", ylim = c(0,1))
  abline(0.1, 0, lty = 2)
  abline(0.05, 0, lty = 3)
  for (i in 2:ncol(df)){
    lines(x, df[i,], type = "b", col = i)
  }
  legend("topright", legend=rownames(df), lty = 1, col=c(1:nrow(df)))
}

converge()
df<-converge.df(n = 1000, n.factors = 8, fun = sobol.fun)
convrge.plot(df)



#


# plot
