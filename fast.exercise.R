# devtools::install_github("nanhung/pksensi")
# rm(list=ls())
library(pksensi)
library(httk)

## Flip-Flop Kinetics ####
FFPK <- function(parameters, times, dose = 320){
  A <- (dose * parameters[1])/( parameters[3]*( parameters[1]- parameters[2]))
  CONC <- A*exp(- parameters[2] * times) - A*exp(- parameters[1] * times)
  return(CONC)
}

FFPK <- pksensi:::FFPK

# Define parameter distribution
q = "qunif"
q.arg = list(list(min = 0.5,  max = 1.5), 
             list(min = 0.02, max = 0.3),
             list(min = 20, max = 60))

# The replication and confidence interval are set to 20, 0.95, respectively.
set.seed(1234)
x<-rfast99(factors=c("KA","KE","V"),
           n = 400, q = q, q.arg = q.arg, rep = 20, conf = 0.95)

times <- seq(from = 0.25, to = 24.25, by = 0.5)
#times <- 10
y<-solve_fun(x, model = FFPK, times = times, output = "output")
tell2(x,y)
x # print the time-dependent output of sensitivity index and convergence index to the console 
pksim(y)
points(Theoph$Time, Theoph$conc, col=Theoph$Subject, pch=19)

check(x)
heat_check(x)
plot(x) # Visualize the printed result 

##### MCSim under R (use deSolve package)
# pros: Don't need to create in file
# cons: Slower than in pure MCSim

# Compile the code
mName = "pbtk1comp"
compile(mName, app = "R", version = "6.0.1", use_model_file = F) # Windows
source(paste0(mName, "_inits.R"))

# Define time and parameters and initial state
parameters <- initparms1comp()
initState <- initState1comp(parms=parameters)
initState["Agutlumen"] <- 10

# Parameter uncertainty
params <- httk::parameterize_1comp(chem.name = "theophylline")
LL <- 0.5 # use 50% variation in this case
UL <- 1.5
q = "qunif"
q.arg = list(list(min = params$Vdist * LL, max = params$Vdist * UL),
             list(min = params$kelim * LL, max = params$kelim * UL), 
             list(min = params$kgutabs * LL, max = params$kgutabs * UL))

x<-rfast99(factors = c("vdist", "ke", "kgutabs"), 
           n = 200, q = q, q.arg = q.arg, rep = 20, conf = 0.95)

# Use pksensi::solve_fun to solve ode
times <- seq(from = 0.01, to = 24.01, by = 1)
#times <- 1

# Use external function initParms = initparms1comp
y<-solve_fun(x, times, parameters = parameters, initParmsfun = "initparms1comp", 
             initState = initState, outnames = Outputs1comp,
             dllname = mName, func = "derivs1comp", initfunc = "initmod1comp", 
             output = "Ccompartment")

tell2(x,y)
check(x)
plot(x)


dim(x$a);dim(y)

# Vdist
plot(x$a[,3,1], y[,3,1,])


par(mfrow = c(1,3))
for(i in 1:3){
  plot(x$a[,1,i], y[,1,25,], xlab = x$factors[i], ylab = dimnames(y)[[4]]) # parameter time-point  
}

## Plot the PK simulation result by pksensi::pksim
pksim(y)
par(mar=c(4,4,1,1))
points(Theoph$Time, Theoph$conc, col=Theoph$Subject, pch=19)
title(xlab="time(hr)", ylab = expression(paste("concentration, ",mu, "M")))

## Create time-dependent sensitivity index
plot(x, cut.off= 0.05)
heat_check(x)

#### log scale ####
pksim(y, log = T)
points(Theoph$Time, log(Theoph$conc), col=Theoph$Subject, pch=19)

####

mName = "3compPBPKmodel"
compile(mName, app = "R", version = "6.0.1", use_model_file = F) # For windows
source(paste0(mName, "_inits.R"))

# Basic check
params <- httk::parameterize_3comp(chem.name = "theophylline")
newState <- c(Agutlumen = 10)
newParms <- c(BW = params$BW,
              CLmetabolismc = params$Clmetabolismc, # different name in httk parameter
              kgutabs = params$kgutabs,
              Qcardiacc = params$Qcardiacc, 
              Qgfrc = params$Qgfrc, 
              Qgutf = params$Qgutf, 
              Qliverf = params$Qliverf, 
              Vgut = params$Vgut,  
              Vliver = params$Vliver, 
              Vrest = params$Vrest, 
              Fraction_unbound_plasma = params$Funbound.plasma, #
              Kliver2plasma = params$Kliver2pu, # 
              Krest2plasma = params$Krest2pu, #
              Kgut2plasma = params$Kgut2pu,  #
              Ratioblood2plasma = params$Rblood2plasma) #

