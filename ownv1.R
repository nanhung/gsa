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

r = 2.0

O.X.df <- function(n){
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
             X21 = runif(n, -6., 1))
}

n <- 8192
X1 <- O.X.df(n); X2 <- O.X.df(n); X3 <- O.X.df(n);
O.S <- sobolowen(NULL, X1, X2, X3)#, conf = 0.95, nboot = 1000)
O.S.APAP.df <- cbind(1, O.S$X)
write.table(O.S.APAP.df, file="apap_setpoint.dat", row.names=FALSE, sep="\t")
system("./mcsim.apap.pbpk_v2 apap.setpoint_v1.in")
O.S.APAP.mcsim.df <- as.data.frame(fread("apap_setpoint.csv", head = T))

#Prior Jansen
O.S.APAP.1.1 <- tell(O.S, O.S.APAP.mcsim.df[,23])
O.S.APAP.1.2 <- tell(O.S, O.S.APAP.mcsim.df[,24])
O.S.APAP.1.3 <- tell(O.S, O.S.APAP.mcsim.df[,25])
O.S.APAP.1.4 <- tell(O.S, O.S.APAP.mcsim.df[,26])
O.S.APAP.1.5 <- tell(O.S, O.S.APAP.mcsim.df[,27])
O.S.APAP.1.6 <- tell(O.S, O.S.APAP.mcsim.df[,28])
O.S.APAP.1.7 <- tell(O.S, O.S.APAP.mcsim.df[,29])
O.S.APAP.1.8 <- tell(O.S, O.S.APAP.mcsim.df[,30])
O.S.APAP.2.1 <- tell(O.S, O.S.APAP.mcsim.df[,31])
O.S.APAP.2.2 <- tell(O.S, O.S.APAP.mcsim.df[,32])
O.S.APAP.2.3 <- tell(O.S, O.S.APAP.mcsim.df[,33])
O.S.APAP.2.4 <- tell(O.S, O.S.APAP.mcsim.df[,34])
O.S.APAP.2.5 <- tell(O.S, O.S.APAP.mcsim.df[,35])
O.S.APAP.2.6 <- tell(O.S, O.S.APAP.mcsim.df[,36])
O.S.APAP.2.7 <- tell(O.S, O.S.APAP.mcsim.df[,37])
O.S.APAP.2.8 <- tell(O.S, O.S.APAP.mcsim.df[,38])
O.S.APAP.3.1 <- tell(O.S, O.S.APAP.mcsim.df[,39])
O.S.APAP.3.2 <- tell(O.S, O.S.APAP.mcsim.df[,40])
O.S.APAP.3.3 <- tell(O.S, O.S.APAP.mcsim.df[,41])
O.S.APAP.3.4 <- tell(O.S, O.S.APAP.mcsim.df[,42])
O.S.APAP.3.5 <- tell(O.S, O.S.APAP.mcsim.df[,43])
O.S.APAP.3.6 <- tell(O.S, O.S.APAP.mcsim.df[,44])
O.S.APAP.3.7 <- tell(O.S, O.S.APAP.mcsim.df[,45])
O.S.APAP.3.8 <- tell(O.S, O.S.APAP.mcsim.df[,46])

Parameter <- c("Tg", "Tp","CYP_Km","CYP_VmaxC","SULT_Km_apap","SULT_Ki",
               "SULT_Km_paps","SULT_VmaxC","UGT_Km","UGT_Ki",
               "UGT_Km_GA","UGT_VmaxC","Km_AG","Vmax_AG","Km_AS",
               "Vmax_AS","kGA_syn","kPAPS_syn","CLC_APAP","CLC_AG","CLC_AS")

apap.mo.df.1.1 <- data.frame(Parameter, O.S.APAP.1.1$S)
apap.mo.df.1.2 <- data.frame(Parameter, O.S.APAP.1.2$S)
apap.mo.df.1.3 <- data.frame(Parameter, O.S.APAP.1.3$S)
apap.mo.df.1.4 <- data.frame(Parameter, O.S.APAP.1.4$S)
apap.mo.df.1.5 <- data.frame(Parameter, O.S.APAP.1.5$S)
apap.mo.df.1.6 <- data.frame(Parameter, O.S.APAP.1.6$S)
apap.mo.df.1.7 <- data.frame(Parameter, O.S.APAP.1.7$S)
apap.mo.df.1.8 <- data.frame(Parameter, O.S.APAP.1.8$S)

