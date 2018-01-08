if(!require(sensitivity)) {
  install.packages("sensitivity"); require(sensitivity)}
if(!require(EnvStats)) {
  install.packages("EnvStats"); require(EnvStats)}
if(!require(data.table)) {
  install.packages("data.table"); require(data.table)}

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

QCC <- log(16.2)

VFC <- log(0.214) # Fat
VKC <- log(0.0044) # Kidney
VGC <- log(0.0144) # Gut
VLC <- log(0.0257) # Hepatic artery
VMC <- log(0.4) # Muscle
VBLAC <- log(0.0243)  # Arterial Blood
VBLVC <- log(0.0557) # Venous Blood
VSC <- log(0.185) # Slowly Perfused
#VRC <- 0.0765  # Rapidly Perfused (1- everything else)

QFC  <- log(0.052) # Fat
QKC  <- log(0.175) # Kidney
QGC  <- log(0.181) # Gut
QLBC <- log(0.046) # Hepatic artery
QMC  <- log(0.191) # Muscle
QSC  <- log(0.14) # Slowly Perfused
# QRC  <- 0.215  # Rapidly Perfused (1 -  everything else)

BP_APAP = log(0.9)

PF_APAP = log(0.447)   # Fat:blood
PG_APAP = log(0.907)    # Gut:blood
PK_APAP = log(0.711)    # Kidney:blood
PL_APAP = log(0.687)    # Liver:blood
PM_APAP = log(0.687)    # Muscle:blood
PR_APAP = log(0.676)   # rapidly perfused:blood [brain, lung, spleen]
PS_APAP = log(0.606)    # slowly perfused:blood [bone, heart, skin]

PF_AS = log(0.088)
PG_AS = log(0.297)
PK_AS = log(0.261)
PL_AS = log(0.203)
PM_AS = log(0.199)
PR_AS = log(0.207)
PS_AS = log(0.254)

PF_AG = log(0.128)
PG_AG = log(0.436)
PK_AG = log(0.392)
PL_AG = log(0.321)
PM_AG = log(0.336)
PR_AG = log(0.364)
PS_AG = log(0.351)

r <- 2.0 # narrow down the range to prevent calculation error
r_QCC <- 0.8 # From Chiu et al. (2009)

r_VFC <- 0.45 # From Chiu et al. (2009)
r_VKC <- 0.17 # From Chiu et al. (2009)
r_VGC <- 0.08 # From Chiu et al. (2009)
r_VLC <- 0.23 # From Chiu et al. (2009)
r_VMC <-  0.34 # From Price et al. (2003), CV = 0.20
r_VBLAC <- 0.12 # From Chiu et al. (2009)
r_VBLVC <- 0.12 # From Chiu et al. (2009)
r_VSC <- 0.34 # From Price et al. (2003), CV = 0.20

r_QFC <- 0.46 # From Chiu et al. (2009)
r_QGC <- 0.18 # From Chiu et al. (2009)
r_QLBC <- 0.45 # From Chiu et al. (2009)
r_QKC <- 0.12 # From Chiu et al. (2009)
r_QSC <- 0.32 # From Chiu et al. (2009)
r_QMC <- 0.35 # From Price et al. (2003), CV = 0.20

r_pc <- 1.2 # Assumed

# sd(exp(runif(1000, QFC-r_QFC, QFC+r_QFC)))/mean(exp(runif(1000, QFC-r_QFC, QFC+r_QFC)))
# sd(exp(runif(1000, QLBC-r_QLBC, QLBC+r_QLBC)))/mean(exp(runif(1000, QLBC-r_QLBC, QLBC+r_QLBC)))
# sd(exp(runif(1000, QSC-r_QSC, QSC+r_QSC)))/mean(exp(runif(1000, QSC-r_QSC, QSC+r_QSC)))

# sd(exp(runif(1000, VMC-r_VMC, VMC+r_VMC)))/mean(exp(runif(1000, VMC-r_VMC, VMC+r_VMC)))
# sd(exp(runif(1000, VSC-r_VSC, VSC+r_VSC)))/mean(exp(runif(1000, VSC-r_VSC, VSC+r_VSC)))

#
exp(QFC+r_QFC)+exp(QGC+r_QGC)+exp(QLBC+r_QLBC)+exp(QKC+r_QKC)+exp(QSC+r_QSC)+exp(QMC+r_QMC)