parameters <- initparms3comp(newParms=newParms)
initState <- initState3comp(newState=newState)
outnames <- Outputs3comp

times <- seq(from = 0.01, to = 6.01, by = 0.2) # NEED ZERO!
y<-deSolve::ode(initState, times, parms = parameters, outnames = outnames, nout=length(outnames),
                dllname = mName, func = "derivs", initfunc = "initmod", method = "lsode", rtol = 1e-08, atol = 1e-12) #
y[,"Crest"]

# Sensitivity analysis
# 20% uncertainty
LL <- 0.8
UL <- 1.2

# 15 parameters
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
             list(min = params$Kliver2pu * LL, max = params$Kliver2pu * UL),
             list(min = params$Krest2pu * LL, max = params$Krest2pu * UL),
             list(min = params$Kgut2pu * LL, max = params$Kgut2pu * UL),
             list(min = params$Rblood2plasma * LL, max = params$Rblood2plasma * UL))

factors <- c("BW","CLmetabolismc","kgutabs",
             "Qcardiacc","Qgfrc","Qgutf","Qliverf",
             "Vgut","Vliver","Vrest",
             "Fraction_unbound_plasma",
             "Kliver2plasma","Krest2plasma","Kgut2plasma",
             "Ratioblood2plasma")

set.seed(1234)
x<-rfast99(factors = factors, n = 2048, q = q, q.arg = q.arg)

#times <- c(0.01, seq(from = 0.5, to = 12.5, by = 1))
times <- seq(from = 0.01, to = 8.01, by = 0.2)
y<-solve_fun(x, times, parameters = parameters, initParmsfun = "initparms3comp", initState = initState, outnames = outnames,
             dllname = mName, func = "derivs", initfunc = "initmod", 
             output = "Crest")
tell2(x,y)
plot(x, cut.off = 0.05);
check(x)
heat_check(x, order = T)

#load(file = "3comp_2000.rda")
#load(file = "3comp_2000y.rda")

pksim(x$y)
pksim(x$y, log = T)
points(Theoph$Time, log(Theoph$conc), col=Theoph$Subject, pch=19)

### For unix

system("./mcsim.ACAT_like Drug_X.simple.in Drug_X.simple.out")
sim = read.delim("Drug_X.simple.out", skip = 2)
names(sim)

par(mfrow = c(3,2), mar = c(4, 5, 2, 1))
for (i in 2:7) {
  plot(sim$Time, sim[,i], xlab = "Time (hour)", ylab = "",
       main = names(sim)[i], las = 1, col = "red", lwd = 2,
       type = "l")
}

### End

mName <- "ACAT_like"
compile(mName, use_model_file = T, app = "R", version="6.0.1") # For windows

# source(paste0(mName, "_inits.R")) for windows
# dyn.load(paste0(mName, .Platform$dynlib.ext))
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
outnames <- Outputs

### Define Exposure
mag <- 100 # Set input
period <- 1e10
inittime <- 0 # Exposure start from 0
exposuretime <- 0.02 # Exposure end at 4 hr

# The output time points
times <- seq(from = 0, to = 24, by = 1) # NEED ZERO!

mintime <- min(times)
maxtime <- max(times)

# Define exposure scenarios: exposure and non-exposure
nperiods <- 1

col1 <- rep(inittime, 2 * nperiods)
I <- 1:length(col1)
J <- which(I %% 2 == 1)
col1[J]  <- col1[J] + (ceiling((J / 2)) - 1) * period
J <- which(I %% 2 == 0)
col1[J] <- col1[J-1] + exposuretime
PerDose <- cbind(col1, rep(c(mag,0), length(col1)/2))

# The matrix of periodic exposure
PerDose
Forcings1 <- list(PerDose)
times <- seq(from = 0, to = 24, by = 1) # NEED ZERO!

## Two type ####  
# ode not work in Windows
newState <- c(A_stom_lu = 1)
initState <- initStates(newStates=newState)
y1<-deSolve::ode(initState, times, parms = parameters, initParmsfun = "initparms", 
                outnames = outnames, nout=length(outnames), 
                dllname = mName, func = "derivs", initfunc = "initmod", method = "lsode", 
                rtol = 1e-08, atol = 1e-12)



