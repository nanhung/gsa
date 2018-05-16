# devtools::install_github("nanhung/pksensi")

library(pksensi)
library(httk)
library(dplyr)

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

pksensi:::tell.rfast99(x, y[,,1])

x %>% plot; abline(0.01, 0, lty = 2) 

x %>% ViSA::converge # Not used

####

set.seed(1234)
x<-rfast99(factors = 8, n = 400,
           q = "qunif", q.arg = list(min = 0, max = 1), replicate = 20, conf = 0.95)
y<-solve_fun(x, model = pksensi:::sobol.fun) 
tell2(x, y) # like sensitivity::tell function, the tell2 function is used to combine the output result and model output.
x
plot(x)

## Flip-Flop Kinetics ####
FFPK <- function(parameters, times, dose = 320){
  A <- (dose * parameters[1])/( parameters[3]*( parameters[1]- parameters[2]))
  CONC <- A*exp(- parameters[2] * times) - A*exp(- parameters[1] * times)
  return(CONC)
}

# Define parameter distribution
q = "qunif"
q.arg = list(list(min = 0.5, max = 1.5), 
             list(min = 0.02, max = 0.3),
             list(min = 20, max = 60))

# The replication and confidence interval are set to 20, 0.95, respectively.
set.seed(1234)
x<-rfast99(factors=c("KA","KE","V"),
           n = 400, q = q, q.arg = q.arg, rep = 20, conf = 0.95)

times <- seq(from = 0.25, to = 24.25, by = 0.5)
y<-solve_fun(x, model = FFPK, times = times)
tell2(x,y)
x # print the time-dependent output of sensitivity index and convergence index to the console 
plot(x, cut.off = 0.05) # Visualize the printed result 
pksim(y)
points(Theoph$Time, Theoph$conc, col=Theoph$Subject, pch=19)

check(x)
check(x, SI = 0.05, CI = 0.05)

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

#
q = "qunif"
q.arg = list(list(min = params$Vdist * LL, max = params$Vdist * UL),
             list(min = params$kelim * LL, max = params$kelim * UL),
             list(min = params$kgutabs * LL, max = params$kgutabs * UL))
x<-rfast99(factors = c("vdist", "ke", "kgutabs"),
           n = 100, q = q, q.arg = q.arg, rep = 10, conf = 0.99)

# Use deSolve to solve ode (take some time)
y<-solve_fun(x, times, parameters = parameters, initState, outnames = "Ccompartment",
             dllname = mName, func = "derivs1comp", initfunc = "initmod1comp")
tell2(x,y)

pksim(y)
points(Theoph$Time, Theoph$conc, col=Theoph$Subject, pch=19)

# log scale
pksim(y, log = T)
points(Theoph$Time, log(Theoph$conc), col=Theoph$Subject, pch=19)

#
check(x)
check(x, SI = 0.05, CI = 0.05)

plot(x)
plot(x, cut.off = 0.05)

#### Fix Volume
q = "qunif"
q.arg = list(list(min = params$kelim * LL, max = params$kelim * UL),
             list(min = params$kgutabs * LL, max = params$kgutabs * UL))
x<-rfast99(factors = c("ke", "kgutabs"),
           n = 100, q = q, q.arg = q.arg, rep = 10, conf = 0.99)
parameters["vdist"] = params$Vdist
y<-solve_fun(x, times, parameters = parameters, initState, outnames = "Ccompartment",
             dllname = mName, func = "derivs1comp", initfunc = "initmod1comp")
tell2(x,y)

pksim(y)
points(Theoph$Time, Theoph$conc, col=Theoph$Subject, pch=19)
plot(x)

####

mName = "3compPBPKmodel"
compile(mName)
source(paste0(mName, "_inits.R"))

parameters <- initparms3comp()
initState <- initState3comp(parms=parameters)
initState[1] <- 10

params <- httk::parameterize_3comp(chem.name = "theophylline")

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

x<-rfast99(factors = factors, n = 100, q = q, q.arg = q.arg, rep = 10, conf = 0.95)

times <- seq(from = 0.5, to = 24.5, by = 1)
#y<-solve_fun(x, times, parameters = parameters, initState, outnames = "Crest",
#             dllname = mName, func = "derivs3comp", initfunc = "initmod3comp")
#tell2(x,y)

#load(file = "3comp_2000.rda")
#load(file = "3comp_2000y.rda")
#load(file = "3comp_4000.rda")
#load(file = "3comp_4000y.rda")

# File size
cat(file.size(file = "3comp_2000.rda")/1e6, "MB")
cat(file.size(file = "3comp_2000y.rda")/1e6, "MB")
cat(file.size(file = "3comp_4000.rda")/1e6, "MB")
cat(file.size(file = "3comp_4000y.rda")/1e6, "MB")

pksim(y)
pksim(y, log = T)
points(Theoph$Time, log(Theoph$conc), col=Theoph$Subject, pch=19)


x

check(x)
check(x, SI = 0.05, CI = 0.05)

plot(x, cut.off = 0.05)

