# library(microbenchmark)
# t<-microbenchmark(system.time(source("jsnv2.R")), unit="s", times=10L)
# t$time
# mean(t$time*1e-9) # 1177.57
# sd(t$time*1e-9) # 17.32478

if(!require(sensitivity)) {
  install.packages("sensitivity"); require(sensitivity)}
if(!require(EnvStats)) {
  install.packages("EnvStats"); require(EnvStats)} # use rtri
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

r_pc <- 1.2 # Use the small range to improve converge


#
J.X.df <- function(n){
  data.frame(X1 = rtri(n, Tg-r, Tg+r, Tg),
             X2 = rtri(n, Tp-r, Tp+r, Tp),
             X3 = rtri(n, CYP_Km-r, CYP_Km+r, CYP_Km),
             X4 = runif(n, -2., 5.),
             X5 = rtri(n, SULT_Km_apap-r, SULT_Km_apap+r, SULT_Km_apap),
             X6 = rtri(n, SULT_Ki-r, SULT_Ki+r, SULT_Ki),
             X7 = rtri(n, SULT_Km_paps-r, SULT_Km_paps+r, SULT_Km_paps),
             X8 = runif(n, 0, 10),
             X9 = rtri(n, UGT_Km-r, UGT_Km+r, UGT_Km),
             X10 = rtri(n, UGT_Ki-r, UGT_Ki+r, UGT_Ki),
             X11 = rtri(n, UGT_Km_GA-r, UGT_Km_GA+r, UGT_Km_GA),
             X12 = runif(n, 0, 10),
             X13 = rtri(n, Km_AG-r, Km_AG+r, Km_AG),
             X14 = runif(n, 7., 15),
             X15 = rtri(n, Km_AS-r, Km_AS+r, Km_AS),
             X16 = runif(n, 7., 15),
             X17 = runif(n, 0., 13),
             X18 = runif(n, 0., 13),
             X19 = runif(n, -6., 1),
             X20 = runif(n, -6., 1),
             X21 = runif(n, -6., 1),
             X22 = rtri(n, QCC-r_QCC, QCC+r_QCC, QCC),
             X23 = rtri(n, VFC-r_VFC, VFC+r_VFC, VFC),
             X24 = rtri(n, VKC-r_VKC, VKC+r_VKC, VKC),
             X25 = rtri(n, VGC-r_VGC, VGC+r_VGC, VGC),
             X26 = rtri(n, VLC-r_VLC, VLC+r_VLC, VLC),
             X27 = rtri(n, VMC-r_VMC, VMC+r_VMC, VMC),
             X28 = rtri(n, VBLAC-r_VBLAC, VBLAC+r_VBLAC, VBLAC),
             X29 = rtri(n, VBLVC-r_VBLVC, VBLVC+r_VBLVC, VBLVC),
             X30 = rtri(n, VSC-r_VSC, VSC+r_VSC, VSC),
             X31 = rtri(n, QFC-r_QFC, QFC+r_QFC, QFC),
             X32 = rtri(n, QKC-r_QKC, QKC+r_QKC, QKC),
             X33 = rtri(n, QGC-r_QGC, QGC+r_QGC, QGC),
             X34 = rtri(n, QLBC-r_QLBC, QLBC+r_QLBC, QLBC),
             X35 = rtri(n, QMC-r_QMC, QMC+r_QMC, QMC),
             X36 = rtri(n, QSC-r_QSC, QSC+r_QSC, QSC),
             X37 = rtri(n, -4.6, 0, BP_APAP),
             X38 = rtri(n, PF_APAP-r_pc, PF_APAP+r_pc, PF_APAP),
             X39 = rtri(n, PG_APAP-r_pc, PG_APAP+r_pc, PG_APAP),
             X40 = rtri(n, PK_APAP-r_pc, PK_APAP+r_pc, PK_APAP),
             X41 = rtri(n, PL_APAP-r_pc, PL_APAP+r_pc, PL_APAP),
             X42 = rtri(n, PM_APAP-r_pc, PM_APAP+r_pc, PM_APAP),
             X43 = rtri(n, PR_APAP-r_pc, PR_APAP+r_pc, PR_APAP),
             X44 = rtri(n, PS_APAP-r_pc, PS_APAP+r_pc, PS_APAP),
             X45 = rtri(n, PF_AS-r_pc, PF_AS+r_pc, PF_AS),
             X46 = rtri(n, PG_AS-r_pc, PG_AS+r_pc, PG_AS),
             X47 = rtri(n, PK_AS-r_pc, PK_AS+r_pc, PK_AS),
             X48 = rtri(n, PL_AS-r_pc, PL_AS+r_pc, PL_AS),
             X49 = rtri(n, PM_AS-r_pc, PM_AS+r_pc, PM_AS),
             X50 = rtri(n, PR_AS-r_pc, PR_AS+r_pc, PR_AS),
             X51 = rtri(n, PS_AS-r_pc, PS_AS+r_pc, PS_AS),
             X52 = rtri(n, PF_AG-r_pc, PF_AG+r_pc, PF_AG),
             X53 = rtri(n, PG_AG-r_pc, PG_AG+r_pc, PG_AG),
             X54 = rtri(n, PK_AG-r_pc, PK_AG+r_pc, PK_AG),
             X55 = rtri(n, PL_AG-r_pc, PL_AG+r_pc, PL_AG),
             X56 = rtri(n, PM_AG-r_pc, PM_AG+r_pc, PM_AG),
             X57 = rtri(n, PR_AG-r_pc, PR_AG+r_pc, PR_AG),
             X58 = rtri(n, PS_AG-r_pc, PS_AG+r_pc, PS_AG)
  )
}

