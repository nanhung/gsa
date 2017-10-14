if(!require(sensitivity)) {
  install.packages("sensitivity"); require(sensitivity)}
if(!require(EnvStats)) {
  install.packages("EnvStats"); require(EnvStats)} # use rtri
if(!require(data.table)) {
  install.packages("data.table"); require(data.table)}

Tg<-0.332
Tp<-0.0476
CYP_Km <- 123
CYP_VmaxC <- 2.57
SULT_Km_apap <- 1.2e3
SULT_Ki <- 478
SULT_Km_paps <- 0.345
SULT_VmaxC <- 467
UGT_Km <- 6.14e3
UGT_Ki <- 4.99e4
UGT_Km_GA <- 0.343
UGT_VmaxC <- 5.21e3
Km_AG <- 1.75e4
Vmax_AG <- 3.54e4
Km_AS <- 2.23e4
Vmax_AS <- 1.4e7
kGA_syn <- 3.6e4
kPAPS_syn <- 3.66e3
CLC_APAP <- 0.0123
CLC_AG <- 0.155
CLC_AS <- 0.138

QCC<-16.2

VFC <- 0.214 # Fat
VKC <- 0.0044 # Kidney
VGC <- 0.0144 # Gut
VLC <- 0.0257 # Hepatic artery
VMC <- 0.4 # Muscle
VBLAC <- 0.0243  # Arterial Blood
VBLVC <- 0.0557 # Venous Blood
VSC <- 0.185 # Slowly Perfused
#VRC <- 0.0765  # Rapidly Perfused (1- everything else)

QFC  <- 0.052 # Fat
QKC  <- 0.175 # Kidney
QGC  <- 0.181 # Gut
QLBC <- 0.046 # Hepatic artery
QMC  <- 0.191 # Muscle
QSC  <- 0.14 # Slowly Perfused
# QRC  <- 0.215  # Rapidly Perfused (1 -  everything else)

BP_APAP = 0.9

PF_APAP = 0.447    # Fat:blood
PG_APAP = 0.907    # Gut:blood
PK_APAP = 0.711    # Kidney:blood
PL_APAP = 0.687    # Liver:blood
PM_APAP = 0.687    # Muscle:blood
PR_APAP = 0.676    # rapidly perfused:blood [brain, lung, spleen]
PS_APAP = 0.606    # slowly perfused:blood [bone, heart, skin]

PF_AS = 0.088
PG_AS = 0.297
PK_AS = 0.261
PL_AS = 0.203
PM_AS = 0.199
PR_AS = 0.207
PS_AS = 0.254

PF_AG = 0.128
PG_AG = 0.436
PK_AG = 0.392
PL_AG = 0.321
PM_AG = 0.336
PR_AG = 0.364
PS_AG = 0.351

#
lwr <- -1.2
upr <- 1.2
lwr_QCC <- -0.8
upr_QCC <- 0.8
lwr_phy <- -0.08
upr_phy <- 0.08
lwr_p <- -2.0
upr_p <- 2.0

