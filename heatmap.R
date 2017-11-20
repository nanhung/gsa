load("morv1.rda")
load("fstv1.rda")
load("jsnv1.rda")
load("ownv1.rda")


#if(!require(gridExtra)) {
#  install.packages("gridExtra"); require(gridExtra)}
if(!require(tidyr)) {
  install.packages("tidyr"); require(tidyr)}
if(!require(dplyr)) {
  install.packages("dplyr"); require(dplyr)}
if(!require(tibble)) {
  install.packages("tibble"); require(tibble)}
if(!require(ggplot2)) {
  install.packages("ggplot2"); require(ggplot2)}
#if(!require(GGally)) {
#  install.packages("GGally"); require(GGally)}
#if(!require(gplots)) {
#  install.packages("gplots"); require(gplots)} #heatmap.2

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
main1<-do.call(cbind, list(apap.mf.df.1.1[,2], apap.mf.df.1.2[,2], apap.mf.df.1.3[,2], apap.mf.df.1.4[,2],
                           apap.mf.df.1.5[,2], apap.mf.df.1.6[,2], apap.mf.df.1.7[,2], apap.mf.df.1.8[,2],
                           apap.mf.df.2.1[,2], apap.mf.df.2.2[,2], apap.mf.df.2.3[,2], apap.mf.df.2.4[,2],
                           apap.mf.df.2.5[,2], apap.mf.df.2.6[,2], apap.mf.df.2.7[,2], apap.mf.df.2.8[,2],
                           apap.mf.df.3.1[,2], apap.mf.df.3.2[,2], apap.mf.df.3.3[,2], apap.mf.df.3.4[,2],
                           apap.mf.df.3.5[,2], apap.mf.df.3.6[,2], apap.mf.df.3.7[,2], apap.mf.df.3.8[,2],
                           apap.mj.df.1.1[,2], apap.mj.df.1.2[,2], apap.mj.df.1.3[,2], apap.mj.df.1.4[,2],
                           apap.mj.df.1.5[,2], apap.mj.df.1.6[,2], apap.mj.df.1.7[,2], apap.mj.df.1.8[,2],
                           apap.mj.df.2.1[,2], apap.mj.df.2.2[,2], apap.mj.df.2.3[,2], apap.mj.df.2.4[,2],
                           apap.mj.df.2.5[,2], apap.mj.df.2.6[,2], apap.mj.df.2.7[,2], apap.mj.df.2.8[,2],
                           apap.mj.df.3.1[,2], apap.mj.df.3.2[,2], apap.mj.df.3.3[,2], apap.mj.df.3.4[,2],
                           apap.mj.df.3.5[,2], apap.mj.df.3.6[,2], apap.mj.df.3.7[,2], apap.mj.df.3.8[,2],
                           apap.mo.df.1.1[,2], apap.mo.df.1.2[,2], apap.mo.df.1.3[,2], apap.mo.df.1.4[,2],
                           apap.mo.df.1.5[,2], apap.mo.df.1.6[,2], apap.mo.df.1.7[,2], apap.mo.df.1.8[,2],
                           apap.mo.df.2.1[,2], apap.mo.df.2.2[,2], apap.mo.df.2.3[,2], apap.mo.df.2.4[,2],
                           apap.mo.df.2.5[,2], apap.mo.df.2.6[,2], apap.mo.df.2.7[,2], apap.mo.df.2.8[,2],
                           apap.mo.df.3.1[,2], apap.mo.df.3.2[,2], apap.mo.df.3.3[,2], apap.mo.df.3.4[,2],
                           apap.mo.df.3.5[,2], apap.mo.df.3.6[,2], apap.mo.df.3.7[,2], apap.mo.df.3.8[,2]))

