load("fstv2.rda")
if(!require(gplots)) {
  install.packages("gplots"); require(gplots)} #heatmap.2
if(!require(tidyr)) {
  install.packages("tidyr"); require(tidyr)}
if(!require(dplyr)) {
  install.packages("dplyr"); require(dplyr)}
if(!require(tibble)) {
  install.packages("tibble"); require(tibble)}
if(!require(ggplot2)) {
  install.packages("ggplot2"); require(ggplot2)}

main1<-do.call(cbind, list(apap.mf.df.1.1[,2], apap.mf.df.1.2[,2], apap.mf.df.1.3[,2], apap.mf.df.1.4[,2],
                           apap.mf.df.1.5[,2], apap.mf.df.1.6[,2], apap.mf.df.1.7[,2], apap.mf.df.1.8[,2],
                           apap.mf.df.2.1[,2], apap.mf.df.2.2[,2], apap.mf.df.2.3[,2], apap.mf.df.2.4[,2],
                           apap.mf.df.2.5[,2], apap.mf.df.2.6[,2], apap.mf.df.2.7[,2], apap.mf.df.2.8[,2],
                           apap.mf.df.3.1[,2], apap.mf.df.3.2[,2], apap.mf.df.3.3[,2], apap.mf.df.3.4[,2],
                           apap.mf.df.3.5[,2], apap.mf.df.3.6[,2], apap.mf.df.3.7[,2], apap.mf.df.3.8[,2]))

totl1<-do.call(cbind, list(apap.tf.df.1.1[,2], apap.tf.df.1.2[,2], apap.tf.df.1.3[,2], apap.tf.df.1.4[,2],
                           apap.tf.df.1.5[,2], apap.tf.df.1.6[,2], apap.tf.df.1.7[,2], apap.tf.df.1.8[,2],
                           apap.tf.df.2.1[,2], apap.tf.df.2.2[,2], apap.tf.df.2.3[,2], apap.tf.df.2.4[,2],
                           apap.tf.df.2.5[,2], apap.tf.df.2.6[,2], apap.tf.df.2.7[,2], apap.tf.df.2.8[,2],
                           apap.tf.df.3.1[,2], apap.tf.df.3.2[,2], apap.tf.df.3.3[,2], apap.tf.df.3.4[,2],
                           apap.tf.df.3.5[,2], apap.tf.df.3.6[,2], apap.tf.df.3.7[,2], apap.tf.df.3.8[,2]))

colnames(main1)<-c("APAP_0.5h", "APAP_1h", "APAP_1.5h", "APAP_2h",
                   "APAP_4h", "APAP_6h", "APAP_8h", "APAP_12h",
                   "APAP-G_0.5h", "APAP-G_1h", "APAP-G_1.5h", "APAP-G_2h",
                   "APAP-G_4h", "APAP-G_6h", "APAP-G_8h", "APAP-G_12h",
                   "APAP-S_0.5h", "APAP-S_1h", "APAP-S_1.5h", "APAP-S_2h",
                   "APAP-S_4h", "APAP-S_6h", "APAP-S_8h", "APAP-S_12h")

rownames(main1)<-rownames(totl1)<-apap.mf.df.1.1[,1]
colnames(totl1)<-colnames(main1)


main2 <- as.data.frame(main1)
totl2 <- as.data.frame(totl1)

#
main4 <- as.data.frame(main1) %>%
  rownames_to_column('Var1') %>%
  gather(Var2, value, -Var1) %>%
  mutate(
    Var1 = factor(Var1, level=row.names(main1)),
    Var2 = factor(gsub("V", "", Var2), level=colnames(main1))
  )

inte1 <- totl1-main1
inte4 <- as.data.frame(inte1) %>%
  rownames_to_column('Var1') %>%
  gather(Var2, value, -Var1) %>%
  mutate(
    Var1 = factor(Var1, level=row.names(inte1)),
    Var2 = factor(gsub("V", "", Var2), level=colnames(inte1))
  )
totl4 <- as.data.frame(totl1) %>%
  rownames_to_column('Var1') %>%
  gather(Var2, value, -Var1) %>%
  mutate(
    Var1 = factor(Var1, level=row.names(totl1)),
    Var2 = factor(gsub("V", "", Var2), level=colnames(totl1))
  )