X1 <- J.X.df(8192); X2 <- J.X.df(8192);
J.S <- soboljansen(NULL, X1, X2) # conf = 0.95, nboot = 1
J.S.APAP.df <- cbind(1, J.S$X)
write.table(J.S.APAP.df, file="apap_setpoint.dat", row.names=FALSE, sep="\t")
system("./mcsim.apap.pbpk_v2 apap.setpoint_v2.in")
J.S.APAP.mcsim.df <- as.data.frame(fread("apap_setpoint.csv", head = T))

#Prior Jansen
J.S.APAP.1.1 <- tell(J.S, J.S.APAP.mcsim.df[,60])
J.S.APAP.1.2 <- tell(J.S, J.S.APAP.mcsim.df[,61])
J.S.APAP.1.3 <- tell(J.S, J.S.APAP.mcsim.df[,62])
J.S.APAP.1.4 <- tell(J.S, J.S.APAP.mcsim.df[,63])
J.S.APAP.1.5 <- tell(J.S, J.S.APAP.mcsim.df[,64])
J.S.APAP.1.6 <- tell(J.S, J.S.APAP.mcsim.df[,65])
J.S.APAP.1.7 <- tell(J.S, J.S.APAP.mcsim.df[,66])
J.S.APAP.1.8 <- tell(J.S, J.S.APAP.mcsim.df[,67])
J.S.APAP.2.1 <- tell(J.S, J.S.APAP.mcsim.df[,68])
J.S.APAP.2.2 <- tell(J.S, J.S.APAP.mcsim.df[,69])
J.S.APAP.2.3 <- tell(J.S, J.S.APAP.mcsim.df[,70])
J.S.APAP.2.4 <- tell(J.S, J.S.APAP.mcsim.df[,71])
J.S.APAP.2.5 <- tell(J.S, J.S.APAP.mcsim.df[,72])
J.S.APAP.2.6 <- tell(J.S, J.S.APAP.mcsim.df[,73])
J.S.APAP.2.7 <- tell(J.S, J.S.APAP.mcsim.df[,74])
J.S.APAP.2.8 <- tell(J.S, J.S.APAP.mcsim.df[,75])
J.S.APAP.3.1 <- tell(J.S, J.S.APAP.mcsim.df[,76])
J.S.APAP.3.2 <- tell(J.S, J.S.APAP.mcsim.df[,77])
J.S.APAP.3.3 <- tell(J.S, J.S.APAP.mcsim.df[,78])
J.S.APAP.3.4 <- tell(J.S, J.S.APAP.mcsim.df[,79])
J.S.APAP.3.5 <- tell(J.S, J.S.APAP.mcsim.df[,80])
J.S.APAP.3.6 <- tell(J.S, J.S.APAP.mcsim.df[,81])
J.S.APAP.3.7 <- tell(J.S, J.S.APAP.mcsim.df[,82])
J.S.APAP.3.8 <- tell(J.S, J.S.APAP.mcsim.df[,83])


