rm(list = ls())
load("morv1.rda")
load("fstv1.rda")
load("jsnv1.rda")
load("ownv1.rda")

if(!require(gridExtra)) {
  install.packages("gridExtra"); require(gridExtra)}
if(!require(ggplot2)) {
  install.packages("ggplot2"); require(ggplot2)}
if(!require(GGally)) {
  install.packages("GGally"); require(GGally)} # To use ggpairs
if(!require(cowplot)) { 
  install.packages("cowplot"); require(cowplot)} # To use plot_grid

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
                           apap.mf.df.3.5[,2], apap.mf.df.3.6[,2], apap.mf.df.3.7[,2], apap.mf.df.3.8[,2]))
                           
main2<-do.call(cbind, list(apap.mj.df.1.1[,2], apap.mj.df.1.2[,2], apap.mj.df.1.3[,2], apap.mj.df.1.4[,2],
                           apap.mj.df.1.5[,2], apap.mj.df.1.6[,2], apap.mj.df.1.7[,2], apap.mj.df.1.8[,2],
                           apap.mj.df.2.1[,2], apap.mj.df.2.2[,2], apap.mj.df.2.3[,2], apap.mj.df.2.4[,2],
                           apap.mj.df.2.5[,2], apap.mj.df.2.6[,2], apap.mj.df.2.7[,2], apap.mj.df.2.8[,2],
                           apap.mj.df.3.1[,2], apap.mj.df.3.2[,2], apap.mj.df.3.3[,2], apap.mj.df.3.4[,2],
                           apap.mj.df.3.5[,2], apap.mj.df.3.6[,2], apap.mj.df.3.7[,2], apap.mj.df.3.8[,2]))
                           
main3<-do.call(cbind, list(apap.mo.df.1.1[,2], apap.mo.df.1.2[,2], apap.mo.df.1.3[,2], apap.mo.df.1.4[,2],
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
                           apap.tf.df.3.5[,2], apap.tf.df.3.6[,2], apap.tf.df.3.7[,2], apap.tf.df.3.8[,2]))
                           
totl2<-do.call(cbind, list(apap.tj.df.1.1[,2], apap.tj.df.1.2[,2], apap.tj.df.1.3[,2], apap.tj.df.1.4[,2],
                           apap.tj.df.1.5[,2], apap.tj.df.1.6[,2], apap.tj.df.1.7[,2], apap.tj.df.1.8[,2],
                           apap.tj.df.2.1[,2], apap.tj.df.2.2[,2], apap.tj.df.2.3[,2], apap.tj.df.2.4[,2],
                           apap.tj.df.2.5[,2], apap.tj.df.2.6[,2], apap.tj.df.2.7[,2], apap.tj.df.2.8[,2],
                           apap.tj.df.3.1[,2], apap.tj.df.3.2[,2], apap.tj.df.3.3[,2], apap.tj.df.3.4[,2],
                           apap.tj.df.3.5[,2], apap.tj.df.3.6[,2], apap.tj.df.3.7[,2], apap.tj.df.3.8[,2]))
                           
totl3<-do.call(cbind, list(apap.to.df.1.1[,2], apap.to.df.1.2[,2], apap.to.df.1.3[,2], apap.to.df.1.4[,2],
                           apap.to.df.1.5[,2], apap.to.df.1.6[,2], apap.to.df.1.7[,2], apap.to.df.1.8[,2],
                           apap.to.df.2.1[,2], apap.to.df.2.2[,2], apap.to.df.2.3[,2], apap.to.df.2.4[,2],
                           apap.to.df.2.5[,2], apap.to.df.2.6[,2], apap.to.df.2.7[,2], apap.to.df.2.8[,2],
                           apap.to.df.3.1[,2], apap.to.df.3.2[,2], apap.to.df.3.3[,2], apap.to.df.3.4[,2],     
                           apap.to.df.3.5[,2], apap.to.df.3.6[,2], apap.to.df.3.7[,2], apap.to.df.3.8[,2]))
inte1<-totl1-main1
inte2<-totl2-main2
inte3<-totl3-main3

rownames(main1)<-rownames(main2)<-rownames(main3)<-rownames(Mmu1)<-apap.mj.df.1.1[,1]
rownames(inte1)<-rownames(inte2)<-rownames(inte3)<-rownames(sig1)<-apap.mj.df.1.1[,1]

df<-data.frame(apply(Mmu1, 1, max), apply(main1, 1, max), apply(main2, 1, max), apply(main3, 1, max))
colnames(df)<-c("Morris","eFAST","Jansen","Owen")
df2<-data.frame(apply(sig1, 1, max), apply(inte1, 1, max), apply(inte2, 1, max), apply(inte3, 1, max))
colnames(df2)<-c("Morris","eFAST","Jansen","Owen")