# Define prior
set.seed(250); pri_Tg <- rtri(1000, Tg*exp(lwr), Tg*exp(upr), Tg)
set.seed(250); pri_Tp <- rtri(1000, Tp*exp(lwr), Tp*exp(upr), Tp)
set.seed(250); pri_CYP_Km <- rtri(1000, CYP_Km*exp(lwr), CYP_Km*exp(upr), CYP_Km)
set.seed(250); pri_CYP_VmaxC <- rtri(1000, CYP_VmaxC*exp(lwr), CYP_VmaxC*exp(upr), CYP_VmaxC)
set.seed(250); pri_SULT_Km_apap <- rtri(1000, SULT_Km_apap*exp(lwr), SULT_Km_apap*exp(upr), SULT_Km_apap)
set.seed(250); pri_SULT_Ki <- rtri(1000, SULT_Ki*exp(lwr), SULT_Ki*exp(upr), SULT_Ki)
set.seed(250); pri_SULT_Km_paps <- rtri(1000, SULT_Km_paps*exp(lwr), SULT_Km_paps*exp(upr), SULT_Km_paps)
set.seed(250); pri_SULT_VmaxC <- rtri(1000, SULT_VmaxC*exp(lwr), SULT_VmaxC*exp(upr), SULT_VmaxC)
set.seed(250); pri_UGT_Km <- rtri(1000, UGT_Km*exp(lwr), UGT_Km*exp(upr), UGT_Km)
set.seed(250); pri_UGT_Ki <- rtri(1000, UGT_Ki*exp(lwr), UGT_Ki*exp(upr), UGT_Ki)
set.seed(250); pri_UGT_Km_GA <- rtri(1000, UGT_Km_GA*exp(lwr), UGT_Km_GA*exp(upr), UGT_Km_GA)
set.seed(250); pri_UGT_VmaxC <- rtri(1000, UGT_VmaxC*exp(lwr), UGT_VmaxC*exp(upr), UGT_VmaxC)
set.seed(250); pri_Km_AG <- rtri(1000, Km_AG*exp(lwr), Km_AG*exp(upr), Km_AG)
set.seed(250); pri_Vmax_AG <- rtri(1000, Vmax_AG*exp(lwr), Vmax_AG*exp(upr), Vmax_AG)
set.seed(250); pri_Km_AS <- rtri(1000, Km_AS*exp(lwr), Km_AS*exp(upr), Km_AS)
set.seed(250); pri_Vmax_AS <- rtri(1000, Vmax_AS*exp(lwr), Vmax_AS*exp(upr), Vmax_AS)
set.seed(250); pri_kGA_syn <- rtri(1000, kGA_syn*exp(lwr), kGA_syn*exp(upr), kGA_syn)
set.seed(250); pri_kPAPS_syn <- rtri(1000, kPAPS_syn*exp(lwr), kPAPS_syn*exp(upr), kPAPS_syn)
set.seed(250); pri_CLC_APAP <- rtri(1000, CLC_APAP*exp(lwr), CLC_APAP*exp(upr), CLC_APAP)
set.seed(250); pri_CLC_AG <- rtri(1000, CLC_AG*exp(lwr), CLC_AG*exp(upr), CLC_AG)
set.seed(250); pri_CLC_AS <- rtri(1000, CLC_AS*exp(lwr), CLC_AS*exp(upr), CLC_AS)

### Physiological parameters (17) ----
set.seed(250); pri_QCC <- rtri(1000, QCC*exp(lwr_QCC), QCC*exp(upr_QCC), QCC) # Cardiac output
#set.seed(250); lnQCC<-rnormTrunc(1000, 0.0, 2.785, -2.785, 2.785)

# Fractional volumes (fraction of body weight).
set.seed(250); pri_VFC <- rtri(1000, VFC*exp(lwr_phy), VFC*exp(upr_phy), VFC)
set.seed(250); pri_VKC <- rtri(1000, VKC*exp(lwr_phy), VKC*exp(upr_phy), VKC)
set.seed(250); pri_VGC <- rtri(1000, VGC*exp(lwr_phy), VGC*exp(upr_phy), VGC)
set.seed(250); pri_VLC <- rtri(1000, VLC*exp(lwr_phy), VLC*exp(upr_phy), VLC)
set.seed(250); pri_VMC <- rtri(1000, VMC*exp(lwr_phy), VMC*exp(upr_phy), VMC)
set.seed(250); pri_VBLAC <- rtri(1000, VBLAC*exp(lwr_phy), VBLAC*exp(upr_phy), VBLAC)
set.seed(250); pri_VBLVC <- rtri(1000, VBLVC*exp(lwr_phy), VBLVC*exp(upr_phy), VBLVC)
set.seed(250); pri_VSC <- rtri(1000, VSC*exp(lwr_phy), VSC*exp(upr_phy), VSC)
pri_VRC <- 1-pri_VFC-pri_VKC-pri_VGC-pri_VLC-pri_VMC-pri_VBLAC-pri_VBLVC-pri_VSC
#hist(pri_VRC) # to make sure there is no negative value  