Parameter <- c("Tg", "Tp","CYP_Km","CYP_VmaxC","SULT_Km_apap","SULT_Ki",
               "SULT_Km_paps","SULT_VmaxC","UGT_Km","UGT_Ki",
               "UGT_Km_GA","UGT_VmaxC","Km_AG","Vmax_AG","Km_AS",
               "Vmax_AS","kGA_syn","kPAPS_syn","CLC_APAP","CLC_AG","CLC_AS",
               "QCC","VFC","VKC","VGC","VLC","VMC","VBLAC","VBLVC","VSC",
               "QFC","QKC","QGC","QLBC","QMC","QSC",  
               "BP_APAP","PF_APAP","PG_APAP","PK_APAP","PL_APAP","PM_APAP","PR_APAP","PS_APAP",
               "PF_AS","PG_AS","PK_AS","PL_AS","PM_AS","PR_AS","PS_AS",
               "PF_AG" ,"PG_AG","PK_AG","PL_AG","PM_AG","PR_AG","PS_AG")

apap.mj.df.1.1 <- data.frame(Parameter, J.S.APAP.1.1$S)
apap.mj.df.1.2 <- data.frame(Parameter, J.S.APAP.1.2$S)
apap.mj.df.1.3 <- data.frame(Parameter, J.S.APAP.1.3$S)
apap.mj.df.1.4 <- data.frame(Parameter, J.S.APAP.1.4$S)
apap.mj.df.1.5 <- data.frame(Parameter, J.S.APAP.1.5$S)
apap.mj.df.1.6 <- data.frame(Parameter, J.S.APAP.1.6$S)
apap.mj.df.1.7 <- data.frame(Parameter, J.S.APAP.1.7$S)
apap.mj.df.1.8 <- data.frame(Parameter, J.S.APAP.1.8$S)

apap.mj.df.2.1 <- data.frame(Parameter, J.S.APAP.2.1$S)
apap.mj.df.2.2 <- data.frame(Parameter, J.S.APAP.2.2$S)
apap.mj.df.2.3 <- data.frame(Parameter, J.S.APAP.2.3$S)
apap.mj.df.2.4 <- data.frame(Parameter, J.S.APAP.2.4$S)
apap.mj.df.2.5 <- data.frame(Parameter, J.S.APAP.2.5$S)
apap.mj.df.2.6 <- data.frame(Parameter, J.S.APAP.2.6$S)
apap.mj.df.2.7 <- data.frame(Parameter, J.S.APAP.2.7$S)
apap.mj.df.2.8 <- data.frame(Parameter, J.S.APAP.2.8$S)

apap.mj.df.3.1 <- data.frame(Parameter, J.S.APAP.3.1$S)
apap.mj.df.3.2 <- data.frame(Parameter, J.S.APAP.3.2$S)
apap.mj.df.3.3 <- data.frame(Parameter, J.S.APAP.3.3$S)
apap.mj.df.3.4 <- data.frame(Parameter, J.S.APAP.3.4$S)
apap.mj.df.3.5 <- data.frame(Parameter, J.S.APAP.3.5$S)
apap.mj.df.3.6 <- data.frame(Parameter, J.S.APAP.3.6$S)
apap.mj.df.3.7 <- data.frame(Parameter, J.S.APAP.3.7$S)
apap.mj.df.3.8 <- data.frame(Parameter, J.S.APAP.3.8$S)

