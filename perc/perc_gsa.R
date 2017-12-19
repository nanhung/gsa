library(RCurl) # to use getURL 

if(!require(sensitivity)) {
  install.packages("sensitivity"); require(sensitivity)}
if(!require(EnvStats)) {
  install.packages("EnvStats"); require(EnvStats)} # to access break formatting functions
if(!require(data.table)) {
  install.packages("data.table"); require(data.table)} # to access break formatting functions

# Set the prior information for the testing parameters
# Physiological parameter
LeanBodyWt = 66  # lean body weight (kg)
Flow_pul = 10.0 # Pulmonary ventilation rate (minute volume)
Vent_Perf = 1.6  # ventilation over perfusion ratio

# Percent mass of tissues with ranges shown
Pct_M_fat  = .20  # % total body mass # no prior and posterior information
Pct_LM_liv = .033  # liver, % of lean mass
Pct_LM_wp  = .28  # well perfused tissue, % of lean mass
#Pct_LM_pp  = .56  # poorly perfused tissue, will be recomputed in scale

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

Pct_M <- exp(0.6)
Pct_Flow_gsd <- exp(0.6) # 1.8 this parameter can cause "out of bound" problem 
PC_gsd <- exp(1.2) # 3.3
MM_gsd <- exp(3.9) # 99.4

LeanBodyWt_min <- exp(log(LeanBodyWt)-log(1.4))
Flow_pul_min <- exp(log(Flow_pul)-log(1.8))
Vent_Perf_min <- exp(log(Vent_Perf)-log(2.0))  # Use 2.0 to cover posterior range 

Pct_M_fat_min <- exp(log(Pct_M_fat)-log(Pct_M))
Pct_LM_liv_min <- exp(log(Pct_LM_liv)-log(Pct_M))
Pct_LM_wp_min <- exp(log(Pct_LM_wp)-log(Pct_M))

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
LeanBodyWt_max <- exp(log(LeanBodyWt)+log(1.4))
Flow_pul_max <- exp(log(Flow_pul)+log(1.8))

Vent_Perf_max <- exp(log(Vent_Perf)+log(2.0)) # Use 2.0 to cover posterior range 

Pct_M_fat_max <- exp(log(Pct_M_fat)+log(Pct_M))
Pct_LM_liv_max <- exp(log(Pct_LM_liv)+log(Pct_M))
Pct_LM_wp_max <- exp(log(Pct_LM_wp)+log(Pct_M))

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
LeanBodyWt.obs.mu <- LeanBodyWt; LeanBodyWt.obs.sig <- 1.04 # Use the imformation from original paper as posterior
Flow_pul.obs.mu <- Flow_pul; Flow_pul.obs.sig <- 1.08
Pct_M_fat.obs.mu <- Pct_M_fat; Pct_M_fat.obs.sig <- 1.08

Vent_Perf.pst.mu <- 1.19; Vent_Perf.pst.sig <- 1.13
Pct_LM_liv.pst.mu <- 0.033; Pct_LM_liv.pst.sig <- 1.04
Pct_LM_wp.pst.mu <- 0.196; Pct_LM_wp.pst.sig <- 1.09
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
  LeanBodyWt.2 <- rlnorm(1000, log(LeanBodyWt.obs.mu), log(LeanBodyWt.obs.sig)) 
  Flow_pul.2 <- rlnorm(1000, log(Flow_pul.obs.mu), log(Flow_pul.obs.sig))
  Vent_Perf.2 <- rlnorm(1000, log(Vent_Perf.pst.mu), log(Vent_Perf.pst.sig))
  Pct_M_fat.2 <- rlnorm(1000, log(Pct_M_fat.obs.mu), log(Pct_M_fat.obs.sig))
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

setwd(paste(getwd(), "/perc", sep=""))

# Parameter distribution
pdf(file="fig1.pdf", width = 9, height = 7)
#png(file="fig2.png",width=2000,height=1200,res=250)
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
dev.off()


setpt1.df <- cbind(1, log(df.pri))
write.table(setpt1.df, file="perc.setpoint.dat", row.names=FALSE, sep="\t")
system("./mcsim.perc perc.setpt1.in")
sim1 <- as.data.frame(fread("perc.setpoint.out", head = T))

setpt2.df <- cbind(1, log(df.pst))
write.table(setpt2.df, file="perc.setpoint.dat", row.names=FALSE, sep="\t")
system("./mcsim.perc perc.setpt1.in")
sim2 <- as.data.frame(fread("perc.setpoint.out", head = T))

