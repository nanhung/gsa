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
r_QCC<- 1.2 # exp(1.2)/exp(-1.2) ~ 11
r_phy<- 0.08
r_pc <- 1.2 # Use the small range to improve converge

#r<-1.0
#name<-UGT_Km
#cat(name, sd(rtri(1000, name-r, name+r, name)), name-r, name+r)


q <- c("qtri","qtri","qtri","qunif",
       "qtri","qtri","qtri","qunif",
       "qtri","qtri","qtri","qunif",
       "qtri","qunif","qtri","qunif",
       "qunif","qunif","qunif","qunif","qunif", rep("qtri", 37))
q.arg <-list(list(Tg-r, Tg+r, Tg),
             list(Tp-r, Tp+r, Tp),
             list(CYP_Km-r, CYP_Km+r, CYP_Km),
             list(-2., 4.),
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
             list(-6., 1),
             list(QCC-r_QCC, QCC+r_QCC, QCC),
             list(VFC-r_phy, VFC+r_phy, VFC),
             list(VKC-r_phy, VKC+r_phy, VKC),
             list(VGC-r_phy, VGC+r_phy, VGC),
             list(VLC-r_phy, VLC+r_phy, VLC),
             list(VMC-r_phy, VMC+r_phy, VMC),
             list(VBLAC-r_phy, VBLAC+r_phy, VBLAC),
             list(VBLVC-r_phy, VBLVC+r_phy, VBLVC),
             list(VSC-r_phy, VSC+r_phy, VSC),
             list(QFC-r_phy, QFC+r_phy, QFC),
             list(QKC-r_phy, QKC+r_phy, QKC),
             list(QGC-r_phy, QGC+r_phy, QGC),
             list(QLBC-r_phy, QLBC+r_phy, QLBC),
             list(QMC-r_phy, QMC+r_phy, QMC),
             list(QSC-r_phy, QSC+r_phy, QSC),
             list(-4.6, 0, BP_APAP),
             list(PF_APAP-r_pc, PF_APAP+r_pc, PF_APAP),
             list(PG_APAP-r_pc, PG_APAP+r_pc, PG_APAP),
             list(PK_APAP-r_pc, PK_APAP+r_pc, PK_APAP),
             list(PL_APAP-r_pc, PL_APAP+r_pc, PL_APAP),
             list(PM_APAP-r_pc, PM_APAP+r_pc, PM_APAP),
             list(PR_APAP-r_pc, PR_APAP+r_pc, PR_APAP),
             list(PS_APAP-r_pc, PS_APAP+r_pc, PS_APAP),
             list(PF_AS-r_pc, PF_AS+r_pc, PF_AS),
             list(PG_AS-r_pc, PG_AS+r_pc, PG_AS),
             list(PK_AS-r_pc, PK_AS+r_pc, PK_AS),
             list(PL_AS-r_pc, PL_AS+r_pc, PL_AS),
             list(PM_AS-r_pc, PM_AS+r_pc, PM_AS),
             list(PR_AS-r_pc, PR_AS+r_pc, PR_AS),
             list(PS_AS-r_pc, PS_AS+r_pc, PS_AS),
             list(PF_AG-r_pc, PF_AG+r_pc, PF_AG),
             list(PG_AG-r_pc, PG_AG+r_pc, PG_AG),
             list(PK_AG-r_pc, PK_AG+r_pc, PK_AG),
             list(PL_AG-r_pc, PL_AG+r_pc, PL_AG),
             list(PM_AG-r_pc, PM_AG+r_pc, PM_AG),
             list(PR_AG-r_pc, PR_AG+r_pc, PR_AG),
             list(PS_AG-r_pc, PS_AG+r_pc, PS_AG))

n <- 8192
eFAST <- fast99(model = NULL, factors = 58, n = n, M = 4, q = q, q.arg = q.arg)
eFAST.APAP.df <- cbind(1, eFAST$X)
write.table(eFAST.APAP.df, file="apap_setpoint.dat", row.names=FALSE, sep="\t")
system("./mcsim.apap.pbpk_v2 apap.setpoint_v2.in")
eFA.APAP.mcsim.df <- as.data.frame(fread("apap_setpoint.csv", head = T))
# Read 475136 rows and 83 (of 83) columns from 0.315 GB file in 00:00:23


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

