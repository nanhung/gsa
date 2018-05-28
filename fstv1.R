# library(microbenchmark)
# t<-microbenchmark(system.time(source("fstv1.R")), unit="s", times=10L)
# t$time
# mean(t$time*1e-9) 254.3378
# sd(t$time*1e-9) 3.732204

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

r = 2.0 # exp(2.3)/exp(-2.3) ~ 100
#r = 2.0 # exp(2.0)/exp(-2.0) ~ 54.6
#r = 1.8 # exp(1.8)/exp(-1.8) ~ 36.6

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

Parameter <- c("Tg", "Tp",
               "CYP_Km","CYP_VmaxC",
               "SULT_Km_apap","SULT_Ki", "SULT_Km_paps","SULT_VmaxC",
               "UGT_Km","UGT_Ki", "UGT_Km_GA","UGT_VmaxC",
               "Km_AG","Vmax_AG",
               "Km_AS","Vmax_AS",
               "kGA_syn","kPAPS_syn",
               "CLC_APAP","CLC_AG","CLC_AS")

n <- 4000
eFAST <- fast99(model = NULL, factors = Parameter, n = n, M = 4, q = q, q.arg = q.arg)
eFAST.APAP.df <- cbind(1, eFAST$X)
write.table(eFAST.APAP.df, file="apap_setpoint.dat", row.names=FALSE, sep="\t")
#system("./mcsim.apap.pbpk_v2 apap.setpoint_v1.in")
system("./mcsim.APAP_PBPK_thera apap.setpoint_v1.in")
eFA.APAP.mcsim.df <- as.data.frame(fread("apap_setpoint.csv", head = T))

eFA.APAP.1.1 <- tell(eFAST, eFA.APAP.mcsim.df[,23])
eFA.APAP.1.2 <- tell(eFAST, eFA.APAP.mcsim.df[,24])
eFA.APAP.1.3 <- tell(eFAST, eFA.APAP.mcsim.df[,25])
eFA.APAP.1.4 <- tell(eFAST, eFA.APAP.mcsim.df[,26])
eFA.APAP.1.5 <- tell(eFAST, eFA.APAP.mcsim.df[,27])
eFA.APAP.1.6 <- tell(eFAST, eFA.APAP.mcsim.df[,28])
eFA.APAP.1.7 <- tell(eFAST, eFA.APAP.mcsim.df[,29])
eFA.APAP.1.8 <- tell(eFAST, eFA.APAP.mcsim.df[,30])
eFA.APAP.2.1 <- tell(eFAST, eFA.APAP.mcsim.df[,31])
eFA.APAP.2.2 <- tell(eFAST, eFA.APAP.mcsim.df[,32])
eFA.APAP.2.3 <- tell(eFAST, eFA.APAP.mcsim.df[,33])
eFA.APAP.2.4 <- tell(eFAST, eFA.APAP.mcsim.df[,34])
eFA.APAP.2.5 <- tell(eFAST, eFA.APAP.mcsim.df[,35])
eFA.APAP.2.6 <- tell(eFAST, eFA.APAP.mcsim.df[,36])
eFA.APAP.2.7 <- tell(eFAST, eFA.APAP.mcsim.df[,37])
eFA.APAP.2.8 <- tell(eFAST, eFA.APAP.mcsim.df[,38])
eFA.APAP.3.1 <- tell(eFAST, eFA.APAP.mcsim.df[,39])
eFA.APAP.3.2 <- tell(eFAST, eFA.APAP.mcsim.df[,40])
eFA.APAP.3.3 <- tell(eFAST, eFA.APAP.mcsim.df[,41])
eFA.APAP.3.4 <- tell(eFAST, eFA.APAP.mcsim.df[,42])
eFA.APAP.3.5 <- tell(eFAST, eFA.APAP.mcsim.df[,43])
eFA.APAP.3.6 <- tell(eFAST, eFA.APAP.mcsim.df[,44])
eFA.APAP.3.7 <- tell(eFAST, eFA.APAP.mcsim.df[,45])
eFA.APAP.3.8 <- tell(eFAST, eFA.APAP.mcsim.df[,46])

# Create the eFAST data frame for use
eFAST_main <- function(data){
  data.frame(
    "Parameter" = Parameter,
    "original" = print(data)[1:21]
  )
}

eFAST_totl <- function(data){
  data.frame(
    "Parameter" = Parameter,
    "original" = print(data)[22:42]
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

#save(apap.mf.df.1.1, apap.mf.df.1.2, apap.mf.df.1.3, apap.mf.df.1.4,
#     apap.mf.df.1.5, apap.mf.df.1.6, apap.mf.df.1.7, apap.mf.df.1.8,
#     apap.mf.df.2.1, apap.mf.df.2.2, apap.mf.df.2.3, apap.mf.df.2.4,
#     apap.mf.df.2.5, apap.mf.df.2.6, apap.mf.df.2.7, apap.mf.df.2.8,
#     apap.mf.df.3.1, apap.mf.df.3.2, apap.mf.df.3.3, apap.mf.df.3.4,
#     apap.mf.df.3.5, apap.mf.df.3.6, apap.mf.df.3.7, apap.mf.df.3.8,
#     apap.tf.df.1.1, apap.tf.df.1.2, apap.tf.df.1.3, apap.tf.df.1.4,
#     apap.tf.df.1.5, apap.tf.df.1.6, apap.tf.df.1.7, apap.tf.df.1.8,
#     apap.tf.df.2.1, apap.tf.df.2.2, apap.tf.df.2.3, apap.tf.df.2.4,
#     apap.tf.df.2.5, apap.tf.df.2.6, apap.tf.df.2.7, apap.tf.df.2.8,
#     apap.tf.df.3.1, apap.tf.df.3.2, apap.tf.df.3.3, apap.tf.df.3.4,
#     apap.tf.df.3.5, apap.tf.df.3.6, apap.tf.df.3.7, apap.tf.df.3.8,
#     file = "fstv1.rda")

# system.time(source("fstv1.R"))