if(!require(sensitivity)) {
  install.packages("sensitivity"); require(sensitivity)}
if(!require(EnvStats)) {
  install.packages("EnvStats"); require(EnvStats)}
if(!require(data.table)) {
  install.packages("data.table"); require(data.table)}

# Normalize 0401
set.seed(0)
x<-morris(model = NULL, factors = 21, r = 1024,
          design = list(type = "oat", levels = 5, grid.jump = 3))
r = 2.0 # set the range to 4

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

#
min<-c(Tg-r, 
        Tp-r, 
        CYP_Km-r, 
        -2, 
        SULT_Km_apap-r, 
        SULT_Ki-r,
        SULT_Km_paps-r, 
        0, 
        UGT_Km-r,
        UGT_Ki-r,
        UGT_Km_GA-r, 
        0, 
        Km_AG-r, 
        7, 
        Km_AS-r,
        7, 
        0, 
        0, 
        -6, 
        -6, 
        -6)

max<-c(Tg+r, 
        Tp+r, 
        CYP_Km+r, 
        5, 
        SULT_Km_apap+r, 
        SULT_Ki+r,
        SULT_Km_paps+r, 
        10, 
        UGT_Km+r,
        UGT_Ki+r,
        UGT_Km_GA+r, 
        10, 
        Km_AG+r, 
        15, 
        Km_AS+r,
        15, 
        13, 
        13, 
        1, 
        1, 
        1)
para.range<-data.frame(min,max)

df<-data.frame()[1:nrow(x$X),]

for(i in 1:21){
  df[,i]<-para.range[i,1] + ((para.range[i,2]-para.range[i,1]) * x$X[,i])
} 

morr.APAP.df <- cbind(1, df)
write.table(morr.APAP.df, file="apap_setpoint.dat", row.names=FALSE, sep="\t")
system("./mcsim.apap.pbpk_v2 apap.setpoint_v1.in")
mor.APAP.mcsim.df <- as.data.frame(fread("apap_setpoint.csv", head = T))

mor.APAP.1.1 <- tell(morr, mor.APAP.mcsim.df[,23])
mor.APAP.1.2 <- tell(morr, mor.APAP.mcsim.df[,24])
mor.APAP.1.3 <- tell(morr, mor.APAP.mcsim.df[,25])
mor.APAP.1.4 <- tell(morr, mor.APAP.mcsim.df[,26])
mor.APAP.1.5 <- tell(morr, mor.APAP.mcsim.df[,27])
mor.APAP.1.6 <- tell(morr, mor.APAP.mcsim.df[,28])
mor.APAP.1.7 <- tell(morr, mor.APAP.mcsim.df[,29])
mor.APAP.1.8 <- tell(morr, mor.APAP.mcsim.df[,30])
mor.APAP.2.1 <- tell(morr, mor.APAP.mcsim.df[,31])
mor.APAP.2.2 <- tell(morr, mor.APAP.mcsim.df[,32])
mor.APAP.2.3 <- tell(morr, mor.APAP.mcsim.df[,33])
mor.APAP.2.4 <- tell(morr, mor.APAP.mcsim.df[,34])
mor.APAP.2.5 <- tell(morr, mor.APAP.mcsim.df[,35])
mor.APAP.2.6 <- tell(morr, mor.APAP.mcsim.df[,36])
mor.APAP.2.7 <- tell(morr, mor.APAP.mcsim.df[,37])
mor.APAP.2.8 <- tell(morr, mor.APAP.mcsim.df[,38])
mor.APAP.3.1 <- tell(morr, mor.APAP.mcsim.df[,39])
mor.APAP.3.2 <- tell(morr, mor.APAP.mcsim.df[,40])
mor.APAP.3.3 <- tell(morr, mor.APAP.mcsim.df[,41])
mor.APAP.3.4 <- tell(morr, mor.APAP.mcsim.df[,42])
mor.APAP.3.5 <- tell(morr, mor.APAP.mcsim.df[,43])
mor.APAP.3.6 <- tell(morr, mor.APAP.mcsim.df[,44])
mor.APAP.3.7 <- tell(morr, mor.APAP.mcsim.df[,45])
mor.APAP.3.8 <- tell(morr, mor.APAP.mcsim.df[,46])

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
               "Vmax_AS","kGA_syn","kPAPS_syn","CLC_APAP","CLC_AG","CLC_AS")

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



