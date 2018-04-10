library(boot)

sobol.fun <- function(X) {
  a <- c(0, 1, 4.5, 9, 99, 99, 99, 99)
  y <- 1
  for (j in 1:8) {
    y <- y * (abs(4 * X[, j] - 2) + a[j]) / (1 + a[j])
  }
  y
}

soboljansen <- function(model = NULL, X1, X2, nboot = 0, conf = 0.95, ...) {
  if ((ncol(X1) != ncol(X2)) | (nrow(X1) != nrow(X2)))
    stop("The samples X1 and X2 must have the same dimensions")
  p <- ncol(X1)
  
  X <- rbind(X1, X2)
  for (i in 1:p) {
    Xb <- X1
    Xb[,i] <- X2[,i]
    X <- rbind(X, Xb) 
  }
  
  x <- list(model = model, X1 = X1, X2 = X2, nboot = nboot, conf = conf, X = X,
            call = match.call())
  class(x) <- "soboljansen"
  
  return(x)
}

estim.soboljansen <- function(data, i = NULL) {
  if(class(data) == "matrix"){
    # This means x$y is a numeric vector.
    if(is.null(i)) i <- 1:nrow(data)
    d <- as.matrix(data[i, ]) # as.matrix for colSums
    n <- nrow(d)
    V <- var(d[, 1])
    VCE <- V - (colSums((d[,2] - d[, - c(1, 2)])^2) / (2 * n - 1))
    VCE.compl <- (colSums((d[,1] - d[, - c(1, 2)])^2) / (2 * n - 1))
    return(c(V, VCE, VCE.compl))
  }
}

bootstats <- function(b, conf = 0.95, type = "norm") {
  p <- length(b$t0)
  lab <- c("original", "bias", "std. error", "min. c.i.", "max. c.i.")
  out <-  as.data.frame(matrix(nrow = p, ncol = length(lab),
                               dimnames = list(NULL, lab)))
  
  for (i in 1 : p) {
    
    # original estimation, bias, standard deviation
    
    out[i, "original"] <- b$t0[i]
    out[i, "bias"] <- mean(b$t[, i]) - b$t0[i]
    out[i, "std. error"] <- sd(b$t[, i])
    
    # confidence interval
    
    if (type == "norm") {
      ci <- boot.ci(b, index = i, type = "norm", conf = conf)
      if (!is.null(ci)) {
        out[i, "min. c.i."] <- ci$norm[2]
        out[i, "max. c.i."] <- ci$norm[3]
      }
    } else if (type == "basic") {
      ci <- boot.ci(b, index = i, type = "basic", conf = conf)
      if (!is.null(ci)) {
        out[i, "min. c.i."] <- ci$basic[4]
        out[i, "max. c.i."] <- ci$basic[5]
      }
    }
  }
  
  return(out)
}

print.soboljansen <- function(x, ...) {
  cat("\nCall:\n", deparse(x$call), "\n", sep = "")
  if (!is.null(x$y)) {
    if (class(x$y) == "numeric") {
      cat("\nModel runs:", length(x$y), "\n")
    } else if (class(x$y) == "matrix") {
      cat("\nModel runs:", nrow(x$y), "\n")
    } else if (class(x$y) == "array") {
      cat("\nModel runs:", dim(x$y)[1], "\n")
    }
    cat("\nFirst order indices:\n")
    print(x$S)
    cat("\nTotal indices:\n")
    print(x$T)
  } else {
    cat("\n(empty)\n")
  }
}

