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
n = 2000
eFAST <- fast99(model = NULL, factors = 21, n = n, M = 4, q = q, q.arg = q.arg)
eFAST.APAP.df <- cbind(1, eFAST$X)
write.table(eFAST.APAP.df, file="apap_setpoint.dat", row.names=FALSE, sep="\t")
system("./mcsim.apap.pbpk_v2 apap.setpoint_v1.in")
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

Parameter <- c("Tg", "Tp","CYP_Km","CYP_VmaxC","SULT_Km_apap","SULT_Ki",
               "SULT_Km_paps","SULT_VmaxC","UGT_Km","UGT_Ki",
               "UGT_Km_GA","UGT_VmaxC","Km_AG","Vmax_AG","Km_AS",
               "Vmax_AS","kGA_syn","kPAPS_syn","CLC_APAP","CLC_AG","CLC_AS")

# Create the eFAST data frame for use
eFAST_main <- function(data){
  data.frame(
    "Parameter" = names(eFA.APAP.mcsim.df[2:22]),
    "original" = print(data)[1:21]
  )
}

eFAST_totl <- function(data){
  data.frame(
    "Parameter" = names(eFA.APAP.mcsim.df[2:22]),
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
     file = "fstv1.rda")

# system.time(source("fstv1.R"))