# Fractional blood flows (fraction of cardiac output).
set.seed(250); pri_QFC  <- rtri(1000, QFC*exp(lwr_phy), QFC*exp(upr_phy), QFC)  # Fat
set.seed(250); pri_QKC  <- rtri(1000, QKC*exp(lwr_phy), QKC*exp(upr_phy), QKC)  # Kidney
set.seed(250); pri_QGC  <- rtri(1000, QGC*exp(lwr_phy), QGC*exp(upr_phy), QGC)  # Gut
set.seed(250); pri_QLBC <- rtri(1000, QLBC*exp(lwr_phy), QLBC*exp(upr_phy), QLBC)  # Hepatic artery
set.seed(250); pri_QMC  <- rtri(1000, QMC*exp(lwr_phy), QMC*exp(upr_phy), QMC)  # Muscle
set.seed(250); pri_QSC  <- rtri(1000, QSC*exp(lwr_phy), QSC*exp(upr_phy), QSC) # Slowly Perfused
pri_QRC <- 1-pri_QFC-pri_QKC-pri_QGC-pri_QLBC-pri_QMC-pri_QSC
#hist(pri_QRC) # to make sure there is no negative value 


### Substance-specific parameter (23) ----

set.seed(250); pri_BP_APAP = rtri(1000, 0.1, 1, BP_APAP)

# Partition Coefficients
set.seed(250); pri_PF_APAP <- rtri(1000, PF_APAP*exp(lwr_p), PF_APAP*exp(upr_p), PF_APAP) # Fat:blood
set.seed(250); pri_PG_APAP <- rtri(1000, PG_APAP*exp(lwr_p), PG_APAP*exp(upr_p), PG_APAP) # Gut:blood
set.seed(250); pri_PK_APAP <- rtri(1000, PK_APAP*exp(lwr_p), PK_APAP*exp(upr_p), PK_APAP) # Kidney:blood
set.seed(250); pri_PL_APAP <- rtri(1000, PL_APAP*exp(lwr_p), PL_APAP*exp(upr_p), PL_APAP) # Liver:blood
set.seed(250); pri_PM_APAP <- rtri(1000, PM_APAP*exp(lwr_p), PM_APAP*exp(upr_p), PM_APAP) # Muscle:blood
set.seed(250); pri_PR_APAP <- rtri(1000, PR_APAP*exp(lwr_p), PR_APAP*exp(upr_p), PR_APAP) # rapidly perfused:blood [brain, lung, spleen]
set.seed(250); pri_PS_APAP <- rtri(1000, PS_APAP*exp(lwr_p), PS_APAP*exp(upr_p), PS_APAP) # slowly perfused:blood [bone, heart, skin]

set.seed(250); pri_PF_AS <- rtri(1000, PF_AS*exp(lwr_p), PF_AS*exp(upr_p), PF_AS) 
set.seed(250); pri_PG_AS <- rtri(1000, PG_AS*exp(lwr_p), PG_AS*exp(upr_p), PG_AS) 
set.seed(250); pri_PK_AS <- rtri(1000, PK_AS*exp(lwr_p), PK_AS*exp(upr_p), PK_AS)
set.seed(250); pri_PL_AS <- rtri(1000, PL_AS*exp(lwr_p), PL_AS*exp(upr_p), PL_AS)
set.seed(250); pri_PM_AS <- rtri(1000, PM_AS*exp(lwr_p), PM_AS*exp(upr_p), PM_AS)     
set.seed(250); pri_PR_AS <- rtri(1000, PR_AS*exp(lwr_p), PR_AS*exp(upr_p), PR_AS)
set.seed(250); pri_PS_AS <- rtri(1000, PS_AS*exp(lwr_p), PS_AS*exp(upr_p), PS_AS)

