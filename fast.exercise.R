# devtools::install_github("nanhung/pksensi")
# rm(list=ls())
library(pksensi)
library(EnvStats)

FFPK <- pksensi:::FFPK

# Define parameter distribution
q = "qunif"
q.arg = list(list(min = 0.6,  max = 1),
             list(min = 0.5,  max = 1.5), 
             list(min = 0.02, max = 0.3),
             list(min = 20, max = 60))

# The replication and confidence interval are set to 20, 0.95, respectively.
set.seed(1234)
x<-rfast99(param=c("F","KA","KE","V"),
           n = 400, q = q, q.arg = q.arg, rep = 20, conf = 0.95)

plot(x$a[,,"F"])
plot(x$a[,,"KA"])
plot(x$a[,,"KE"])
plot(x$a[,,"V"])

plot(x$a[,,"KA"], x$a[,,"KE"])
plot(x$a[,,"KA"], x$a[,,"V"])
plot(x$a[,,"KE"], x$a[,,"V"])

mean(x$a[,,"KA"]); sd(x$a[,,"KA"])
mean(x$a[,,"KE"]); sd(x$a[,,"KE"])
mean(x$a[,,"V"]); sd(x$a[,,"V"])


times <- seq(from = 0.25, to = 24.25, by = 0.5)
#times <- 10
y<-solve_fun(x, model = FFPK, time = times, vars = "output")
tell2(x,y)
x # print the time-dependent output of sensitivity index and convergence index to the console 

plot(x$a[,1,"F"], y[,1,1,]) # rep = 1; time = 0.25
plot(x$a[,1,"KA"], y[,1,1,]) 
plot(x$a[,1,"KE"], y[,1,1,])
plot(x$a[,1,"V"], y[,1,1,])

pksim(y)
#points(Theoph$Time, Theoph$conc, col=Theoph$Subject, pch=19)

check(x)
heat_check(x, SI.cutoff = c(0.01,0.05,0.1,0.2))
heat_check(x, index = "CI", CI.cutoff = c(0.01,0.05,0.1,0.2))
plot(x) # Visualize the printed result 

####
q = "qnormTrunc"
q.arg = list(list(mean = 1, sd = 0.29, min = 0.5,  max = 1.5), 
             list(mean = 0.16, sd = 0.08, min = 0.02, max = 0.3),
             list(mean = 40, sd = 11.55, min = 20, max = 60))
set.seed(1234)
x<-rfast99(factors=c("KA","KE","V"),
           n = 400, q = q, q.arg = q.arg, rep = 20, conf = 0.95)

plot(x$a[,,"KA"])
plot(x$a[,,"KE"])
plot(x$a[,,"V"])

plot(x$a[,,"KA"], x$a[,,"KE"])
plot(x$a[,,"KA"], x$a[,,"V"])
plot(x$a[,,"KE"], x$a[,,"V"])

times <- seq(from = 0.25, to = 24.25, by = 0.5)
y<-solve_fun(x, model = FFPK, time = times, output = "output")
tell2(x,y)
x

plot(x$a[,1,"KA"], y[,1,1,]) # rep = 1; time = 0.25
plot(x$a[,1,"KE"], y[,1,1,])
plot(x$a[,1,"V"], y[,1,1,])

pksim(y)

check(x)
heat_check(x, SI.cutoff = c(0.01,0.05,0.1,0.2))
heat_check(x, index = "CI", CI.cutoff = c(0.01,0.05,0.1,0.2))
plot(x) # Visualize the printed result 


##### MCSim under R (use deSolve package)
# pros: Don't need to create in file
# cons: Slower than in pure MCSim

# Compile the code
pbtk1cpt_model()
mName <- "pbtk1cpt"
compile_model(mName, app = "R", version = "6.0.1") # Windows
source(paste0(mName, "_inits.R"))

# Define time and parameters and initial state
parms <- initParms()
parms["vdist"] <- 0.74
parms["ke"] <- 0.28
parms["kgutabs"] <- 2.18
initState <- initStates(parms=parms)
initState["Agutlument"] <- 10

# Parameter uncertainty
LL <- 0.5 # use 50% variation in this case
UL <- 1.5
q <- "qunif"
q.arg <- list(list(min = parms["vdist"] * LL, max = parms["vdist"] * UL),
             list(min = parms["ke"] * LL, max = parms["ke"] * UL), # time unit from /hr to /d
             list(min = parms["kgutabs"] * LL, max = parms["kgutabs"] * UL)) # time unit from /hr to /d

x<-rfast99(params = names(parms), n = 200, q = q, q.arg = q.arg, rep = 20)