apap.mo.df.2.1 <- data.frame(Parameter, O.S.APAP.2.1$S)
apap.mo.df.2.2 <- data.frame(Parameter, O.S.APAP.2.2$S)
apap.mo.df.2.3 <- data.frame(Parameter, O.S.APAP.2.3$S)
apap.mo.df.2.4 <- data.frame(Parameter, O.S.APAP.2.4$S)
apap.mo.df.2.5 <- data.frame(Parameter, O.S.APAP.2.5$S)
apap.mo.df.2.6 <- data.frame(Parameter, O.S.APAP.2.6$S)
apap.mo.df.2.7 <- data.frame(Parameter, O.S.APAP.2.7$S)
apap.mo.df.2.8 <- data.frame(Parameter, O.S.APAP.2.8$S)

apap.mo.df.3.1 <- data.frame(Parameter, O.S.APAP.3.1$S)
apap.mo.df.3.2 <- data.frame(Parameter, O.S.APAP.3.2$S)
apap.mo.df.3.3 <- data.frame(Parameter, O.S.APAP.3.3$S)
apap.mo.df.3.4 <- data.frame(Parameter, O.S.APAP.3.4$S)
apap.mo.df.3.5 <- data.frame(Parameter, O.S.APAP.3.5$S)
apap.mo.df.3.6 <- data.frame(Parameter, O.S.APAP.3.6$S)
apap.mo.df.3.7 <- data.frame(Parameter, O.S.APAP.3.7$S)
apap.mo.df.3.8 <- data.frame(Parameter, O.S.APAP.3.8$S)

apap.to.df.1.1 <- data.frame(Parameter, O.S.APAP.1.1$T)
apap.to.df.1.2 <- data.frame(Parameter, O.S.APAP.1.2$T)
apap.to.df.1.3 <- data.frame(Parameter, O.S.APAP.1.3$T)
apap.to.df.1.4 <- data.frame(Parameter, O.S.APAP.1.4$T)
apap.to.df.1.5 <- data.frame(Parameter, O.S.APAP.1.5$T)
apap.to.df.1.6 <- data.frame(Parameter, O.S.APAP.1.6$T)
apap.to.df.1.7 <- data.frame(Parameter, O.S.APAP.1.7$T)
apap.to.df.1.8 <- data.frame(Parameter, O.S.APAP.1.8$T)

apap.to.df.2.1 <- data.frame(Parameter, O.S.APAP.2.1$T)
apap.to.df.2.2 <- data.frame(Parameter, O.S.APAP.2.2$T)
apap.to.df.2.3 <- data.frame(Parameter, O.S.APAP.2.3$T)
apap.to.df.2.4 <- data.frame(Parameter, O.S.APAP.2.4$T)
apap.to.df.2.5 <- data.frame(Parameter, O.S.APAP.2.5$T)
apap.to.df.2.6 <- data.frame(Parameter, O.S.APAP.2.6$T)
apap.to.df.2.7 <- data.frame(Parameter, O.S.APAP.2.7$T)
apap.to.df.2.8 <- data.frame(Parameter, O.S.APAP.2.8$T)

apap.to.df.3.1 <- data.frame(Parameter, O.S.APAP.3.1$T)
apap.to.df.3.2 <- data.frame(Parameter, O.S.APAP.3.2$T)
apap.to.df.3.3 <- data.frame(Parameter, O.S.APAP.3.3$T)
apap.to.df.3.4 <- data.frame(Parameter, O.S.APAP.3.4$T)
apap.to.df.3.5 <- data.frame(Parameter, O.S.APAP.3.5$T)
apap.to.df.3.6 <- data.frame(Parameter, O.S.APAP.3.6$T)
apap.to.df.3.7 <- data.frame(Parameter, O.S.APAP.3.7$T)
apap.to.df.3.8 <- data.frame(Parameter, O.S.APAP.3.8$T)