#
binf<-c(Tg-r, 
        Tp-r, 
        CYP_Km-r, 
        -2, 
        SULT_Km_apap-r, 
        SULT_Ki-r,
        SULT_Km_paps-r, 
        0, 
        UGT_Km-r,
        UGT_Ki-r,
        UGT_Km_GA-r, 
        0, 
        Km_AG-r, 
        7, 
        Km_AS-r,
        7, 
        0, 
        0, 
        -6, 
        -6, 
        -6,
        QCC-r_QCC,
        VFC-r_VFC,
        VKC-r_VKC,
        VGC-r_VGC,
        VLC-r_VLC,
        VMC-r_VMC,
        VBLAC-r_VBLAC,
        VBLVC-r_VBLVC,
        VSC-r_VSC,
        QFC-r_QFC,
        QKC-r_QKC,
        QGC-r_QGC,
        QLBC-r_QLBC,
        QMC-r_QMC,
        QSC-r_QSC,  
        0.1,
        PF_APAP-r_pc,
        PG_APAP-r_pc,
        PK_APAP-r_pc,
        PL_APAP-r_pc,
        PM_APAP-r_pc,
        PR_APAP-r_pc,
        PS_APAP-r_pc,
        PF_AS-r_pc,
        PG_AS-r_pc,
        PK_AS-r_pc,
        PL_AS-r_pc,
        PM_AS-r_pc,
        PR_AS-r_pc,
        PS_AS-r_pc,
        PF_AG-r_pc,
        PG_AG-r_pc,
        PK_AG-r_pc,
        PL_AG-r_pc,
        PM_AG-r_pc,
        PR_AG-r_pc,
        PS_AG-r_pc)

bsup<-c(Tg+r, 
        Tp+r, 
        CYP_Km+r, 
        5, 
        SULT_Km_apap+r, 
        SULT_Ki+r,
        SULT_Km_paps+r, 
        10, 
        UGT_Km+r,
        UGT_Ki+r,
        UGT_Km_GA+r, 
        10, 
        Km_AG+r, 
        15, 
        Km_AS+r,
        15, 
        13, 
        13, 
        1, 
        1, 
        1,
        QCC+r_QCC,
        VFC+r_VFC,
        VKC+r_VKC,
        VGC+r_VGC,
        VLC+r_VLC,
        VMC+r_VMC,
        VBLAC+r_VBLAC,
        VBLVC+r_VBLVC,
        VSC+r_VSC,
        QFC+r_QFC,
        QKC+r_QKC,
        QGC+r_QGC,
        QLBC+r_QLBC,
        QMC+r_QMC,
        QSC+r_QSC,  
        1,
        PF_APAP+r_pc,
        PG_APAP+r_pc,
        PK_APAP+r_pc,
        PL_APAP+r_pc,
        PM_APAP+r_pc,
        PR_APAP+r_pc,
        PS_APAP+r_pc,
        PF_AS+r_pc,
        PG_AS+r_pc,
        PK_AS+r_pc,
        PL_AS+r_pc,
        PM_AS+r_pc,
        PR_AS+r_pc,
        PS_AS+r_pc,
        PF_AG+r_pc,
        PG_AG+r_pc,
        PK_AG+r_pc,
        PL_AG+r_pc,
        PM_AG+r_pc,
        PR_AG+r_pc,
        PS_AG+r_pc)

#round(log(binf), digits=4)
#round(log(bsup), digits=4)

morr <- morris(model = NULL, factors = 58, r = 1024, 
               design = list(type = "oat", levels = 5, grid.jump = 3), 
               binf = binf, bsup = bsup)
morr.APAP.df <- cbind(1, morr$X)
write.table(morr.APAP.df, file="apap_setpoint.dat", row.names=FALSE, sep="\t")
system("./mcsim.apap.pbpk_v2 apap.setpoint_v2.in")
mor.APAP.mcsim.df <- as.data.frame(fread("apap_setpoint.csv", head = T))