main4$order<-"Main"
totl4$order<-"Total"
inte4$order<-"Interaction"

Var3<-c(rep("APAP_0.5h", 58),
        rep("APAP_1h", 58),
        rep("APAP_1.5h", 58),
        rep("APAP_2h", 58),
        rep("APAP_4h", 58),
        rep("APAP_6h", 58),
        rep("APAP_8h", 58),
        rep("APAP_12h", 58),
        rep("APAP-G_0.5h", 58),
        rep("APAP-G_1h", 58),
        rep("APAP-G_1.5h", 58),
        rep("APAP-G_2h", 58),
        rep("APAP-G_4h", 58),
        rep("APAP-G_6h", 58),
        rep("APAP-G_8h", 58),
        rep("APAP-G_12h", 58),
        rep("APAP-S_0.5h", 58),
        rep("APAP-S_1h", 58),
        rep("APAP-S_1.5h", 58),
        rep("APAP-S_2h", 58),
        rep("APAP-S_4h", 58),
        rep("APAP-S_6h", 58),
        rep("APAP-S_8h", 58),
        rep("APAP-S_12h", 58))

Var4<-factor(Var3, level=c("APAP_0.5h","APAP_1h","APAP_1.5h","APAP_2h",
                           "APAP_4h","APAP_6h","APAP_8h","APAP_12h",
                           "APAP-G_0.5h","APAP-G_1h","APAP-G_1.5h","APAP-G_2h",
                           "APAP-G_4h","APAP-G_6h","APAP-G_8h","APAP-G_12h",
                           "APAP-S_0.5h","APAP-S_1h","APAP-S_1.5h","APAP-S_2h",
                           "APAP-S_4h","APAP-S_6h","APAP-S_8h","APAP-S_12h")) 
mt<-rbind(main4, inte4)
#mt<-rbind(main4, totl4)
mt1<-cbind(mt, Var4)

mt1$order <- factor(mt1$order, levels = c("Main","Interaction"))
mt1$Var1 <- with(mt1, factor(Var1, levels = rev(levels(Var1))))
#mt1$order <- factor(mt1$order, levels = c("Main","Total"))

mt1$value2 <- mt1$value
mt1$value2[mt1$value2 < 0.05] <- NA

colRows <-  c(rep("grey60", 37), rep("black", 21))
colCols <-  c(rep("brown1",8),rep("brown3",8),rep("brown4",8))

p11<-ggplot(mt1, aes(Var4, Var1)) +
  geom_tile(aes(fill = value)) + 
  facet_grid(~order) +
  geom_text(aes(label = round(value2, 2)), size=2.5) +
  scale_fill_gradient(low = "white", high = "red", limits = c(-0.05,1.00)) +
  labs(title="", x="Datasets", y="Parameters")+
  theme(axis.text.x = element_text(size=10, angle = 45, hjust = 1, color=colCols), 
        axis.text.y = element_text(size=10, color=colRows), legend.title=element_blank(),
        legend.position="top")

#pdf(file="figS3.pdf", width = 14, height = 10)
png(file="figS4.png",width=3200,height=3200,res=300)
p11
dev.off()

################### 
rm(list=ls())
load("jsnv2.rda")

main1<-do.call(cbind, list(apap.mj.df.1.1[,2], apap.mj.df.1.2[,2], apap.mj.df.1.3[,2], apap.mj.df.1.4[,2],
                           apap.mj.df.1.5[,2], apap.mj.df.1.6[,2], apap.mj.df.1.7[,2], apap.mj.df.1.8[,2],
                           apap.mj.df.2.1[,2], apap.mj.df.2.2[,2], apap.mj.df.2.3[,2], apap.mj.df.2.4[,2],
                           apap.mj.df.2.5[,2], apap.mj.df.2.6[,2], apap.mj.df.2.7[,2], apap.mj.df.2.8[,2],
                           apap.mj.df.3.1[,2], apap.mj.df.3.2[,2], apap.mj.df.3.3[,2], apap.mj.df.3.4[,2],
                           apap.mj.df.3.5[,2], apap.mj.df.3.6[,2], apap.mj.df.3.7[,2], apap.mj.df.3.8[,2]))

