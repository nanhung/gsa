# devtools::install_github("nanhung/rfast99")

library(rfast99)
library(dplyr)
library(deSolve)
library(httk)
#library(ggplot2)
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


check(x)
check(x, SI = 0.05, CI = 0.05)

## Flip-Flop Kinetics ####
FFPK <- function(parameters, times, dose = 500){
  A <- (dose * parameters[1])/( parameters[3]*( parameters[1]- parameters[2]))
  CONC <- A*exp(- parameters[2] * times) - A*exp(- parameters[1] * times)
  return(CONC)
}

q = "qunif"
q.arg = list(list(min = 0.2, max = 1), 
             list(min = 0.2, max = 1),
             list(min = 1, max = 5))

set.seed(1234)
x<-rfast99(factors=c("KA","KE","V"),
           n = 4000, q = q, q.arg = q.arg, rep = 10, conf = 0.99)

times <- seq(from = 0.5, to = 24, by = 0.5)

y<-solve_fun(x, model = FFPK, times = times)

tell2(x,y)

check.rfast99(x)
check.rfast99(x, SI = 0.05, CI = 0.05)


plot(x)

  

##### MCSim under R (use deSolve package)
# pros: Don't need to create in file
# cons: ?

compile <- function (mName)
  if (.Platform$OS.type == "windows") {
    message("The current function haven't supprot Windows system")
  } else {  # Unix; good luck
    if (is.loaded("derivs", PACKAGE=mName))
      dyn.unload(paste0(mName,.Platform$dynlib.ext))
    if(file.exists(paste0(mName, ".model"))){
      system (paste0("mod -R ", mName, ".model ", mName,".c")) # model to c file
    }
    system (paste0("R CMD SHLIB ", mName, ".c")) # create .o and .so files
    dyn.load(paste(mName, .Platform$dynlib.ext, sep=""))
    
    if(file.exists(paste0(mName, "_inits.R"))){
      source(paste0(mName, "_inits.R"))
    }
  }

mName = "pbtk1comp"
compile(mName)



times <- seq(from = 0.5, to = 24.5, by = 1)
parameters <- initparms1comp()
initState <- initState1comp(parms=parameters)
initState[1] <- 1

params <- httk::parameterize_1comp(chem.name = "theophylline")

# 10% uncertainty
LL <- 0.9
UL <- 1.1

q = "qunif"
q.arg = list(list(min = params$Vdist * LL, max = params$Vdist * UL),
             list(min = params$kelim * LL, max = params$kelim * UL),
             list(min = params$kgutabs * LL, max = params$kgutabs * UL))

x<-rfast99(factors = c("vdist", "ke", "kgutabs"),
           n = 100, q = q, q.arg = q.arg, rep = 10, conf = 0.99)

y<-solve_fun(x, times, parameters = parameters, initState, outnames = "Ccompartment",
             dllname = mName, func = "derivs1comp", jacfunc = "jac1comp", initfunc = "initmod1comp")

tell2(x,y)


check(x)
check(x, SI = 0.05, CI = 0.05)

plot(x)

####


mName = "3compPBPKmodel"
compile(mName)

parameters <- initparms3comp()
initState <- initState3comp(parms=parameters)
initState[1] <- 1

params <- httk::parameterize_3comp(chem.name = "theophylline")

# 10% uncertainty
LL <- 0.9
UL <- 1.1

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

x<-rfast99(factors = factors, n = 1000, q = q, q.arg = q.arg, rep = 10, conf = 0.99)

times <- seq(from = 0.5, to = 24.5, by = 1)
y<-solve_fun(x, times, parameters = parameters, initState, outnames = "Crest",
             dllname = mName, func = "derivs3comp", jacfunc = "jac3comp", initfunc = "initmod3comp")

tell2(x,y)


check(x)
check(x, SI = 0.05, CI = 0.05)

plot(x)

plot.rfast99 <- function(x, ...){
  
  nv <- length(colnames(x$tSI))+1
  nc <- ceiling(sqrt(nv))
  nr <- nv/nc
  
  par(mfrow = c(nr, nc), mar = c(4,2,4,1))
  for(i in 1:ncol(x$tSI)){
    plot(times, x$tSI[,i], ylim = c(0, 1), bty = 'n',
         type = 'l', lwd = 2, xlab = 'time', ylab = '', 
         main = colnames(x$tSI)[i])
    col.transp = adjustcolor('black', alpha = 0.4)
    polygon(x = c(times, rev(times)),
            y =c(x$tSI[,i]-x$tCI[,i], rev(x$tSI[,i]+x$tCI[,i])),
            col = col.transp, border = col.transp)
    
    col.transp = adjustcolor('red', alpha = 0.4)
    lines(times, x$mSI[,i], ylim = c(0, 1), bty = 'n',
          lwd = 2, col = 'red')
    polygon(x = c(times, rev(times)),
            y =c(x$mSI[,i]-x$mCI[,i], rev(x$mSI[,i]+x$mCI[,i])),
            col = col.transp, border = col.transp)
  }
  plot.new()
  legend('top', legend = c('total order', 'first order'), col = c('black','red'),
         lty = 'solid', lwd = 1, pch = NA, bty = 'n',
         text.col = 'black', 
         fill = adjustcolor(c('black', 'red'), alpha = 0.4), border = NA, cex = 1.2)
}


## Check each time point; time = 0.5
# tell(x, y[,,"0.5"]) %>% converge
# x

#####

plot(rownames(x$mSI), x$mSI[,1], ylim=c(0,1), type="l", xlab="Time", ylab = "Sensitivity index")
lines(rownames(x$mSI), x$mSI[,2])
lines(rownames(x$mSI), x$mSI[,3])
abline(0.05, 0, lty = 2); abline(0.01, 0, lty = 3)

plot(rownames(x$tSI), x$tSI[,1], ylim=c(0,1), type="l", xlab="Time", ylab = "Sensitivity index")
lines(rownames(x$tSI), x$tSI[,2])
lines(rownames(x$tSI), x$tSI[,3])
abline(0.05, 0, lty = 2); abline(0.01, 0, lty = 3)


####
library(ggplot2)


##
# X <- tidy_index(x, index = "SI") 
ggfast(x, index = "SI")
ggfast(x, index = "CI")



###

