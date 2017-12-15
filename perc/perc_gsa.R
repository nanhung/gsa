library(sensitivity)
library(EnvStats) # to use truncation lognormal
library(RCurl) # to use getURL 
library(readr) # to use read_table2 

if(!require(sensitivity)) {
  install.packages("sensitivity"); require(sensitivity)}
if(!require(EnvStats)) {
  install.packages("EnvStats"); require(EnvStats)} # to access break formatting functions

# Set the prior information for the testing parameters
# Physiological parameter
LeanBodyWt = 66  # lean body weight (kg)
Flow_pul = 10.0 # Pulmonary ventilation rate (minute volume)
Vent_Perf = 1.6  # ventilation over perfusion ratio

# Percent mass of tissues with ranges shown
Pct_M_fat  = .16  # % total body mass
Pct_LM_liv = .033  # liver, % of lean mass
Pct_LM_wp  = .48  # well perfused tissue, % of lean mass
#Pct_LM_pp  = .70  # poorly perfused tissue, will be recomputed in scale

# Percent blood flows to tissues
Pct_Flow_fat = .07
Pct_Flow_liv = .25
#Pct_Flow_wp  = .50 
Pct_Flow_pp  = .20

# Tissue/blood partition coeficients (geometric mean)
PC_fat = 125 
PC_liv = 4.8
PC_wp  = 4.8 
PC_pp  = 1.6
PC_art = 12.0

sc_Vmax = .042   # scaling coeficient of body weight for Vmax
Km = 16

# Set minimun and maximum parameter value for Morris
# Use 1.6 to make sure the min-max can cover the poster
# the range is wider than prvious study
# It's a challenging work to determine the suitable distribution to do GSA

# min


Pct_Flow_gsd <- exp(0.7) # 2
PC_gsd <- exp(1.2) # 3.3
MM_gsd <- exp(4.6) # 99.4

LeanBodyWt_min <- exp(log(LeanBodyWt)-log(1.6))
Flow_pul_min <- exp(log(Flow_pul)-log(1.6))
Vent_Perf_min <- exp(log(Vent_Perf)-log(2.0))  # Use 2.0 to cover posterior range 

Pct_M_fat_min <- exp(log(Pct_M_fat)-log(1.6))
Pct_LM_liv_min <- exp(log(Pct_LM_liv)-log(1.6))
Pct_LM_wp_min <- exp(log(Pct_LM_wp)-log(1.6))

Pct_Flow_fat_min <- exp(log(Pct_Flow_fat)-log(Pct_Flow_gsd))
Pct_Flow_liv_min <- exp(log(Pct_Flow_liv)-log(Pct_Flow_gsd))
Pct_Flow_pp_min <- exp(log(Pct_Flow_pp)-log(Pct_Flow_gsd))

PC_fat_min <- exp(log(PC_fat)-log(PC_gsd))
PC_liv_min <- exp(log(PC_liv)-log(PC_gsd))
PC_wp_min <- exp(log(PC_wp)-log(PC_gsd))
PC_pp_min <- exp(log(PC_pp)-log(PC_gsd))
PC_art_min <- exp(log(PC_art)-log(PC_gsd))

sc_Vmax_min <- exp(log(sc_Vmax)-log(MM_gsd))
Km_min <- exp(log(Km)-log(MM_gsd))

# Max
LeanBodyWt_max <- exp(log(LeanBodyWt)+log(1.6))
Flow_pul_max <- exp(log(Flow_pul)+log(1.6))

Vent_Perf_max <- exp(log(Vent_Perf)+log(2.0)) # Use 2.0 to cover posterior range 

Pct_M_fat_max <- exp(log(Pct_M_fat)+log(1.6))
Pct_LM_liv_max <- exp(log(Pct_LM_liv)+log(1.6))
Pct_LM_wp_max <- exp(log(Pct_LM_wp)+log(1.6))

Pct_Flow_fat_max <- exp(log(Pct_Flow_fat)+log(Pct_Flow_gsd))
Pct_Flow_liv_max <- exp(log(Pct_Flow_liv)+log(Pct_Flow_gsd))
Pct_Flow_pp_max <- exp(log(Pct_Flow_pp)+log(Pct_Flow_gsd))