converge.soboljansen <- function(x, y = NULL, return.var = NULL, ...) {
  id <- deparse(substitute(x))
  
  if (! is.null(y)) {
    x$y <- y
  } else if (is.null(x$y)) {
    stop("y not found")
  }
  
  p <- ncol(x$X1)
  n <- nrow(x$X1)
  
  if(class(x$y) == "numeric"){
    data <- matrix(x$y, nrow = n)
    
    # estimation of the partial variances (V, D1 and Dt)
    if (x$nboot == 0){
      V <- data.frame(original = estim.soboljansen(data))
    } else{
      V.boot <- boot(data, estim.soboljansen, R = x$nboot)
      V <- bootstats(V.boot, x$conf, "basic")
    }
    rownames(V) <- c("global", 
                     colnames(x$X1), 
                     paste("-", colnames(x$X1), sep = ""))
    
    # estimation of the Sobol' indices (S1 and St)
    if (x$nboot == 0) {
      S <- V[2:(p + 1), 1, drop = FALSE] / V[1,1]
      T <- V[(p + 2):(2 * p + 1), 1, drop = FALSE] / V[1,1]
      rownames(T) <- colnames(x$X1)
    } else {
      S.boot <- V.boot
      S.boot$t0 <- V.boot$t0[2:(p + 1)] / V.boot$t0[1]
      S.boot$t <- V.boot$t[,2:(p + 1)] / V.boot$t[,1]
      S <- bootstats(S.boot, x$conf, "basic")
      
      T.boot <- V.boot
      T.boot$t0 <- V.boot$t0[(p + 2):(2 * p + 1)] / V.boot$t0[1]
      T.boot$t <- V.boot$t[,(p + 2):(2 * p + 1)] / V.boot$t[,1]
      T <- bootstats(T.boot, x$conf, "basic")
      rownames(S) <- colnames(x$X1)
      rownames(T) <- colnames(x$X1)
    }
  } else if(class(x$y) == "matrix"){
    data <- array(x$y, dim = c(n, nrow(x$y) / n, ncol(x$y)), 
                  dimnames = list(NULL, NULL, colnames(x$y)))
    if(x$nboot == 0){
      V <- estim.soboljansen(data)
      rownames(V) <- c("global", 
                       colnames(x$X1), 
                       paste("-", colnames(x$X1), sep = ""))
      V_global <- matrix(rep(V[1, ], p), nrow = p, byrow = TRUE)
      S <- V[2:(p + 1), , drop = FALSE] / V_global
      T <- V[(p + 2):(2 * p + 1), , drop = FALSE] / V_global
      rownames(T) <- colnames(x$X1)
    } else{
      V.boot <- lapply(1:ncol(x$y), function(col_idx){
        boot(as.matrix(data[, , col_idx]), estim.soboljansen, R = x$nboot)
      })
      V <- sapply(1:length(V.boot), function(col_idx){
        as.matrix(bootstats(V.boot[[col_idx]], x$conf, "basic"))
      }, simplify = "array")
      dimnames(V) <- list(
        c("global", colnames(x$X1), paste("-", colnames(x$X1), sep = "")),
        dimnames(V)[[2]],
        colnames(x$y))
      S <- sapply(1:length(V.boot), function(col_idx){
        S.boot_col <- V.boot[[col_idx]]
        S.boot_col$t0 <- V.boot[[col_idx]]$t0[2:(p + 1)] / V.boot[[col_idx]]$t0[1]
        S.boot_col$t <- V.boot[[col_idx]]$t[, 2:(p + 1)] / V.boot[[col_idx]]$t[, 1]
        as.matrix(bootstats(S.boot_col, x$conf, "basic"))
      }, simplify = "array")
      T <- sapply(1:length(V.boot), function(col_idx){
        T.boot_col <- V.boot[[col_idx]]
        T.boot_col$t0 <- V.boot[[col_idx]]$t0[(p + 2):(2 * p + 1)] / V.boot[[col_idx]]$t0[1]
        T.boot_col$t <- V.boot[[col_idx]]$t[, (p + 2):(2 * p + 1)] / V.boot[[col_idx]]$t[, 1]
        as.matrix(bootstats(T.boot_col, x$conf, "basic"))
      }, simplify = "array")
      dimnames(S) <- dimnames(T) <- list(colnames(x$X1),
                                         dimnames(V)[[2]],
                                         colnames(x$y))
    }
  } else if(class(x$y) == "array"){
    data <- array(x$y, dim = c(n, dim(x$y)[1] / n, dim(x$y)[2:3]), 
                  dimnames = list(NULL, NULL, 
                                  dimnames(x$y)[[2]], dimnames(x$y)[[3]]))
    if(x$nboot == 0){
      V <- estim.soboljansen(data)
      dimnames(V)[[1]] <- c("global", 
                            colnames(x$X1), 
                            paste("-", colnames(x$X1), sep = ""))
      V_global <- array(rep(V[1, , ], each = p), dim = c(p, dim(x$y)[2:3]))
      S <- V[2:(p + 1), , , drop = FALSE] / V_global
      T <- V[(p + 2):(2 * p + 1), , , drop = FALSE] / V_global
      dimnames(T)[[1]] <- colnames(x$X1)
    } else{
      V.boot <- lapply(1:dim(x$y)[[3]], function(dim3_idx){
        lapply(1:dim(x$y)[[2]], function(dim2_idx){
          boot(as.matrix(data[, , dim2_idx, dim3_idx]), estim.soboljansen, R = x$nboot)
        })
      })
      V <- sapply(1:dim(x$y)[[3]], function(dim3_idx){
        sapply(1:dim(x$y)[[2]], function(dim2_idx){
          as.matrix(bootstats(V.boot[[dim3_idx]][[dim2_idx]], x$conf, "basic"))
        }, simplify = "array")
      }, simplify = "array")
      dimnames(V) <- list(c("global", 
                            colnames(x$X1), 
                            paste("-", colnames(x$X1), sep = "")),
                          dimnames(V)[[2]],
                          dimnames(x$y)[[2]],
                          dimnames(x$y)[[3]])
      S <- sapply(1:dim(x$y)[[3]], function(dim3_idx){
        sapply(1:dim(x$y)[[2]], function(dim2_idx){
          S.boot_dim2 <- V.boot[[dim3_idx]][[dim2_idx]]
          S.boot_dim2$t0 <- 
            V.boot[[dim3_idx]][[dim2_idx]]$t0[2:(p + 1)] / 
            V.boot[[dim3_idx]][[dim2_idx]]$t0[1]
          S.boot_dim2$t <- 
            V.boot[[dim3_idx]][[dim2_idx]]$t[, 2:(p + 1)] / 
            V.boot[[dim3_idx]][[dim2_idx]]$t[, 1]
          as.matrix(bootstats(S.boot_dim2, x$conf, "basic"))
        }, simplify = "array")
      }, simplify = "array")
      T <- sapply(1:dim(x$y)[[3]], function(dim3_idx){
        sapply(1:dim(x$y)[[2]], function(dim2_idx){
          T.boot_dim2 <- V.boot[[dim3_idx]][[dim2_idx]]
          T.boot_dim2$t0 <- 
            V.boot[[dim3_idx]][[dim2_idx]]$t0[(p + 2):(2 * p + 1)] / 
            V.boot[[dim3_idx]][[dim2_idx]]$t0[1]
          T.boot_dim2$t <- 
            V.boot[[dim3_idx]][[dim2_idx]]$t[, (p + 2):(2 * p + 1)] / 
            V.boot[[dim3_idx]][[dim2_idx]]$t[, 1]
          as.matrix(bootstats(T.boot_dim2, x$conf, "basic"))
        }, simplify = "array")
      }, simplify = "array")
      dimnames(S) <- dimnames(T) <- list(colnames(x$X1),
                                         dimnames(V)[[2]],
                                         dimnames(x$y)[[2]],
                                         dimnames(x$y)[[3]])
    }
  }
  
  # converge
  S$converge <- S$`max. c.i.` - S$`min. c.i.`
  T$converge <- T$`max. c.i.` - T$`min. c.i.`
  #
  
  # return
  x$V <- V
  x$S <- S
  x$T <- T
  
  for (i in return.var) {
    x[[i]] <- get(i)
  }
  
  assign(id, x, parent.frame())
}

