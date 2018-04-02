if(!require(tidyr)) {
  install.packages("tidyr"); require(tidyr)}
if(!require(dplyr)) {
  install.packages("dplyr"); require(dplyr)}
if(!require(tibble)) {
  install.packages("tibble"); require(tibble)}
if(!require(ggplot2)) {
  install.packages("ggplot2"); require(ggplot2)}

load("morv1.rda")

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

rownames(Mmu1)<-rownames(sig1)<-apap.Mmu.df.1.1[,1]
colnames(Mmu1)<-colnames(sig1)<-c("APAP_0.5h","APAP_1h","APAP_1.5h","APAP_2h",
                                  "APAP_4h","APAP_6h","APAP_8h","APAP_12h",
                                  "APAP-G_0.5h","APAP-G_1h", "APAP-G_1.5h","APAP-G_2h",
                                  "APAP-G_4h","APAP-G_6h", "APAP-G_8h","APAP-G_12h",
                                  "APAP-S_0.5h", "APAP-S_1h", "APAP-S_1.5h","APAP-S_2h",
                                  "APAP-S_4h", "APAP-S_6h", "APAP-S_8h","APAP-S_12h")
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
Mmu4$order<-"mu*"
sig4$order<-"sigma"
mor<-rbind(Mmu4, sig4)


mor$Var1 = with(mor, factor(Var1, levels = rev(levels(Var1)))) # revert order

mor$value2 <- mor$value
mor$value2[mor$value2 < max(mor$value)*0.05] <- NA

colCols <-  c(rep("cadetblue2",8),rep("cadetblue3",8),rep("cadetblue4",8))

p11<-ggplot(mor, aes(Var2, Var1)) +
  geom_tile(aes(fill = value)) + 
  facet_grid(.~order) +
  geom_text(aes(label = round(value2, 1)), size=2.5) +
  scale_fill_gradient(low = "white", high = "blue") +
  labs(title="", x="Datasets", y="Parameters")+
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size=10, color=colCols),
        legend.position = "right", legend.title=element_blank())


#jpeg(file="figS2.jpeg",width=3200,height=1600,res=250)
#pdf(file="fig2.pdf", width = 12, height = 6)
#p11
#dev.off()

# 0402
Mmu2<-do.call(cbind, list(apap.Mmu.df.1.1[,2]/max(apap.Mmu.df.1.1[,2]),
                          apap.Mmu.df.1.2[,2]/max(apap.Mmu.df.1.2[,2]),
                          apap.Mmu.df.1.3[,2]/max(apap.Mmu.df.1.3[,2]),
                          apap.Mmu.df.1.4[,2]/max(apap.Mmu.df.1.4[,2]),
                          apap.Mmu.df.1.5[,2]/max(apap.Mmu.df.1.5[,2]),
                          apap.Mmu.df.1.6[,2]/max(apap.Mmu.df.1.6[,2]), 
                          apap.Mmu.df.1.7[,2]/max(apap.Mmu.df.1.7[,2]), 
                          apap.Mmu.df.1.8[,2]/max(apap.Mmu.df.1.8[,2]),
                          apap.Mmu.df.2.1[,2]/max(apap.Mmu.df.2.1[,2]), 
                          apap.Mmu.df.2.2[,2]/max(apap.Mmu.df.2.2[,2]), 
                          apap.Mmu.df.2.3[,2]/max(apap.Mmu.df.2.3[,2]), 
                          apap.Mmu.df.2.4[,2]/max(apap.Mmu.df.2.4[,2]),
                          apap.Mmu.df.2.5[,2]/max(apap.Mmu.df.2.5[,2]), 
                          apap.Mmu.df.2.6[,2]/max(apap.Mmu.df.2.6[,2]), 
                          apap.Mmu.df.2.7[,2]/max(apap.Mmu.df.2.7[,2]),
                          apap.Mmu.df.2.8[,2]/max(apap.Mmu.df.2.8[,2]),
                          apap.Mmu.df.3.1[,2]/max(apap.Mmu.df.3.1[,2]), 
                          apap.Mmu.df.3.2[,2]/max(apap.Mmu.df.3.2[,2]), 
                          apap.Mmu.df.3.3[,2]/max(apap.Mmu.df.3.3[,2]),
                          apap.Mmu.df.3.4[,2]/max(apap.Mmu.df.3.4[,2]),
                          apap.Mmu.df.3.5[,2]/max(apap.Mmu.df.3.5[,2]),
                          apap.Mmu.df.3.6[,2]/max(apap.Mmu.df.3.6[,2]),
                          apap.Mmu.df.3.7[,2]/max(apap.Mmu.df.3.7[,2]),
                          apap.Mmu.df.3.8[,2]/max(apap.Mmu.df.3.8[,2])))