newState <- c(A_stom_lu = 0)
initState <- initStates(newStates=newState)
y2<-deSolve::ode(initState, times, parms = parameters, initParmsfun = "initparms", 
                outnames = outnames, nout=length(outnames), 
                dllname = mName, func = "derivs", initfunc = "initmod", method = "lsode", rtol = 1e-08, atol = 1e-12,
                initforc="initforc",
                forcings=Forcings1) #

y1[,"C_blood"]
y2[,"C_blood"]

### GSA ################################
q = "qunif"
q.arg = list(list(min = -2.3, max = 0), # Peff
             list(min = -2.3, max = 0), # Ratio_BP
             list(min = -2.3, max = 2.3), #PC
             list(min = -2.3, max = 2.3), #PC
             list(min = -2.3, max = 2.3), #PC
             list(min = -2.3, max = 2.3), #PC
             list(min = -2.3, max = 2.3), #PC
             list(min = -2.3, max = 2.3), #PC
             list(min = -2.3, max = 2.3), #PC
             list(min = -2.3, max = 2.3), #PC 
             list(min = -2.3, max = 2.3), #PC
             list(min = -2.3, max = 2.3), #PC
             list(min = -2.3, max = 2.3), #PC
             list(min = -2.3, max = 0), # Fu_
             list(min = -2.3, max = 0), # Fu_
             list(min = -2.3, max = 0), # Fu_
             list(min = -2.3, max = 0), # Fu_
             list(min = -2.3, max = 0), # Fu_
             list(min = -2.3, max = 0), # Fu_
             list(min = -2.3, max = 0), # Fu_
             list(min = -2.3, max = 0), # Fu_
             list(min = -2.3, max = 0), # Fu_
             list(min = -2.3, max = 0), # Fu_
             list(min = -2.3, max = 0), # Fu_
             list(min = -2.3, max = 0), # Fu_
             list(min = -2.3, max = 0), # Fu_
             list(min = -2.3, max = 0), # Fu_
             list(min = 0, max = 2.3), # Vmax_vitro
             list(min = 0, max = 2.3), # Km_vitro
             list(min = -4.6, max = 0)) # Kle_kid

factors <- c("Peff","Ratio_BP",
             "PC_adip",
             "PC_kid",
             "PC_rpt",
             "PC_ppt",
             "PC_liver",
             "PC_stom",
             "PC_duod",
             "PC_jeju",
             "PC_ileon",
             "PC_cecum",
             "PC_colon",
             "Fu_adip",
             "Fu_kid",
             "Fu_ppt",
             "Fu_rpt",
             "Fu_blood",
             "Fu_liver",
             "Fu_portvein",
             "Fu_stom",
             "Fu_duod",
             "Fu_jeju",
             "Fu_ileon",
             "Fu_cecum",
             "Fu_colon",
             "Fu_plasma",
             "Vmax_vitro", "Km_vitro", "Kle_kid")

times <- seq(from = 0.01, to = 8.01, by = 0.4)
outnames <- Outputs

x<-rfast99(factors = factors, n = 2000, q = q, q.arg = q.arg) 

newState <- c(A_stom_lu = 1)
initState <- initStates(newStates=newState)
y<-solve_fun(x, times, parameters = parameters, initState = initState, 
             outnames = outnames, dllname = mName, initParmsfun = "initParms",
             func = "derivs", initfunc = "initmod", lnparam = T, output = "C_blood")

pksim(y)
tell2(x,y)
pksim(y, log= T)

tell2(x,y)
plot(x)

dev.off()
heat_check(x, index = "SI", order = T) + 
  ggplot2::scale_fill_grey(start = .9, end = .0)

png(file="figS3.png",width=3200,height=2800,res=300)
plot(x, cut.off = 0.05)
dev.off()

png(file="figS4.png",width=2000,height=2400,res=300)
heat_check(x, index = "SI", order = T) + 
  ggplot2::scale_fill_grey(start = .9, end = .0)
dev.off()

#load(file = "acat_2000.rda")
#load(file = "acat_2000y.rda")
#save(x, file = "acat_2000.rda")
#save(y, file = "acat_2000y.rda")

pksim(y)
pksim(y, log = T)
points(Theoph$Time, log(Theoph$conc), col=Theoph$Subject, pch=19)

plot(x, cut.off = 0.05)

x

check(x)
check(x, SI = 0.05, CI = 0.05)

plot(x, cut.off = 0.05)

