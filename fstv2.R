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
r <- 1.2
r_QCC <- 0.8
r_phy <- 0.08
r_p <- 2.0

q <- rep("qtri", 58)
q.arg <-list(list(log(Tg) - r, log(Tg) + r, log(Tg)),
             list(log(Tp) - r, log(Tp) + r, log(Tp)),
             list(log(CYP_Km) - r, log(CYP_Km) + r, log(CYP_Km)),
             list(log(CYP_VmaxC) - r, log(CYP_VmaxC) + r, log(CYP_VmaxC)),
             list(log(SULT_Km_apap) - r, log(SULT_Km_apap) + r, log(SULT_Km_apap)),
             list(log(SULT_Ki) - r, log(SULT_Ki) + r, log(SULT_Ki)),
             list(log(SULT_Km_paps) - r, log(SULT_Km_paps) + r, log(SULT_Km_paps)),
             list(log(SULT_VmaxC) - r, log(SULT_VmaxC) + r, log(SULT_VmaxC)),
             list(log(UGT_Km) - r, log(UGT_Km) + r, log(UGT_Km)),
             list(log(UGT_Ki) - r, log(UGT_Ki) + r, log(UGT_Ki)),
             list(log(UGT_Km_GA) - r, log(UGT_Km_GA) + r, log(UGT_Km_GA)),
             list(log(UGT_VmaxC) - r, log(UGT_VmaxC) + r, log(UGT_VmaxC)),
             list(log(Km_AG) - r, log(Km_AG) + r, log(Km_AG)),
             list(log(Vmax_AG) - r, log(Vmax_AG) + r, log(Vmax_AG)),
             list(log(Km_AS) - r, log(Km_AS) + r, log(Km_AS)),
             list(log(Vmax_AS) - r, log(Vmax_AS) + r, log(Vmax_AS)),
             list(log(kGA_syn) - r, log(kGA_syn) + r, log(kGA_syn)),
             list(log(kPAPS_syn) - r, log(kPAPS_syn) + r, log(kPAPS_syn)),
             list(log(CLC_APAP) - r, log(CLC_APAP) + r, log(CLC_APAP)),
             list(log(CLC_AG) - r, log(CLC_AG) + r, log(CLC_AG)),
             list(log(CLC_AS) - r, log(CLC_AS) + r, log(CLC_AS)),
             list(log(QCC) - r_QCC, log(QCC) + r_QCC, log(QCC)),
             list(log(VFC) - r_phy, log(VFC) + r_phy, log(VFC)),
             list(log(VKC) - r_phy, log(VKC) + r_phy, log(VKC)),
             list(log(VGC) - r_phy, log(VGC) + r_phy, log(VGC)),
             list(log(VLC) - r_phy, log(VLC) + r_phy, log(VLC)),
             list(log(VMC) - r_phy, log(VMC) + r_phy, log(VMC)),
             list(log(VBLAC) - r_phy, log(VBLAC) + r_phy, log(VBLAC)),
             list(log(VBLVC) - r_phy, log(VBLVC) + r_phy, log(VBLVC)),
             list(log(VSC) - r_phy, log(VSC) + r_phy, log(VSC)),
             list(log(QFC) - r_phy, log(QFC) + r_phy, log(QFC)),
             list(log(QKC) - r_phy, log(QKC) + r_phy, log(QKC)),
             list(log(QGC) - r_phy, log(QGC) + r_phy, log(QGC)),
             list(log(QLBC) - r_phy, log(QLBC) + r_phy, log(QLBC)),
             list(log(QMC) - r_phy, log(QMC) + r_phy, log(QMC)),
             list(log(QSC) - r_phy, log(QSC) + r_phy, log(QSC)),
             list(log(0.1), log(1), log(BP_APAP)),
             list(log(PF_APAP) - r_p, log(PF_APAP) + r_p, log(PF_APAP)),
             list(log(PG_APAP) - r_p, log(PG_APAP) + r_p, log(PG_APAP)),
             list(log(PK_APAP) - r_p, log(PK_APAP) + r_p, log(PK_APAP)),
             list(log(PL_APAP) - r_p, log(PL_APAP) + r_p, log(PL_APAP)),
             list(log(PM_APAP) - r_p, log(PM_APAP) + r_p, log(PM_APAP)),
             list(log(PR_APAP) - r_p, log(PR_APAP) + r_p, log(PR_APAP)),
             list(log(PS_APAP) - r_p, log(PS_APAP) + r_p, log(PS_APAP)),
             list(log(PF_AS) - r_p, log(PF_AS) + r_p, log(PF_AS)),
             list(log(PG_AS) - r_p, log(PG_AS) + r_p, log(PG_AS)),
             list(log(PK_AS) - r_p, log(PK_AS) + r_p, log(PK_AS)),
             list(log(PL_AS) - r_p, log(PL_AS) + r_p, log(PL_AS)),
             list(log(PM_AS) - r_p, log(PM_AS) + r_p, log(PM_AS)),
             list(log(PR_AS) - r_p, log(PR_AS) + r_p, log(PR_AS)),
             list(log(PS_AS) - r_p, log(PS_AS) + r_p, log(PS_AS)),
             list(log(PF_AG) - r_p, log(PF_AG) + r_p, log(PF_AG)),
             list(log(PG_AG) - r_p, log(PG_AG) + r_p, log(PG_AG)),
             list(log(PK_AG) - r_p, log(PK_AG) + r_p, log(PK_AG)),
             list(log(PL_AG) - r_p, log(PL_AG) + r_p, log(PL_AG)),
             list(log(PM_AG) - r_p, log(PM_AG) + r_p, log(PM_AG)),
             list(log(PR_AG) - r_p, log(PR_AG) + r_p, log(PR_AG)),
             list(log(PS_AG) - r_p, log(PS_AG) + r_p, log(PS_AG))
             )

