# library(microbenchmark)
# t<-microbenchmark(system.time(source("jsnv1.R")), unit="s", times=10L)
# t$time
# mean(t$time*1e-9) # 269.6173
# sd(t$time*1e-9) # 6.155541

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
             X21 = runif(n, -6., 1))
}

n <- 8192
X1 <- J.X.df(n); X2 <- J.X.df(n);
J.S <- soboljansen(NULL, X1, X2)#, conf = 0.95, nboot = 1000)
J.S.APAP.df <- cbind(1, J.S$X)
write.table(J.S.APAP.df, file="apap_setpoint.dat", row.names=FALSE, sep="\t")
system("./mcsim.apap.pbpk_v2 apap.setpoint_v1.in")
J.S.APAP.mcsim.df <- as.data.frame(fread("apap_setpoint.csv", head = T))

#Prior Jansen
J.S.APAP.1.1 <- tell(J.S, J.S.APAP.mcsim.df[,23])
J.S.APAP.1.2 <- tell(J.S, J.S.APAP.mcsim.df[,24])
J.S.APAP.1.3 <- tell(J.S, J.S.APAP.mcsim.df[,25])
J.S.APAP.1.4 <- tell(J.S, J.S.APAP.mcsim.df[,26])
J.S.APAP.1.5 <- tell(J.S, J.S.APAP.mcsim.df[,27])
J.S.APAP.1.6 <- tell(J.S, J.S.APAP.mcsim.df[,28])
J.S.APAP.1.7 <- tell(J.S, J.S.APAP.mcsim.df[,29])
J.S.APAP.1.8 <- tell(J.S, J.S.APAP.mcsim.df[,30])
J.S.APAP.2.1 <- tell(J.S, J.S.APAP.mcsim.df[,31])
J.S.APAP.2.2 <- tell(J.S, J.S.APAP.mcsim.df[,32])
J.S.APAP.2.3 <- tell(J.S, J.S.APAP.mcsim.df[,33])
J.S.APAP.2.4 <- tell(J.S, J.S.APAP.mcsim.df[,34])
J.S.APAP.2.5 <- tell(J.S, J.S.APAP.mcsim.df[,35])
J.S.APAP.2.6 <- tell(J.S, J.S.APAP.mcsim.df[,36])
J.S.APAP.2.7 <- tell(J.S, J.S.APAP.mcsim.df[,37])
J.S.APAP.2.8 <- tell(J.S, J.S.APAP.mcsim.df[,38])
J.S.APAP.3.1 <- tell(J.S, J.S.APAP.mcsim.df[,39])
J.S.APAP.3.2 <- tell(J.S, J.S.APAP.mcsim.df[,40])
J.S.APAP.3.3 <- tell(J.S, J.S.APAP.mcsim.df[,41])
J.S.APAP.3.4 <- tell(J.S, J.S.APAP.mcsim.df[,42])
J.S.APAP.3.5 <- tell(J.S, J.S.APAP.mcsim.df[,43])
J.S.APAP.3.6 <- tell(J.S, J.S.APAP.mcsim.df[,44])
J.S.APAP.3.7 <- tell(J.S, J.S.APAP.mcsim.df[,45])
J.S.APAP.3.8 <- tell(J.S, J.S.APAP.mcsim.df[,46])

Parameter <- c("Tg", "Tp","CYP_Km","CYP_VmaxC","SULT_Km_apap","SULT_Ki",
               "SULT_Km_paps","SULT_VmaxC","UGT_Km","UGT_Ki",
               "UGT_Km_GA","UGT_VmaxC","Km_AG","Vmax_AG","Km_AS",
               "Vmax_AS","kGA_syn","kPAPS_syn","CLC_APAP","CLC_AG","CLC_AS")

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

#save(apap.mj.df.1.1, apap.mj.df.1.2, apap.mj.df.1.3, apap.mj.df.1.4,
#     apap.mj.df.1.5, apap.mj.df.1.6, apap.mj.df.1.7, apap.mj.df.1.8,
#     apap.mj.df.2.1, apap.mj.df.2.2, apap.mj.df.2.3, apap.mj.df.2.4,
#     apap.mj.df.2.5, apap.mj.df.2.6, apap.mj.df.2.7, apap.mj.df.2.8,
#     apap.mj.df.3.1, apap.mj.df.3.2, apap.mj.df.3.3, apap.mj.df.3.4,
#     apap.mj.df.3.5, apap.mj.df.3.6, apap.mj.df.3.7, apap.mj.df.3.8,
#     apap.tj.df.1.1, apap.tj.df.1.2, apap.tj.df.1.3, apap.tj.df.1.4,
#     apap.tj.df.1.5, apap.tj.df.1.6, apap.tj.df.1.7, apap.tj.df.1.8,
#     apap.tj.df.2.1, apap.tj.df.2.2, apap.tj.df.2.3, apap.tj.df.2.4,
#     apap.tj.df.2.5, apap.tj.df.2.6, apap.tj.df.2.7, apap.tj.df.2.8,
#     apap.tj.df.3.1, apap.tj.df.3.2, apap.tj.df.3.3, apap.tj.df.3.4,
#     apap.tj.df.3.5, apap.tj.df.3.6, apap.tj.df.3.7, apap.tj.df.3.8,
#     file = "jsnv1.rda")

# system.time(source("jsnv1.R"))