## APAP_PBPK ####
# Use MCSim check
MCnewParms <- c(lnTg = -1.0,
                lnTp = -2.85,
                lnCYP_Km = 4.78,
                lnCYP_VmaxC = 0,
                lnSULT_Km_apap = 6.9,
                lnSULT_Ki = 6.6,
                lnSULT_Km_paps = -0.4,
                lnSULT_VmaxC = 6.0,
                lnUGT_Km = 9.33,
                lnUGT_Ki = 10.0,
                lnUGT_Km_GA = -0.03,
                lnUGT_VmaxC = 9.39,
                lnKm_AG = 10.3,
                lnVmax_AG = 10.8,
                lnKm_AS = 10.0,
                lnVmax_AS = 13.7,
                lnkGA_syn = 13.0,
                lnkPAPS_syn = 13.0,
                lnCLC_APAP = -5.5,
                lnCLC_AG = -2.00,
                lnCLC_AS = -2.00)

eFAST.APAP.df <- rbind(MCnewParms, MCnewParms)
#write.table(eFAST.APAP.df, file="apap_setpoint.dat", row.names=T, sep="\t")
#system("./mcsim.APAP_PBPK_thera apap.setpoint_v1.in")
#eFA.APAP.mcsim.df <- as.data.frame(data.table::fread("apap_setpoint.csv", head = T))
write.table(eFAST.APAP.df, file="setpoint.dat", row.names=T, sep="\t")
#system("./mcsim.APAP_PBPK_thera setpoint.in")
eFA.APAP.mcsim.df <- as.data.frame(data.table::fread("setpoint.csv", head = T))
eFA.APAP.mcsim.df[2, ncol(eFAST.APAP.df):ncol(eFA.APAP.mcsim.df)]

#
mName <- "APAP_PBPK_thera"
compile(mName, use_model_file = T, version = "6.0.1", app = "R")

newParms <- c(mgkg_flag = 0,
              OralDose_APAP_mg = 1000, # Dose
              OralDur_APAP = 0.75,
              lnTg = -1.0,
              lnTp = -2.85,
              lnCYP_Km = 4.78,
              lnCYP_VmaxC = 0,
              lnSULT_Km_apap = 6.9,
              lnSULT_Ki = 6.6,
              lnSULT_Km_paps = -0.4,
              lnSULT_VmaxC = 6.0,
              lnUGT_Km = 9.33,
              lnUGT_Ki = 10.0,
              lnUGT_Km_GA = -0.03,
              lnUGT_VmaxC = 9.39,
              lnKm_AG = 10.3,
              lnVmax_AG = 10.8,
              lnKm_AS = 10.0,
              lnVmax_AS = 13.7,
              lnkGA_syn = 13.0,
              lnkPAPS_syn = 13.0,
              lnCLC_APAP = -5.5,
              lnCLC_AG = -2.00,
              lnCLC_AS = -2.00)

newStates <- c(AL_PAPS = 1, AL_GA = 1)

# Be careful the parms <- within(as.list(parms) may cause the problem 
# in parameter definition
parameters <- initParms(newParms = newParms)
initState <- initStates(parms=NULL, newStates = newStates)
outnames <- Outputs

parameters["ODose_APAP"]
parameters["kPAPS_syn"]

### Define Exposure
mag <- 2 # Set input
period <- 1e10
inittime <- 0 # Exposure start from 0
exposuretime <- 0.75

# The output time points
times <- seq(from = 0, to = 12, by = 0.2) # NEED ZERO!

mintime <- min(times)
maxtime <- max(times)

# Define exposure scenarios: exposure and non-exposure
nperiods <- 1
col1 <- c(inittime, exposuretime)
OralExp <- cbind(col1, rep(c(mag,0), length(col1)/2))

IV <- 0 
IVExp <- rbind(c(min(times), IV), c(max(times) + 1, 0))
IVExp

# The matrix of periodic exposure
Forcings1 <- list(OralExp, IVExp)
y<-deSolve::ode(initState, times, parms = parameters, outnames = outnames, 
                nout=length(outnames), dllname = mName, func = "derivs", initfunc = "initmod", method = "lsode", 
                rtol = 1e-08, atol = 1e-12,
                initforc="initforc",
                forcings=Forcings1) #

#y[,"AST_Oral_APAP"]
y[,"lnCPL_AS_mcgL"]


################
#
mName <- "APAP_PBPK_thera"
compile(mName, use_model_file = T, version = "6.0.1", app = "mcsim")
library(EnvStats)
factors <- c("lnTg", "lnTp",
             "lnCYP_Km","lnCYP_VmaxC",
             "lnSULT_Km_apap","lnSULT_Ki","lnSULT_Km_paps","lnSULT_VmaxC",
             "lnUGT_Km","lnUGT_Ki","lnUGT_Km_GA","lnUGT_VmaxC",
             "lnKm_AG","lnVmax_AG","lnKm_AS","lnVmax_AS",
             "lnkGA_syn","lnkPAPS_syn",
             "lnCLC_APAP","lnCLC_AG","lnCLC_AS")
