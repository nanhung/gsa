#setwd(paste(getwd(), "/perc", sep = ""))
set.seed(1234)

library(sensitivity)
morr <- morris(model = NULL, factors = 16, r = 1024,
               design = list(type = "oat", levels = 5, grid.jump = 3), 
               binf = c(log(LeanBodyWt_min),
                        log(Flow_pul_min),
                        log(Vent_Perf_min),
                        log(Pct_M_fat_min), 
                        log(Pct_LM_liv_min), 
                        log(Pct_LM_wp_min),
                        log(Pct_Flow_fat_min), 
                        log(Pct_Flow_liv_min), 
                        log(Pct_Flow_pp_min), 
                        log(PC_fat_min), 
                        log(PC_liv_min), 
                        log(PC_wp_min), 
                        log(PC_pp_min), 
                        log(PC_art_min),
                        log(sc_Vmax_min), 
                        log(Km_min)
               ),
               bsup = c(log(LeanBodyWt_max),
                        log(Flow_pul_max),
                        log(Vent_Perf_max),
                        log(Pct_M_fat_max), 
                        log(Pct_LM_liv_max), 
                        log(Pct_LM_wp_max),
                        log(Pct_Flow_fat_max), 
                        log(Pct_Flow_liv_max), 
                        log(Pct_Flow_pp_max), 
                        log(PC_fat_max), 
                        log(PC_liv_max), 
                        log(PC_wp_max), 
                        log(PC_pp_max), 
                        log(PC_art_max),
                        log(sc_Vmax_max), 
                        log(Km_max)), scale = TRUE)                  

buildDLL <- function(mName) {
  system (paste("mod -R ", mName, " ", mName, ".c", sep = "")) 
  system (paste("R CMD SHLIB ", mName, ".c", sep = "")) # create .o and .so files
  dyn.load(paste(mName, .Platform$dynlib.ext, sep=""))
}

mName <- "perc.model"
buildDLL(mName)

morr$X[1292:1293,]
morr$X[1292,1]
source("perc.model_inits.R")

# (6)
newParms<-c(
  PPM_per_mg_per_l = 1.475410e+02,
  mg_per_l_per_PPM = 6.777778e-03,
  InhMag = 72, 
  Period = 1e10,
  Exposure = 240,
  IngDose = 0
)

#
parms_init <- initParms(newParms = newParms)

i = 1292

# Redefine parameter (43)
parms_init[which(names(parms_init) == "lnLeanBodyWt")]<-morr$X[i,1]
parms_init[which(names(parms_init) == "LeanBodyWt")]<-exp(morr$X[i,1])
parms_init[which(names(parms_init) == "BodyWt")] <- parms_init["LeanBodyWt"] / (1-exp(morr$X[i,4]))

parms_init[which(names(parms_init) == "lnPct_M_fat")]<-morr$X[i,4]
parms_init[which(names(parms_init) == "Pct_M_fat")]<-exp(morr$X[i,4])
parms_init[which(names(parms_init) == "lnPct_LM_liv")]<-morr$X[i,5]
parms_init[which(names(parms_init) == "Pct_LM_liv")]<-exp(morr$X[i,5])
parms_init[which(names(parms_init) == "lnPct_LM_wp")]<-morr$X[i,6]
parms_init[which(names(parms_init) == "Pct_LM_wp")]<-exp(morr$X[i,6])

parms_init[which(names(parms_init) == "V_fat")] <- parms_init["Pct_M_fat"]  * parms_init["BodyWt"] / 0.92
parms_init[which(names(parms_init) == "V_liv")] <- parms_init["Pct_LM_liv"] * parms_init["LeanBodyWt"]
parms_init[which(names(parms_init) == "V_wp")] <- parms_init["Pct_LM_wp"] * parms_init["LeanBodyWt"]
parms_init[which(names(parms_init) == "V_pp")] <- 0.9 * parms_init["LeanBodyWt"] - parms_init["V_liv"] - parms_init["V_wp"]