set.seed(250); pri_PF_AG <- rtri(1000, PF_AG*exp(lwr_p), PF_AG*exp(upr_p), PF_AG)  
set.seed(250); pri_PG_AG <- rtri(1000, PG_AG*exp(lwr_p), PG_AG*exp(upr_p), PG_AG)
set.seed(250); pri_PK_AG <- rtri(1000, PK_AG*exp(lwr_p), PK_AG*exp(upr_p), PK_AG)
set.seed(250); pri_PL_AG <- rtri(1000, PL_AG*exp(lwr_p), PL_AG*exp(upr_p), PL_AG)
set.seed(250); pri_PM_AG <- rtri(1000, PM_AG*exp(lwr_p), PM_AG*exp(upr_p), PM_AG)  
set.seed(250); pri_PR_AG <- rtri(1000, PR_AG*exp(lwr_p), PR_AG*exp(upr_p), PR_AG)
set.seed(250); pri_PS_AG <- rtri(1000, PS_AG*exp(lwr_p), PS_AG*exp(upr_p), PS_AG)

J.X.df <- function(n){
  data.frame(X1 = rtri(n, Tg*exp(lwr), Tg*exp(upr), Tg),
             X2 = rtri(n, Tp*exp(lwr), Tp*exp(upr), Tp),
             X3 = rtri(n, CYP_Km*exp(lwr), CYP_Km*exp(upr), CYP_Km),
             X4 = rtri(n, CYP_VmaxC*exp(lwr), CYP_VmaxC*exp(upr), CYP_VmaxC),
             X5 = rtri(n, SULT_Km_apap*exp(lwr), SULT_Km_apap*exp(upr), SULT_Km_apap),
             X6 = rtri(n, SULT_Ki*exp(lwr), SULT_Ki*exp(upr), SULT_Ki),
             X7 = rtri(n, SULT_Km_paps*exp(lwr), SULT_Km_paps*exp(upr), SULT_Km_paps),
             X8 = rtri(n, SULT_VmaxC*exp(lwr), SULT_VmaxC*exp(upr), SULT_VmaxC),
             X9 = rtri(n, UGT_Km*exp(lwr), UGT_Km*exp(upr), UGT_Km),
             X10 = rtri(n, UGT_Ki*exp(lwr), UGT_Ki*exp(upr), UGT_Ki),
             X11 = rtri(n, UGT_Km_GA*exp(lwr), UGT_Km_GA*exp(upr), UGT_Km_GA),
             X12 = rtri(n, UGT_VmaxC*exp(lwr), UGT_VmaxC*exp(upr), UGT_VmaxC),
             X13 = rtri(n, Km_AG*exp(lwr), Km_AG*exp(upr), Km_AG),
             X14 = rtri(n, Vmax_AG*exp(lwr), Vmax_AG*exp(upr), Vmax_AG),
             X15 = rtri(n, Km_AS*exp(lwr), Km_AS*exp(upr), Km_AS),
             X16 = rtri(n, Vmax_AS*exp(lwr), Vmax_AS*exp(upr), Vmax_AS),
             X17 = rtri(n, kGA_syn*exp(lwr), kGA_syn*exp(upr), kGA_syn),
             X18 = rtri(n, kPAPS_syn*exp(lwr), kPAPS_syn*exp(upr), kPAPS_syn),
             X19 = rtri(n, CLC_APAP*exp(lwr), CLC_APAP*exp(upr), CLC_APAP),
             X20 = rtri(n, CLC_AG*exp(lwr), CLC_AG*exp(upr), CLC_AG),
             X21 = rtri(n, CLC_AS*exp(lwr), CLC_AS*exp(upr), CLC_AS),
             X22 = rtri(n, QCC*exp(lwr_QCC), QCC*exp(upr_QCC), QCC),
             X23 = rtri(n, VFC*exp(lwr_phy), VFC*exp(upr_phy), VFC),
             X24 = rtri(n, VKC*exp(lwr_phy), VKC*exp(upr_phy), VKC),
             X25 = rtri(n, VGC*exp(lwr_phy), VGC*exp(upr_phy), VGC),
             X26 = rtri(n, VLC*exp(lwr_phy), VLC*exp(upr_phy), VLC),
             X27 = rtri(n, VMC*exp(lwr_phy), VMC*exp(upr_phy), VMC),
             X28 = rtri(n, VBLAC*exp(lwr_phy), VBLAC*exp(upr_phy), VBLAC),
             X29 = rtri(n, VBLVC*exp(lwr_phy), VBLVC*exp(upr_phy), VBLVC),
             X30 = rtri(n, VSC*exp(lwr_phy), VSC*exp(upr_phy), VSC),
             X31 = rtri(n, QFC*exp(lwr_phy), QFC*exp(upr_phy), QFC),
             X32 = rtri(n, QKC*exp(lwr_phy), QKC*exp(upr_phy), QKC),
             X33 = rtri(n, QGC*exp(lwr_phy), QGC*exp(upr_phy), QGC),
             X34 = rtri(n, QLBC*exp(lwr_phy), QLBC*exp(upr_phy), QLBC),
             X35 = rtri(n, QMC*exp(lwr_phy), QMC*exp(upr_phy), QMC),
             X36 = rtri(n, QSC*exp(lwr_phy), QSC*exp(upr_phy), QSC),
             X37 = rtri(n, 0.1, 1, BP_APAP),
             X38 = rtri(n, PF_APAP*exp(lwr_p), PF_APAP*exp(upr_p), PF_APAP),
             X39 = rtri(n, PG_APAP*exp(lwr_p), PG_APAP*exp(upr_p), PG_APAP),
             X40 = rtri(n, PK_APAP*exp(lwr_p), PK_APAP*exp(upr_p), PK_APAP),
             X41 = rtri(n, PL_APAP*exp(lwr_p), PL_APAP*exp(upr_p), PL_APAP),
             X42 = rtri(n, PM_APAP*exp(lwr_p), PM_APAP*exp(upr_p), PM_APAP),
             X43 = rtri(n, PR_APAP*exp(lwr_p), PR_APAP*exp(upr_p), PR_APAP),
             X44 = rtri(n, PS_APAP*exp(lwr_p), PS_APAP*exp(upr_p), PS_APAP),
             X45 = rtri(n, PF_AS*exp(lwr_p), PF_AS*exp(upr_p), PF_AS),
             X46 = rtri(n, PG_AS*exp(lwr_p), PG_AS*exp(upr_p), PG_AS),
             X47 = rtri(n, PK_AS*exp(lwr_p), PK_AS*exp(upr_p), PK_AS),
             X48 = rtri(n, PL_AS*exp(lwr_p), PL_AS*exp(upr_p), PL_AS),
             X49 = rtri(n, PM_AS*exp(lwr_p), PM_AS*exp(upr_p), PM_AS),
             X50 = rtri(n, PR_AS*exp(lwr_p), PR_AS*exp(upr_p), PR_AS),
             X51 = rtri(n, PS_AS*exp(lwr_p), PS_AS*exp(upr_p), PS_AS),
             X52 = rtri(n, PF_AG*exp(lwr_p), PF_AG*exp(upr_p), PF_AG),
             X53 = rtri(n, PG_AG*exp(lwr_p), PG_AG*exp(upr_p), PG_AG),
             X54 = rtri(n, PK_AG*exp(lwr_p), PK_AG*exp(upr_p), PK_AG),
             X55 = rtri(n, PL_AG*exp(lwr_p), PL_AG*exp(upr_p), PL_AG),
             X56 = rtri(n, PM_AG*exp(lwr_p), PM_AG*exp(upr_p), PM_AG),
             X57 = rtri(n, PR_AG*exp(lwr_p), PR_AG*exp(upr_p), PR_AG),
             X58 = rtri(n, PS_AG*exp(lwr_p), PS_AG*exp(upr_p), PS_AG)
             )
}