n = 8000
eFAST <- fast99(model = NULL, factors = 58, n = n, M = 4, q = q, q.arg = q.arg)
eFAST.APAP.df <- cbind(1, eFAST$X)
write.table(eFAST.APAP.df, file="apap_setpoint.dat", row.names=FALSE, sep="\t")
system("./mcsim.apap.pbpk_v2 apap.setpoint_v2.in")
eFA.APAP.mcsim.df <- as.data.frame(fread("apap_setpoint.csv", head = T))

eFA.APAP.1.1 <- tell(eFAST, eFA.APAP.mcsim.df[,60])
eFA.APAP.1.2 <- tell(eFAST, eFA.APAP.mcsim.df[,61])
eFA.APAP.1.3 <- tell(eFAST, eFA.APAP.mcsim.df[,62])
eFA.APAP.1.4 <- tell(eFAST, eFA.APAP.mcsim.df[,63])
eFA.APAP.1.5 <- tell(eFAST, eFA.APAP.mcsim.df[,64])
eFA.APAP.1.6 <- tell(eFAST, eFA.APAP.mcsim.df[,65])
eFA.APAP.1.7 <- tell(eFAST, eFA.APAP.mcsim.df[,66])
eFA.APAP.1.8 <- tell(eFAST, eFA.APAP.mcsim.df[,67])
eFA.APAP.2.1 <- tell(eFAST, eFA.APAP.mcsim.df[,68])
eFA.APAP.2.2 <- tell(eFAST, eFA.APAP.mcsim.df[,69])
eFA.APAP.2.3 <- tell(eFAST, eFA.APAP.mcsim.df[,70])
eFA.APAP.2.4 <- tell(eFAST, eFA.APAP.mcsim.df[,71])
eFA.APAP.2.5 <- tell(eFAST, eFA.APAP.mcsim.df[,72])
eFA.APAP.2.6 <- tell(eFAST, eFA.APAP.mcsim.df[,73])
eFA.APAP.2.7 <- tell(eFAST, eFA.APAP.mcsim.df[,74])
eFA.APAP.2.8 <- tell(eFAST, eFA.APAP.mcsim.df[,75])
eFA.APAP.3.1 <- tell(eFAST, eFA.APAP.mcsim.df[,76])
eFA.APAP.3.2 <- tell(eFAST, eFA.APAP.mcsim.df[,77])
eFA.APAP.3.3 <- tell(eFAST, eFA.APAP.mcsim.df[,78])
eFA.APAP.3.4 <- tell(eFAST, eFA.APAP.mcsim.df[,79])
eFA.APAP.3.5 <- tell(eFAST, eFA.APAP.mcsim.df[,80])
eFA.APAP.3.6 <- tell(eFAST, eFA.APAP.mcsim.df[,81])
eFA.APAP.3.7 <- tell(eFAST, eFA.APAP.mcsim.df[,82])
eFA.APAP.3.8 <- tell(eFAST, eFA.APAP.mcsim.df[,83])