PC_fat_max <- exp(log(PC_fat)+log(PC_gsd))
PC_liv_max <- exp(log(PC_liv)+log(PC_gsd))
PC_wp_max <- exp(log(PC_wp)+log(PC_gsd))
PC_pp_max <- exp(log(PC_pp)+log(PC_gsd))
PC_art_max <- exp(log(PC_art)+log(PC_gsd))

sc_Vmax_max <- exp(log(sc_Vmax)+log(MM_gsd))
Km_max <- exp(log(Km)*log(MM_gsd))

# Prior
set.seed(1234)
{
  LeanBodyWt.1 <- exp(rtri(1000, log(LeanBodyWt_min), log(LeanBodyWt_max), log(LeanBodyWt)))
  Flow_pul.1 <- exp(rtri(1000, log(Flow_pul_min), log(Flow_pul_max), log(Flow_pul)))
  Vent_Perf.1 <- exp(rtri(1000, log(Vent_Perf_min), log(Vent_Perf_max), log(Vent_Perf)))
  Pct_M_fat.1 <- exp(rtri(1000, log(Pct_M_fat_min), log(Pct_M_fat_max), log(Pct_M_fat)))
  Pct_LM_liv.1 <- exp(rtri(1000, log(Pct_LM_liv_min), log(Pct_LM_liv_max), log(Pct_LM_liv)))
  Pct_LM_wp.1 <- exp(rtri(1000, log(Pct_LM_wp_min), log(Pct_LM_wp_max), log(Pct_LM_wp)))
  Pct_Flow_fat.1 <- exp(rtri(1000, log(Pct_Flow_fat_min), log(Pct_Flow_fat_max), log(Pct_Flow_fat)))
  Pct_Flow_liv.1 <- exp(rtri(1000, log(Pct_Flow_liv_min), log(Pct_Flow_liv_max), log(Pct_Flow_liv)))
  Pct_Flow_pp.1 <- exp(rtri(1000, log(Pct_Flow_pp_min), log(Pct_Flow_pp_max), log(Pct_Flow_pp)))
  PC_fat.1 <- exp(rtri(1000, log(PC_fat_min), log(PC_fat_max), log(PC_fat)))
  PC_liv.1 <- exp(rtri(1000, log(PC_liv_min), log(PC_liv_max), log(PC_liv)))
  PC_wp.1 <- exp(rtri(1000, log(PC_wp_min), log(PC_wp_max), log(PC_wp)))
  PC_pp.1 <- exp(rtri(1000, log(PC_pp_min), log(PC_pp_max), log(PC_pp)))
  PC_art.1 <- exp(rtri(1000, log(PC_art_min), log(PC_art_max), log(PC_art)))
  sc_Vmax.1 <- exp(rtri(1000, log(sc_Vmax_min), log(sc_Vmax_max), log(sc_Vmax)))
  Km.1 <- exp(rtri(1000, log(Km_min), log(Km_max), log(Km)))  
}

# From Bois et al. (1996)
Vent_Perf.pst.mu <- 1.19; Vent_Perf.pst.sig <- 1.13
Pct_LM_liv.pst.mu <- 0.033; Pct_LM_liv.pst.sig <- 1.04
Pct_LM_wp.pst.mu <- 0.637; Pct_LM_wp.pst.sig <- 1.06
Pct_LM_pp.pst.mu <- 0.641; Pct_LM_pp.pst.sig <- 1.03 # Will be recomputed in scale
Pct_Flow_fat.pst.mu <- 0.0488; Pct_Flow_fat.pst.sig <- 1.12
Pct_Flow_liv.pst.mu <- 0.179; Pct_Flow_liv.pst.sig <- 1.11 
Pct_Flow_wp.pst.mu <- 0.637; Pct_Flow_wp.pst.sig <- 1.06 # Will be recomputed in scale
Pct_Flow_pp.pst.mu <- 0.129; Pct_Flow_pp.pst.sig <- 1.11 
PC_fat.pst.mu <- 84.1; PC_fat.pst.sig <- 1.28
PC_liv.pst.mu <- 3.08; PC_liv.pst.sig <- 1.12
PC_wp.pst.mu <- 1.92; PC_wp.pst.sig <- 1.12
PC_pp.pst.mu <- 2.9; PC_pp.pst.sig <- 1.15    
PC_art.pst.mu <- 16; PC_art.pst.sig <- 1.11
sc_Vmax.pst.mu <- 0.00191; sc_Vmax.pst.sig <- 1.45
Km.pst.mu <- 0.729; Km.pst.sig <- 1.20