parms_init[which(names(parms_init) == "lnFlow_pul")]<-morr$X[i,2]
parms_init[which(names(parms_init) == "Flow_pul")]<-exp(morr$X[i,2])
parms_init[which(names(parms_init) == "Flow_alv")]<-parms_init["Flow_pul"]*0.7
parms_init[which(names(parms_init) == "lnVent_Perf")]<-morr$X[i,3]
parms_init[which(names(parms_init) == "Vent_Perf")]<-exp(morr$X[i,3])
parms_init[which(names(parms_init) == "Flow_tot")] <- parms_init["Flow_alv"] / parms_init["Vent_Perf"]
parms_init[which(names(parms_init) == "lnPct_Flow_fat")]<-morr$X[i,7]
parms_init[which(names(parms_init) == "Pct_Flow_fat")]<-exp(morr$X[i,7])
parms_init[which(names(parms_init) == "lnPct_Flow_liv")]<-morr$X[i,8]
parms_init[which(names(parms_init) == "Pct_Flow_liv")]<-exp(morr$X[i,8])

parms_init[which(names(parms_init) == "lnPct_Flow_pp")]<-morr$X[i,9]
parms_init[which(names(parms_init) == "Pct_Flow_pp")]<-exp(morr$X[i,9])
parms_init[which(names(parms_init) == "Flow_fat")] <- parms_init["Pct_Flow_fat"] * parms_init["Flow_tot"]
parms_init[which(names(parms_init) == "Flow_liv")] <- parms_init["Pct_Flow_liv"] * parms_init["Flow_tot"]
parms_init[which(names(parms_init) == "Flow_pp")] <- parms_init["Pct_Flow_pp"] * parms_init["Flow_tot"]
parms_init[which(names(parms_init) == "Flow_wp")] <- parms_init["Flow_tot"] - parms_init["Flow_fat"] - parms_init["Flow_liv"] - parms_init["Flow_pp"]

parms_init[which(names(parms_init) == "lnPC_fat")]<-morr$X[i,10]
parms_init[which(names(parms_init) == "PC_fat")]<-exp(morr$X[i,10])
parms_init[which(names(parms_init) == "lnPC_liv")]<-morr$X[i,11]
parms_init[which(names(parms_init) == "PC_liv")]<-exp(morr$X[i,11])
parms_init[which(names(parms_init) == "lnPC_wp")]<-morr$X[i,12]
parms_init[which(names(parms_init) == "PC_wp")]<-exp(morr$X[i,12])
parms_init[which(names(parms_init) == "lnPC_pp")]<-morr$X[i,13]
parms_init[which(names(parms_init) == "PC_pp")]<-exp(morr$X[i,13])
parms_init[which(names(parms_init) == "lnPC_art")]<-morr$X[i,14]
parms_init[which(names(parms_init) == "PC_art")]<-exp(morr$X[i,14])
parms_init[which(names(parms_init) == "lnsc_Vmax")]<-morr$X[i,15]
parms_init[which(names(parms_init) == "sc_Vmax")]<-exp(morr$X[i,15])
parms_init[which(names(parms_init) == "lnKm")]<-morr$X[i,16]
parms_init[which(names(parms_init) == "Km")]<-exp(morr$X[i,16])
parms_init[which(names(parms_init) == "Vmax")] <- parms_init["sc_Vmax"] * exp (0.7 * log (parms_init["LeanBodyWt"]))

Y_init <- initStates(parms = parms)
times <- c(0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 230, 239.99, 240, 250, 260, 270, 280, 290, 300, 310, 320, 330, 339.9, 340, 350, 2880)
#times <- c(0,1440,2880)

parms_init
Outputs
Y_init

##
mag <- parms_init["InhMag"] # Set input
period <- parms_init["Period"]
inittime <- 0 # Exposure start from 0
exposuretime <- parms_init["Exposure"]

mintime <- min(times)
maxtime <- max(times)

# Define exposure scenarios: exposure and non-exposure
nperiods <- ceiling(maxtime / period) + 1 

