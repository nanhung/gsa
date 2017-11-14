# Use files: apap.setpoint_v1.in, apap.pbpk_v2.model 

# load package
if(!require(sensitivity)) {
  install.packages("sensitivity"); require(sensitivity)}
if(!require(EnvStats)) {
  install.packages("EnvStats"); require(EnvStats)}
if(!require(data.table)) {
  install.packages("data.table"); require(data.table)}
if(!require(ggplot2)) {
  install.packages("ggplot2"); require(ggplot2)}
if(!require(gridExtra)) {
  install.packages("gridExtra"); require(gridExtra)}


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

n <- 8192
eFAST <- fast99(model = NULL, factors = 21, n = n, M = 4, q = q, q.arg = q.arg)
eFAST.APAP.df <- cbind(1, eFAST$X)
write.table(eFAST.APAP.df, file="apap_setpoint.dat", row.names=FALSE, sep="\t")
system("./mcsim.apap.pbpk_v2 apap.setpoint_v1.in")
eFA.APAP.mcsim.df <- as.data.frame(fread("apap_setpoint.csv", head = T))

# Tell 
#Prior eFAST
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

# Lowry Plot ----
fortify_lowry_data <- function(data, param_var = "Parameter", main_var = "Main.Effect", inter_var = "Interaction")
{
  #Convert wide to long format
  #browser()
  mdata <- melt(data, id.vars = param_var)
  
  #Order columns by main effect and reorder parameter levels
  o <- order(data[, main_var], decreasing = TRUE)
  data <- data[o, ]
  data[, param_var] <- factor(data[, param_var], levels = data[, param_var])
  
  #Force main effect, interaction to be numeric
  data[, main_var] <- as.numeric(data[, main_var])
  data[, inter_var] <- as.numeric(data[, inter_var])
  
  #total effect is main effect + interaction
  data$.total.effect <- rowSums(data[, c(main_var, inter_var)])
  
  #Get cumulative totals for the ribbon
  data$.cumulative.main.effect <- cumsum(data[, main_var])
  data$.cumulative.total.effect <- cumsum(data$.total.effect)
  
  #A quirk of ggplot2 means we need x coords of bars
  data$.numeric.param <- as.numeric(data[, param_var])
  
  #The other upper bound
  #.maximum =  1 - main effects not included
  data$.maximum <- c(1 - rev(cumsum(rev(data[, main_var])))[-1], 1)
  data$.valid.ymax <- with(data, pmin(.maximum, .cumulative.total.effect))
  mdata[, param_var] <- factor(mdata[, param_var], levels = data[, param_var])
  mdata[, 2] <- factor(mdata[, 2], levels = c("Interaction","Main.Effect"))
  
  list(data = data, mdata = mdata)}

lowry_plot <- function(data,
                       param_var = "Parameter",
                       main_var = "Main.Effect",
                       inter_var = "Interaction",
                       x_lab = "Parameters",
                       y_lab = "Total Effects",
                       ggtitle = " ",
                       ribbon_alpha = 0.5, x_text_angle = 45)
{
  #Fortify data and dump contents into plot function environment
  data_list <- fortify_lowry_data(data, param_var, main_var, inter_var)
  list2env(data_list, envir = sys.frame(sys.nframe()))
  
  p <- ggplot() +
    geom_bar(aes_string(x = param_var, y = "value", fill = "variable"),
             data = mdata, stat="identity") +
    geom_ribbon(aes(x = .numeric.param, ymin = .cumulative.main.effect, ymax = .valid.ymax),
                data = data,
                alpha = ribbon_alpha) +
    xlab(x_lab) +
    ylab(y_lab) +
    ggtitle(ggtitle) + theme_bw() +
    geom_hline(yintercept=0.95, color="red", linetype="dotted") +
    theme(axis.text.x = element_text(angle = x_text_angle, hjust = 1),
          legend.position = "none",
          legend.title = element_blank())
  p
}

