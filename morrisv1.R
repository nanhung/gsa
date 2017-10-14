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

#
lwr<- -1
upr<- 1


# Define prior
set.seed(250); pri_Tg <- runif(1000, Tg*exp(lwr), Tg*exp(upr))
set.seed(250); pri_Tp <- runif(1000, Tp*exp(lwr), Tp*exp(upr))
set.seed(250); pri_CYP_Km <- runif(1000, CYP_Km*exp(lwr), CYP_Km*exp(upr))
set.seed(250); pri_CYP_VmaxC <- runif(1000, CYP_VmaxC*exp(lwr), CYP_VmaxC*exp(upr))
set.seed(250); pri_SULT_Km_apap <- runif(1000, SULT_Km_apap*exp(lwr), SULT_Km_apap*exp(upr))
set.seed(250); pri_SULT_Ki <- runif(1000, SULT_Ki*exp(lwr), SULT_Ki*exp(upr))
set.seed(250); pri_SULT_Km_paps <- runif(1000, SULT_Km_paps*exp(lwr), SULT_Km_paps*exp(upr))
set.seed(250); pri_SULT_VmaxC <- runif(1000, SULT_VmaxC*exp(lwr), SULT_VmaxC*exp(upr))
set.seed(250); pri_UGT_Km <- runif(1000, UGT_Km*exp(lwr), UGT_Km*exp(upr))
set.seed(250); pri_UGT_Ki <- runif(1000, UGT_Ki*exp(lwr), UGT_Ki*exp(upr))
set.seed(250); pri_UGT_Km_GA <- runif(1000, UGT_Km_GA*exp(lwr), UGT_Km_GA*exp(upr))
set.seed(250); pri_UGT_VmaxC <- runif(1000, UGT_VmaxC*exp(lwr), UGT_VmaxC*exp(upr))
set.seed(250); pri_Km_AG <- runif(1000, Km_AG*exp(lwr), Km_AG*exp(upr))
set.seed(250); pri_Vmax_AG <- runif(1000, Vmax_AG*exp(lwr), Vmax_AG*exp(upr))
set.seed(250); pri_Km_AS <- runif(1000, Km_AS*exp(lwr), Km_AS*exp(upr))
set.seed(250); pri_Vmax_AS <- runif(1000, Vmax_AS*exp(lwr), Vmax_AS*exp(upr))
set.seed(250); pri_kGA_syn <- runif(1000, kGA_syn*exp(lwr), kGA_syn*exp(upr))
set.seed(250); pri_kPAPS_syn <- runif(1000, kPAPS_syn*exp(lwr), kPAPS_syn*exp(upr))
set.seed(250); pri_CLC_APAP <- runif(1000, CLC_APAP*exp(lwr), CLC_APAP*exp(upr))
set.seed(250); pri_CLC_AG <- runif(1000, CLC_AG*exp(lwr), CLC_AG*exp(upr))
set.seed(250); pri_CLC_AS <- runif(1000, CLC_AS*exp(lwr), CLC_AS*exp(upr))

Parameter <- c("Tg", "Tp","CYP_Km","CYP_VmaxC","SULT_Km_apap","SULT_Ki",
               "SULT_Km_paps","SULT_VmaxC","UGT_Km","UGT_Ki",
               "UGT_Km_GA","UGT_VmaxC","Km_AG","Vmax_AG","Km_AS",
               "Vmax_AS","kGA_syn","kPAPS_syn","CLC_APAP","CLC_AG","CLC_AS")
#
binf <- c(min(log(pri_Tg)),min(log(pri_Tp)),min(log(pri_CYP_Km)),min(log(pri_CYP_VmaxC)),min(log(pri_SULT_Km_apap)),min(log(pri_SULT_Ki)),min(log(pri_SULT_Km_paps)),
          min(log(pri_SULT_VmaxC)),min(log(pri_UGT_Km)),min(log(pri_UGT_Ki)),min(log(pri_UGT_Km_GA)),min(log(pri_UGT_VmaxC)),min(log(pri_Km_AG)),min(log(pri_Vmax_AG)),
          min(log(pri_Km_AS)),min(log(pri_Vmax_AS)),min(log(pri_kGA_syn )),min(log(pri_kPAPS_syn)),min(log(pri_CLC_APAP)),min(log(pri_CLC_AG)),min(log(pri_CLC_AS)))
bsup <- c(max(log(pri_Tg)),max(log(pri_Tp)),max(log(pri_CYP_Km)),max(log(pri_CYP_VmaxC)),max(log(pri_SULT_Km_apap)),max(log(pri_SULT_Ki)),max(log(pri_SULT_Km_paps)),
          max(log(pri_SULT_VmaxC)),max(log(pri_UGT_Km)),max(log(pri_UGT_Ki)),max(log(pri_UGT_Km_GA)),max(log(pri_UGT_VmaxC)),max(log(pri_Km_AG)),max(log(pri_Vmax_AG)),
          max(log(pri_Km_AS)),max(log(pri_Vmax_AS)),max(log(pri_kGA_syn)),max(log(pri_kPAPS_syn)),max(log(pri_CLC_APAP)),max(log(pri_CLC_AG)),max(log(pri_CLC_AS)))

m.s<-function(r){
  morr <- morris(model = NULL, factors = 21, r = r, 
                 design = list(type = "oat", levels = 5, grid.jump = 3), 
                 binf = binf, bsup = bsup, scale = TRUE)
  morr.APAP.df <- cbind(1, morr$X)
  write.table(morr.APAP.df, file="apap_setpoint.dat", row.names=FALSE, sep="\t")
  system("./mcsim.apap.pbpk_v2 apap.setpoint_v1.in")
  mor.APAP.mcsim.df <- as.data.frame(fread("apap_setpoint.csv", head = T))
  mor.APAP.1.1 <- tell(morr, mor.APAP.mcsim.df[,23])
  rbind(apply(mor.APAP.1.1$ee, 2, function(x) mean(abs(x))),apply(mor.APAP.1.1$ee, 2, sd))
}

system.time(m.s.1000.0<-m.s(3000))
