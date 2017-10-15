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
lwr<- -1.2
upr<- 1.2

# Define prior
set.seed(250); pri_Tg <- rtri(1000, Tg*exp(lwr), Tg*exp(upr), Tg)
set.seed(250); pri_Tp <- rtri(1000, Tp*exp(lwr), Tp*exp(upr), Tp)
set.seed(250); pri_CYP_Km <- rtri(1000, CYP_Km*exp(lwr), CYP_Km*exp(upr), CYP_Km)
set.seed(250); pri_CYP_VmaxC <- rtri(1000, CYP_VmaxC*exp(lwr), CYP_VmaxC*exp(upr), CYP_VmaxC)
set.seed(250); pri_SULT_Km_apap <- rtri(1000, SULT_Km_apap*exp(lwr), SULT_Km_apap*exp(upr), SULT_Km_apap)
set.seed(250); pri_SULT_Ki <- rtri(1000, SULT_Ki*exp(lwr), SULT_Ki*exp(upr), SULT_Ki)
set.seed(250); pri_SULT_Km_paps <- rtri(1000, SULT_Km_paps*exp(lwr), SULT_Km_paps*exp(upr), SULT_Km_paps)
set.seed(250); pri_SULT_VmaxC <- rtri(1000, SULT_VmaxC*exp(lwr), SULT_VmaxC*exp(upr), SULT_VmaxC)
set.seed(250); pri_UGT_Km <- rtri(1000, UGT_Km*exp(lwr), UGT_Km*exp(upr), UGT_Km)
set.seed(250); pri_UGT_Ki <- rtri(1000, UGT_Ki*exp(lwr), UGT_Ki*exp(upr), UGT_Ki)
set.seed(250); pri_UGT_Km_GA <- rtri(1000, UGT_Km_GA*exp(lwr), UGT_Km_GA*exp(upr), UGT_Km_GA)
set.seed(250); pri_UGT_VmaxC <- rtri(1000, UGT_VmaxC*exp(lwr), UGT_VmaxC*exp(upr), UGT_VmaxC)
set.seed(250); pri_Km_AG <- rtri(1000, Km_AG*exp(lwr), Km_AG*exp(upr), Km_AG)
set.seed(250); pri_Vmax_AG <- rtri(1000, Vmax_AG*exp(lwr), Vmax_AG*exp(upr), Vmax_AG)
set.seed(250); pri_Km_AS <- rtri(1000, Km_AS*exp(lwr), Km_AS*exp(upr), Km_AS)
set.seed(250); pri_Vmax_AS <- rtri(1000, Vmax_AS*exp(lwr), Vmax_AS*exp(upr), Vmax_AS)
set.seed(250); pri_kGA_syn <- rtri(1000, kGA_syn*exp(lwr), kGA_syn*exp(upr), kGA_syn)
set.seed(250); pri_kPAPS_syn <- rtri(1000, kPAPS_syn*exp(lwr), kPAPS_syn*exp(upr), kPAPS_syn)
set.seed(250); pri_CLC_APAP <- rtri(1000, CLC_APAP*exp(lwr), CLC_APAP*exp(upr), CLC_APAP)
set.seed(250); pri_CLC_AG <- rtri(1000, CLC_AG*exp(lwr), CLC_AG*exp(upr), CLC_AG)
set.seed(250); pri_CLC_AS <- rtri(1000, CLC_AS*exp(lwr), CLC_AS*exp(upr), CLC_AS)

O.X.df <- function(n){
  data.frame(X1 = rtri(n, Tg*exp(lwr), Tg*exp(upr), Tg),
             X2 = rtri(n, Tp*exp(lwr), Tp*exp(upr), Tp),
             X3 = rtri(n, CYP_Km*exp(lwr), CYP_Km*exp(upr), CYP_Km),
             X4 = rtri(n, CYP_VmaxC*exp(lwr), CYP_VmaxC*exp(upr), CYP_VmaxC),
             X5 = rtri(n, SULT_Km_apap*exp(lwr), SULT_Km_apap*exp(upr), SULT_Km_apap),
             X6 = rtri(n, SULT_Ki*exp(lwr), SULT_Ki*exp(upr), SULT_Ki),
             X7 = rtri(n, SULT_Km_paps*exp(lwr), SULT_Km_paps*exp(upr), SULT_Km_paps),
             X8 = rtri(n, SULT_VmaxC*exp(lwr), SULT_VmaxC*exp(upr), SULT_VmaxC),
             X9 = rtri(n, UGT_Km*exp(lwr), UGT_Km*exp(upr), UGT_Km),
             X10 = rtri(n, UGT_Ki*exp(lwr), UGT_Ki*exp(upr), UGT_Ki),
             X11 = rtri(n, UGT_Km_GA*exp(lwr), UGT_Km_GA*exp(upr), UGT_Km_GA),
             X12 = rtri(n, UGT_VmaxC*exp(lwr), UGT_VmaxC*exp(upr), UGT_VmaxC),
             X13 = rtri(n, Km_AG*exp(lwr), Km_AG*exp(upr), Km_AG),
             X14 = rtri(n, Vmax_AG*exp(lwr), Vmax_AG*exp(upr), Vmax_AG),
             X15 = rtri(n, Km_AS*exp(lwr), Km_AS*exp(upr), Km_AS),
             X16 = rtri(n, Vmax_AS*exp(lwr), Vmax_AS*exp(upr), Vmax_AS),
             X17 = rtri(n, kGA_syn*exp(lwr), kGA_syn*exp(upr), kGA_syn),
             X18 = rtri(n, kPAPS_syn*exp(lwr), kPAPS_syn*exp(upr), kPAPS_syn),
             X19 = rtri(n, CLC_APAP*exp(lwr), CLC_APAP*exp(upr), CLC_APAP),
             X20 = rtri(n, CLC_AG*exp(lwr), CLC_AG*exp(upr), CLC_AG),
             X21 = rtri(n, CLC_AS*exp(lwr), CLC_AS*exp(upr), CLC_AS))
}

X1 <- O.X.df(160); X2 <- O.X.df(160); X3 <- O.X.df(160);
O.S <- sobolowen(NULL, X1, X2, X3, conf = 0.95, nboot = 1000)
O.S$X <- log(O.S$X)
O.S.APAP.df <- cbind(1, O.S$X)
write.table(O.S.APAP.df, file="apap_setpoint.dat", row.names=FALSE, sep="\t")
system("./mcsim.apap.pbpk_v2 apap.setpoint_v1.in")
O.S.APAP.mcsim.df <- as.data.frame(fread("apap_setpoint.csv", head = T))