q <- c("qtri","qtri","qtri","qunif",
       "qtri","qtri","qtri","qunif",
       "qtri","qtri","qtri","qunif",
       "qtri","qunif","qtri","qunif",
       "qunif","qunif","qunif","qunif","qunif")

#Nominal value
Tg <- log(0.23)
Tp <- log(0.033)
CYP_Km <- log(130)
SULT_Km_apap <- log(300)
SULT_Ki <- log(526)
SULT_Km_paps <- log(0.5)
UGT_Km <- log(6.0e3)
UGT_Ki <- log(5.8e4)
UGT_Km_GA <-log(0.5)
Km_AG <- log(1.99e4)
Km_AS <- log(2.29e4)

r = 2.0

q.arg <-list(list(Tg-r, Tg+r, Tg),
             list(Tp-r, Tp+r, Tp),
             list(CYP_Km-r, CYP_Km+r, CYP_Km),
             list(-2., 5.),
             list(SULT_Km_apap-r, SULT_Km_apap+r, SULT_Km_apap),
             list(SULT_Ki-r, SULT_Ki+r, SULT_Ki),
             list(SULT_Km_paps-r, SULT_Km_paps+r, SULT_Km_paps),
             list(0, 10), #U(0.15)
             list(UGT_Km-r, UGT_Km+r, UGT_Km),
             list(UGT_Ki-r, UGT_Ki+r, UGT_Ki),
             list(UGT_Km_GA-r, UGT_Km_GA+r, UGT_Km_GA),
             list(0, 10), #U(0.15)
             list(Km_AG-r, Km_AG+r, Km_AG),
             list(7., 15),
             list(Km_AS-r, Km_AS+r, Km_AS),
             list(7., 15),
             list(0., 13),
             list(0., 13),
             list(-6., 1),
             list(-6., 1),
             list(-6., 1))

times <- seq(from = 0.01, to = 12.01, by = 0.4)
output <- c("lnCPL_APAP_mcgL", "lnCPL_AG_mcgL", "lnCPL_AS_mcgL")

set.seed(1234)
#x<-rfast99(factors = factors, n = 4000, q = q, q.arg = q.arg) 
x<-rfast99(factors = factors, n = 1024, q = q, q.arg = q.arg) 

#####
#y<-solve_fun(x, times, parameters = parameters, initParmsfun = "initParms", 
#             initState = initState, outnames = outnames, dllname = mName,
#             func = "derivs", initfunc = "initmod", output = output, method = "lsode",
#             initforc="initforc", forcings=Forcings1)

infile.name <- "setpoint.in"
outfile.name <- "setpoint.csv"
conditions <- c("mgkg_flag = 0",
                "OralExp_APAP = NDoses(2, 1, 0, 0, 0.75)",
                "OralDur_APAP = 0.75",
                "OralDose_APAP_mg = 1000.0",
                "IVExp_APAP = 0.",
                "IVDose_APAP_mg = 0.")
generate_infile(infile.name = infile.name, 
                outfile.name = outfile.name, 
                parameters = factors,
                output = output,
                time = times, 
                condition = conditions) 
y<-solve_mcsim(x, mName = mName, 
               infile.name = "setpoint.in", 
               setpoint.name = "setpoint.dat",
               parameters = factors,
               output = output,
               time = times,
               outfile.name = "setpoint.csv",
               condition = conditions)

#user   system  elapsed 
#1267.084  652.133 1917.641 
#user   system  elapsed 
#4517.225    0.823 4518.596 


tell2(x,y)
plot(x, vars = "lnCPL_AG_mcgL")
plot(x, vars = "lnCPL_AS_mcgL")

pdf(file="HEAT.pdf", width = 14, height = 12)
heat_check(x, index = "SI") 
dev.off()

# X <- tidy_index(x, index = "SI") 
heat_check(x, index = "SI") 
heat_check(x, index = "SI", order = T)
heat_check(x, index = "CI")

# Continous
heat_check(x, level = F)

# Add value
heat_check(x, level = F, text = T)
heat_check(x, text = T)

# grey scale
heat_check(x) + ggplot2::scale_fill_grey(start = .9, end = .0)
heat_check(x, level = F) + ggplot2::scale_fill_gradient(low = "white", high = "black")
# viridis
heat_check(x) + viridis::scale_fill_viridis(discrete=TRUE)
heat_check(x, level = F) + viridis::scale_fill_viridis()

# specific index
heat_check(x, fit = c("first order","total order"))
           