mor.APAP.1.1 <- tell(morr, mor.APAP.mcsim.df[,60])
mor.APAP.1.2 <- tell(morr, mor.APAP.mcsim.df[,61])
mor.APAP.1.3 <- tell(morr, mor.APAP.mcsim.df[,62])
mor.APAP.1.4 <- tell(morr, mor.APAP.mcsim.df[,63])
mor.APAP.1.5 <- tell(morr, mor.APAP.mcsim.df[,64])
mor.APAP.1.6 <- tell(morr, mor.APAP.mcsim.df[,65])
mor.APAP.1.7 <- tell(morr, mor.APAP.mcsim.df[,66])
mor.APAP.1.8 <- tell(morr, mor.APAP.mcsim.df[,67])
mor.APAP.2.1 <- tell(morr, mor.APAP.mcsim.df[,68])
mor.APAP.2.2 <- tell(morr, mor.APAP.mcsim.df[,69])
mor.APAP.2.3 <- tell(morr, mor.APAP.mcsim.df[,70])
mor.APAP.2.4 <- tell(morr, mor.APAP.mcsim.df[,71])
mor.APAP.2.5 <- tell(morr, mor.APAP.mcsim.df[,72])
mor.APAP.2.6 <- tell(morr, mor.APAP.mcsim.df[,73])
mor.APAP.2.7 <- tell(morr, mor.APAP.mcsim.df[,74])
mor.APAP.2.8 <- tell(morr, mor.APAP.mcsim.df[,75])
mor.APAP.3.1 <- tell(morr, mor.APAP.mcsim.df[,76])
mor.APAP.3.2 <- tell(morr, mor.APAP.mcsim.df[,77])
mor.APAP.3.3 <- tell(morr, mor.APAP.mcsim.df[,78])
mor.APAP.3.4 <- tell(morr, mor.APAP.mcsim.df[,79])
mor.APAP.3.5 <- tell(morr, mor.APAP.mcsim.df[,80])
mor.APAP.3.6 <- tell(morr, mor.APAP.mcsim.df[,81])
mor.APAP.3.7 <- tell(morr, mor.APAP.mcsim.df[,82])
mor.APAP.3.8 <- tell(morr, mor.APAP.mcsim.df[,83])

mu.1.1 <- apply(mor.APAP.1.1$ee, 2, function(x) mean(abs(x)))
mu.1.2 <- apply(mor.APAP.1.2$ee, 2, function(x) mean(abs(x)))
mu.1.3 <- apply(mor.APAP.1.3$ee, 2, function(x) mean(abs(x)))
mu.1.4 <- apply(mor.APAP.1.4$ee, 2, function(x) mean(abs(x)))
mu.1.5 <- apply(mor.APAP.1.5$ee, 2, function(x) mean(abs(x)))
mu.1.6 <- apply(mor.APAP.1.6$ee, 2, function(x) mean(abs(x)))
mu.1.7 <- apply(mor.APAP.1.7$ee, 2, function(x) mean(abs(x)))
mu.1.8 <- apply(mor.APAP.1.8$ee, 2, function(x) mean(abs(x)))
mu.2.1 <- apply(mor.APAP.2.1$ee, 2, function(x) mean(abs(x)))
mu.2.2 <- apply(mor.APAP.2.2$ee, 2, function(x) mean(abs(x)))
mu.2.3 <- apply(mor.APAP.2.3$ee, 2, function(x) mean(abs(x)))
mu.2.4 <- apply(mor.APAP.2.4$ee, 2, function(x) mean(abs(x)))
mu.2.5 <- apply(mor.APAP.2.5$ee, 2, function(x) mean(abs(x)))
mu.2.6 <- apply(mor.APAP.2.6$ee, 2, function(x) mean(abs(x)))
mu.2.7 <- apply(mor.APAP.2.7$ee, 2, function(x) mean(abs(x)))
mu.2.8 <- apply(mor.APAP.2.8$ee, 2, function(x) mean(abs(x)))
mu.3.1 <- apply(mor.APAP.3.1$ee, 2, function(x) mean(abs(x)))
mu.3.2 <- apply(mor.APAP.3.2$ee, 2, function(x) mean(abs(x)))
mu.3.3 <- apply(mor.APAP.3.3$ee, 2, function(x) mean(abs(x)))
mu.3.4 <- apply(mor.APAP.3.4$ee, 2, function(x) mean(abs(x)))
mu.3.5 <- apply(mor.APAP.3.5$ee, 2, function(x) mean(abs(x)))
mu.3.6 <- apply(mor.APAP.3.6$ee, 2, function(x) mean(abs(x)))
mu.3.7 <- apply(mor.APAP.3.7$ee, 2, function(x) mean(abs(x)))
mu.3.8 <- apply(mor.APAP.3.8$ee, 2, function(x) mean(abs(x)))