sig2<-do.call(cbind, list(apap.sig.df.1.1[,2]/max(apap.sig.df.1.1[,2]), 
                          apap.sig.df.1.2[,2]/max(apap.sig.df.1.2[,2]), 
                          apap.sig.df.1.3[,2]/max(apap.sig.df.1.3[,2]), 
                          apap.sig.df.1.4[,2]/max(apap.sig.df.1.4[,2]),
                          apap.sig.df.1.5[,2]/max(apap.sig.df.1.5[,2]), 
                          apap.sig.df.1.6[,2]/max(apap.sig.df.1.6[,2]), 
                          apap.sig.df.1.7[,2]/max(apap.sig.df.1.7[,2]), 
                          apap.sig.df.1.8[,2]/max(apap.sig.df.1.8[,2]),
                          apap.sig.df.2.1[,2]/max(apap.sig.df.2.1[,2]), 
                          apap.sig.df.2.2[,2]/max(apap.sig.df.2.2[,2]), 
                          apap.sig.df.2.3[,2]/max(apap.sig.df.2.3[,2]), 
                          apap.sig.df.2.4[,2]/max(apap.sig.df.2.4[,2]),
                          apap.sig.df.2.5[,2]/max(apap.sig.df.2.5[,2]), 
                          apap.sig.df.2.6[,2]/max(apap.sig.df.2.6[,2]), 
                          apap.sig.df.2.7[,2]/max(apap.sig.df.2.7[,2]), 
                          apap.sig.df.2.8[,2]/max(apap.sig.df.2.8[,2]),
                          apap.sig.df.3.1[,2]/max(apap.sig.df.3.1[,2]), 
                          apap.sig.df.3.2[,2]/max(apap.sig.df.3.2[,2]), 
                          apap.sig.df.3.3[,2]/max(apap.sig.df.3.3[,2]), 
                          apap.sig.df.3.4[,2]/max(apap.sig.df.3.4[,2]),
                          apap.sig.df.3.5[,2]/max(apap.sig.df.3.5[,2]), 
                          apap.sig.df.3.6[,2]/max(apap.sig.df.3.6[,2]), 
                          apap.sig.df.3.7[,2]/max(apap.sig.df.3.7[,2]), 
                          apap.sig.df.3.8[,2]/max(apap.sig.df.3.8[,2])))

rownames(Mmu2)<-rownames(sig2)<-apap.Mmu.df.1.1[,1]
colnames(Mmu2)<-colnames(sig2)<-c("APAP_0.5h","APAP_1h","APAP_1.5h","APAP_2h",
                                  "APAP_4h","APAP_6h","APAP_8h","APAP_12h",
                                  "APAP-G_0.5h","APAP-G_1h", "APAP-G_1.5h","APAP-G_2h",
                                  "APAP-G_4h","APAP-G_6h", "APAP-G_8h","APAP-G_12h",
                                  "APAP-S_0.5h", "APAP-S_1h", "APAP-S_1.5h","APAP-S_2h",
                                  "APAP-S_4h", "APAP-S_6h", "APAP-S_8h","APAP-S_12h")
Mmu3 <- as.data.frame(Mmu2) %>%
  rownames_to_column('Var1') %>%
  gather(Var2, value, -Var1) %>%
  mutate(
    Var1 = factor(Var1, level=row.names(Mmu2)),
    Var2 = factor(gsub("V", "", Var2), level=colnames(Mmu2))
  )

sig3 <- as.data.frame(sig2) %>%
  rownames_to_column('Var1') %>%
  gather(Var2, value, -Var1) %>%
  mutate(
    Var1 = factor(Var1, level=row.names(sig2)),
    Var2 = factor(gsub("V", "", Var2), level=colnames(sig2))
  )

Mmu3$est<-"Morris"
sig3$est<-"Morris"
Mmu3$order<-"mu*"
sig3$order<-"sigma"
mor<-rbind(Mmu3, sig3)

mor$Var1 = with(mor, factor(Var1, levels = rev(levels(Var1)))) # revert order

mor$value2 <- mor$value
mor$value2[mor$value2 < max(mor$value)*0.05] <- NA

colCols <-  c(rep("cadetblue2",8),rep("cadetblue3",8),rep("cadetblue4",8))

p11<-ggplot(mor, aes(Var2, Var1)) +
  geom_tile(aes(fill = value)) + 
  facet_grid(.~order) +
  geom_text(aes(label = round(value2, 1)), size=2.5) +
  scale_fill_gradient(low = "white", high = "blue") +
  labs(title="", x="Datasets", y="Parameters")+
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size=10, color=colCols),
        legend.position = "right", legend.title=element_blank())



################
rm(list=ls())
load("morv2.rda")

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

rownames(Mmu1)<-rownames(sig1)<-apap.Mmu.df.1.1[,1]
colnames(Mmu1)<-colnames(sig1)<-c("APAP_0.5h","APAP_1h","APAP_1.5h","APAP_2h",
                                  "APAP_4h","APAP_6h","APAP_8h","APAP_12h",
                                  "APAP-G_0.5h","APAP-G_1h", "APAP-G_1.5h","APAP-G_2h",
                                  "APAP-G_4h","APAP-G_6h", "APAP-G_8h","APAP-G_12h",
                                  "APAP-S_0.5h", "APAP-S_1h", "APAP-S_1.5h","APAP-S_2h",
                                  "APAP-S_4h", "APAP-S_6h", "APAP-S_8h","APAP-S_12h")
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
Mmu4$order<-"mu*"
sig4$order<-"sigma"
mor<-rbind(Mmu4, sig4)


mor$Var1 = with(mor, factor(Var1, levels = rev(levels(Var1)))) # revert order

mor$value2 <- mor$value
mor$value2[mor$value2 < max(mor$value)*0.05] <- NA

colRows <-  c(rep("grey60", 37), rep("black", 21))
colCols <-  c(rep("cadetblue2",8),rep("cadetblue3",8),rep("cadetblue4",8))

p12<-ggplot(mor, aes(Var2, Var1)) +
  geom_tile(aes(fill = value)) + 
  facet_grid(.~order) +
  geom_text(aes(label = round(value2, 1)), size=2.5) +
  scale_fill_gradient(low = "white", high = "blue") +
  labs(title="", x="Datasets", y="Parameters")+
  theme(axis.text.x = element_text(size=10, angle = 45, hjust = 1, color=colCols), 
        axis.text.y = element_text(size=10, color=colRows), legend.title=element_blank(),
        legend.position="top")

jpeg(file="figS5.jpg",width=4000,height=3200,res=300)
#pdf(file="fig2.pdf", width = 12, height = 6)
p12
dev.off()
