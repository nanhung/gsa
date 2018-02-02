if(!require(sensitivity)) {
  install.packages("sensitivity"); require(sensitivity)}
if(!require(EnvStats)) {
  install.packages("EnvStats"); require(EnvStats)} # use rtri
if(!require(data.table)) {
  install.packages("data.table"); require(data.table)}
if(!require(plyr)) {
  install.packages("plyr"); require(plyr)}

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

#r = 2.3
r = 2.0

#
q <- c("qtri","qtri","qtri","qunif",
       "qtri","qtri","qtri","qunif",
       "qtri","qtri","qtri","qunif",
       "qtri","qunif","qtri","qunif",
       "qunif","qunif","qunif","qunif","qunif")
q.arg <-list(list(Tg-r, Tg+r, Tg),
             list(Tp-r, Tp+r, Tp),
             list(CYP_Km-r, CYP_Km+r, CYP_Km),
             list(-2., 5.),
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
             list(-6., 1))

#eFAST <- fast99(model = NULL, factors = 21, n = 1000, M = 4, q = q, q.arg = q.arg)
#eFAST.APAP.df <- cbind(1, eFAST$X)
#write.table(eFAST.APAP.df, file="apap_setpoint.dat", row.names=FALSE, sep="\t")
#system("./mcsim.apap.pbpk_v2 apap.setpoint_v1.in")
#eFA.APAP.mcsim.df <- as.data.frame(fread("apap_setpoint.csv", head = T))
#eFA.APAP.1.1<-tell(eFAST, eFA.APAP.mcsim.df[,23])
#print(eFA.APAP.1.1)[1:21]

source("fast17.R")

fun <- function(n){
  eFAST <- fast99(model = NULL, factors = 21, n = n, M = 4, q = q, q.arg = q.arg)
  eFAST.APAP.df <- cbind(1, eFAST$X)
  write.table(eFAST.APAP.df, file="apap_setpoint.dat", row.names=FALSE, sep="\t")
  system("./mcsim.apap.pbpk_v2 apap.setpoint_v1.in")
  eFA.APAP.mcsim.df <- as.data.frame(fread("apap_setpoint.csv", head = T))
  eFA.APAP.1.1<-tell(eFAST, eFA.APAP.mcsim.df[,23])
  print(eFA.APAP.1.1)[1:42]
}

normalize.max<-function(m){ # 1 for each col, 2 for each row
  M<-sweep(m, 1, apply(m, 1, min))/(sweep(m, 1, apply(m, 1, min))-sweep(m, 1, apply(m, 1, max)))
  max(apply(M, 2, max)- apply(M, 2, min)) 
} #Find max # use in GSA convergence test for morris

normalize.max<-function(m){ # For eFAST assume that Max index = 1
  max(apply(m, 2, max)-apply(m, 2, min))
}

n <- 8192
replicate <- 20
m<-do.call(rbind, rlply(replicate, fun(n=n))) # replicate: 100; r = 1000

#m1<-rbind(m[1:4,],m[6:10,])
#M<-sweep(m1, 1, apply(m1, 1, min))/(sweep(m1, 1, apply(m1, 1, min))-sweep(m1, 1, apply(m1, 1, max)))
#max(apply(M, 2, max)- apply(M, 2, min)) 

#
for (i in 1:21){ # Main
  print((max(m[,i])-min(m[,i])))
}

for (i in 1:21){  # Total
  (max(m[,i])-min(m[,i]))
}

# Use SULT_Vmax as benchmark
(max(m[,8])-min(m[,8])) # Main
(max(m[,29])-min(m[,29])) # Total

# Total check
normalize.max(m[,1:21]) 
normalize.max(m[,22:42]) 

# 1024
# rep= 20, n = 1024; (max(m[,8])-min(m[,8])) = 0.3034725
# rep= 20, n = 1024; (max(m[,29])-min(m[,29])) = 0.3280996

# 2048
# rep= 20, n = 2048; normalize.max(m[,1:21]) = 0.06608291
# rep= 20, n = 2048; normalize.max(m[,22:42]) = 0.07369318

# 4096
# rep= 20, n = 4096; normalize.max(m[,1:21]) = 0.03265557
# rep= 20, n = 4096; normalize.max(m[,22:42]) = 0.03678102

# 8192
# rep= 20, n = 8192; normalize.max(m[,1:21]) = 0.01547068
# rep= 20, n = 8192; normalize.max(m[,22:42]) = 0.03122304

fun2 <- function(n){
  eFAST <- fast99(model = NULL, factors = 58, n = n, M = 4, q = q, q.arg = q.arg)
  eFAST.APAP.df <- cbind(1, eFAST$X)
  write.table(eFAST.APAP.df, file="apap_setpoint.dat", row.names=FALSE, sep="\t")
  system("./mcsim.apap.pbpk_v2 apap.setpoint_v2.in")
  eFA.APAP.mcsim.df <- as.data.frame(fread("apap_setpoint.csv", head = T))
  eFA.APAP.1.1<-tell(eFAST, eFA.APAP.mcsim.df[,60])
  print(eFA.APAP.1.1)[1:116]
}

n <- 2048
replicate <- 20
m<-do.call(rbind, rlply(replicate, fun2(n=n))) # replicate: 100; r = 2048

# 1024
# rep= 20, n = 1024; normalize.max(m[,1:58]) = 0.2792638
# rep= 20, n = 1024; normalize.max(m[,59:116]) = 0.2831886

# 2048
# rep= 10, n = 2048; normalize.max(m[,1:58]) = 0.07678351
# rep= 10, n = 2048; normalize.max(m[,59:116]) = 0.07782856
# rep= 20, n = 2048; normalize.max(m[,1:58]) = 0.07931762
# rep= 20, n = 2048; normalize.max(m[,59:116]) = 0.07986921

# 4096
# rep= 20, n = 4096; normalize.max(m[,1:58]) = 0.1242296
# rep= 20, n = 4096; normalize.max(m[,59:116]) = 0.1254523

# 8192
# rep= 20, n = 8192; normalize.max(m[,1:58]) = 0.05283211
# rep= 20, n = 8192; normalize.max(m[,59:116]) = 0.05349235

# 16384
# rep= 20, n = 16384; normalize.max(m[,1:58]) = 0.05283211
# rep= 20, n = 16384; normalize.max(m[,59:116]) = 0.05349235

# rep= 50, n = 16384; normalize.max(m[,1:58]) = 0.03672055
# rep= 50, n = 16384; normalize.max(m[,59:116]) = 0.03717712