sig.1.1 <- apply(mor.APAP.1.1$ee, 2, sd)
sig.1.2 <- apply(mor.APAP.1.2$ee, 2, sd)
sig.1.3 <- apply(mor.APAP.1.3$ee, 2, sd)
sig.1.4 <- apply(mor.APAP.1.4$ee, 2, sd)
sig.1.5 <- apply(mor.APAP.1.5$ee, 2, sd)
sig.1.6 <- apply(mor.APAP.1.6$ee, 2, sd)
sig.1.7 <- apply(mor.APAP.1.7$ee, 2, sd)
sig.1.8 <- apply(mor.APAP.1.8$ee, 2, sd)
sig.2.1 <- apply(mor.APAP.2.1$ee, 2, sd)
sig.2.2 <- apply(mor.APAP.2.2$ee, 2, sd)
sig.2.3 <- apply(mor.APAP.2.3$ee, 2, sd)
sig.2.4 <- apply(mor.APAP.2.4$ee, 2, sd)
sig.2.5 <- apply(mor.APAP.2.5$ee, 2, sd)
sig.2.6 <- apply(mor.APAP.2.6$ee, 2, sd)
sig.2.7 <- apply(mor.APAP.2.7$ee, 2, sd)
sig.2.8 <- apply(mor.APAP.2.8$ee, 2, sd)
sig.3.1 <- apply(mor.APAP.3.1$ee, 2, sd)
sig.3.2 <- apply(mor.APAP.3.2$ee, 2, sd)
sig.3.3 <- apply(mor.APAP.3.3$ee, 2, sd)
sig.3.4 <- apply(mor.APAP.3.4$ee, 2, sd)
sig.3.5 <- apply(mor.APAP.3.5$ee, 2, sd)
sig.3.6 <- apply(mor.APAP.3.6$ee, 2, sd)
sig.3.7 <- apply(mor.APAP.3.7$ee, 2, sd)
sig.3.8 <- apply(mor.APAP.3.8$ee, 2, sd)

Parameter <- c("Tg", "Tp","CYP_Km","CYP_VmaxC","SULT_Km_apap","SULT_Ki",
               "SULT_Km_paps","SULT_VmaxC","UGT_Km","UGT_Ki",
               "UGT_Km_GA","UGT_VmaxC","Km_AG","Vmax_AG","Km_AS",
               "Vmax_AS","kGA_syn","kPAPS_syn","CLC_APAP","CLC_AG","CLC_AS",
               "QCC","VFC","VKC","VGC","VLC","VMC","VBLAC","VBLVC","VSC",
               "QFC","QKC","QGC","QLBC","QMC","QSC",  
               "BP_APAP","PF_APAP","PG_APAP","PK_APAP","PL_APAP","PM_APAP","PR_APAP","PS_APAP",
               "PF_AS","PG_AS","PK_AS","PL_AS","PM_AS","PR_AS","PS_AS",
               "PF_AG" ,"PG_AG","PK_AG","PL_AG","PM_AG","PR_AG","PS_AG")

apap.Mmu.df.1.1 <- data.frame(Parameter, mu.1.1)
apap.Mmu.df.1.2 <- data.frame(Parameter, mu.1.2)
apap.Mmu.df.1.3 <- data.frame(Parameter, mu.1.3)
apap.Mmu.df.1.4 <- data.frame(Parameter, mu.1.4)
apap.Mmu.df.1.5 <- data.frame(Parameter, mu.1.5)
apap.Mmu.df.1.6 <- data.frame(Parameter, mu.1.6)
apap.Mmu.df.1.7 <- data.frame(Parameter, mu.1.7)
apap.Mmu.df.1.8 <- data.frame(Parameter, mu.1.8)

apap.Mmu.df.2.1 <- data.frame(Parameter, mu.2.1)
apap.Mmu.df.2.2 <- data.frame(Parameter, mu.2.2)
apap.Mmu.df.2.3 <- data.frame(Parameter, mu.2.3)
apap.Mmu.df.2.4 <- data.frame(Parameter, mu.2.4)
apap.Mmu.df.2.5 <- data.frame(Parameter, mu.2.5)
apap.Mmu.df.2.6 <- data.frame(Parameter, mu.2.6)
apap.Mmu.df.2.7 <- data.frame(Parameter, mu.2.7)
apap.Mmu.df.2.8 <- data.frame(Parameter, mu.2.8)