converge <- function(x, y = NULL, ...)
  UseMethod("converge")

#p <- ncol(x$X1)
#n <- nrow(x$X1)

#x$y<-y
#data <- matrix(x$y, nrow = n)

#V.boot <- boot(data, estim.soboljansen, R = x$nboot)
#V <- bootstats(V.boot, x$conf, "basic")
#rownames(V) <- c("global", 
#                 colnames(x$X1), 
#                 paste("-", colnames(x$X1), sep = ""))

#S.boot <- V.boot
#S.boot$t0 <- V.boot$t0[2:(p + 1)] / V.boot$t0[1]
#S.boot$t <- V.boot$t[,2:(p + 1)] / V.boot$t[,1]
#S <- bootstats(S.boot, x$conf, "basic")
#S$converge <- S$`max. c.i.` - S$`min. c.i.`

#T.boot <- V.boot
#T.boot$t0 <- V.boot$t0[(p + 2):(2 * p + 1)] / V.boot$t0[1]
#T.boot$t <- V.boot$t[,(p + 2):(2 * p + 1)] / V.boot$t[,1]
#T <- bootstats(T.boot, x$conf, "basic")
#T$converge <- T$`max. c.i.` - T$`min. c.i.`

#rownames(S) <- colnames(x$X1)
#rownames(T) <- colnames(x$X1)

# return
#x$V <- V
#x$S <- S
#x$T <- T

