library(sensitivity)
library(plyr)

#
fast99 <- function(model = NULL, factors, n, M = 4, omega = NULL,
                   q = NULL, q.arg = NULL, ...) {
  
  # factors numbers and names
  
  if (is.character(factors)) {
    X.labels <- factors
    p <- length(X.labels)
  } else {
    p <- factors
    X.labels <- paste("X", 1 : p, sep = "")
  }
  
  # quantiles
  
  if (is.null(q)) {
    q <- rep("qunif", p)
  } else if (length(q) == 1) {
    q <- rep(q, p)
  }
  if (is.null(q.arg)) {
    q.arg <- rep(list(), p)
  } else if (FALSE %in% sapply(q.arg, is.list)) { # q.arg isn't a list of lists
    q.arg <- rep(list(q.arg), p)
  }
  
  # set of frequencies
  
  if (is.null(omega)) {
    omega <- numeric(p)
    omega[1] <- floor((n - 1) / (2 * M))
    m <- floor(omega[1] / (2 * M))
    if (m >= p - 1) {
      omega[-1] <- floor(seq(from = 1, to = m, length.out = p - 1))
    } else {
      omega[-1] <- (0 : (p - 2)) %% m + 1
    }
  }
  
  # discretization of the s-space
  
  s <- 2 * pi / n * (0 : (n - 1))
  
  # transformation to get points in the x-space
  
  X <- as.data.frame(matrix(nrow = n * p, ncol = p))
  colnames(X) <- X.labels
  omega2 <- numeric(p)
  for (i in 1 : p) {
    omega2[i] <- omega[1]
    omega2[-i] <- omega[-1]
    l <- seq((i - 1) * n + 1, i * n)
    for (j in 1 : p) {
      v <- runif(1, min = 0, max = 2 * pi) # add random phase shift
      g <- 0.5 + 1 / pi * asin(sin(omega2[j] * s + v))
      X[l, j] <- do.call(q[j], c(list(p = g), q.arg[[j]]))
    }
  }
  
  # object of class "fast99"
  
  x <- list(model = model, M = M, s = s, omega = omega, X = X,
            call = match.call())
  class(x) <- "fast99"
  
  if (!is.null(x$model)) {
    response(x, ...)
    tell(x)
  }
  
  return(x)
}

#
fun <- function(n){
  x <- fast99(model = NULL, factors = 8, n = n,
              q = "qunif", q.arg = list(min = 0, max = 1))
  y <- sobol.fun(x$X)
  tell(x, y)
  print(x)[1:length(print(x))]
}

#
rep.fast<-function(n, rep=10, ci=.95){
  capture.output(m<-do.call(rbind, rlply(rep, fun(n=n))))
  s1<-ncol(m)/2
  st<-ncol(m)/2+1
  
  p <- s1
  X.labels <- paste("X", 1 : p, sep = "")
  
  Median<- apply(m[,1:s1], 2, quantile, probs= c(.5))
  Lower.limit<- apply(m[,1:s1], 2, quantile, probs= c((1-ci)/2))
  Upper.limit<- apply(m[,1:s1], 2, quantile, probs= c(1-(1-ci)/2))
  Convergence.index<-Upper.limit - Lower.limit
  cat("\n", "First order indices:", "\n")
  print(data.frame(Median, Lower.limit, Upper.limit, Convergence.index, row.names = X.labels))
  cat("Max. convergence index: ", round(max(Upper.limit-Lower.limit), 4), "\n")
  
  Median<- apply(m[,st:ncol(m)], 2, quantile, probs= c(.5))
  Lower.limit<- apply(m[,st:ncol(m)], 2, quantile, probs= c((1-ci)/2))
  Upper.limit<- apply(m[,st:ncol(m)], 2, quantile, probs= c(1-(1-ci)/2))
  Convergence.index<-Upper.limit - Lower.limit
  cat("\n", "Total order indices:", "\n")
  print(data.frame(Median, Lower.limit, Upper.limit, Convergence.index, row.names = X.labels))
  cat("Max. convergence index: ", round(max(Upper.limit-Lower.limit), 4), "\n")
}

#
n <- 100
rep <- 100
set.seed(1234)
rep.fast(n, rep) # seed = 1234, convergence index = c(0.3379, 0.2484)


#
set.seed(1234); rep.fast(n=200, rep) # convergence index = c(0.0837, 0.0649)
set.seed(1234); rep.fast(n=400, rep) # convergence index = c(0.0831, 0.0633)
set.seed(1234); rep.fast(n=800, rep) # convergence index = c(0.0692, 0.0516)
set.seed(1234); rep.fast(n=1600, rep) # convergence index = c(0.0324, 0.0265)

#
set.seed(1234); rep.fast(n=200, rep, ci=.99) #  seed = 1234, convergence index = c(0.0969, 0.0698)