save(apap.mo.df.1.1, apap.mo.df.1.2, apap.mo.df.1.3, apap.mo.df.1.4,
     apap.mo.df.1.5, apap.mo.df.1.6, apap.mo.df.1.7, apap.mo.df.1.8,
     apap.mo.df.2.1, apap.mo.df.2.2, apap.mo.df.2.3, apap.mo.df.2.4,
     apap.mo.df.2.5, apap.mo.df.2.6, apap.mo.df.2.7, apap.mo.df.2.8,
     apap.mo.df.3.1, apap.mo.df.3.2, apap.mo.df.3.3, apap.mo.df.3.4,
     apap.mo.df.3.5, apap.mo.df.3.6, apap.mo.df.3.7, apap.mo.df.3.8,
     apap.to.df.1.1, apap.to.df.1.2, apap.to.df.1.3, apap.to.df.1.4,
     apap.to.df.1.5, apap.to.df.1.6, apap.to.df.1.7, apap.to.df.1.8,
     apap.to.df.2.1, apap.to.df.2.2, apap.to.df.2.3, apap.to.df.2.4,
     apap.to.df.2.5, apap.to.df.2.6, apap.to.df.2.7, apap.to.df.2.8,
     apap.to.df.3.1, apap.to.df.3.2, apap.to.df.3.3, apap.to.df.3.4,
     apap.to.df.3.5, apap.to.df.3.6, apap.to.df.3.7, apap.to.df.3.8,
     file = "ownv1.rda")

# system.time(source("ownv1.R"))

if(!require(gplots)) {
  install.packages("gplots"); require(gplots)} #heatmap.2

main1<-do.call(cbind, list(apap.mo.df.1.1[,2], apap.mo.df.1.2[,2], apap.mo.df.1.3[,2], apap.mo.df.1.4[,2],
                           apap.mo.df.1.5[,2], apap.mo.df.1.6[,2], apap.mo.df.1.7[,2], apap.mo.df.1.8[,2],
                           apap.mo.df.2.1[,2], apap.mo.df.2.2[,2], apap.mo.df.2.3[,2], apap.mo.df.2.4[,2],
                           apap.mo.df.2.5[,2], apap.mo.df.2.6[,2], apap.mo.df.2.7[,2], apap.mo.df.2.8[,2],
                           apap.mo.df.3.1[,2], apap.mo.df.3.2[,2], apap.mo.df.3.3[,2], apap.mo.df.3.4[,2],
                           apap.mo.df.3.5[,2], apap.mo.df.3.6[,2], apap.mo.df.3.7[,2], apap.mo.df.3.8[,2]))

totl1<-do.call(cbind, list(apap.to.df.1.1[,2], apap.to.df.1.2[,2], apap.to.df.1.3[,2], apap.to.df.1.4[,2],
                           apap.to.df.1.5[,2], apap.to.df.1.6[,2], apap.to.df.1.7[,2], apap.to.df.1.8[,2],
                           apap.to.df.2.1[,2], apap.to.df.2.2[,2], apap.to.df.2.3[,2], apap.to.df.2.4[,2],
                           apap.to.df.2.5[,2], apap.to.df.2.6[,2], apap.to.df.2.7[,2], apap.to.df.2.8[,2],
                           apap.to.df.3.1[,2], apap.to.df.3.2[,2], apap.to.df.3.3[,2], apap.to.df.3.4[,2],
                           apap.to.df.3.5[,2], apap.to.df.3.6[,2], apap.to.df.3.7[,2], apap.to.df.3.8[,2]))

colnames(main1)<-c("APAP_0.5h", "APAP_1h", "APAP_1.5h", "APAP_2h",
                   "APAP_4h", "APAP_6h", "APAP_8h", "APAP_12h",
                   "APAP-G_0.5h", "APAP-G_1h", "APAP-G_1.5h", "APAP-G_2h",
                   "APAP-G_4h", "APAP-G_6h", "APAP-G_8h", "APAP-G_12h",
                   "APAP-S_0.5h", "APAP-S_1h", "APAP-S_1.5h", "APAP-S_2h",
                   "APAP-S_4h", "APAP-S_6h", "APAP-S_8h", "APAP-S_12h")

rownames(main1)<-c("Tg","Tp","CYP_Km","CYP_VmaxC","SULT_Km_apap","SULT_Ki",
                   "SULT_Km_paps","SULT_VmaxC","UGT_Km","UGT_Ki",
                   "UGT_Km_GA","UGT_VmaxC","Km_AG","Vmax_AG","Km_AS",
                   "Vmax_AS","kGA_syn","kPAPS_syn","CLC_APAP","CLC_AG","CLC_AS")

rownames(totl1)<-rownames(main1)
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

pdf(file="ownv1.pdf", width = 12, height = 8)
heatmap.2(T1, cexRow=1.2, cexCol=1.2, col = bluered(100), margins=c(6,9),trace="none",srtCol=35,
          density.info = 'histogram', scale = "none", keysize = 1.2, 
          cellnote=round(T1, digits = 1),
          notecol="black")
dev.off()