set.seed(1234)
{
  LeanBodyWt.2 <- NA
  Flow_pul.2 <- NA
  Vent_Perf.2 <- rlnorm(1000, log(Vent_Perf.pst.mu), log(Vent_Perf.pst.sig))
  Pct_M_fat.2 <- NA
  Pct_LM_liv.2 <- rlnorm(1000, log(Pct_LM_liv.pst.mu), log(Pct_LM_liv.pst.sig))
  Pct_LM_wp.2 <- rlnorm(1000, log(Pct_LM_wp.pst.mu), log(Pct_LM_wp.pst.sig))
  #Pct_LM_pp.2 <- rlnorm(1000, log(Pct_LM_pp.pst.mu), log(Pct_LM_pp.pst.sig))
  Pct_Flow_fat.2 <- rlnorm(1000, log(Pct_Flow_fat.pst.mu), log(Pct_Flow_fat.pst.sig))
  Pct_Flow_liv.2 <- rlnorm(1000, log(Pct_Flow_liv.pst.mu), log(Pct_Flow_liv.pst.sig))
  #Pct_Flow_wp.2 <- rlnorm(1000, log(Pct_Flow_wp.pst.mu), log(Pct_Flow_wp.pst.sig))
  Pct_Flow_pp.2 <- rlnorm(1000, log(Pct_Flow_pp.pst.mu), log(Pct_Flow_pp.pst.sig))
  PC_fat.2 <- rlnorm(1000, log(PC_fat.pst.mu), log(PC_fat.pst.sig))
  PC_liv.2 <- rlnorm(1000, log(PC_liv.pst.mu), log(PC_liv.pst.sig))
  PC_wp.2 <- rlnorm(1000, log(PC_wp.pst.mu), log(PC_wp.pst.sig))
  PC_pp.2 <- rlnorm(1000, log(PC_pp.pst.mu), log(PC_pp.pst.sig))
  PC_art.2 <- rlnorm(1000, log(PC_art.pst.mu), log(PC_art.pst.sig))
  sc_Vmax.2 <- rlnorm(1000, log(sc_Vmax.pst.mu), log(sc_Vmax.pst.sig))
  Km.2 <- rlnorm(1000, log(Km.pst.mu), log(Km.pst.sig))
}

# Check V_pp to prevent nagetive value
V_liv.1  <- Pct_LM_liv.1 * LeanBodyWt.1;
V_wp.1 <- Pct_LM_wp.1  * LeanBodyWt.1;
V_pp.1 <- 0.9 * LeanBodyWt.1 - V_liv.1 - V_wp.1;

V_liv.2  <- Pct_LM_liv.2 * LeanBodyWt.1;
V_wp.2 <- Pct_LM_wp.2  * LeanBodyWt.1;
V_pp.2 <- 0.9 * LeanBodyWt.1 - V_liv.2 - V_wp.2;

# Check Flow_wp to prevent nagetive value
Flow_tot.1 <- Flow_pul.1 * 0.7 / Vent_Perf.1;
Flow_fat.1 <- Pct_Flow_fat.1 * Flow_tot.1;
Flow_liv.1 <- Pct_Flow_liv.1 * Flow_tot.1;
Flow_pp.1  <- Pct_Flow_pp.1  * Flow_tot.1;
Flow_wp.1  <- Flow_tot.1 - Flow_fat.1 - Flow_liv.1 - Flow_pp.1;
plot(density(Flow_wp.1))

