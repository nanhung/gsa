library(boot)
library(sensitivity)

n <- 4000
X1 <- data.frame(matrix(runif(7 * n), nrow = n))
X2 <- data.frame(matrix(runif(8 * n), nrow = n))
x <- soboljansen(model = NULL, X1, X2, nboot = 100)

y <- sobol.fun(x$X)

t<-tell(x,y)



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
  
  cat("\nConvergence of the sensitivity indices:\n")
  print(X)
  cat("\nMaximum of first order:", row.names(X)[which(X[,1] == max(X[,1]))], max(X[,1]), "\n")
  cat("Maximum of total order:", row.names(X)[which(X[,2] == max(X[,2]))], max(X[,2]), "\n")
}


converge(t)

a<-c("k11","k12", "k23", "k34", "k45","k56", "k67", "k78")
converge(t,a)
