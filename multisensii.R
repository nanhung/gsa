library(multisensi)

source("pbtk1comp_inits.R")

mName <- "pbtk1comp"
system (paste("R CMD SHLIB ", mName, ".c", sep = "")) # create .o and .so files
if (is.loaded("derivs", PACKAGE=mName))
  dyn.unload(paste0(mName,.Platform$dynlib.ext))
dyn.load(paste(mName, .Platform$dynlib.ext, sep=""))

T <- c(0, seq(from = 0.5, to = 24.5, by = 1)) # 0 is necessary
parameters<-initparms1comp()
parameters <- c(1,0.5,0.5)

initState <- initState1comp(parms=parameters)
initState[1] <- 1

pbtk <- function(X, t = T)
{
  out <- matrix(nrow = nrow(X), ncol = length(t), NA)
  for (i in 1:nrow(X))
  {
    Y <- ode(initState, T, parms = as.numeric(X[i,]), dllname = mName, nout=1,
             func = "derivs1comp", jacfunc = "jac1comp", 
             initfunc = "initmod1comp", outnames = "Ccompartment")
    
    out[i, ] <- Y[,"Ccompartment"]
  }
  out <- as.data.frame(out)
  names(out) <- paste("t", t, sep = "")
  return(out)
}

q.arg = list(list(min = 0.7, max = 1.3), 
             list(min = 0.1, max = 0.4),
             list(min = 0.8, max = 1.2))

x <- fast99(model = NULL, factors = c("vdist","ke","kgutabs"), n = 400,
            q = "qunif", q.arg = q.arg)
X<-x$X

pbtk(X)

# Test
pbtk.seq.fast <- multisensi(design = fast99, model = pbtk,
                            center = FALSE, reduction = NULL, analysis = analysis.sensitivity,
                            design.args=list( factors=c("vdist","ke","kgutabs"), n=1000, q = "qunif",
                                              q.arg = list(list(min = 0.7, max = 1.3), 
                                                           list(min = 0.1, max = 0.4),
                                                           list(min = 0.8, max = 1.2))),
                            analysis.args=list(keep.outputs=FALSE))

pbtk.seq.fast
print(pbtk.seq.fast,digits=2)
plot(pbtk.seq.fast, normalized = TRUE, color = terrain.colors, gsi.plot = FALSE)
title(xlab = "Time")

#####
m <- 10000
Xb <- data.frame(vdist = runif(m, min = 0.7, max = 1.3), 
                 ke = runif(m, min = 0.1, max = 0.4),
                 kgutabs = runif(m, min = 0.8, max = 1.2))

pbtk.seq.sobol <- multisensi(design = soboljansen, model = pbtk,
                                 reduction = NULL, analysis = analysis.sensitivity, center = TRUE,
                                 design.args = list(X1 = Xb[1:(m/2), ], X2 = Xb[(1 + m/2):m, ], nboot = 100),
                                 analysis.args = list(keep.outputs = FALSE))

pbtk.seq.sobol
print(pbtk.seq.sobol,digits=2)
plot(pbtk.seq.sobol, normalized = TRUE, color = terrain.colors, gsi.plot = FALSE)
title(xlab = "Time")

