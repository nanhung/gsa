

sobol.fun <- function(X) {
  a <- c(0, 1, 4.5, 9, 99, 99, 99, 99)
  y <- 1
  for (j in 1:8) {
    y <- y * (abs(4 * X[, j] - 2) + a[j]) / (1 + a[j])
  }
  y
}

fast18 <- function(model = NULL, factors, n, M = 4, omega = NULL,
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
  
  # object of class "fast18"
  
  x <- list(model = model, M = M, s = s, omega = omega, X = X,
            call = match.call())
  class(x) <- "fast18"
  
  return(x)
}

print.fast18 <- function(x, ...) {
  cat("\nCall:\n", deparse(x$call), "\n", sep = "")
  if (! is.null(x$y)) {
    cat("\nModel runs:", length(x$y), "\n")
    S <- cbind(x$D1 / x$V, 1 - x$Dt / x$V)
    colnames(S) <- c("first order", "total order")
    rownames(S) <- colnames(x$X)
    cat("\nEstimations of the indices:\n")
    print(S)
  } else {
    cat("(empty)\n")
  }
}


x <- fast18(model = NULL, factors = 8, n = n,
            q = "qunif", q.arg = list(min = 0, max = 1))

x$y <- sobol.fun(x$X)


p <- ncol(x$X)
n <- length(x$s)

V <- numeric(p)
D1 <- numeric(p)
Dt <- numeric(p)

for (i in 1 : p) {
  l <- seq((i - 1) * n + 1, i * n)
  f <- fft(x$y[l], inverse = FALSE)
  Sp <- ( Mod(f[2 : (n / 2)]) / n )^2
  V[i] <- 2 * sum(Sp)
  D1[i] <- 2 * sum(Sp[(1 : x$M) * x$omega[1]])
  Dt[i] <- 2 * sum(Sp[1 : (x$omega[1] / 2)])
}







x$V <- V
x$D1 <- D1
x$Dt <- Dt

x
