library(plyr)


Tg<-0.332 # prior
Tp<-0.0476
CYP_Km <- 123
CYP_VmaxC <- 2.57
SULT_Km_apap <- 300 # prior (post: 1.2e3)
SULT_Ki <- 478
SULT_Km_paps <- 0.345
SULT_VmaxC <- 467
UGT_Km <- 6.0e3 # prior (post: 6.14e3)
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

#
r <- 1.2

q <- rep("qtri", 21)
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
             list(log(CLC_AS) - r, log(CLC_AS) + r, log(CLC_AS)))


#eFAST <- fast99(model = NULL, factors = 21, n = 1000, M = 4, q = q, q.arg = q.arg)
#eFAST.APAP.df <- cbind(1, eFAST$X)
#write.table(eFAST.APAP.df, file="apap_setpoint.dat", row.names=FALSE, sep="\t")
#system("./mcsim.apap.pbpk_v2 apap.setpoint_v1.in")
#eFA.APAP.mcsim.df <- as.data.frame(fread("apap_setpoint.csv", head = T))
#eFA.APAP.1.1<-tell(eFAST, eFA.APAP.mcsim.df[,23])
#print(eFA.APAP.1.1)[1:21]

fun <- function(n){
  eFAST <- fast99(model = NULL, factors = 21, n = n, M = 4, q = q, q.arg = q.arg)
  eFAST.APAP.df <- cbind(1, eFAST$X)
  write.table(eFAST.APAP.df, file="apap_setpoint.dat", row.names=FALSE, sep="\t")
  system("./mcsim.apap.pbpk_v2 apap.setpoint_v1.in")
  eFA.APAP.mcsim.df <- as.data.frame(fread("apap_setpoint.csv", head = T))
  eFA.APAP.1.1<-tell(eFAST, eFA.APAP.mcsim.df[,23])
  print(eFA.APAP.1.1)[1:21]
}

normalize.max<-function(m){ # 1 for each col, 2 for each row
  M<-sweep(m, 1, apply(m, 1, min))/(sweep(m, 1, apply(m, 1, min))-sweep(m, 1, apply(m, 1, max)))
  max(apply(M, 2, max)- apply(M, 2, min)) 
} #Find max # use in GSA convergence test for morris

#normalize.max<-function(m){ # For eFAST assume that Max index = 1
#  max(apply(m, 2, max)-apply(m, 2, min))
#}

m<-do.call(rbind, rlply(100, fun(n=1000))) # replicate: 100; r = 1000


normalize.max(m) 

# rep= 10, n = 500; normalize.max(m) = 0.2560969


# rep= 20, n = 1000; normalize.max(m) = 0.09113575
# rep= 100, n = 1000; normalize.max(m) = 0.09890751


# rep= 20, n = 2000; normalize.max(m) = 0.0735599