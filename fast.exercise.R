# devtools::install_github("nanhung/pksensi")

library(pksensi)
library(dplyr)
library(deSolve)
library(httk)
library(ggplot2)
# sensitivty

#### Sobol model

set.seed(1234)
x<-rfast99(factors = 20, n = 100,
           q = "qunif", q.arg = list(min = 0, max = 1), replicate = 10, conf = 0.99)

n <- length(x$s)
factors <- x$factors
replicate <- x$replicate

out <- 1 # Not time dependent

y <- array(dim = c(n * factors, replicate, out), NA)

for (i in 1 : x$rep) {
  y[,i,]<-sensitivity::sobol.fun(x$a[,i,]) 
}

tell.rfast99(x, y[,,1])

x %>% plot; abline(0.01, 0, lty = 2) 

x %>% ViSA::converge # Not used

####

set.seed(1234)
x<-rfast99(factors = 20, n = 1000,
           q = "qunif", q.arg = list(min = 0, max = 1), replicate = 10, conf = 0.99)

y<-solve_fun(x, model = sobol.fun)

tell2(x, y)

x

check(x)
check(x, SI = 0.05, CI = 0.05)

## Flip-Flop Kinetics ####
FFPK <- function(parameters, times, dose = 320){
  A <- (dose * parameters[1])/( parameters[3]*( parameters[1]- parameters[2]))
  CONC <- A*exp(- parameters[2] * times) - A*exp(- parameters[1] * times)
  return(CONC)
}

q = "qunif"
q.arg = list(list(min = 0.5, max = 1.5), 
             list(min = 0.02, max = 0.3),
             list(min = 20, max = 60))

set.seed(1234)
x<-rfast99(factors=c("KA","KE","V"),
           n = 400, q = q, q.arg = q.arg, rep = 10, conf = 0.99)

times <- seq(from = 0.25, to = 24.25, by = 0.5)

y<-solve_fun(x, model = FFPK, times = times)

pksim(y) # uncertainty analysis
title(ylab="concentration", xlab="time", main = "Ccompartment")
points(Theoph$Time, Theoph$conc, col=Theoph$Subject, pch=19)

tell2(x,y)
x

check(x)
check(x, SI = 0.05, CI = 0.05) # redefine cut-off and convergence threshold

plot(x)
plot(x, cut.off = 0.05)
  
heat_check(x, index = "SI") 
heat_check(x, index = "SI", order = T) + 
  scale_fill_grey(start = .9, end = .0) # color blind friendly

heat_check(x, index = "CI")

##### MCSim under R (use deSolve package)
# pros: Don't need to create in file
# cons: Slower than in pure MCSim

compile <- function (mName, model = F) {
  if (model == T){ # Generate the ".c" file and "_inits.R" from model file 
    if(file.exists(paste0(mName, ".model")) && .Platform$OS.type == "unix"){
      system (paste0("mod -R ", mName, ".model ", mName,".c")) # model to c file
    } else if (.Platform$OS.type == "windows") {
      warning("The model compiled function haven't supprot Windows system")
    }
  }
  if (is.loaded("derivs", PACKAGE=mName))
    dyn.unload(paste0(mName,.Platform$dynlib.ext))
  
  if (.Platform$OS.type == "windows") {
    if (!(devtools::find_rtools() == TRUE)) {
      # The windows user neet to install Rtools to complile the c file
      # The MacOS user neet to install Xcode
      warning("The Rtools should be installed first") 
    }
  } 
  system (paste0("R CMD SHLIB ", mName, ".c")) # create .o and .so (or .dll) files
  
  dyn.load(paste0(mName, .Platform$dynlib.ext))
  
  if(file.exists(paste0(mName, "_inits.R"))){
    source(paste0(mName, "_inits.R"))
  }
}

mName = "pbtk1comp"
compile(mName)
source(paste0(mName, "_inits.R"))

# Define time and parameters and initial state
times <- seq(from = 0.5, to = 24.5, by = 1)
parameters <- initparms1comp()
initState <- initState1comp(parms=parameters)
initState[1] <- 10

params <- httk::parameterize_1comp(chem.name = "theophylline")

# 50% uncertainty
LL <- 0.5
UL <- 1.5

q = "qunif"
q.arg = list(list(min = params$Vdist * LL, max = params$Vdist * UL),
             list(min = params$kelim * LL, max = params$kelim * UL),
             list(min = params$kgutabs * LL, max = params$kgutabs * UL))