totl1<-do.call(cbind, list(apap.tj.df.1.1[,2], apap.tj.df.1.2[,2], apap.tj.df.1.3[,2], apap.tj.df.1.4[,2],
                           apap.tj.df.1.5[,2], apap.tj.df.1.6[,2], apap.tj.df.1.7[,2], apap.tj.df.1.8[,2],
                           apap.tj.df.2.1[,2], apap.tj.df.2.2[,2], apap.tj.df.2.3[,2], apap.tj.df.2.4[,2],
                           apap.tj.df.2.5[,2], apap.tj.df.2.6[,2], apap.tj.df.2.7[,2], apap.tj.df.2.8[,2],
                           apap.tj.df.3.1[,2], apap.tj.df.3.2[,2], apap.tj.df.3.3[,2], apap.tj.df.3.4[,2],
                           apap.tj.df.3.5[,2], apap.tj.df.3.6[,2], apap.tj.df.3.7[,2], apap.tj.df.3.8[,2]))

colnames(main1)<-c("APAP_0.5h", "APAP_1h", "APAP_1.5h", "APAP_2h",
                   "APAP_4h", "APAP_6h", "APAP_8h", "APAP_12h",
                   "APAP-G_0.5h", "APAP-G_1h", "APAP-G_1.5h", "APAP-G_2h",
                   "APAP-G_4h", "APAP-G_6h", "APAP-G_8h", "APAP-G_12h",
                   "APAP-S_0.5h", "APAP-S_1h", "APAP-S_1.5h", "APAP-S_2h",
                   "APAP-S_4h", "APAP-S_6h", "APAP-S_8h", "APAP-S_12h")

rownames(main1)<-rownames(totl1)<-apap.mj.df.1.1[,1]
colnames(totl1)<-colnames(main1)


main2 <- as.data.frame(main1)
totl2 <- as.data.frame(totl1)

#
main4 <- as.data.frame(main1) %>%
  rownames_to_column('Var1') %>%
  gather(Var2, value, -Var1) %>%
  mutate(
    Var1 = factor(Var1, level=row.names(main1)),
    Var2 = factor(gsub("V", "", Var2), level=colnames(main1))
  )

inte1 <- totl1-main1
inte4 <- as.data.frame(inte1) %>%
  rownames_to_column('Var1') %>%
  gather(Var2, value, -Var1) %>%
  mutate(
    Var1 = factor(Var1, level=row.names(inte1)),
    Var2 = factor(gsub("V", "", Var2), level=colnames(inte1))
  )
totl4 <- as.data.frame(totl1) %>%
  rownames_to_column('Var1') %>%
  gather(Var2, value, -Var1) %>%
  mutate(
    Var1 = factor(Var1, level=row.names(totl1)),
    Var2 = factor(gsub("V", "", Var2), level=colnames(totl1))
  )

main4$order<-"Main"
totl4$order<-"Total"
inte4$order<-"Interaction"

Var3<-c(rep("APAP_0.5h", 58),
        rep("APAP_1h", 58),
        rep("APAP_1.5h", 58),
        rep("APAP_2h", 58),
        rep("APAP_4h", 58),
        rep("APAP_6h", 58),
        rep("APAP_8h", 58),
        rep("APAP_12h", 58),
        rep("APAP-G_0.5h", 58),
        rep("APAP-G_1h", 58),
        rep("APAP-G_1.5h", 58),
        rep("APAP-G_2h", 58),
        rep("APAP-G_4h", 58),
        rep("APAP-G_6h", 58),
        rep("APAP-G_8h", 58),
        rep("APAP-G_12h", 58),
        rep("APAP-S_0.5h", 58),
        rep("APAP-S_1h", 58),
        rep("APAP-S_1.5h", 58),
        rep("APAP-S_2h", 58),
        rep("APAP-S_4h", 58),
        rep("APAP-S_6h", 58),
        rep("APAP-S_8h", 58),
        rep("APAP-S_12h", 58))

Var4<-factor(Var3, level=c("APAP_0.5h","APAP_1h","APAP_1.5h","APAP_2h",
                           "APAP_4h","APAP_6h","APAP_8h","APAP_12h",
                           "APAP-G_0.5h","APAP-G_1h","APAP-G_1.5h","APAP-G_2h",
                           "APAP-G_4h","APAP-G_6h","APAP-G_8h","APAP-G_12h",
                           "APAP-S_0.5h","APAP-S_1h","APAP-S_1.5h","APAP-S_2h",
                           "APAP-S_4h","APAP-S_6h","APAP-S_8h","APAP-S_12h")) 