totl1<-do.call(cbind, list(apap.tf.df.1.1[,2], apap.tf.df.1.2[,2], apap.tf.df.1.3[,2], apap.tf.df.1.4[,2],
                           apap.tf.df.1.5[,2], apap.tf.df.1.6[,2], apap.tf.df.1.7[,2], apap.tf.df.1.8[,2],
                           apap.tf.df.2.1[,2], apap.tf.df.2.2[,2], apap.tf.df.2.3[,2], apap.tf.df.2.4[,2],
                           apap.tf.df.2.5[,2], apap.tf.df.2.6[,2], apap.tf.df.2.7[,2], apap.tf.df.2.8[,2],
                           apap.tf.df.3.1[,2], apap.tf.df.3.2[,2], apap.tf.df.3.3[,2], apap.tf.df.3.4[,2],
                           apap.tf.df.3.5[,2], apap.tf.df.3.6[,2], apap.tf.df.3.7[,2], apap.tf.df.3.8[,2],
                           apap.tj.df.1.1[,2], apap.tj.df.1.2[,2], apap.tj.df.1.3[,2], apap.tj.df.1.4[,2],
                           apap.tj.df.1.5[,2], apap.tj.df.1.6[,2], apap.tj.df.1.7[,2], apap.tj.df.1.8[,2],
                           apap.tj.df.2.1[,2], apap.tj.df.2.2[,2], apap.tj.df.2.3[,2], apap.tj.df.2.4[,2],
                           apap.tj.df.2.5[,2], apap.tj.df.2.6[,2], apap.tj.df.2.7[,2], apap.tj.df.2.8[,2],
                           apap.tj.df.3.1[,2], apap.tj.df.3.2[,2], apap.tj.df.3.3[,2], apap.tj.df.3.4[,2],
                           apap.tj.df.3.5[,2], apap.tj.df.3.6[,2], apap.tj.df.3.7[,2], apap.tj.df.3.8[,2],
                           apap.to.df.1.1[,2], apap.to.df.1.2[,2], apap.to.df.1.3[,2], apap.to.df.1.4[,2],
                           apap.to.df.1.5[,2], apap.to.df.1.6[,2], apap.to.df.1.7[,2], apap.to.df.1.8[,2],
                           apap.to.df.2.1[,2], apap.to.df.2.2[,2], apap.to.df.2.3[,2], apap.to.df.2.4[,2],
                           apap.to.df.2.5[,2], apap.to.df.2.6[,2], apap.to.df.2.7[,2], apap.to.df.2.8[,2],
                           apap.to.df.3.1[,2], apap.to.df.3.2[,2], apap.to.df.3.3[,2], apap.to.df.3.4[,2],     
                           apap.to.df.3.5[,2], apap.to.df.3.6[,2], apap.to.df.3.7[,2], apap.to.df.3.8[,2]))

rownames(main1)<-rownames(totl1)<-rownames(Mmu1)<-rownames(sig1)<-apap.mj.df.1.1[,1]

colnames(main1)<-c("FST.APAP_0.5h", "FST.APAP_1h", "FST.APAP_1.5h", "FST.APAP_2h",
                   "FST.APAP_4h", "FST.APAP_6h", "FST.APAP_8h", "FST.APAP_12h",
                   "FST.A-G_0.5h", "FST.A-G_1h", "FST.A-G_1.5h", "FST.A-G_2h",
                   "FST.A-G_4h", "FST.A-G_6h", "FST.A-G_8h", "FST.A-G_12h",
                   "FST.A-S_0.5h", "FST.A-S_1h", "FST.A-S_1.5h", "FST.A-S_2h",
                   "FST.A-S_4h", "FST.A-S_6h", "FST.A-S_8h", "FST.A-S_12h",
                   "JSN.APAP_0.5h", "JSN.APAP_1h", "JSN.APAP_1.5h", "JSN.APAP_2h",
                   "JSN.APAP_4h", "JSN.APAP_6h", "JSN.APAP_8h", "JSN.APAP_12h",
                   "JSN.A-G_0.5h", "JSN.A-G_1h", "JSN.A-G_1.5h", "JSN.A-G_2h",
                   "JSN.A-G_4h", "JSN.A-G_6h", "JSN.A-G_8h", "JSN.A-G_12h",
                   "JSN.A-S_0.5h", "JSN.A-S_1h", "JSN.A-S_1.5h", "JSN.A-S_2h",
                   "JSN.A-S_4h", "JSN.A-S_6h", "JSN.A-S_8h", "JSN.A-S_12h",
                   "OWN.APAP_0.5h", "OWN.APAP_1h", "OWN.APAP_1.5h", "OWN.APAP_2h",
                   "OWN.APAP_4h", "OWN.APAP_6h", "OWN.APAP_8h", "OWN.APAP_12h",
                   "OWN.A-G_0.5h", "OWN.A-G_1h", "OWN.A-G_1.5h", "OWN.A-G_2h",
                   "OWN.A-G_4h", "OWN.A-G_6h", "OWN.A-G_8h", "OWN.A-G_12h",
                   "OWN.A-S_0.5h", "OWN.A-S_1h", "OWN.A-S_1.5h", "OWN.A-S_2h",
                   "OWN.A-S_4h", "OWN.A-S_6h", "OWN.A-S_8h", "OWN.A-S_12h")

colnames(totl1)<-colnames(main1)
colnames(Mmu1)<-colnames(sig1)<-c("APAP_0.5h","APAP_1h","APAP_1.5h","APAP_2h",
                                  "APAP_4h","APAP_6h","APAP_8h","APAP_12h",
                                  "APAP-G_0.5h","APAP-G_1h", "APAP-G_1.5h","APAP-G_2h",
                                  "APAP-G_4h","APAP-G_6h", "APAP-G_8h","APAP-G_12h",
                                  "APAP-S_0.5h", "APAP-S_1h", "APAP-S_1.5h","APAP-S_2h",
                                  "APAP-S_4h", "APAP-S_6h", "APAP-S_8h","APAP-S_12h")

main4 <- as.data.frame(main1) %>%
  rownames_to_column('Var1') %>%
  gather(Var2, value, -Var1) %>%
  mutate(
    Var1 = factor(Var1, level=row.names(main1)),
    Var2 = factor(gsub("V", "", Var2), level=colnames(main1))
  )