x<-rfast99(factors = c("vdist", "ke", "kgutabs"),
           n = 400, q = q, q.arg = q.arg, rep = 10, conf = 0.99)



# Use deSolve to solve ode (take some time)
y<-solve_fun(x, times, parameters = parameters, initState, outnames = "Ccompartment",
             dllname = mName, func = "derivs1comp", initfunc = "initmod1comp")
tell2(x,y)

pksim(y)
points(Theoph$Time, Theoph$conc, col=Theoph$Subject, pch=19)
pksim(y, log = T)
points(Theoph$Time, log(Theoph$conc), col=Theoph$Subject, pch=19)

#
check(x)
check(x, SI = 0.05, CI = 0.05)

plot(x)
plot(x, cut.off = 0.05)

####

mName = "3compPBPKmodel"
compile(mName)
source(paste0(mName, "_inits.R"))

parameters <- initparms3comp()
initState <- initState3comp(parms=parameters)
initState[1] <- 10

params <- httk::parameterize_3comp(chem.name = "theophylline")
#params <- httk::parameterize_3comp(chem.name = "acetaminophen")

# 20% uncertainty
LL <- 0.8
UL <- 1.2

# 20 parameters
q = "qunif"
q.arg = list(list(min = params$BW * LL, max = params$BW * UL),
             list(min = params$Clmetabolismc * LL, max = params$Clmetabolismc * UL),
             list(min = params$kgutabs * LL, max = params$kgutabs * UL),
             list(min = params$Qcardiacc * LL, max = params$Qcardiacc * UL),
             list(min = params$Qgfrc * LL, max = params$Qgfrc * UL),
             list(min = params$Qgutf * LL, max = params$Qgutf * UL),
             list(min = params$Qliverf * LL, max = params$Qliverf * UL),
             list(min = params$Vgut * LL, max = params$Vgut * UL),
             list(min = params$Vliver * LL, max = params$Vliver * UL),
             list(min = params$Vrest * LL, max = params$Vrest * UL),
             list(min = params$Funbound.plasma * LL, max = params$Funbound.plasma * UL),
             list(min = params$Clmetabolism * LL, max = params$Clmetabolism * UL),
             list(min = params$Qcardiac * LL, max = params$Qcardiac * UL),
             list(min = params$Qgfr * LL, max = params$Qgfr * UL),
             list(min = params$Qgut * LL, max = params$Qgut * UL),
             list(min = params$Qliver * LL, max = params$Qliver * UL),
             list(min = params$Kliver2pu * LL, max = params$Kliver2pu * UL),
             list(min = params$Krest2pu * LL, max = params$Krest2pu * UL),
             list(min = params$Kgut2pu * LL, max = params$Kgut2pu * UL),
             list(min = params$Rblood2plasma * LL, max = params$Rblood2plasma * UL))

factors <- names(parameters)

x<-rfast99(factors = factors, n = 4000, q = q, q.arg = q.arg, rep = 10, conf = 0.95)

times <- seq(from = 0.5, to = 24.5, by = 1)
#y<-solve_fun(x, times, parameters = parameters, initState, outnames = "Crest",
#             dllname = mName, func = "derivs3comp", jacfunc = "jac3comp", initfunc = "initmod3comp")
#tell2(x,y)

#load(file = "3comp_2000.rda")
#load(file = "3comp_2000.rda")
#load(file = "3comp_4000.rda")
#load(file = "3comp_4000y.rda")

# File size
cat(file.size(file = "3comp_4000.rda")/1e6, "MB")
cat(file.size(file = "3comp_4000y.rda")/1e6, "MB")

pksim(y)
pksim(y, log = T)
points(Theoph$Time, log(Theoph$conc), col=Theoph$Subject, pch=19)


x

check(x)
check(x, SI = 0.05, CI = 0.05)

plot(x, cut.off = 0.05)


# X <- tidy_index(x, index = "SI") 
heat_check(x, index = "SI") 
heat_check(x, index = "SI", order = T)
heat_check(x, index = "CI")

# Continous
heat_check(x, category = F)

# Add value
heat_check(x, category = F, text = T)
heat_check(x, text = T)

# grey scale
heat_check(x) + ggplot2::scale_fill_grey(start = .9, end = .0)
heat_check(x, category = F) + ggplot2::scale_fill_gradient(low = "white", high = "black")
# viridis
heat_check(x) + viridis::scale_fill_viridis(discrete=TRUE)
heat_check(x, category = F) + viridis::scale_fill_viridis()

# specific index
heat_check(x, filter = c("first order","total order"))
           