mt<-rbind(main4, inte4)
#mt<-rbind(main4, totl4)
mt1<-cbind(mt, Var4)

mt1$order <- factor(mt1$order, levels = c("Main","Interaction"))
mt1$Var1 <- with(mt1, factor(Var1, levels = rev(levels(Var1))))
#mt1$order <- factor(mt1$order, levels = c("Main","Total"))

mt1$value2 <- mt1$value
mt1$value2[mt1$value2 < 0.05] <- NA

colRows <-  c(rep("grey60", 37), rep("black", 21))
colCols <-  c(rep("brown1",8),rep("brown3",8),rep("brown4",8))

p12<-ggplot(mt1, aes(Var4, Var1)) +
  geom_tile(aes(fill = value)) + 
  facet_grid(~order) +
  geom_text(aes(label = round(value2, 2)), size=2.5) +
  scale_fill_gradient(low = "white", high = "red", limits = c(-0.05,1.00)) +
  labs(title="", x="Datasets", y="Parameters")+
  theme(axis.text.x = element_text(size=10, angle = 45, hjust = 1, color=colCols), 
        axis.text.y = element_text(size=10, color=colRows), legend.title=element_blank(),
        legend.position="top")

png(file="figS5.png",width=3200,height=3200,res=300)
p12
dev.off()

################### 
rm(list=ls())
load("ownv2.rda")

main1<-do.call(cbind, list(apap.mo.df.1.1[,2], apap.mo.df.1.2[,2], apap.mo.df.1.3[,2], apap.mo.df.1.4[,2],
                           apap.mo.df.1.5[,2], apap.mo.df.1.6[,2], apap.mo.df.1.7[,2], apap.mo.df.1.8[,2],
                           apap.mo.df.2.1[,2], apap.mo.df.2.2[,2], apap.mo.df.2.3[,2], apap.mo.df.2.4[,2],
                           apap.mo.df.2.5[,2], apap.mo.df.2.6[,2], apap.mo.df.2.7[,2], apap.mo.df.2.8[,2],
                           apap.mo.df.3.1[,2], apap.mo.df.3.2[,2], apap.mo.df.3.3[,2], apap.mo.df.3.4[,2],
                           apap.mo.df.3.5[,2], apap.mo.df.3.6[,2], apap.mo.df.3.7[,2], apap.mo.df.3.8[,2]))

totl1<-do.call(cbind, list(apap.to.df.1.1[,2], apap.to.df.1.2[,2], apap.to.df.1.3[,2], apap.to.df.1.4[,2],
                           apap.to.df.1.5[,2], apap.to.df.1.6[,2], apap.to.df.1.7[,2], apap.to.df.1.8[,2],
                           apap.to.df.2.1[,2], apap.to.df.2.2[,2], apap.to.df.2.3[,2], apap.to.df.2.4[,2],
                           apap.to.df.2.5[,2], apap.to.df.2.6[,2], apap.to.df.2.7[,2], apap.to.df.2.8[,2],
                           apap.to.df.3.1[,2], apap.to.df.3.2[,2], apap.to.df.3.3[,2], apap.to.df.3.4[,2],
                           apap.to.df.3.5[,2], apap.to.df.3.6[,2], apap.to.df.3.7[,2], apap.to.df.3.8[,2]))

colnames(main1)<-c("APAP_0.5h", "APAP_1h", "APAP_1.5h", "APAP_2h",
                   "APAP_4h", "APAP_6h", "APAP_8h", "APAP_12h",
                   "APAP-G_0.5h", "APAP-G_1h", "APAP-G_1.5h", "APAP-G_2h",
                   "APAP-G_4h", "APAP-G_6h", "APAP-G_8h", "APAP-G_12h",
                   "APAP-S_0.5h", "APAP-S_1h", "APAP-S_1.5h", "APAP-S_2h",
                   "APAP-S_4h", "APAP-S_6h", "APAP-S_8h", "APAP-S_12h")

