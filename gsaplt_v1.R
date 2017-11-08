if(!require(ggplot2)) {
  install.packages("ggplot2"); require(ggplot2)}

#load("morv1.rda") ----

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

Mu2<-as.matrix(Mmu1)
Mu3<-(Mmu1 - mean(Mmu1)) / sd(Mmu1)

# load("fstv1.rda") ----
if(!require(gplots)) {
  install.packages("gplots"); require(gplots)} #heatmap.2

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

#https://stackoverflow.com/questions/32573733/how-to-color-a-group-of-labels-or-branches-in-heatmap-2-in-r
colRows <-  c("grey60","grey60","grey60","black",
              "grey60","grey60","grey60","black",
              "grey60","grey60","grey60","black",
              "grey60","black","grey60","black",
              "black","black","black","black","black")
colCols <-  c(rep("grey60",8),rep("red",8),rep("maroon",8))

rownames(main1)<-rownames(totl1)<-apap.mf.df.1.1[,1]
colnames(totl1)<-colnames(main1)


main2 <- as.data.frame(main1)
totl2 <- as.data.frame(totl1)

M0<-main2[,1:24]
T0<-totl2[,1:24]

#M1<-as.matrix(scale(M0, center = F, scale =F))
#T1<-as.matrix(scale(T0, center = F, scale =F))

M1<-as.matrix(M0)
T1<-as.matrix(T0)
              
#M0<-as.matrix(M0)
#M1<-scale(M0, center = rep(mean(M0), 24), scale = rep(sd(M0), 24))
#T0<-as.matrix(T0)
#T1<-scale(M0, center = rep(mean(T0), 24), scale = rep(sd(T0), 24))

#M0<-as.matrix(M0)
#M1<-(M0 - mean(M0)) / sd(M0)
#T0<-as.matrix(T0)
#T1<-(T0 - mean(T0)) / sd(T0)

M1<-M1[ order(apply(M1, 1, max), decreasing = T), ]
T1<-T1[ order(apply(T1, 1, max), decreasing = T), ]


for(i in 1:24){
  print(sum(M1[1:10,i])/sum(M1[,i])) 
}

for(i in 1:24){
  print(sum(T1[1:18,i])/sum(T1[,i])) 
}


lmat = rbind(c(2,3),c(4,1))
lwid = c(1.5,3.5)
lhei = c(1,5)



#pdf(file="fstv1M.pdf", width = 14, height = 8)
png(file="fstv1M.png",width=4000,height=2800,res=250)
heatmap.2(M1, cexRow=1.2, cexCol=1.2, col = colorpanel(100, "white", "red"), margins=c(6,9),trace="none",srtCol=35,
          density.info = 'histogram', scale = "none", keysize = 1.5, 
          #colRow = colRows, 
          colCol =  colCols,
          dendrogram="none", # remove column cluster
          Colv=FALSE, Rowv=FALSE, key.xlab = "Sobol indices (Main)", key.ylab = "",
          lmat=lmat, lwid = lwid, lhei = lhei,
          key.par=list(mar=c(8,4,4,4)),
          cellnote=round(M1, digits = 2),
          notecol="black")
dev.off()

#pdf(file="fstv1T.pdf", width = 14, height = 8)
png(file="fstv1T.png",width=4000,height=2800,res=250)
heatmap.2(T1, cexRow=1.2, cexCol=1.2, col = colorpanel(100, "white", "red"), margins=c(6,9),trace="none",srtCol=35,
          density.info = 'histogram', scale = "none", keysize = 1.2, 
          #colRow = colRows, 
          colCol =  colCols,
          dendrogram="none", # remove column cluster
          Colv=FALSE, Rowv=FALSE, key.xlab = "Sobol indices (Total)", key.ylab = "",
          lmat=lmat, lwid = lwid, lhei = lhei,
          cellnote=round(T1, digits = 2),
          key.par=list(mar=c(8,4,4,4)),
          notecol="black")
dev.off()


#load("jsnv1.rda") ----
if(!require(gplots)) {
  install.packages("gplots"); require(gplots)} #heatmap.2

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

rownames(main1)<-rownames(totl1)<-Parameter
colnames(totl1)<-colnames(main1)


main2 <- as.data.frame(main1)
totl2 <- as.data.frame(totl1)

M0<-main2[,1:24]
T0<-totl2[,1:24]

M1<-as.matrix(scale(M0))
T1<-as.matrix(scale(T0))

#heatmap.2(M1, cexRow=1.2, cexCol=1.2, col = bluered(100), margins=c(6,9),trace="none",srtCol=35,
#          density.info = 'histogram', scale = "none", keysize = 1.2, 
#          cellnote=round(M1, digits = 1),
#          notecol="black")

pdf(file="jsnv1.pdf", width = 12, height = 8)
heatmap.2(T1, cexRow=1.2, cexCol=1.2, col = bluered(100), margins=c(6,9),trace="none",srtCol=35,
          density.info = 'histogram', scale = "none", keysize = 1.2, 
          cellnote=round(T1, digits = 1),
          notecol="black")
dev.off()