totl4 <- as.data.frame(totl1) %>%
  rownames_to_column('Var1') %>%
  gather(Var2, value, -Var1) %>%
  mutate(
    Var1 = factor(Var1, level=row.names(totl1)),
    Var2 = factor(gsub("V", "", Var2), level=colnames(totl1))
  )

inte1<-totl1-main1
inte4 <- as.data.frame(inte1) %>%
  rownames_to_column('Var1') %>%
  gather(Var2, value, -Var1) %>%
  mutate(
    Var1 = factor(Var1, level=row.names(inte1)),
    Var2 = factor(gsub("V", "", Var2), level=colnames(inte1))
  )

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

# Remove mean and combind main and total
main4$order<-"Main"
totl4$order<-"Total"
inte4$order<-"Interaction"

main4$est<-c(rep("eFAST", 504), rep("Jasen", 504), rep("Owen", 504))
totl4$est<-c(rep("eFAST", 504), rep("Jasen", 504), rep("Owen", 504))
inte4$est<-c(rep("eFAST", 504), rep("Jasen", 504), rep("Owen", 504))

Var3<-c(rep("APAP_0.5h", 21),
        rep("APAP_1h", 21),
        rep("APAP_1.5h", 21),
        rep("APAP_2h", 21),
        rep("APAP_4h", 21),
        rep("APAP_6h", 21),
        rep("APAP_8h", 21),
        rep("APAP_12h", 21),
        rep("APAP-G_0.5h", 21),
        rep("APAP-G_1h", 21),
        rep("APAP-G_1.5h", 21),
        rep("APAP-G_2h", 21),
        rep("APAP-G_4h", 21),
        rep("APAP-G_6h", 21),
        rep("APAP-G_8h", 21),
        rep("APAP-G_12h", 21),
        rep("APAP-S_0.5h", 21),
        rep("APAP-S_1h", 21),
        rep("APAP-S_1.5h", 21),
        rep("APAP-S_2h", 21),
        rep("APAP-S_4h", 21),
        rep("APAP-S_6h", 21),
        rep("APAP-S_8h", 21),
        rep("APAP-S_12h", 21))

Var4<-factor(Var3, level=c("APAP_0.5h","APAP_1h","APAP_1.5h","APAP_2h",
                           "APAP_4h","APAP_6h","APAP_8h","APAP_12h",
                           "APAP-G_0.5h","APAP-G_1h","APAP-G_1.5h","APAP-G_2h",
                           "APAP-G_4h","APAP-G_6h","APAP-G_8h","APAP-G_12h",
                           "APAP-S_0.5h","APAP-S_1h","APAP-S_1.5h","APAP-S_2h",
                           "APAP-S_4h","APAP-S_6h","APAP-S_8h","APAP-S_12h")) 

mt<-rbind(main4,inte4)
mt1<-cbind(mt, Var4)

mt1$Var1 = with(mt1, factor(Var1, levels = rev(levels(Var1))))
mt1$order <- factor(mt1$order, levels = c("Main","Interaction"))

mt1$value2 <- mt1$value
mt1$value2[mt1$value2 < 0.05] <- NA

colCols <-  c(rep("brown1",8),rep("brown3",8),rep("brown4",8))


### ----
p12<-ggplot(mt1, aes(Var4, Var1)) +
  geom_tile(aes(fill = value)) + 
  facet_grid(est~order) +
  geom_text(aes(label = round(value2, 2)), size=2.5) +
  scale_fill_gradient(low = "white", high = "red", limits = c(-0.05,1.00)) +
  labs(title="", x="Datasets", y="Parameters")+
  theme(axis.text.x = element_text(angle = 45, hjust = 1, color=colCols), 
        legend.position = "top", legend.title=element_blank())

pdf(file="fig3.pdf", width = 14, height = 10)
p12
dev.off()


#
Mmu4$est<-"Morris"
sig4$est<-"Morris"
Mmu4$order<-"mu*"
sig4$order<-"sigma"
mor<-rbind(Mmu4, sig4)


mor$Var1 = with(mor, factor(Var1, levels = rev(levels(Var1)))) # revert order

mor$value2 <- mor$value
mor$value2[mor$value2 < 1] <- NA

colCols <-  c(rep("cadetblue2",8),rep("cadetblue3",8),rep("cadetblue4",8))

p11<-ggplot(mor, aes(Var2, Var1)) +
  geom_tile(aes(fill = value)) + 
  facet_grid(.~order) +
  geom_text(aes(label = round(value2, 1)), size=2.5) +
  scale_fill_gradient(low = "white", high = "blue") +
  labs(title="", x="Datasets", y="Parameters")+
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size=10, color=colCols),
        legend.position = "right", legend.title=element_blank())


#png(file="fig2.png",width=3200,height=3200,res=250)
pdf(file="fig2.pdf", width = 12, height = 5)
p11
dev.off()


pdf(file="fig6.pdf", width = 12, height = 12)
grid.arrange(p1,p2, ncol=1, heights=c(1,2))
dev.off()