# Use pksensi::solve_fun to solve ode
times <- seq(from = 0.01, to = 24.01, by = 1)
#times <- 1

y <- deSolve::ode(initState, times, func = "derivs", parms = parms, 
         dllname = mName, initfunc = "initmod", nout = 1, outnames = Outputs)

plot(y)


# Use external function initParms = initparms1comp
y<-solve_fun(x, times, params = parms, initState = initState, outnames = Outputs, dllname = mName)

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


#
system.time(y<-solve_fun(x, times, params = parms, initState = initState, 
                         outnames = Outputs, dllname = mName))

compile_model(mName, app = "mcsim")
infile.name <- "setpoint.in"
outfile.name <- "setpoint.csv"
conditions <- c("Agutlument = 10")
generate_infile(infile.name = infile.name, 
                outfile.name = outfile.name, 
                params = c("vdist", "ke", "kgutabs"),
                vars = Outputs,
                time = times, 
                condition = conditions) 
system.time(y.mcsim<-solve_mcsim(x, mName = mName, 
                                 infile.name = "setpoint.in", 
                                 params = c("vdist", "ke", "kgutabs"),
                                 vars = Outputs,
                                 time = times,
                                 outfile.name = "setpoint.out",
                                 condition = conditions))

tell2(x, y.mcsim)
check(x)
plot(x)


####

mName = "3compPBPKmodel"
compile_model(mName, app = "R", version = "6.0.1", use_model_file = F) # For windows
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
x<-rfast99(params = factors, n = 2048, q = q, q.arg = q.arg)

#times <- c(0.01, seq(from = 0.5, to = 12.5, by = 1))
times <- seq(from = 0.01, to = 8.01, by = 0.2)
y<-solve_fun(x, times, params = parameters, initParmsfun = "initparms3comp", initState = initState, outnames = outnames,
             dllname = mName, func = "derivs", initfunc = "initmod", 
             vars = "Crest")
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
compile_model(mName, app = "R", version="6.0.1") # For windows

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

x<-rfast99(params = factors, n = 2000, q = q, q.arg = q.arg) 

newState <- c(A_stom_lu = 1)
initState <- initStates(newStates=newState)

system.time(y<-solve_fun(x, times, params = parameters, initState = initState, 
                         outnames = outnames, dllname = mName, initParmsfun = "initParms",
                         func = "derivs", initfunc = "initmod", lnparam = T, output = "C_blood"))


pksim(y)
tell2(x,y)
pksim(y, log= T)

tell2(x,y)
plot(x)

dev.off()
heat_check(x, index = "SI", order = T, vars = "C_blood") + 
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
compile_model(mName, version = "6.0.1", app = "R")

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
#mag <- 2 # Set input
#period <- 1e10
#inittime <- 0 # Exposure start from 0
#exposuretime <- 0.75

# The output time points
#times <- seq(from = 0, to = 12, by = 0.2) # NEED ZERO!

#mintime <- min(times)
#maxtime <- max(times)

# Define exposure scenarios: exposure and non-exposure
#nperiods <- 1
#col1 <- c(inittime, exposuretime)
#OralExp <- cbind(col1, rep(c(mag,0), length(col1)/2))

#IV <- 0 
#IVExp <- rbind(c(min(times), IV), c(max(times) + 1, 0))
#IVExp

# The matrix of periodic exposure
#Forcings1 <- list(OralExp, IVExp)
#y1<-deSolve::ode(initState, times, parms = parameters, outnames = outnames, 
#                nout=length(outnames), dllname = mName, func = "derivs", initfunc = "initmod", method = "lsode", 
#                rtol = 1e-08, atol = 1e-12,
#                initforc="initforc",
#                forcings=Forcings1) #

#y[,"AST_Oral_APAP"]
#y1[,"lnCPL_AS_mcgL"]

factors <- c("lnTg", "lnTp",
             "lnCYP_Km","lnCYP_VmaxC",
             "lnSULT_Km_apap","lnSULT_Ki","lnSULT_Km_paps","lnSULT_VmaxC",
             "lnUGT_Km","lnUGT_Ki","lnUGT_Km_GA","lnUGT_VmaxC",
             "lnKm_AG","lnVmax_AG","lnKm_AS","lnVmax_AS",
             "lnkGA_syn","lnkPAPS_syn",
             "lnCLC_APAP","lnCLC_AG","lnCLC_AS")
q <- c("qnormTrunc","qnormTrunc","qnormTrunc","qunif",
       "qnormTrunc","qnormTrunc","qnormTrunc","qunif",
       "qnormTrunc","qnormTrunc","qnormTrunc","qunif",
       "qnormTrunc","qunif","qnormTrunc","qunif",
       "qunif","qunif","qunif","qunif","qunif")