time<-c(60, 120, 239.9, 245, 270, 360, 480, 720, 1440, 2880)/60

conc<-function(conc1st, conclast){
  sim.str<-which(names(sim1)==conc1st)
  sim.end<-which(names(sim1)==conclast)
  sim.str:sim.end
}

C_exh_ug_1<-conc("C_exh_ug_1.1", "C_exh_ug_1.10")
C_ven_ug_1<-conc("C_ven_ug_1.1", "C_ven_ug_1.10")
Q_met_1<-conc("Q_met_ug_1.1", "Q_met_ug_1.10")
C_exh_ug_2<-conc("C_exh_ug_2.1", "C_exh_ug_2.10")
C_ven_ug_2<-conc("C_ven_ug_2.1", "C_ven_ug_2.10")
Q_met_2<-conc("Q_met_ug_2.1", "Q_met_ug_2.10")
C_exh_ug_3<-conc("C_exh_ug_3.1", "C_exh_ug_3.10")
C_ven_ug_3<-conc("C_ven_ug_3.1", "C_ven_ug_3.10")
Q_met_3<-conc("Q_met_ug_3.1", "Q_met_ug_3.10")

#

TK.plt<-function(j, mtext, col, ylim, ylwr, yupr){
  for (i in 1:dim(sim1)[1]) {
    if (i == 1) {
      plot(time, sim1[i,j], xlab = "", ylab = "", yaxt="n",
           main = "", las = 1, col = "grey", pch = 20, cex.lab = 1.5,
           type = "l", log = "y", ylim = ylim)
      mtext(mtext, cex = 1, col = col)
      
      ticks <- seq(ylwr, yupr, by=2)
      labels <- sapply(ticks, function(i) as.expression(bquote(10^ .(i))))
      axis(2, at=c(10^ticks[1], 10^ticks[2], 10^ticks[3], 10^ticks[4], 10^ticks[5]),
           labels=labels)
      
      
    } else {
      plot(time, sim1[i,j], xlab = "", ylab = "", xaxt = "n", yaxt = "n",
           main = "", las = 1, col = "grey", pch = 20, lwd= 0.1,
           type = "l", log = "y", ylim = ylim) 
    }
    par(new=T)
  }
  par(new=F)
  
  for (i in 1:dim(sim2)[1]) {
    lines(time, sim2[i,j], lwd= 0.1, col=col)  
  }
}

pdf(file="fig2.pdf", width = 9, height = 7)
#png(file="fig2.png",width=2000,height=1200,res=250)
par(mfrow=c(3,3), mar = c(2, 2, 3, 1), oma = c(3,3,2,0))
TK.plt(C_exh_ug_1, expression(paste("Exhaled air, ",mu, "g/L")), "blue", c(1E-4, 1E4), -4, 4)
TK.plt(C_exh_ug_2, expression(paste("Exhaled air, ",mu, "g/L")), "blue", c(1E-4, 1E4), -4, 4)
TK.plt(C_exh_ug_3, expression(paste("Exhaled air, ",mu, "g/L")), "red", c(1E-4, 1E4), -4, 4)

TK.plt(C_ven_ug_1, expression(paste("Blood, ",mu, "g/L")), "blue", c(1E-3, 1E5), -3, 5)
TK.plt(C_ven_ug_2, expression(paste("Blood, ",mu, "g/L")), "blue", c(1E-3, 1E5), -3, 5)
TK.plt(C_ven_ug_3, expression(paste("Blood, ",mu, "g/L")), "red", c(1E-3, 1E5), -3, 5)

TK.plt(Q_met_1, expression(paste("Metabolized, ",mu, "g")), "blue", c(1E-1, 1E7), -1, 7)
TK.plt(Q_met_2, expression(paste("Metabolized, ",mu, "g")), "blue", c(1E-1, 1E7), -1, 7)
TK.plt(Q_met_3, expression(paste("Metabolized, ",mu, "g")), "red", c(1E-3, 1E5), -3, 5)

mtext("Concentration", WEST<-2, line=0.6, cex=1, outer=TRUE) 
mtext("Time, hr", South<-1, line=0.6, cex=1, outer=TRUE) 
mtext("Inhalation = 72 ppm", NORTH<-3, line=-1, adj=0.3, cex=1.2, outer=TRUE, col="blue")
mtext("Ingestion = 72 mg", NORTH<-3, line=-1, adj=0.93, cex=1.2, outer=TRUE, col="red")
dev.off()

