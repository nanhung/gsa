library(multisensi)

verhulst <- function(K, Y0, a, t)
{
  output <- K/(1 + (K/Y0 - 1) * exp(-a * t))
  return(output)
}

T <- seq(from = 5, to = 100, by = 5)
verhulst2 <- function(X, t = T)
{
  out <- matrix(nrow = nrow(X), ncol = length(t), NA)
  for (i in 1:nrow(X))
  {
    out[i, ] <- verhulst(X$K[i], X$Y0[i], X$a[i], t)
  }
  out <- as.data.frame(out)
  names(out) <- paste("t", t, sep = "")
  return(out)
}

verhulst.seq.fast <- multisensi(design = fast99, model = verhulst2,
                                center = FALSE, reduction = NULL, analysis = analysis.sensitivity,
                                design.args=list( factors=c("K","Y0","a"), n=1000, q = "qunif",
                                                  q.arg = list(list(min=100, max=1000), list(min=1, max=40),
                                                               list(min = 0.05, max = 0.2))),
                                analysis.args=list(keep.outputs=FALSE))

verhulst.seq.fast
print(verhulst.seq.fast,digits=2)
plot(verhulst.seq.fast, normalized = TRUE, color = terrain.colors, gsi.plot = FALSE)
title(xlab = "Time in half-decades")

#####
m <- 10000
Xb <- data.frame(K = runif(m, min = 100, max = 1000), Y0 = runif(m, min = 1,
                                                                 max = 40), a = runif(m, min = 0.05, max = 0.2))

verhulst.seq.sobol <- multisensi(design = soboljansen, model = verhulst2,
                                 reduction = NULL, analysis = analysis.sensitivity, center = TRUE,
                                 design.args = list(X1 = Xb[1:(m/2), ], X2 = Xb[(1 + m/2):m, ], nboot = 100),
                                 analysis.args = list(keep.outputs = FALSE))

verhulst.seq.sobol
print(verhulst.seq.sobol,digits=2)
plot(verhulst.seq.sobol, normalized = TRUE, color = terrain.colors, gsi.plot = FALSE)
title(xlab = "Time in half-decades")

par(mfrow=c(1,2))


#####
# with dimension reduction by o-splines basis
# and sensitivity analysis with sensitivity:fast99
resG3 <- multisensi(design=fast99, model=biomasse,
                    analysis=analysis.sensitivity,
                    design.args=list(factors = names(biomasseX), n = 100,
                                     q = "qunif", q.arg = list(list(min = 0.9, max = 2.8),
                                                               list(min = 0.9, max = 0.99), list(min = 0.6, max = 0.8),
                                                               list(min = 3, max = 12), list(min = 0.0035, max = 0.01),
                                                               list(min = 0.0011, max = 0.0025),
                                                               list(min = 700, max = 1100))), 
                    climdata=Climat,
                    reduction=basis.osplines,
                    basis.args=list(knots=7, mdegree=3),
                    center=FALSE,scale=FALSE,dimension=NULL)
summary(resG3)