X1 <- J.X.df(16000); X2 <- J.X.df(16000);
J.S <- soboljansen(NULL, X1, X2, conf = 0.95, nboot = 1000)
J.S$X <- log(J.S$X)
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

if(!require(gplots)) {
  install.packages("gplots"); require(gplots)} #heatmap.2

main1<-do.call(cbind, list(apap.mj.df.1.1[,2], apap.mj.df.1.2[,2], apap.mj.df.1.3[,2], apap.mj.df.1.4[,2],
                           apap.mj.df.1.5[,2], apap.mj.df.1.6[,2], apap.mj.df.1.7[,2], apap.mj.df.1.8[,2],
                           apap.mj.df.2.1[,2], apap.mj.df.2.2[,2], apap.mj.df.2.3[,2], apap.mj.df.2.4[,2],
                           apap.mj.df.2.5[,2], apap.mj.df.2.6[,2], apap.mj.df.2.7[,2], apap.mj.df.2.8[,2],
                           apap.mj.df.3.1[,2], apap.mj.df.3.2[,2], apap.mj.df.3.3[,2], apap.mj.df.3.4[,2],
                           apap.mj.df.3.5[,2], apap.mj.df.3.6[,2], apap.mj.df.3.7[,2], apap.mj.df.3.8[,2]))