apap.tj.df.1.1 <- data.frame(Parameter, J.S.APAP.1.1$T)
apap.tj.df.1.2 <- data.frame(Parameter, J.S.APAP.1.2$T)
apap.tj.df.1.3 <- data.frame(Parameter, J.S.APAP.1.3$T)
apap.tj.df.1.4 <- data.frame(Parameter, J.S.APAP.1.4$T)
apap.tj.df.1.5 <- data.frame(Parameter, J.S.APAP.1.5$T)
apap.tj.df.1.6 <- data.frame(Parameter, J.S.APAP.1.6$T)
apap.tj.df.1.7 <- data.frame(Parameter, J.S.APAP.1.7$T)
apap.tj.df.1.8 <- data.frame(Parameter, J.S.APAP.1.8$T)

apap.tj.df.2.1 <- data.frame(Parameter, J.S.APAP.2.1$T)
apap.tj.df.2.2 <- data.frame(Parameter, J.S.APAP.2.2$T)
apap.tj.df.2.3 <- data.frame(Parameter, J.S.APAP.2.3$T)
apap.tj.df.2.4 <- data.frame(Parameter, J.S.APAP.2.4$T)
apap.tj.df.2.5 <- data.frame(Parameter, J.S.APAP.2.5$T)
apap.tj.df.2.6 <- data.frame(Parameter, J.S.APAP.2.6$T)
apap.tj.df.2.7 <- data.frame(Parameter, J.S.APAP.2.7$T)
apap.tj.df.2.8 <- data.frame(Parameter, J.S.APAP.2.8$T)

apap.tj.df.3.1 <- data.frame(Parameter, J.S.APAP.3.1$T)
apap.tj.df.3.2 <- data.frame(Parameter, J.S.APAP.3.2$T)
apap.tj.df.3.3 <- data.frame(Parameter, J.S.APAP.3.3$T)
apap.tj.df.3.4 <- data.frame(Parameter, J.S.APAP.3.4$T)
apap.tj.df.3.5 <- data.frame(Parameter, J.S.APAP.3.5$T)
apap.tj.df.3.6 <- data.frame(Parameter, J.S.APAP.3.6$T)
apap.tj.df.3.7 <- data.frame(Parameter, J.S.APAP.3.7$T)
apap.tj.df.3.8 <- data.frame(Parameter, J.S.APAP.3.8$T)

save(apap.mj.df.1.1, apap.mj.df.1.2, apap.mj.df.1.3, apap.mj.df.1.4,
     apap.mj.df.1.5, apap.mj.df.1.6, apap.mj.df.1.7, apap.mj.df.1.8,
     apap.mj.df.2.1, apap.mj.df.2.2, apap.mj.df.2.3, apap.mj.df.2.4,
     apap.mj.df.2.5, apap.mj.df.2.6, apap.mj.df.2.7, apap.mj.df.2.8,
     apap.mj.df.3.1, apap.mj.df.3.2, apap.mj.df.3.3, apap.mj.df.3.4,
     apap.mj.df.3.5, apap.mj.df.3.6, apap.mj.df.3.7, apap.mj.df.3.8,
     apap.tj.df.1.1, apap.tj.df.1.2, apap.tj.df.1.3, apap.tj.df.1.4,
     apap.tj.df.1.5, apap.tj.df.1.6, apap.tj.df.1.7, apap.tj.df.1.8,
     apap.tj.df.2.1, apap.tj.df.2.2, apap.tj.df.2.3, apap.tj.df.2.4,
     apap.tj.df.2.5, apap.tj.df.2.6, apap.tj.df.2.7, apap.tj.df.2.8,
     apap.tj.df.3.1, apap.tj.df.3.2, apap.tj.df.3.3, apap.tj.df.3.4,
     apap.tj.df.3.5, apap.tj.df.3.6, apap.tj.df.3.7, apap.tj.df.3.8,
     file = "jsnv2.rda")