# eFAST data manipulate
APAP_eFAST_data <- function(data){
  data.frame(
    "Parameter" = names(eFA.APAP.mcsim.df[2:22]),
    "Main Effect" = print(data)[1:21],
    "Interaction" = print(data)[22:42]-print(data)[1:21]
  )
}

# 
APAP.eFA.dat.1.1 <- APAP_eFAST_data(eFA.APAP.1.1)
APAP.eFA.dat.1.2 <- APAP_eFAST_data(eFA.APAP.1.2)
APAP.eFA.dat.1.3 <- APAP_eFAST_data(eFA.APAP.1.3)
APAP.eFA.dat.1.4 <- APAP_eFAST_data(eFA.APAP.1.4)
APAP.eFA.dat.1.5 <- APAP_eFAST_data(eFA.APAP.1.5)
APAP.eFA.dat.1.6 <- APAP_eFAST_data(eFA.APAP.1.6)
APAP.eFA.dat.1.7 <- APAP_eFAST_data(eFA.APAP.1.7)
APAP.eFA.dat.1.8 <- APAP_eFAST_data(eFA.APAP.1.8)

APAP.eFA.dat.2.1 <- APAP_eFAST_data(eFA.APAP.2.1)
APAP.eFA.dat.2.2 <- APAP_eFAST_data(eFA.APAP.2.2)
APAP.eFA.dat.2.3 <- APAP_eFAST_data(eFA.APAP.2.3)
APAP.eFA.dat.2.4 <- APAP_eFAST_data(eFA.APAP.2.4)
APAP.eFA.dat.2.5 <- APAP_eFAST_data(eFA.APAP.2.5)
APAP.eFA.dat.2.6 <- APAP_eFAST_data(eFA.APAP.2.6)
APAP.eFA.dat.2.7 <- APAP_eFAST_data(eFA.APAP.2.7)
APAP.eFA.dat.2.8 <- APAP_eFAST_data(eFA.APAP.2.8)

APAP.eFA.dat.3.1 <- APAP_eFAST_data(eFA.APAP.3.1)
APAP.eFA.dat.3.2 <- APAP_eFAST_data(eFA.APAP.3.2)
APAP.eFA.dat.3.3 <- APAP_eFAST_data(eFA.APAP.3.3)
APAP.eFA.dat.3.4 <- APAP_eFAST_data(eFA.APAP.3.4)
APAP.eFA.dat.3.5 <- APAP_eFAST_data(eFA.APAP.3.5)
APAP.eFA.dat.3.6 <- APAP_eFAST_data(eFA.APAP.3.6)
APAP.eFA.dat.3.7 <- APAP_eFAST_data(eFA.APAP.3.7)
APAP.eFA.dat.3.8 <- APAP_eFAST_data(eFA.APAP.3.8)

save(APAP.eFA.dat.1.1, APAP.eFA.dat.1.2, APAP.eFA.dat.1.3, APAP.eFA.dat.1.4,
     APAP.eFA.dat.1.5, APAP.eFA.dat.1.6, APAP.eFA.dat.1.7, APAP.eFA.dat.1.8,
     APAP.eFA.dat.2.1, APAP.eFA.dat.2.2, APAP.eFA.dat.2.3, APAP.eFA.dat.2.4,
     APAP.eFA.dat.2.5, APAP.eFA.dat.2.6, APAP.eFA.dat.2.7, APAP.eFA.dat.2.8,
     APAP.eFA.dat.3.1, APAP.eFA.dat.3.2, APAP.eFA.dat.3.3, APAP.eFA.dat.3.4,
     APAP.eFA.dat.3.5, APAP.eFA.dat.3.6, APAP.eFA.dat.3.7, APAP.eFA.dat.3.8,
     file = "fstv1-lwy.rda")