col1 <- rep(inittime, 2 * nperiods)
I <- 1:length(col1)
J <- which(I %% 2 == 1)
col1[J]  <- col1[J] + (ceiling((J / 2)) - 1) * period
J <- which(I %% 2 == 0)
col1[J] <- col1[J-1] + exposuretime
PerDose <- cbind(col1, rep(c(mag,0), length(col1)/2))

# The matrix of periodic exposure
PerDose

mag <- 0 # the backgroud exposure dose = 0
ConstDose <- rbind(c(min(times), mag), c(max(times) + 1, 0))
ConstDose


library(deSolve)
Forcings <- list(PerDose, ConstDose)
out <- ode(Y_init, times, parms = parms_init, 
           outnames = Outputs, nout=length(Outputs),
           func = "derivs", dllname = "perc.model",
           initfunc = "initmod", initforc="initforc",
           fcontrol=list(method="constant", rule=1, f=0),
           forcings=Forcings)
# drop
locate <- which(colnames(out) == "Pct_cumulative_oral")

out<-out[,-locate]

# Plot
par(mfrow = c(4,5), mar = c(4,2,3,1))
for(i in 2:ncol(out)){
  plot(out[,1], out[,i], type="l", xlab = "Time", ylab="" , 
       col = 2, main = names(out[3,i]))
}

##
morr.perc.df <- cbind(1, morr$X) 
nrow(morr$X) # nrow=17408
write.table(morr.perc.df, file="perc.setpoint.dat", row.names=FALSE, sep="\t")
system("./mcsim.perc perc.setpt2.in")
sim.morris <- as.data.frame(fread("perc.setpoint.out", head = T))


mor.1.1 <- tell(morr, sim.morris[,ncol(morr$X)+2])
mor.1.2 <- tell(morr, sim.morris[,ncol(morr$X)+3])
mor.1.3 <- tell(morr, sim.morris[,ncol(morr$X)+4])

mor.2.1 <- tell(morr, sim.morris[,ncol(morr$X)+5])
mor.2.2 <- tell(morr, sim.morris[,ncol(morr$X)+6])
mor.2.3 <- tell(morr, sim.morris[,ncol(morr$X)+7])

mor.3.1 <- tell(morr, sim.morris[,ncol(morr$X)+8])
mor.3.2 <- tell(morr, sim.morris[,ncol(morr$X)+9])
mor.3.3 <- tell(morr, sim.morris[,ncol(morr$X)+10])

mu.star.1.1 <- apply(mor.1.1$ee, 2, function(x) mean(abs(x)))
mu.star.1.2 <- apply(mor.1.2$ee, 2, function(x) mean(abs(x)))
mu.star.1.3 <- apply(mor.1.3$ee, 2, function(x) mean(abs(x)))
mu.star.2.1 <- apply(mor.2.1$ee, 2, function(x) mean(abs(x)))
mu.star.2.2 <- apply(mor.2.2$ee, 2, function(x) mean(abs(x)))
mu.star.2.3 <- apply(mor.2.3$ee, 2, function(x) mean(abs(x)))
mu.star.3.1 <- apply(mor.3.1$ee, 2, function(x) mean(abs(x)))
mu.star.3.2 <- apply(mor.3.2$ee, 2, function(x) mean(abs(x)))
mu.star.3.3 <- apply(mor.3.3$ee, 2, function(x) mean(abs(x)))

sigma.1.1 <- apply(mor.1.1$ee, 2, sd)
sigma.1.2 <- apply(mor.1.2$ee, 2, sd)
sigma.1.3 <- apply(mor.1.3$ee, 2, sd)
sigma.2.1 <- apply(mor.2.1$ee, 2, sd)
sigma.2.2 <- apply(mor.2.2$ee, 2, sd)
sigma.2.3 <- apply(mor.2.3$ee, 2, sd)
sigma.3.1 <- apply(mor.3.1$ee, 2, sd)
sigma.3.2 <- apply(mor.3.2$ee, 2, sd)
sigma.3.3 <- apply(mor.3.3$ee, 2, sd)