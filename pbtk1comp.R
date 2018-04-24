library(deSolve)

mName <- "pbtk1comp"
system (paste("R CMD SHLIB ", mName, ".c", sep = "")) # create .o and .so files
dyn.load(paste(mName, .Platform$dynlib.ext, sep=""))

parms <- c(
  vdist = 1,
  ke = 0.1,
  kgutabs = 0.5
)

Y <- init

Ccompartment <- 