###

system("./mcsim.ACAT_like Drug_X.simple.in Drug_X.simple.out")
sim = read.delim("Drug_X.simple.out", skip = 2)
names(sim)

par(mfrow = c(3,2), mar = c(4, 5, 2, 1))
for (i in 2:7) {
  plot(sim$Time, sim[,i], xlab = "Time (hour)", ylab = "",
       main = names(sim)[i], las = 1, col = "red", lwd = 2,
       type = "l", log = "y")
}

###

library(pksensi)
library(httk)
library(dplyr)

library(deSolve)
mName <- "ACAT_like"
compile(mName, model = T)
newState <- c(A_stom_lu = 1780)
newParms <- c(BDM = 70,
              MM = 180.17, 
              f_Abs_jeju  = 1,
              Peff = 0.175,
              Ratio_BP = 0.824,
              PC_adip   = 1,
              PC_kid    = 1,
              PC_rpt    = 1,
              PC_ppt    = 1,
              PC_liver  = 1,
              PC_stom   = 1,
              PC_duod   = 1,
              PC_jeju   = 1,
              PC_ileon  = 1,
              PC_cecum  = 1,
              PC_colon  = 1,
              Fu_adip     = 1,
              Fu_kid      = 1,
              Fu_ppt      = 1,
              Fu_rpt      = 1,
              Fu_blood    = 1,
              Fu_liver    = 1,
              Fu_portvein = 1,
              Fu_stom     = 1,
              Fu_duod     = 1,
              Fu_jeju     = 1,
              Fu_ileon    = 1,
              Fu_cecum    = 1,
              Fu_colon    = 1,
              Fu_plasma   = 0.016,
              Vmax_vitro = 2.48,
              Km_vitro = 3.31,
              Kle_kid = 0.085)
parameters <- initParms(newParms=newParms)
initState <- initStates(newStates=newState)

#Outputs # C_blood
#out <- Outputs

#times <- seq(from = 0, to = 24, by = 1) # NEED ZERO!
#y<-ode(initState, times, parms = parameters, outnames = out, nout=length(out),
#       dllname = mName, func = "derivs", initfunc = "initmod", method = "lsode", rtol = 1e-08, atol = 1e-12) #

y<-ode(initState, times, parms = parameters, outnames = out, nout=length(out),
       dllname = mName, func = "derivs", initfunc = "initmod", method = "lsode", rtol = 1e-08, atol = 1e-12)

## GSA

# 20% uncertainty

LL <- 0.9
UL <- 1.1

newParms

q = "qunif"

q.arg = list(list(min = newParms["BDM"], max = newParms["BDM"]),
             list(min = newParms["Peff"], max = newParms["Peff"]))

factors <- c("BDM", "Peff")

x<-rfast99(factors = factors, n = 100, q = q, q.arg = q.arg, rep = 10, conf = 0.95)

times <- seq(from = 0.5, to = 4.5, by = 1)

solve_fun <- function(x, times = NULL, parameters, initState, dllname,
                      func, initfunc, nout = 1, outnames,
                      method ="lsoda", rtol=1e-8, atol=1e-12,
                      model = NULL, lnparam = F){
  n <- length(x$s)
  factors <- ifelse (class(x$factors) == "character", length(x$factors), x$factors)
  replicate <- x$rep
  out <- ifelse (is.null(times), 1, length(times))
  y <- array(dim = c(n * factors, replicate, out), NA)
  
  if (is.null(model) == TRUE){
    for (k in 1 : dim(y)[3]) { #outputs
      
      # Specific time or variable
      inputs = c(0, times[k])
      
      for (i in 1 : dim(y)[2]) { # replicate
        for (j in 1 : dim(y)[1]) { # Model evaluation
          for (p in x$factors) {
            parameters[p] <- ifelse (lnparam == T,  exp(x$a[j,i,p]), x$a[j,i,p])
          }
          
          # Integrate
          tmp <- deSolve::ode(initState, inputs, func = "derivs", parms = parameters,
                              dllname = mName,
                              method = "lsode", rtol=1e-8, atol=1e-12,
                              initfunc = "initmod", nout = nout, outnames = "C_blood")
          y[j,i,k] <- tmp[2, outnames]
        }
      }
    }
  } else {
    for (i in 1 : dim(y)[2]) { # Replicate
      for (j in 1 : dim(y)[1]) { # Model evaluation
        if (lnparam == T) { parameters <- exp(x$a[j,i,])}
        else if (lnparam == F) { parameters <- x$a[j,i,]}
        
        if (is.null(times)) tmp <- model(parameters) else tmp <- model(parameters, times)
        
        for (k in 1 : dim(y)[3]) { # Output time
          y[j,i,k] <- tmp[k]
        }
      }
    }
  }
  dimnames(y)[[3]]<-times
  return(y)
}


y<-solve_fun(x, times, parameters = parameters, initState, 
             outnames = "C_blood",
             dllname = mName, func = "derivs", initfunc = "initmod")



tell2(x,y)
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
           