# Create the eFAST data frame for use
eFAST_main <- function(data){
  data.frame(
    "Parameter" = Parameter,
    "original" = print(data)[1:58]
  )
}

eFAST_totl <- function(data){
  data.frame(
    "Parameter" = Parameter,
    "original" = print(data)[59:116]
  )
}


apap.mf.df.1.1 <- eFAST_main(eFA.APAP.1.1)
apap.mf.df.1.2 <- eFAST_main(eFA.APAP.1.2)
apap.mf.df.1.3 <- eFAST_main(eFA.APAP.1.3)
apap.mf.df.1.4 <- eFAST_main(eFA.APAP.1.4)
apap.mf.df.1.5 <- eFAST_main(eFA.APAP.1.5)
apap.mf.df.1.6 <- eFAST_main(eFA.APAP.1.6)
apap.mf.df.1.7 <- eFAST_main(eFA.APAP.1.7)
apap.mf.df.1.8 <- eFAST_main(eFA.APAP.1.8)

apap.mf.df.2.1 <- eFAST_main(eFA.APAP.2.1)
apap.mf.df.2.2 <- eFAST_main(eFA.APAP.2.2)
apap.mf.df.2.3 <- eFAST_main(eFA.APAP.2.3)
apap.mf.df.2.4 <- eFAST_main(eFA.APAP.2.4)
apap.mf.df.2.5 <- eFAST_main(eFA.APAP.2.5)
apap.mf.df.2.6 <- eFAST_main(eFA.APAP.2.6)
apap.mf.df.2.7 <- eFAST_main(eFA.APAP.2.7)
apap.mf.df.2.8 <- eFAST_main(eFA.APAP.2.8)

apap.mf.df.3.1 <- eFAST_main(eFA.APAP.3.1)
apap.mf.df.3.2 <- eFAST_main(eFA.APAP.3.2)
apap.mf.df.3.3 <- eFAST_main(eFA.APAP.3.3)
apap.mf.df.3.4 <- eFAST_main(eFA.APAP.3.4)
apap.mf.df.3.5 <- eFAST_main(eFA.APAP.3.5)
apap.mf.df.3.6 <- eFAST_main(eFA.APAP.3.6)
apap.mf.df.3.7 <- eFAST_main(eFA.APAP.3.7)
apap.mf.df.3.8 <- eFAST_main(eFA.APAP.3.8)

apap.tf.df.1.1 <- eFAST_totl(eFA.APAP.1.1)
apap.tf.df.1.2 <- eFAST_totl(eFA.APAP.1.2)
apap.tf.df.1.3 <- eFAST_totl(eFA.APAP.1.3)
apap.tf.df.1.4 <- eFAST_totl(eFA.APAP.1.4)
apap.tf.df.1.5 <- eFAST_totl(eFA.APAP.1.5)
apap.tf.df.1.6 <- eFAST_totl(eFA.APAP.1.6)
apap.tf.df.1.7 <- eFAST_totl(eFA.APAP.1.7)
apap.tf.df.1.8 <- eFAST_totl(eFA.APAP.1.8)

apap.tf.df.2.1 <- eFAST_totl(eFA.APAP.2.1)
apap.tf.df.2.2 <- eFAST_totl(eFA.APAP.2.2)
apap.tf.df.2.3 <- eFAST_totl(eFA.APAP.2.3)
apap.tf.df.2.4 <- eFAST_totl(eFA.APAP.2.4)
apap.tf.df.2.5 <- eFAST_totl(eFA.APAP.2.5)
apap.tf.df.2.6 <- eFAST_totl(eFA.APAP.2.6)
apap.tf.df.2.7 <- eFAST_totl(eFA.APAP.2.7)
apap.tf.df.2.8 <- eFAST_totl(eFA.APAP.2.8)

apap.tf.df.3.1 <- eFAST_totl(eFA.APAP.3.1)
apap.tf.df.3.2 <- eFAST_totl(eFA.APAP.3.2)
apap.tf.df.3.3 <- eFAST_totl(eFA.APAP.3.3)
apap.tf.df.3.4 <- eFAST_totl(eFA.APAP.3.4)
apap.tf.df.3.5 <- eFAST_totl(eFA.APAP.3.5)
apap.tf.df.3.6 <- eFAST_totl(eFA.APAP.3.6)
apap.tf.df.3.7 <- eFAST_totl(eFA.APAP.3.7)
apap.tf.df.3.8 <- eFAST_totl(eFA.APAP.3.8)