rownames(main1)<-rownames(totl1)<-apap.mo.df.1.1[,1]
colnames(totl1)<-colnames(main1)


main2 <- as.data.frame(main1)
totl2 <- as.data.frame(totl1)

#
main4 <- as.data.frame(main1) %>%
  rownames_to_column('Var1') %>%
  gather(Var2, value, -Var1) %>%
  mutate(
    Var1 = factor(Var1, level=row.names(main1)),
    Var2 = factor(gsub("V", "", Var2), level=colnames(main1))
  )

inte1 <- totl1-main1
inte4 <- as.data.frame(inte1) %>%
  rownames_to_column('Var1') %>%
  gather(Var2, value, -Var1) %>%
  mutate(
    Var1 = factor(Var1, level=row.names(inte1)),
    Var2 = factor(gsub("V", "", Var2), level=colnames(inte1))
  )
totl4 <- as.data.frame(totl1) %>%
  rownames_to_column('Var1') %>%
  gather(Var2, value, -Var1) %>%
  mutate(
    Var1 = factor(Var1, level=row.names(totl1)),
    Var2 = factor(gsub("V", "", Var2), level=colnames(totl1))
  )

main4$order<-"Main"
totl4$order<-"Total"
inte4$order<-"Interaction"

Var3<-c(rep("APAP_0.5h", 58),
        rep("APAP_1h", 58),
        rep("APAP_1.5h", 58),
        rep("APAP_2h", 58),
        rep("APAP_4h", 58),
        rep("APAP_6h", 58),
        rep("APAP_8h", 58),
        rep("APAP_12h", 58),
        rep("APAP-G_0.5h", 58),
        rep("APAP-G_1h", 58),
        rep("APAP-G_1.5h", 58),
        rep("APAP-G_2h", 58),
        rep("APAP-G_4h", 58),
        rep("APAP-G_6h", 58),
        rep("APAP-G_8h", 58),
        rep("APAP-G_12h", 58),
        rep("APAP-S_0.5h", 58),
        rep("APAP-S_1h", 58),
        rep("APAP-S_1.5h", 58),
        rep("APAP-S_2h", 58),
        rep("APAP-S_4h", 58),
        rep("APAP-S_6h", 58),
        rep("APAP-S_8h", 58),
        rep("APAP-S_12h", 58))

Var4<-factor(Var3, level=c("APAP_0.5h","APAP_1h","APAP_1.5h","APAP_2h",
                           "APAP_4h","APAP_6h","APAP_8h","APAP_12h",
                           "APAP-G_0.5h","APAP-G_1h","APAP-G_1.5h","APAP-G_2h",
                           "APAP-G_4h","APAP-G_6h","APAP-G_8h","APAP-G_12h",
                           "APAP-S_0.5h","APAP-S_1h","APAP-S_1.5h","APAP-S_2h",
                           "APAP-S_4h","APAP-S_6h","APAP-S_8h","APAP-S_12h")) 
mt<-rbind(main4, inte4)
#mt<-rbind(main4, totl4)
mt1<-cbind(mt, Var4)

mt1$order <- factor(mt1$order, levels = c("Main","Interaction"))
mt1$Var1 <- with(mt1, factor(Var1, levels = rev(levels(Var1))))
#mt1$order <- factor(mt1$order, levels = c("Main","Total"))

mt1$value2 <- mt1$value
mt1$value2[mt1$value2 < 0.05] <- NA

colRows <-  c(rep("grey60", 37), rep("black", 21))
colCols <-  c(rep("brown1",8),rep("brown3",8),rep("brown4",8))

p13<-ggplot(mt1, aes(Var4, Var1)) +
  geom_tile(aes(fill = value)) + 
  facet_grid(~order) +
  geom_text(aes(label = round(value2, 2)), size=2.5) +
  scale_fill_gradient(low = "white", high = "red", limits = c(-0.05,1.00)) +
  labs(title="", x="Datasets", y="Parameters")+
  theme(axis.text.x = element_text(size=10, angle = 45, hjust = 1, color=colCols), 
        axis.text.y = element_text(size=10, color=colRows), legend.title=element_blank(),
        legend.position="top")

png(file="figS6.png",width=3200,height=3200,res=300)
p13
dev.off()
