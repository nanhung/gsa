if(!require(sensitivity)) {
  install.packages("sensitivity"); require(sensitivity)}
if(!require(EnvStats)) {
  install.packages("EnvStats"); require(EnvStats)}
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

#
binf<-c(Tg*exp(lwr), 
        Tp*exp(lwr), 
        CYP_Km*exp(lwr), 
        CYP_VmaxC*exp(lwr), 
        SULT_Km_apap*exp(lwr), 
        SULT_Ki*exp(lwr),
        SULT_Km_paps*exp(lwr), 
        SULT_VmaxC*exp(lwr), 
        UGT_Km*exp(lwr),
        UGT_Ki*exp(lwr),
        UGT_Km_GA*exp(lwr), 
        UGT_VmaxC*exp(lwr), 
        Km_AG*exp(lwr), 
        Vmax_AG*exp(lwr), 
        Km_AS*exp(lwr),
        Vmax_AS*exp(lwr), 
        kGA_syn*exp(lwr), 
        kPAPS_syn*exp(lwr), 
        CLC_APAP*exp(lwr), 
        CLC_AG*exp(lwr), 
        CLC_AS*exp(lwr),
        QCC*exp(lwr_QCC),
        VFC*exp(lwr_phy),
        VKC*exp(lwr_phy),
        VGC*exp(lwr_phy),
        VLC*exp(lwr_phy),
        VMC*exp(lwr_phy),
        VBLAC*exp(lwr_phy),
        VBLVC*exp(lwr_phy),
        VSC*exp(lwr_phy),
        QFC*exp(lwr_phy),
        QKC*exp(lwr_phy),
        QGC*exp(lwr_phy),
        QLBC*exp(lwr_phy),
        QMC*exp(lwr_phy),
        QSC*exp(lwr_phy),  
        0.1,
        PF_APAP*exp(lwr_p),
        PG_APAP*exp(lwr_p),
        PK_APAP*exp(lwr_p),
        PL_APAP*exp(lwr_p),
        PM_APAP*exp(lwr_p),
        PR_APAP*exp(lwr_p),
        PS_APAP*exp(lwr_p),
        PF_AS*exp(lwr_p),
        PG_AS*exp(lwr_p),
        PK_AS*exp(lwr_p),
        PL_AS*exp(lwr_p),
        PM_AS*exp(lwr_p),
        PR_AS*exp(lwr_p),
        PS_AS*exp(lwr_p),
        PF_AG*exp(lwr_p),
        PG_AG*exp(lwr_p),
        PK_AG*exp(lwr_p),
        PL_AG*exp(lwr_p),
        PM_AG*exp(lwr_p),
        PR_AG*exp(lwr_p),
        PS_AG*exp(lwr_p))

bsup<-c(Tg*exp(upr), 
        Tp*exp(upr), 
        CYP_Km*exp(upr), 
        CYP_VmaxC*exp(upr), 
        SULT_Km_apap*exp(upr), 
        SULT_Ki*exp(upr),
        SULT_Km_paps*exp(upr), 
        SULT_VmaxC*exp(upr), 
        UGT_Km*exp(upr),
        UGT_Ki*exp(upr),
        UGT_Km_GA*exp(upr), 
        UGT_VmaxC*exp(upr), 
        Km_AG*exp(upr), 
        Vmax_AG*exp(upr), 
        Km_AS*exp(upr),
        Vmax_AS*exp(upr), 
        kGA_syn*exp(upr), 
        kPAPS_syn*exp(upr), 
        CLC_APAP*exp(upr), 
        CLC_AG*exp(upr), 
        CLC_AS*exp(upr),
        QCC*exp(upr_QCC),
        VFC*exp(upr_phy),
        VKC*exp(upr_phy),
        VGC*exp(upr_phy),
        VLC*exp(upr_phy),
        VMC*exp(upr_phy),
        VBLAC*exp(upr_phy),
        VBLVC*exp(upr_phy),
        VSC*exp(upr_phy),
        QFC*exp(upr_phy),
        QKC*exp(upr_phy),
        QGC*exp(upr_phy),
        QLBC*exp(upr_phy),
        QMC*exp(upr_phy),
        QSC*exp(upr_phy),  
        1,
        PF_APAP*exp(upr_p),
        PG_APAP*exp(upr_p),
        PK_APAP*exp(upr_p),
        PL_APAP*exp(upr_p),
        PM_APAP*exp(upr_p),
        PR_APAP*exp(upr_p),
        PS_APAP*exp(upr_p),
        PF_AS*exp(upr_p),
        PG_AS*exp(upr_p),
        PK_AS*exp(upr_p),
        PL_AS*exp(upr_p),
        PM_AS*exp(upr_p),
        PR_AS*exp(upr_p),
        PS_AS*exp(upr_p),
        PF_AG*exp(upr_p),
        PG_AG*exp(upr_p),
        PK_AG*exp(upr_p),
        PL_AG*exp(upr_p),
        PM_AG*exp(upr_p),
        PR_AG*exp(upr_p),
        PS_AG*exp(upr_p))