g1<-ggpairs(df, title = "Main, 21  parameters")
g2<-ggpairs(df2, title = "Interaction, 21 parameters")

#
load("morv2.rda")
load("fstv2.rda")
load("jsnv2.rda")
load("ownv2.rda")

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
                           apap.mf.df.3.5[,2], apap.mf.df.3.6[,2], apap.mf.df.3.7[,2], apap.mf.df.3.8[,2]))

main2<-do.call(cbind, list(apap.mj.df.1.1[,2], apap.mj.df.1.2[,2], apap.mj.df.1.3[,2], apap.mj.df.1.4[,2],
                           apap.mj.df.1.5[,2], apap.mj.df.1.6[,2], apap.mj.df.1.7[,2], apap.mj.df.1.8[,2],
                           apap.mj.df.2.1[,2], apap.mj.df.2.2[,2], apap.mj.df.2.3[,2], apap.mj.df.2.4[,2],
                           apap.mj.df.2.5[,2], apap.mj.df.2.6[,2], apap.mj.df.2.7[,2], apap.mj.df.2.8[,2],
                           apap.mj.df.3.1[,2], apap.mj.df.3.2[,2], apap.mj.df.3.3[,2], apap.mj.df.3.4[,2],
                           apap.mj.df.3.5[,2], apap.mj.df.3.6[,2], apap.mj.df.3.7[,2], apap.mj.df.3.8[,2]))

main3<-do.call(cbind, list(apap.mo.df.1.1[,2], apap.mo.df.1.2[,2], apap.mo.df.1.3[,2], apap.mo.df.1.4[,2],
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
                           apap.tf.df.3.5[,2], apap.tf.df.3.6[,2], apap.tf.df.3.7[,2], apap.tf.df.3.8[,2]))

totl2<-do.call(cbind, list(apap.tj.df.1.1[,2], apap.tj.df.1.2[,2], apap.tj.df.1.3[,2], apap.tj.df.1.4[,2],
                           apap.tj.df.1.5[,2], apap.tj.df.1.6[,2], apap.tj.df.1.7[,2], apap.tj.df.1.8[,2],
                           apap.tj.df.2.1[,2], apap.tj.df.2.2[,2], apap.tj.df.2.3[,2], apap.tj.df.2.4[,2],
                           apap.tj.df.2.5[,2], apap.tj.df.2.6[,2], apap.tj.df.2.7[,2], apap.tj.df.2.8[,2],
                           apap.tj.df.3.1[,2], apap.tj.df.3.2[,2], apap.tj.df.3.3[,2], apap.tj.df.3.4[,2],
                           apap.tj.df.3.5[,2], apap.tj.df.3.6[,2], apap.tj.df.3.7[,2], apap.tj.df.3.8[,2]))

totl3<-do.call(cbind, list(apap.to.df.1.1[,2], apap.to.df.1.2[,2], apap.to.df.1.3[,2], apap.to.df.1.4[,2],
                           apap.to.df.1.5[,2], apap.to.df.1.6[,2], apap.to.df.1.7[,2], apap.to.df.1.8[,2],
                           apap.to.df.2.1[,2], apap.to.df.2.2[,2], apap.to.df.2.3[,2], apap.to.df.2.4[,2],
                           apap.to.df.2.5[,2], apap.to.df.2.6[,2], apap.to.df.2.7[,2], apap.to.df.2.8[,2],
                           apap.to.df.3.1[,2], apap.to.df.3.2[,2], apap.to.df.3.3[,2], apap.to.df.3.4[,2],     
                           apap.to.df.3.5[,2], apap.to.df.3.6[,2], apap.to.df.3.7[,2], apap.to.df.3.8[,2]))
inte1<-totl1-main1
inte2<-totl2-main2
inte3<-totl3-main3

rownames(main1)<-rownames(main2)<-rownames(main3)<-rownames(Mmu1)<-apap.mj.df.1.1[,1]
rownames(inte1)<-rownames(inte2)<-rownames(inte3)<-rownames(sig1)<-apap.mj.df.1.1[,1]

df<-data.frame(apply(Mmu1, 1, max), apply(main1, 1, max), apply(main2, 1, max), apply(main3, 1, max))
colnames(df)<-c("Morris","eFAST","Jansen","Owen")
df2<-data.frame(apply(sig1, 1, max), apply(inte1, 1, max), apply(inte2, 1, max), apply(inte3, 1, max))
colnames(df2)<-c("Morris","eFAST","Jansen","Owen")

g3<-ggpairs(df, title = "Main, all 58 parameters")
g4<-ggpairs(df2, title = "Interaction, all 58 parameters")

#
png(file="fig2.png",width=4000,height=4000,res=250)
plot_grid(
  ggmatrix_gtable(g1),
  ggmatrix_gtable(g2),
  ggmatrix_gtable(g3),
  ggmatrix_gtable(g4),
  ncol = 2
)
dev.off()