q.arg<- list(list(-1.5, 2, -3.5, 0.5),
             list(-3.4, 2, -5.4, -1.4),
             list(4.9, 2, 2.9, 6.9),
             list(-2., 5.),
             list(5.7, 2, 3.7, 7.7),
             list(6.3, 2, 4.3, 8.3),
             list(-0.69, 2, -2.69, 1.31),
             list(0, 10),
             list(8.7, 2, 6.7, 10.7),
             list(10.97, 2, 8.97, 12.97),
             list(-0.69, 2, -2.69, 1.3),
             list(0, 10),
             list(9.9, 2, 7.9, 11.9),
             list(7., 15),
             list(10, 2, 8, 12),
             list(7., 15),
             list(0., 13),
             list(0., 13),
             list(-6., 1),
             list(-6., 1),
             list(-6., 1))

times <- seq(from = 0.1, to = 12.1, by = 0.2)
set.seed(1234)
x<-rfast99(params = factors, n = 4096, q = q, q.arg = q.arg) 

y<-solve_fun(x, times, params = parameters, initState = initState, 
             outnames = outnames, dllname = mName, initParmsfun = "initParms",
             func = "derivs", initfunc = "initmod")
tell2(x,y)
dimnames(y)
y[,,,"lnCPL_APAP_mcgL"]

heat_check(x, vars = "lnCPL_APAP_mcgL")

################
#
mName <- "APAP_PBPK_thera"
compile_model(mName, use_model_file = T, version = "6.0.1", app = "mcsim")

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

r = 1.5

q.arg<- list(list(-1.5, 2, -3.5, 0.5),
             list(-3.4, 2, -5.4, -1.4),
             list(4.9, 2, 2.9, 6.9),
             list(-2., 5.),
             list(5.7, 2, 3.7, 7.7),
             list(6.3, 2, 4.3, 8.3),
             list(-0.69, 2, -2.69, 1.31),
             list(0, 10),
             list(8.7, 2, 6.7, 10.7),
             list(10.97, 2, 8.97, 12.97),
             list(-0.69, 2, -2.69, 1.3),
             list(0, 10),
             list(9.9, 2, 7.9, 11.9),
             list(7., 15),
             list(10, 2, 8, 12),
             list(7., 15),
             list(0., 13),
             list(0., 13),
             list(-6., 1),
             list(-6., 1),
             list(-6., 1))

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
x<-rfast99(params = factors, n = 1024, q = q, q.arg = q.arg, replicate = 1) 

#####
#y<-solve_fun(x, times, parameters = parameters, initParmsfun = "initParms", 
#             initState = initState, outnames = outnames, dllname = mName,
#             func = "derivs", initfunc = "initmod", output = output, method = "lsode",
#             initforc="initforc", forcings=Forcings1)

conditions <- c("mgkg_flag = 0",
                "OralExp_APAP = NDoses(2, 1, 0, 0, 0.75)",
                "OralDur_APAP = 0.75",
                "OralDose_APAP_mg = 1000.0",
                "IVExp_APAP = 0.",
                "IVDose_APAP_mg = 0.")
generate_infile(params = factors,
                vars = output,
                time = times, 
                condition = conditions) 
y2<-solve_mcsim(x, mName = mName, 
               params = factors,
               vars = output,
               time = times,
               condition = conditions,
               generate.infile = F)

tell2(x, y2)

heat_check(x)
heat_check(x, order = "interaction")

png(file="plot_dynamic.png",width=3200,height=2800,res=300)
plot(x)
dev.off()

png(file="plot_uncertainty.png",width=3000,height=1200,res=300)
par(mfrow = c(1,3))
pksim(y2, vars = 1, main = "lnCPL_APAP_mcgL")
pksim(y2, vars = 2, legend = F, main = "lnCPL_AG_mcgL")
pksim(y2, vars = 3, legend = F, main = "lnCPL_AS_mcgL")
dev.off()

png(file="heatmap_sensitivity.png",width=3600,height=3000,res=300)
heat_check(x)
dev.off()

png(file="heatmap_convergence.png",width=3600,height=3000,res=300)
heat_check(x, index = "CI") + ggplot2::scale_fill_grey(start = .9, end = .0) # need to add function to warn rep = 1 
dev.off()

### MONTECARLO
dist<-rep("Uniform", 21)
generate_infile(infile.name = infile.name, 
                outfile.name = outfile.name, 
                parameters = factors,
                output = output,
                time = times, 
                n=1000, dist = dist, q.arg = q.arg, 
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
           