#
set.seed(1234)
morr <- morris(model = NULL, factors = 16, r = 100, 
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

options(scipen = 6)
pdf(file="fig3x.pdf", width = 8, height = 8)
#png(file="fig2.png",width=2000,height=1200,res=250)
par(mfrow=c(3,3), mar = c(2, 2, 3, 1), oma = c(3,3,1,0))
xlab <- expression(paste(mu,"*"))
labels <- c("LeanBodyWt", "Flow_pul", "Vent_Perf", 
            "Pct_M_fat", "Pct_LM_liv", "Pct_LM_wp",
            "Pct_Flow_fat", "Pct_Flow_liv", "Pct_Flow_pp",
            "PC_fat", "PC_liv", "PC_wp", "PC_pp", "PC_art",
            "sc_Vmax", "Km")

plot(mu.star.1.1, sigma.1.1, main = "4-hr exposure \n Exhaled air",
     col = "white", xlab = "", ylab = "",
     xlim=NULL)
text(mu.star.1.1, sigma.1.1, labels = labels, cex=0.8)
plot(mu.star.2.1, sigma.2.1, main = "48-hr exposure \n Exhaled air",
     col = "white", xlab = "", ylab = "",
     xlim=NULL)
text(mu.star.2.1, sigma.2.1, labels = labels, cex=0.8)
plot(mu.star.3.1, sigma.3.1, main = "1-time oral dose \n Exhaled air",
     col = "white", xlab = "", ylab = "",
     xlim=NULL)
text(mu.star.3.1, sigma.3.1, labels = labels, cex=0.8)

plot(mu.star.1.2, sigma.1.2, main = "Blood",
     col = "white", xlab = "", ylab = "",
     xlim=NULL)
text(mu.star.1.2, sigma.1.2, labels = labels, cex=0.8)
plot(mu.star.2.2, sigma.2.2, main = "Blood",
     col = "white", xlab = "", ylab = "",
     xlim=NULL)
text(mu.star.2.2, sigma.2.2, labels = labels, cex=0.8)
plot(mu.star.3.2, sigma.3.2, main = "Blood",
     col = "white", xlab = "", ylab = "",
     xlim=NULL)
text(mu.star.3.2, sigma.3.2, labels = labels, cex=0.8)

plot(mu.star.1.3, sigma.1.3, main = "Metabolized",
     col = "white", xlab = "", ylab = "",
     xlim=NULL)
text(mu.star.1.3, sigma.1.3, labels = labels, cex=0.8)
plot(mu.star.2.3, sigma.2.3, main = "Metabolized",
     col = "white", xlab = "", ylab = "",
     xlim=NULL)
text(mu.star.2.3, sigma.2.3, labels = labels, cex=0.8)
plot(mu.star.3.3, sigma.3.3, main = "Metabolized",
     col = "white", xlab = "", ylab = "",
     xlim=NULL)
text(mu.star.3.3, sigma.3.3, labels = labels, cex=0.8)
mtext(expression(~sigma), WEST<-2, line=0.7, cex=1, outer=TRUE) 
mtext(expression(paste(mu,"*")), South<-1, line=0.7, cex=1, outer=TRUE) 
dev.off()

#
q <- rep("qtri", 16)
q.arg <- list(list(log(LeanBodyWt_min), log(LeanBodyWt_max), log(LeanBodyWt)),
              list(log(Flow_pul_min), log(Flow_pul_max), log(Flow_pul)),
              list(log(Vent_Perf_min), log(Vent_Perf_max), log(Vent_Perf)),
              list(log(Pct_M_fat_min), log(Pct_M_fat_max), log(Pct_M_fat)),
              list(log(Pct_LM_liv_min), log(Pct_LM_liv_max), log(Pct_LM_liv)),
              list(log(Pct_LM_wp_min), log(Pct_LM_wp_max), log(Pct_LM_wp)),
              list(log(Pct_Flow_fat_min), log(Pct_Flow_fat_max), log(Pct_Flow_fat)),
              list(log(Pct_Flow_liv_min), log(Pct_Flow_liv_max), log(Pct_Flow_liv)),
              list(log(Pct_Flow_pp_min), log(Pct_Flow_pp_max), log(Pct_Flow_pp)),
              list(log(PC_fat_min), log(PC_fat_max), log(PC_fat)),
              list(log(PC_liv_min), log(PC_liv_max), log(PC_liv)),
              list(log(PC_wp_min), log(PC_wp_max), log(PC_wp)),
              list(log(PC_pp_min), log(PC_pp_max), log(PC_pp)),
              list(log(PC_art_min), log(PC_art_max), log(PC_art)),
              list(log(sc_Vmax_min), log(sc_Vmax_max), log(sc_Vmax)),
              list(log(Km_min), log(Km_max), log(Km)))

fast <- fast99(model = NULL, factors = 16, n = 8192, M = 4, q = q, q.arg = q.arg)

fast.perc.df <- cbind(1, fast$X) # nrow = 131072
write.table(fast.perc.df, file="perc.setpoint.dat", row.names=FALSE, sep="\t")
system("./mcsim.perc perc.setpt2.in")
sim.fast <- as.data.frame(fread("perc.setpoint.out", head=T)) 

fst.1.1 <- tell(fast, sim.fast[,ncol(fast$X)+2])
fst.1.2 <- tell(fast, sim.fast[,ncol(fast$X)+3])
fst.1.3 <- tell(fast, sim.fast[,ncol(fast$X)+4])

fst.2.1 <- tell(fast, sim.fast[,ncol(fast$X)+5])
fst.2.2 <- tell(fast, sim.fast[,ncol(fast$X)+6])
fst.2.3 <- tell(fast, sim.fast[,ncol(fast$X)+7])

fst.3.1 <- tell(fast, sim.fast[,ncol(fast$X)+8])
fst.3.2 <- tell(fast, sim.fast[,ncol(fast$X)+9])
fst.3.3 <- tell(fast, sim.fast[,ncol(fast$X)+10])

#
fast.table<-function(dataset){
  rbind(print(dataset)[1:16], print(dataset)[17:32]-print(dataset)[1:16])
}

f.table.1.1 <- fast.table(fst.1.1)
f.table.2.1 <- fast.table(fst.2.1)
f.table.3.1 <- fast.table(fst.3.1)
f.table.1.2 <- fast.table(fst.1.2)
f.table.2.2 <- fast.table(fst.2.2)
f.table.3.2 <- fast.table(fst.3.2)
f.table.1.3 <- fast.table(fst.1.3)
f.table.2.3 <- fast.table(fst.2.3)
f.table.3.3 <- fast.table(fst.3.3)

# pst
q <- rep("qnormTrunc", 16)
q.arg <- list(list(log(LeanBodyWt.obs.mu), log(LeanBodyWt.obs.sig), log(LeanBodyWt_min), log(LeanBodyWt_max)),
              list(log(Flow_pul.obs.mu), log(Flow_pul.obs.sig), log(Flow_pul_min), log(Flow_pul_max)),
              list(log(Vent_Perf.pst.mu), log(Vent_Perf.pst.sig), log(Vent_Perf_min), log(Vent_Perf_max)),
              list(log(Pct_M_fat.obs.mu), log(Pct_M_fat.obs.sig), log(Pct_M_fat_min), log(Pct_M_fat_max)),
              list(log(Pct_LM_liv.pst.mu), log(Pct_LM_liv.pst.sig), log(Pct_LM_liv_min), log(Pct_LM_liv_max)),
              list(log(Pct_LM_wp.pst.mu), log(Pct_LM_wp.pst.sig), log(Pct_LM_wp_min), log(Pct_LM_wp_max)),
              list(log(Pct_Flow_fat.pst.mu), log(Pct_Flow_fat.pst.sig), log(Pct_Flow_fat_min), log(Pct_Flow_fat_max)),
              list(log(Pct_Flow_liv.pst.mu), log(Pct_Flow_liv.pst.sig), log(Pct_Flow_liv_min), log(Pct_Flow_liv_max)),
              list(log(Pct_Flow_pp.pst.mu), log(Pct_Flow_pp.pst.sig), log(Pct_Flow_pp_min), log(Pct_Flow_pp_max)),
              list(log(PC_fat.pst.mu), log(PC_fat.pst.sig), log(PC_fat_min), log(PC_fat_max)),
              list(log(PC_liv.pst.mu), log(PC_liv.pst.sig), log(PC_liv_min), log(PC_liv_max)),
              list(log(PC_wp.pst.mu), log(PC_wp.pst.sig), log(PC_wp_min), log(PC_wp_max)),
              list(log(PC_pp.pst.mu), log(PC_pp.pst.sig), log(PC_pp_min), log(PC_pp_max)),
              list(log(PC_art.pst.mu), log(PC_art.pst.sig), log(PC_art_min), log(PC_art_max)),
              list(log(sc_Vmax.pst.mu), log(sc_Vmax.pst.sig), log(sc_Vmax_min), log(sc_Vmax_max)),
              list(log(Km.pst.mu), log(Km.pst.sig), log(Km_min), log(Km_max)))

fst2 <- fast99(model = NULL, factors = 16, n = 8192, M = 4, q = q, q.arg = q.arg)
fst2.perc.df <- cbind(1, fst2$X) # nrow = 131072
write.table(fst2.perc.df, file="perc.setpoint.dat", row.names=FALSE, sep="\t")
system("./mcsim.perc perc.setpt2.in")
sim.fst2 <- as.data.frame(fread("perc.setpoint.out", head=T)) 

fst2.1.1 <- tell(fst2, sim.fst2[,ncol(morr$X)+2])
fst2.1.2 <- tell(fst2, sim.fst2[,ncol(morr$X)+3])
fst2.1.3 <- tell(fst2, sim.fst2[,ncol(morr$X)+4])

fst2.2.1 <- tell(fst2, sim.fst2[,ncol(morr$X)+5])
fst2.2.2 <- tell(fst2, sim.fst2[,ncol(morr$X)+6])
fst2.2.3 <- tell(fst2, sim.fst2[,ncol(morr$X)+7])

fst2.3.1 <- tell(fst2, sim.fst2[,ncol(morr$X)+8])
fst2.3.2 <- tell(fst2, sim.fst2[,ncol(morr$X)+9])
fst2.3.3 <- tell(fst2, sim.fst2[,ncol(morr$X)+10])

f2.table.1.1 <- fast.table(fst2.1.1)
f2.table.2.1 <- fast.table(fst2.2.1)
f2.table.3.1 <- fast.table(fst2.3.1)
f2.table.1.2 <- fast.table(fst2.1.2)
f2.table.2.2 <- fast.table(fst2.2.2)
f2.table.3.2 <- fast.table(fst2.3.2)
f2.table.1.3 <- fast.table(fst2.1.3)
f2.table.2.3 <- fast.table(fst2.2.3)
f2.table.3.3 <- fast.table(fst2.3.3)


pdf(file="fig3.pdf", width = 9, height = 8)
par(mfrow=c(3,3), mar = c(4, 2, 3, 1), oma = c(3,3,1,0))
bp11<-barplot(f.table.1.1, ylim = c(0,1), col=c("white","grey"))
text(bp11, par('usr')[3], labels = labels, srt = 45, adj = c(1.1,1.1), xpd = TRUE, cex=.9)
bp21<-barplot(f.table.2.1, ylim = c(0,1), col=c("white","grey"))
text(bp21, par('usr')[3], labels = labels, srt = 45, adj = c(1.1,1.1), xpd = TRUE, cex=.9)
bp31<-barplot(f.table.3.1, ylim = c(0,1), col=c("white","grey"))
text(bp31, par('usr')[3], labels = labels, srt = 45, adj = c(1.1,1.1), xpd = TRUE, cex=.9)

bp12<-barplot(f.table.1.2, ylim = c(0,1), col=c("white","grey"))
text(bp12, par('usr')[3], labels = labels, srt = 45, adj = c(1.1,1.1), xpd = TRUE, cex=.9)
bp22<-barplot(f.table.2.2, ylim = c(0,1), col=c("white","grey"))
text(bp22, par('usr')[3], labels = labels, srt = 45, adj = c(1.1,1.1), xpd = TRUE, cex=.9)
bp32<-barplot(f.table.3.2, ylim = c(0,1), col=c("white","grey"))
text(bp32, par('usr')[3], labels = labels, srt = 45, adj = c(1.1,1.1), xpd = TRUE, cex=.9)

bp13<-barplot(f.table.1.3, ylim = c(0,1), col=c("white","grey"))
text(bp13, par('usr')[3], labels = labels, srt = 45, adj = c(1.1,1.1), xpd = TRUE, cex=.9)
bp23<-barplot(f.table.2.3, ylim = c(0,1), col=c("white","grey"))
text(bp23, par('usr')[3], labels = labels, srt = 45, adj = c(1.1,1.1), xpd = TRUE, cex=.9)
bp33<-barplot(f.table.3.3, ylim = c(0,1), col=c("white","grey"))
text(bp33, par('usr')[3], labels = labels, srt = 45, adj = c(1.1,1.1), xpd = TRUE, cex=.9)

# subplot
par(fig=c(0.05,0.25,0.74,0.98), new=TRUE)
plot(mu.star.1.1, sigma.1.1, main = "",
     col = "white", xlab = "", ylab = "",
     xlim=NULL)
text(mu.star.1.1, sigma.1.1, labels = labels, cex=0.8)
mtext(expression(~sigma), side=2, line=2, cex.lab=0.4)
mtext(expression(paste(mu,"*")), side=1, line=2, cex.lab=0.4)

par(fig=c(0.38,0.58,0.74,0.98), new=TRUE)
plot(mu.star.2.1, sigma.2.1, main = "",
     col = "white", xlab = "", ylab = "",
     xlim=NULL)
text(mu.star.2.1, sigma.2.1, labels = labels, cex=0.8)
par(fig=c(0.72,0.92,0.74,0.98), new=TRUE)
plot(mu.star.3.1, sigma.3.1, main = "",
     col = "white", xlab = "", ylab = "",
     xlim=NULL)
text(mu.star.3.1, sigma.3.1, labels = labels, cex=0.8)

par(fig=c(0.05,0.25,0.42,0.66), new=TRUE)
plot(mu.star.1.2, sigma.1.2, main = "",
     col = "white", xlab = "", ylab = "",
     xlim=NULL)
text(mu.star.1.2, sigma.1.2, labels = labels, cex=0.8)
par(fig=c(0.38,0.58,0.42,0.66), new=TRUE)
plot(mu.star.2.2, sigma.2.2, main = "",
     col = "white", xlab = "", ylab = "",
     xlim=NULL)
text(mu.star.2.2, sigma.2.2, labels = labels, cex=0.8)
par(fig=c(0.72,0.92,0.42,0.66), new=TRUE)
plot(mu.star.3.2, sigma.3.2, main = "",
     col = "white", xlab = "", ylab = "",
     xlim=NULL)
text(mu.star.3.2, sigma.3.2, labels = labels, cex=0.8)


par(fig=c(0.05,0.25,0.08,0.32), new=TRUE)
plot(mu.star.1.3, sigma.1.3, main = "",
     col = "white", xlab = "", ylab = "",
     xlim=NULL)
text(mu.star.1.3, sigma.1.3, labels = labels, cex=0.8)
par(fig=c(0.38,0.58,0.08,0.32), new=TRUE)
plot(mu.star.2.3, sigma.2.3, main = "",
     col = "white", xlab = "", ylab = "",
     xlim=NULL)
text(mu.star.2.3, sigma.2.3, labels = labels, cex=0.8)
par(fig=c(0.72,0.92,0.08,0.32), new=TRUE)
plot(mu.star.3.3, sigma.3.3, main = "",
     col = "white", xlab = "", ylab = "",
     xlim=NULL)
text(mu.star.3.3, sigma.3.3, labels = labels, cex=0.8)

#par(fig=c(0.05,0.25,0.76,0.98), new=TRUE)
#barplot(f2.table.1.1, ylim = c(0,1), col=c("white","grey"))
#par(fig=c(0.38,0.58,0.76,0.98), new=TRUE)
#barplot(f2.table.2.1, ylim = c(0,1), col=c("white","grey"))
#par(fig=c(0.72,0.92,0.76,0.98), new=TRUE)
#barplot(f2.table.3.1, ylim = c(0,1), col=c("white","grey"))

#par(fig=c(0.05,0.25,0.42,0.64), new=TRUE)
#barplot(f2.table.1.2, ylim = c(0,1), col=c("white","grey"))
#par(fig=c(0.38,0.58,0.42,0.64), new=TRUE)
#barplot(f2.table.2.2, ylim = c(0,1), col=c("white","grey"))
#par(fig=c(0.72,0.92,0.42,0.64), new=TRUE)
#barplot(f2.table.3.2, ylim = c(0,1), col=c("white","grey"))

#par(fig=c(0.05,0.25,0.08,0.3), new=TRUE)
#barplot(f2.table.1.2, ylim = c(0,1), col=c("white","grey"))
#par(fig=c(0.38,0.58,0.08,0.3), new=TRUE)
#barplot(f2.table.2.2, ylim = c(0,1), col=c("white","grey"))
#par(fig=c(0.72,0.92,0.08,0.3), new=TRUE)
#barplot(f2.table.3.2, ylim = c(0,1), col=c("white","grey"))

mtext("Sobol sensitivity index", WEST<-2, line=0.7, cex=1.2, outer=TRUE) 
mtext("Parameter", South<-1, line=0.7, cex=1.2, outer=TRUE) 
dev.off()