Flow_tot.2 <- Flow_pul.1 * 0.7 / Vent_Perf.2;
Flow_fat.2 <- Pct_Flow_fat.2 * Flow_tot.2;
Flow_liv.2 <- Pct_Flow_liv.2 * Flow_tot.2;
Flow_pp.2  <- Pct_Flow_pp.2  * Flow_tot.2;
Flow_wp.2  <- Flow_tot.2 - Flow_fat.2 - Flow_liv.2 - Flow_pp.2;
plot(density(Flow_wp.2))

#
df.pri<-data.frame(LeanBodyWt.1, Flow_pul.1, Vent_Perf.1, 
                   Pct_M_fat.1, Pct_LM_liv.1, Pct_LM_wp.1,
                   Pct_Flow_fat.1, Pct_Flow_liv.1, Pct_Flow_pp.1,
                   PC_fat.1, PC_liv.1, PC_wp.1, PC_pp.1, PC_art.1,
                   sc_Vmax.1, Km.1)
df.pst<-data.frame(LeanBodyWt.2, Flow_pul.2, Vent_Perf.2, 
                   Pct_M_fat.2, Pct_LM_liv.2, Pct_LM_wp.2,
                   Pct_Flow_fat.2, Pct_Flow_liv.2, Pct_Flow_pp.2,
                   PC_fat.2, PC_liv.2, PC_wp.2, PC_pp.2, PC_art.2,
                   sc_Vmax.2, Km.2)
names(df.pri)<-c("Ln_LeanBodyWt", "Ln_Flow_pul", "Ln_Vent_Perf", 
                 "Ln_Pct_M_fat", "Ln_Pct_LM_liv", "Ln_Pct_LM_wp",
                 "Ln_Pct_Flow_fat", "Ln_Pct_Flow_liv", "Ln_Pct_Flow_pp",
                 "Ln_PC_fat", "Ln_PC_liv", "LnPC_wp", "Ln_PC_pp", "Ln_PC_art",
                 "Ln_sc_Vmax", "Ln_Km")


par(mfrow=c(4,4), mar=c(2,2,2,1))
for(i in 1:16)
{
  if (is.na(df.pst[1,i])==TRUE){
    plot(density(log(df.pri[,i])), main = names(df.pri)[i], xlab="", ylab="",
         col=2, lwd = 2)
  }else{
    plot(density(log(df.pst[,i])), main = names(df.pri)[i], xlab="", ylab="",
         xlim=c(log(min(df.pri[,i])),log(max(df.pri[,i]))), col=3, lwd = 2)
    lines(density(log(df.pri[,i])), col=2, lwd = 2)
  }
}

system("cd perc; ./mcsim.perc perc.mtc.in");

#
set.seed(1234)
morr <- morris(model = NULL, factors = 16, r = 1024, 
               design = list(type = "oat", levels = 5, grid.jump = 3), 
               binf = c(LeanBodyWt_min,
                        Flow_pul_min,
                        Vent_Perf_min,
                        Pct_M_fat_min, 
                        Pct_LM_liv_min, 
                        Pct_LM_wp_min,
                        Pct_Flow_fat_min, 
                        Pct_Flow_liv_min, 
                        Pct_Flow_pp_min, 
                        PC_fat_min, 
                        PC_liv_min, 
                        PC_wp_min, 
                        PC_pp_min, 
                        PC_art_min,
                        sc_Vmax_min, 
                        Km_min
                        ),
               bsup = c(LeanBodyWt_max,
                        Flow_pul_max,
                        Vent_Perf_max,
                        Pct_M_fat_max, 
                        Pct_LM_liv_max, 
                        Pct_LM_wp_max,
                        Pct_Flow_fat_max, 
                        Pct_Flow_liv_max, 
                        Pct_Flow_pp_max, 
                        PC_fat_max, 
                        PC_liv_max, 
                        PC_wp_max, 
                        PC_pp_max, 
                        PC_art_max,
                        sc_Vmax_max, 
                        Km_max), scale = TRUE)                  

morr.perc.df <- cbind(1, morr$X) 
nrow(morr$X) # nrow=17408
write.table(morr.perc.df, file="perc.setpoint.dat", row.names=FALSE, sep="\t")