# Create lowry plot
f1.1 <- lowry_plot(APAP.eFA.dat.1.1 , ggtitle = "APAP_plasma t = 0.5h")
f1.2 <- lowry_plot(APAP.eFA.dat.1.2 , ggtitle = "APAP_plasma t = 1.0h")
f1.3 <- lowry_plot(APAP.eFA.dat.1.3 , ggtitle = "APAP_plasma t = 1.5h")
f1.4 <- lowry_plot(APAP.eFA.dat.1.4 , ggtitle = "APAP_plasma t = 2.0h")
f1.5 <- lowry_plot(APAP.eFA.dat.1.5 , ggtitle = "APAP_plasma t = 4.0h")
f1.6 <- lowry_plot(APAP.eFA.dat.1.6 , ggtitle = "APAP_plasma t = 6.0h")
f1.7 <- lowry_plot(APAP.eFA.dat.1.7 , ggtitle = "APAP_plasma t = 8.0h")
f1.8 <- lowry_plot(APAP.eFA.dat.1.8 , ggtitle = "APAP_plasma t = 12.0h")

f2.1 <- lowry_plot(APAP.eFA.dat.2.1 , ggtitle = "APAP-G_plasma t = 0.5h")
f2.2 <- lowry_plot(APAP.eFA.dat.2.2 , ggtitle = "APAP-G_plasma t = 1.0h")
f2.3 <- lowry_plot(APAP.eFA.dat.2.3 , ggtitle = "APAP-G_plasma t = 1.5h")
f2.4 <- lowry_plot(APAP.eFA.dat.2.4 , ggtitle = "APAP-G_plasma t = 2.0h")
f2.5 <- lowry_plot(APAP.eFA.dat.2.5 , ggtitle = "APAP-G_plasma t = 4.0h")
f2.6 <- lowry_plot(APAP.eFA.dat.2.6 , ggtitle = "APAP-G_plasma t = 6.0h")
f2.7 <- lowry_plot(APAP.eFA.dat.2.7 , ggtitle = "APAP-G_plasma t = 8.0h")
f2.8 <- lowry_plot(APAP.eFA.dat.2.8 , ggtitle = "APAP-G_plasma t = 12.0h")

f3.1 <- lowry_plot(APAP.eFA.dat.3.1 , ggtitle = "APAP-S_plasma t = 0.5h")
f3.2 <- lowry_plot(APAP.eFA.dat.3.2 , ggtitle = "APAP-S_plasma t = 1.0h")
f3.3 <- lowry_plot(APAP.eFA.dat.3.3 , ggtitle = "APAP-S_plasma t = 1.5h")
f3.4 <- lowry_plot(APAP.eFA.dat.3.4 , ggtitle = "APAP-S_plasma t = 2.0h")
f3.5 <- lowry_plot(APAP.eFA.dat.3.5 , ggtitle = "APAP-S_plasma t = 4.0h")
f3.6 <- lowry_plot(APAP.eFA.dat.3.6 , ggtitle = "APAP-S_plasma t = 6.0h")
f3.7 <- lowry_plot(APAP.eFA.dat.3.7 , ggtitle = "APAP-S_plasma t = 8.0h")
f3.8 <- lowry_plot(APAP.eFA.dat.3.8 , ggtitle = "APAP-S_plasma t = 12.0h")


# create png file
#png(file="lowryplot-APAP.png",width=2400,height=1600,res=150)
pdf("lowryplot-APAP.pdf", 15, 9)
grid.arrange(f1.1, f1.2, f1.3, f1.4,
             f1.5, f1.6, f1.7, f1.8, ncol=4)
dev.off()

#png(file="lowryplot-AG.png",width=2400,height=1600,res=150)
pdf("lowryplot-AG.pdf", 15, 9)
grid.arrange(f2.1, f2.2, f2.3, f2.4,
             f2.5, f2.6, f2.7, f2.8, ncol=4)
dev.off()

#png(file="lowryplot-AS.png",width=2400,height=1600,res=150)
pdf("lowryplot-AS.pdf", 15, 9)
grid.arrange(f3.1, f3.2, f3.3, f3.4,
             f3.5, f3.6, f3.7, f3.8, ncol=4)
dev.off()