save(apap.mf.df.1.1, apap.mf.df.1.2, apap.mf.df.1.3, apap.mf.df.1.4,
     apap.mf.df.1.5, apap.mf.df.1.6, apap.mf.df.1.7, apap.mf.df.1.8,
     apap.mf.df.2.1, apap.mf.df.2.2, apap.mf.df.2.3, apap.mf.df.2.4,
     apap.mf.df.2.5, apap.mf.df.2.6, apap.mf.df.2.7, apap.mf.df.2.8,
     apap.mf.df.3.1, apap.mf.df.3.2, apap.mf.df.3.3, apap.mf.df.3.4,
     apap.mf.df.3.5, apap.mf.df.3.6, apap.mf.df.3.7, apap.mf.df.3.8,
     apap.tf.df.1.1, apap.tf.df.1.2, apap.tf.df.1.3, apap.tf.df.1.4,
     apap.tf.df.1.5, apap.tf.df.1.6, apap.tf.df.1.7, apap.tf.df.1.8,
     apap.tf.df.2.1, apap.tf.df.2.2, apap.tf.df.2.3, apap.tf.df.2.4,
     apap.tf.df.2.5, apap.tf.df.2.6, apap.tf.df.2.7, apap.tf.df.2.8,
     apap.tf.df.3.1, apap.tf.df.3.2, apap.tf.df.3.3, apap.tf.df.3.4,
     apap.tf.df.3.5, apap.tf.df.3.6, apap.tf.df.3.7, apap.tf.df.3.8,
     file = "fstv2.rda")

# load("fstv2.rda") ----
if(!require(gplots)) {
  install.packages("gplots"); require(gplots)} #heatmap.2

main1<-do.call(cbind, list(apap.mf.df.1.1[,2], apap.mf.df.1.2[,2], apap.mf.df.1.3[,2], apap.mf.df.1.4[,2],
                           apap.mf.df.1.5[,2], apap.mf.df.1.6[,2], apap.mf.df.1.7[,2], apap.mf.df.1.8[,2],
                           apap.mf.df.2.1[,2], apap.mf.df.2.2[,2], apap.mf.df.2.3[,2], apap.mf.df.2.4[,2],
                           apap.mf.df.2.5[,2], apap.mf.df.2.6[,2], apap.mf.df.2.7[,2], apap.mf.df.2.8[,2],
                           apap.mf.df.3.1[,2], apap.mf.df.3.2[,2], apap.mf.df.3.3[,2], apap.mf.df.3.4[,2],
                           apap.mf.df.3.5[,2], apap.mf.df.3.6[,2], apap.mf.df.3.7[,2], apap.mf.df.3.8[,2]))

totl1<-do.call(cbind, list(apap.tf.df.1.1[,2], apap.tf.df.1.2[,2], apap.tf.df.1.3[,2], apap.tf.df.1.4[,2],
                           apap.tf.df.1.5[,2], apap.tf.df.1.6[,2], apap.tf.df.1.7[,2], apap.tf.df.1.8[,2],
                           apap.tf.df.2.1[,2], apap.tf.df.2.2[,2], apap.tf.df.2.3[,2], apap.tf.df.2.4[,2],
                           apap.tf.df.2.5[,2], apap.tf.df.2.6[,2], apap.tf.df.2.7[,2], apap.tf.df.2.8[,2],
                           apap.tf.df.3.1[,2], apap.tf.df.3.2[,2], apap.tf.df.3.3[,2], apap.tf.df.3.4[,2],
                           apap.tf.df.3.5[,2], apap.tf.df.3.6[,2], apap.tf.df.3.7[,2], apap.tf.df.3.8[,2]))

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

heatmap.2(M1, cexRow=1.2, cexCol=1.2, col = bluered(100), margins=c(6,9),trace="none",srtCol=35,
          density.info = 'histogram', scale = "none", keysize = 1.2, 
          cellnote=round(M1, digits = 1),
          notecol="black")

pdf(file="fstv2.pdf", width = 12, height = 12)
heatmap.2(T1, cexRow=1.2, cexCol=1.2, col = bluered(100), margins=c(6,9),trace="none",srtCol=35,
          density.info = 'histogram', scale = "none", keysize = 1.2, 
          cellnote=round(T1, digits = 1),
          notecol="black")
dev.off()