apap.Mmu.df.3.1 <- data.frame(Parameter, mu.3.1)
apap.Mmu.df.3.2 <- data.frame(Parameter, mu.3.2)
apap.Mmu.df.3.3 <- data.frame(Parameter, mu.3.3)
apap.Mmu.df.3.4 <- data.frame(Parameter, mu.3.4)
apap.Mmu.df.3.5 <- data.frame(Parameter, mu.3.5)
apap.Mmu.df.3.6 <- data.frame(Parameter, mu.3.6)
apap.Mmu.df.3.7 <- data.frame(Parameter, mu.3.7)
apap.Mmu.df.3.8 <- data.frame(Parameter, mu.3.8)

apap.sig.df.1.1 <- data.frame(Parameter, sig.1.1)
apap.sig.df.1.2 <- data.frame(Parameter, sig.1.2)
apap.sig.df.1.3 <- data.frame(Parameter, sig.1.3)
apap.sig.df.1.4 <- data.frame(Parameter, sig.1.4)
apap.sig.df.1.5 <- data.frame(Parameter, sig.1.5)
apap.sig.df.1.6 <- data.frame(Parameter, sig.1.6)
apap.sig.df.1.7 <- data.frame(Parameter, sig.1.7)
apap.sig.df.1.8 <- data.frame(Parameter, sig.1.8)

apap.sig.df.2.1 <- data.frame(Parameter, sig.2.1)
apap.sig.df.2.2 <- data.frame(Parameter, sig.2.2)
apap.sig.df.2.3 <- data.frame(Parameter, sig.2.3)
apap.sig.df.2.4 <- data.frame(Parameter, sig.2.4)
apap.sig.df.2.5 <- data.frame(Parameter, sig.2.5)
apap.sig.df.2.6 <- data.frame(Parameter, sig.2.6)
apap.sig.df.2.7 <- data.frame(Parameter, sig.2.7)
apap.sig.df.2.8 <- data.frame(Parameter, sig.2.8)

apap.sig.df.3.1 <- data.frame(Parameter, sig.3.1)
apap.sig.df.3.2 <- data.frame(Parameter, sig.3.2)
apap.sig.df.3.3 <- data.frame(Parameter, sig.3.3)
apap.sig.df.3.4 <- data.frame(Parameter, sig.3.4)
apap.sig.df.3.5 <- data.frame(Parameter, sig.3.5)
apap.sig.df.3.6 <- data.frame(Parameter, sig.3.6)
apap.sig.df.3.7 <- data.frame(Parameter, sig.3.7)
apap.sig.df.3.8 <- data.frame(Parameter, sig.3.8)

save(apap.Mmu.df.1.1,apap.Mmu.df.1.2,apap.Mmu.df.1.3,apap.Mmu.df.1.4,
     apap.Mmu.df.1.5,apap.Mmu.df.1.6,apap.Mmu.df.1.7,apap.Mmu.df.1.8,
     apap.Mmu.df.2.1,apap.Mmu.df.2.2,apap.Mmu.df.2.3,apap.Mmu.df.2.4,
     apap.Mmu.df.2.5,apap.Mmu.df.2.6,apap.Mmu.df.2.7,apap.Mmu.df.2.8,
     apap.Mmu.df.3.1,apap.Mmu.df.3.2,apap.Mmu.df.3.3,apap.Mmu.df.3.4,
     apap.Mmu.df.3.5,apap.Mmu.df.3.6,apap.Mmu.df.3.7,apap.Mmu.df.3.8,
     apap.sig.df.1.1,apap.sig.df.1.2,apap.sig.df.1.3,apap.sig.df.1.4,
     apap.sig.df.1.5,apap.sig.df.1.6,apap.sig.df.1.7,apap.sig.df.1.8,
     apap.sig.df.2.1,apap.sig.df.2.2,apap.sig.df.2.3,apap.sig.df.2.4,
     apap.sig.df.2.5,apap.sig.df.2.6,apap.sig.df.2.7,apap.sig.df.2.8,
     apap.sig.df.3.1,apap.sig.df.3.2,apap.sig.df.3.3,apap.sig.df.3.4,
     apap.sig.df.3.5,apap.sig.df.3.6,apap.sig.df.3.7,apap.sig.df.3.8,
     file = "morv2.rda")