if(!require(sensitivity)) {
  install.packages("sensitivity"); require(sensitivity)}
if(!require(EnvStats)) {
  install.packages("EnvStats"); require(EnvStats)}
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

r = 2.6 # exp(2.6)/exp(-2.6) ~ 181.3


#
binf<-c(Tg-r, 
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

bsup<-c(Tg+r, 
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

#round(log(binf), digits=4)
#round(log(bsup), digits=4)

morr <- morris(model = NULL, factors = 21, r = 1024, 
               design = list(type = "oat", levels = 5, grid.jump = 3), 
               binf = binf, bsup = bsup)
morr.APAP.df <- cbind(1, morr$X)
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

save(apap.Mmu.df.1.1,apap.Mmu.df.1.2,apap.Mmu.df.1.3,apap.Mmu.df.1.4,
     apap.Mmu.df.1.5,apap.Mmu.df.1.6,apap.Mmu.df.1.7,apap.Mmu.df.1.8,
     apap.Mmu.df.2.1,apap.Mmu.df.2.2,apap.Mmu.df.2.3,apap.Mmu.df.2.4,
     apap.Mmu.df.2.5,apap.Mmu.df.2.6,apap.Mmu.df.2.7,apap.Mmu.df.2.8,
     apap.Mmu.df.3.1,apap.Mmu.df.3.2,apap.Mmu.df.3.3,apap.Mmu.df.3.4,
     apap.Mmu.df.3.5,apap.Mmu.df.3.6,apap.Mmu.df.3.7,apap.Mmu.df.3.8,
     apap.sig.df.1.1,apap.sig.df.1.2,apap.sig.df.1.3,apap.sig.df.1.4,
     apap.sig.df.1.5,apap.sig.df.1.6,apap.sig.df.1.7,apap.sig.df.1.8,
     apap.sig.df.2.1,apap.sig.df.2.2,apap.sig.df.2.3,apap.sig.df.2.4,
     apap.sig.df.2.5,apap.sig.df.2.6,apap.sig.df.2.7,apap.sig.df.2.8,
     apap.sig.df.3.1,apap.sig.df.3.2,apap.sig.df.3.3,apap.sig.df.3.4,
     apap.sig.df.3.5,apap.sig.df.3.6,apap.sig.df.3.7,apap.sig.df.3.8,
     file = "morv1.rda")

Mmu1<-do.call(cbind, list(apap.Mmu.df.1.1[,2], apap.Mmu.df.1.2[,2], apap.Mmu.df.1.3[,2], apap.Mmu.df.1.4[,2],
                          apap.Mmu.df.1.5[,2], apap.Mmu.df.1.6[,2], apap.Mmu.df.1.7[,2], apap.Mmu.df.1.8[,2],
                          apap.Mmu.df.2.1[,2], apap.Mmu.df.2.2[,2], apap.Mmu.df.2.3[,2], apap.Mmu.df.2.4[,2],
                          apap.Mmu.df.2.5[,2], apap.Mmu.df.2.6[,2], apap.Mmu.df.2.7[,2], apap.Mmu.df.2.8[,2],
                          apap.Mmu.df.3.1[,2], apap.Mmu.df.3.2[,2], apap.Mmu.df.3.3[,2], apap.Mmu.df.3.4[,2],
                          apap.Mmu.df.3.5[,2], apap.Mmu.df.3.6[,2], apap.Mmu.df.3.7[,2], apap.Mmu.df.3.8[,2]
))
sig1<-do.call(cbind, list(apap.sig.df.1.1[,2], apap.sig.df.1.2[,2], apap.sig.df.1.3[,2], apap.sig.df.1.4[,2],
                          apap.sig.df.1.5[,2], apap.sig.df.1.6[,2], apap.sig.df.1.7[,2], apap.sig.df.1.8[,2],
                          apap.sig.df.2.1[,2], apap.sig.df.2.2[,2], apap.sig.df.2.3[,2], apap.sig.df.2.4[,2],
                          apap.sig.df.2.5[,2], apap.sig.df.2.6[,2], apap.sig.df.2.7[,2], apap.sig.df.2.8[,2],
                          apap.sig.df.3.1[,2], apap.sig.df.3.2[,2], apap.sig.df.3.3[,2], apap.sig.df.3.4[,2],
                          apap.sig.df.3.5[,2], apap.sig.df.3.6[,2], apap.sig.df.3.7[,2], apap.sig.df.3.8[,2]))

colnames(Mmu1)<-colnames(sig1)<-c("APAP_0.5h","APAP_1h","APAP_1.5h","APAP_2h",
                                  "APAP_4h","APAP_6h","APAP_8h","APAP_12h",
                                  "APAP-G_0.5h","APAP-G_1h", "APAP-G_1.5h","APAP-G_2h",
                                  "APAP-G_4h","APAP-G_6h", "APAP-G_8h","APAP-G_12h",
                                  "APAP-S_0.5h", "APAP-S_1h", "APAP-S_1.5h","APAP-S_2h",
                                  "APAP-S_4h", "APAP-S_6h", "APAP-S_8h","APAP-S_12h")
rownames(Mmu1)<-rownames(sig1)<-apap.Mmu.df.1.1[,1]

M1<-as.matrix(scale(Mmu1))

M0<-as.matrix(Mmu1)
M1<-(Mmu1 - mean(Mmu1)) / sd(Mmu1)
S0<-as.matrix(sig1)
S1<-(sig1 - mean(sig1)) / sd(sig1)


#
if(!require(dplyr)) {
  install.packages("dplyr"); require(dplyr)} # pipline
if(!require(tibble)) {
  install.packages("tibble"); require(tibble)} #rownames_to_column
if(!require(tidyr)) {
  install.packages("tidyr"); require(tidyr)} #gather
if(!require(ggplot2)) {
  install.packages("ggplot2"); require(ggplot2)}
if(!require(gplots)) {
  install.packages("gplots"); require(gplots)} #heatmap.2

Mmu4 <- as.data.frame(Mmu1) %>%
  rownames_to_column('Var1') %>%
  gather(Var2, value, -Var1) %>%
  mutate(
    Var1 = factor(Var1, level=row.names(Mmu1)),
    Var2 = factor(gsub("V", "", Var2), level=colnames(Mmu1))
  )

sig4 <- as.data.frame(sig1) %>%
  rownames_to_column('Var1') %>%
  gather(Var2, value, -Var1) %>%
  mutate(
    Var1 = factor(Var1, level=row.names(sig1)),
    Var2 = factor(gsub("V", "", Var2), level=colnames(sig1))
  )

Mmu4$est<-"Morris"
sig4$est<-"Morris"
Mmu4$order<-"mu"
sig4$order<-"sigma"

mor<-rbind(Mmu4, sig4)
mor$Var2 = with(mor, factor(Var2, levels = rev(levels(Var2)))) # revert order

p11<-ggplot(mor, aes(Var1, Var2)) +
  geom_tile(aes(fill = value)) + 
  facet_grid(est~order) +
  facet_wrap(~grp, labeller=label_parsed)
  geom_text(aes(label = round(value, 1)), size=2) +
  scale_fill_gradient(low = "white", high = "blue") +
  labs(title="", x="Parameters", y="Datasets")+
  theme(axis.text.x = element_text(angle = 45, hjust = 1), legend.position = "right", legend.title=element_blank())

colRows <-  c("grey60","grey60","grey60","black",
              "grey60","grey60","grey60","black",
              "grey60","grey60","grey60","black",
              "grey60","black","grey60","black",
              "black","black","black","black","black")
colCols <-  c(rep("grey60",8),rep("red",8),rep("maroon",8))


# https://stackoverflow.com/questions/15351575/moving-color-key-in-r-heatmap-2-function-of-gplots-package

lmat = rbind(3:4,2:1)
lwid = c(1,4)
lhei = c(1,4)


pdf(file="mor_mu_v1.pdf", width = 12, height = 8)
heatmap.2(M1, cexRow=1.2, cexCol=1.2, col = bluered(100), margins=c(6,9),trace="none",srtCol=35,
          density.info = 'histogram', scale = "none", keysize = 1,
          cellnote=round(M1, digits = 1), 
          dendrogram="row", 
          Colv=FALSE,
          lmat=lmat, lwid = lwid, lhei = lhei,
          colRow = colRows, colCol =  colCols,
          notecol="black")
dev.off()

pdf(file="mor_sig_v1.pdf", width = 12, height = 8)
heatmap.2(S1, cexRow=1.2, cexCol=1.2, col = bluered(100), margins=c(6,9),trace="none",srtCol=35,
          density.info = 'histogram', scale = "none", keysize = 1.2, 
          cellnote=round(M1, digits = 1),
          dendrogram="row", # remove column cluster
          Colv=FALSE,
          lmat=lmat, lwid = lwid, lhei = lhei,
          colRow = colRows, colCol =  colCols, # color text
          notecol="black")
dev.off()