totl1<-do.call(cbind, list(apap.tj.df.1.1[,2], apap.tj.df.1.2[,2], apap.tj.df.1.3[,2], apap.tj.df.1.4[,2],
                           apap.tj.df.1.5[,2], apap.tj.df.1.6[,2], apap.tj.df.1.7[,2], apap.tj.df.1.8[,2],
                           apap.tj.df.2.1[,2], apap.tj.df.2.2[,2], apap.tj.df.2.3[,2], apap.tj.df.2.4[,2],
                           apap.tj.df.2.5[,2], apap.tj.df.2.6[,2], apap.tj.df.2.7[,2], apap.tj.df.2.8[,2],
                           apap.tj.df.3.1[,2], apap.tj.df.3.2[,2], apap.tj.df.3.3[,2], apap.tj.df.3.4[,2],
                           apap.tj.df.3.5[,2], apap.tj.df.3.6[,2], apap.tj.df.3.7[,2], apap.tj.df.3.8[,2]))

colnames(main1)<-c("APAP_0.5h", "APAP_1h", "APAP_1.5h", "APAP_2h",
                   "APAP_4h", "APAP_6h", "APAP_8h", "APAP_12h",
                   "APAP-G_0.5h", "APAP-G_1h", "APAP-G_1.5h", "APAP-G_2h",
                   "APAP-G_4h", "APAP-G_6h", "APAP-G_8h", "APAP-G_12h",
                   "APAP-S_0.5h", "APAP-S_1h", "APAP-S_1.5h", "APAP-S_2h",
                   "APAP-S_4h", "APAP-S_6h", "APAP-S_8h", "APAP-S_12h")

rownames(main1)<-rownames(totl1)<-Parameter
colnames(totl1)<-colnames(main1)

main2 <- as.data.frame(main1)
totl2 <- as.data.frame(totl1)

M0<-main2[,1:24]
T0<-totl2[,1:24]

M1<-as.matrix(scale(M0))
T1<-as.matrix(scale(T0))

pdf(file="fig6.pdf", width = 12, height = 12)
heatmap.2(M1, cexRow=1.2, cexCol=1.2, col = bluered(100), margins=c(6,9),trace="none",srtCol=35,
          density.info = 'histogram', scale = "none", keysize = 1.2, 
          cellnote=round(M1, digits = 1),
          notecol="black")
dev.off()

pdf(file="fig6.pdf", width = 12, height = 12)
heatmap.2(T1, cexRow=1.2, cexCol=1.2, col = bluered(100), margins=c(6,9),trace="none",srtCol=35,
          density.info = 'histogram', scale = "none", keysize = 1.2, 
          cellnote=round(T1, digits = 1),
          notecol="black")
dev.off()