#round(log(binf), digits=4)
#round(log(bsup), digits=4)

morr <- morris(model = NULL, factors = 58, r = 1000, 
               design = list(type = "oat", levels = 5, grid.jump = 3), 
               binf = log(binf), bsup = log(bsup))
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

Mmu1<-do.call(cbind, list(apap.Mmu.df.1.1[,2], apap.Mmu.df.1.2[,2], apap.Mmu.df.1.3[,2], apap.Mmu.df.1.4[,2],
                          apap.Mmu.df.1.5[,2], apap.Mmu.df.1.6[,2], apap.Mmu.df.1.7[,2], apap.Mmu.df.1.8[,2],
                          apap.Mmu.df.2.1[,2], apap.Mmu.df.2.2[,2], apap.Mmu.df.2.3[,2], apap.Mmu.df.2.4[,2],
                          apap.Mmu.df.2.5[,2], apap.Mmu.df.2.6[,2], apap.Mmu.df.2.7[,2], apap.Mmu.df.2.8[,2],
                          apap.Mmu.df.3.1[,2], apap.Mmu.df.3.2[,2], apap.Mmu.df.3.3[,2], apap.Mmu.df.3.4[,2],
                          apap.Mmu.df.3.5[,2], apap.Mmu.df.3.6[,2], apap.Mmu.df.3.7[,2], apap.Mmu.df.3.8[,2]
))
sig1<-do.call(cbind, list(apap.sig.df.1.1[,2], apap.sig.df.1.2[,2], apap.sig.df.1.3[,2], apap.sig.df.1.4[,2],
                          apap.sig.df.1.5[,2], apap.sig.df.1.6[,2], apap.sig.df.1.7[,2], apap.sig.df.1.8[,2],
                          apap.sig.df.2.1[,2], apap.sig.df.2.2[,2], apap.sig.df.2.3[,2], apap.sig.df.2.4[,2],
                          apap.sig.df.2.5[,2], apap.sig.df.2.6[,2], apap.sig.df.2.7[,2], apap.sig.df.2.8[,2],
                          apap.sig.df.3.1[,2], apap.sig.df.3.2[,2], apap.sig.df.3.3[,2], apap.sig.df.3.4[,2],
                          apap.sig.df.3.5[,2], apap.sig.df.3.6[,2], apap.sig.df.3.7[,2], apap.sig.df.3.8[,2]))

colnames(Mmu1)<-colnames(sig1)<-c("APAP_0.5h","APAP_1h","APAP_1.5h","APAP_2h",
                                  "APAP_4h","APAP_6h","APAP_8h","APAP_12h",
                                  "APAP-G_0.5h","APAP-G_1h", "APAP-G_1.5h","APAP-G_2h",
                                  "APAP-G_4h","APAP-G_6h", "APAP-G_8h","APAP-G_12h",
                                  "APAP-S_0.5h", "APAP-S_1h", "APAP-S_1.5h","APAP-S_2h",
                                  "APAP-S_4h", "APAP-S_6h", "APAP-S_8h","APAP-S_12h")
rownames(Mmu1)<-rownames(sig1)<-c("Tg", "Tp","CYP_Km","CYP_VmaxC","SULT_Km_apap","SULT_Ki",
                                  "SULT_Km_paps","SULT_VmaxC","UGT_Km","UGT_Ki",
                                  "UGT_Km_GA","UGT_VmaxC","Km_AG","Vmax_AG","Km_AS",
                                  "Vmax_AS","kGA_syn","kPAPS_syn","CLC_APAP","CLC_AG","CLC_AS",
                                  "QCC","VFC","VKC","VGC","VLC","VMC","VBLAC","VBLVC","VSC",
                                  "QFC","QKC","QGC","QLBC","QMC","QSC",  
                                  "BP_APAP","PF_APAP","PG_APAP","PK_APAP","PL_APAP","PM_APAP","PR_APAP","PS_APAP",
                                  "PF_AS","PG_AS","PK_AS","PL_AS","PM_AS","PR_AS","PS_AS",
                                  "PF_AG" ,"PG_AG","PK_AG","PL_AG","PM_AG","PR_AG","PS_AG")

M1<-as.matrix(scale(Mmu1))
S1<-as.matrix(scale(sig1))

if(!require(gplots)) {
  install.packages("gplots"); require(gplots)} #heatmap.2

pdf(file="mor_mu_v2.pdf", width = 12, height = 12)
heatmap.2(M1, cexRow=1.2, cexCol=1.2, col = bluered(100), margins=c(6,9),trace="none",srtCol=35,
          density.info = 'histogram', scale = "none", keysize = 1.2, 
          cellnote=round(M1, digits = 1),
          notecol="black")
dev.off()

pdf(file="mor_sig_v2.pdf", width = 12, height = 12)
heatmap.2(S1, cexRow=1.2, cexCol=1.2, col = bluered(100), margins=c(6,9),trace="none",srtCol=35,
          density.info = 'histogram', scale = "none", keysize = 1.2, 
          cellnote=round(M1, digits = 1),
          notecol="black")
dev.off()