Parameter <- c("Tg", "Tp","CYP_Km","CYP_VmaxC","SULT_Km_apap","SULT_Ki",
               "SULT_Km_paps","SULT_VmaxC","UGT_Km","UGT_Ki",
               "UGT_Km_GA","UGT_VmaxC","Km_AG","Vmax_AG","Km_AS",
               "Vmax_AS","kGA_syn","kPAPS_syn","CLC_APAP","CLC_AG","CLC_AS",
               "QCC","VFC","VKC","VGC","VLC","VMC","VBLAC","VBLVC","VSC",
               "QFC","QKC","QGC","QLBC","QMC","QSC",  
               "BP_APAP","PF_APAP","PG_APAP","PK_APAP","PL_APAP","PM_APAP","PR_APAP","PS_APAP",
               "PF_AS","PG_AS","PK_AS","PL_AS","PM_AS","PR_AS","PS_AS",
               "PF_AG" ,"PG_AG","PK_AG","PL_AG","PM_AG","PR_AG","PS_AG")

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

# system.time(source("fstv2.R"))

# n <- 1024
#23.12    0.32   77.95 

# n <- 2048
#43.36    0.51  150.49 

# n <- 4096
#user  system elapsed 
#81.85    0.87  289.67

# n <- 8192
#user  system elapsed 
#167.16    2.03  589.53 
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

rownames(main1)<-rownames(totl1)<-apap.mf.df.1.1[,1]
colnames(totl1)<-colnames(main1)


main2 <- as.data.frame(main1)
totl2 <- as.data.frame(totl1)

M0<-main2[,1:24]
T0<-totl2[,1:24]

M1<-as.matrix(M0)
#M1<-scale(M0)
#M1<-scale(M0, center = rep(mean(M0), 24), scale = rep(sd(M0), 24))
T1<-as.matrix(T0)
#T1<-scale(T0)
#T1<-scale(M0, center = rep(mean(T0), 24), scale = rep(sd(T0), 24))

#M1<-(M0 - mean(M0)) / sd(M0)
#T1<-(T0 - mean(T0)) / sd(T0)

M1<-M1[ order(apply(M1, 1, max), decreasing = T), ]
T1<-T1[ order(apply(T1, 1, max), decreasing = T), ]

for(i in 1:24){
  print(sum(T1[1:27,i])/sum(T1[,i])) 
}

colRows <-  c("grey60","grey60","grey60","black",
              "grey60","grey60","grey60","black",
              "grey60","grey60","grey60","black",
              "grey60","black","grey60","black",
              "black","black","black","black","black", rep("darkgreen", 37))
colCols <-  c(rep("grey60",8),rep("red",8),rep("maroon",8))




#heatmap.2(M1, cexRow=1.2, cexCol=1.2, col = bluered(100), margins=c(6,9),trace="none",srtCol=35,
#          density.info = 'histogram', scale = "none", keysize = 1.2, 
#          cellnote=round(M1, digits = 1),
#          notecol="black")

lmat = rbind(c(2,3),c(4,1))
lwid = c(1.5,3.5)
lhei = c(1,5)

#pdf(file="fstv2.pdf", width = 14, height = 12)
png(file="fstv2T.png",width=4000,height=4000,res=250)
heatmap.2(T1, cexRow=1.2, cexCol=1.2, col = colorpanel(100, "white", "red"), margins=c(6,9),trace="none",srtCol=35,
          density.info = 'histogram', scale = "none", keysize = 1.2, 
          cellnote=round(T1, digits = 2),
          #colRow = colRows, 
          colCol =  colCols,
          dendrogram="none", 
          Colv=FALSE, Rowv=FALSE, key.xlab = "Sobol indices (Total)", key.ylab = "",
          key.par=list(mar=c(8,4,4,4)),
          lmat=lmat, lwid = lwid, lhei = lhei,
          notecol="black")
dev.off()


