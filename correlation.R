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
#font_install("fontcm")

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

df3<-data.frame(apply(Mmu1, 1, max), apply(main1, 1, max), apply(main2, 1, max), apply(main3, 1, max))
colnames(df)<-c("Morris","eFAST","Jansen","Owen")
df4<-data.frame(apply(sig1, 1, max), apply(inte1, 1, max), apply(inte2, 1, max), apply(inte3, 1, max))
colnames(df2)<-c("Morris","eFAST","Jansen","Owen")

#g3<-ggpairs(df3, title = "Main, all 58 parameters")
#g4<-ggpairs(df4, title = "Interaction, all 58 parameters")

#
#png(file="fig2.png",width=3000,height=3000,res=300)
#plot_grid(
#  ggmatrix_gtable(g1),
#  ggmatrix_gtable(g2),
#  ggmatrix_gtable(g3),
#  ggmatrix_gtable(g4),
#  ncol = 2
#)
#dev.off()



##### SUPPLEMENT------------

##########
corplt<-function(df, v1, v2, col){
  plot(df[,v1], df[,v2], col = "white", xlab = names(df[v1]), ylab = names(df[v2]),
       xlim=range(df[,v1]), ylim=range(df[,v2]))
  text(df[,v1], df[,v2], labels= row.names(df))
  polygon(x = c(min(df[,v1]), min(df[,v1]), max(df[,v1]), max(df[,v1])), 
          y = c(min(df[,v2]), max(df[,v2]), max(df[,v2]), min(df[,v2])), 
          col = col, border = NA)
  text(3/5*max(df[,v1]), min(df[,v2]), font=3,
       paste("r = ", format(cor(df[,v1],df[,v2]), digits=3) ,sep=""), pos = 4, cex=1.5)
}


#####
textplt<-function(mtext){
  x = 0:10;  
  y = 0:10;
  plot(x, y, type="n", xaxt='n', yaxt='n')
  text(5,5, mtext, col=1, cex=5)  
}


##
png(file="corplt21.png", width=3000,height=3000,res=300)
par(mfrow=c(4,4), mar=c(2,2,2,1), oma=c(0,0,2,0))
corplt(df, 1, 4, rgb(0,0,0, alpha=0.1))
mtext("21 original parameters", NORTH<-3, line=0.2, adj=0.5, cex=1.5, outer=TRUE)
corplt(df, 2, 4, rgb(0,0,0, alpha=0.1))
corplt(df, 3, 4, rgb(0,0,0, alpha=0.1))
textplt("Morris")
corplt(df, 1, 3, rgb(0,0,0, alpha=0.1))
corplt(df, 2, 3, rgb(0,0,0, alpha=0.1))
textplt("eFAST")
corplt(df2, 4, 3, rgb(1,0,0, alpha=0.1))
corplt(df, 1, 2, rgb(0,0,0, alpha=0.1))
textplt("Jansen")
corplt(df2, 3, 2, rgb(1,0,0, alpha=0.1))
corplt(df2, 4, 2, rgb(1,0,0, alpha=0.1))
textplt("Owen")
corplt(df2, 2, 1, rgb(1,0,0, alpha=0.1))
corplt(df2, 3, 1, rgb(1,0,0, alpha=0.1))
corplt(df2, 4, 1, rgb(1,0,0, alpha=0.1))
dev.off()


png(file="corplt58.png",width=3000,height=3000,res=300)
par(mfrow=c(4,4), mar=c(2,2,2,1), oma=c(0,0,2,0))
corplt(df3, 1, 4, rgb(0,0,0, alpha=0.1))
mtext("58 original parameters", NORTH<-3, line=0.2, adj=0.5, cex=1.5, outer=TRUE)
corplt(df3, 2, 4, rgb(0,0,0, alpha=0.1))
corplt(df3, 3, 4, rgb(0,0,0, alpha=0.1))
textplt("Morris")
corplt(df3, 1, 3, rgb(0,0,0, alpha=0.1))
corplt(df3, 2, 3, rgb(0,0,0, alpha=0.1))
textplt("eFAST")
corplt(df4, 4, 3, rgb(1,0,0, alpha=0.1))
corplt(df3, 1, 2, rgb(0,0,0, alpha=0.1))
textplt("Jansen")
corplt(df4, 3, 2, rgb(1,0,0, alpha=0.1))
corplt(df4, 4, 2, rgb(1,0,0, alpha=0.1))
textplt("Owen")
corplt(df4, 2, 1, rgb(1,0,0, alpha=0.1))
corplt(df4, 3, 1, rgb(1,0,0, alpha=0.1))
corplt(df4, 4, 1, rgb(1,0,0, alpha=0.1))
dev.off()

##
jpeg(file="fig2.jpg",width=2800,height=5200,res=300)
par(mar=c(2,2,2,1), oma=c(4,4,0,0))
layout(matrix(c(1,1,1,1,
                2,3,4,5,
                6,7,8,9,
                10,11,12,13,
                14,15,16,17,
                18,18,18,18,
                19,20,21,22,
                23,24,25,26,
                27,28,29,30,
                31,32,33,34), nrow = 10, ncol = 4, byrow = TRUE), 
       heights=c(1,3,3,3,3,1,3,3,3,3))
plot.new()
mtext(text="A   21 original parameters", line = -3, adj=0, cex=1.5)
corplt(df, 4, 1, rgb(0,0,0, alpha=0.1))
corplt(df, 3, 1, rgb(0,0,0, alpha=0.1))
corplt(df, 2, 1, rgb(0,0,0, alpha=0.1))
textplt("Morris")
corplt(df, 4, 2, rgb(0,0,0, alpha=0.1))
corplt(df, 3, 2, rgb(0,0,0, alpha=0.1))
textplt("eFAST")
corplt(df2, 1, 2, rgb(1,0,0, alpha=0.1))
corplt(df, 4, 3, rgb(0,0,0, alpha=0.1))
textplt("Jansen")
corplt(df2, 2, 3, rgb(1,0,0, alpha=0.1))
corplt(df2, 1, 3, rgb(1,0,0, alpha=0.1))
textplt("Owen")
corplt(df2, 3, 4, rgb(1,0,0, alpha=0.1))
corplt(df2, 2, 4, rgb(1,0,0, alpha=0.1))
corplt(df2, 1, 4, rgb(1,0,0, alpha=0.1))
plot.new()
mtext(text="B   58 original parameters", line = -3, adj=0, cex=1.5)
corplt(df3, 4, 1, rgb(0,0,0, alpha=0.1))
corplt(df3, 3, 1, rgb(0,0,0, alpha=0.1))
corplt(df3, 2, 1, rgb(0,0,0, alpha=0.1))
textplt("Morris")
corplt(df3, 4, 2, rgb(0,0,0, alpha=0.1))
corplt(df3, 3, 2, rgb(0,0,0, alpha=0.1))
textplt("eFAST")
corplt(df4, 1, 2, rgb(1,0,0, alpha=0.1))
corplt(df3, 4, 3, rgb(0,0,0, alpha=0.1))
textplt("Jansen")
corplt(df4, 2, 3, rgb(1,0,0, alpha=0.1))
corplt(df4, 1, 3, rgb(1,0,0, alpha=0.1))
textplt("Owen")
corplt(df4, 3, 4, rgb(1,0,0, alpha=0.1))
corplt(df4, 2, 4, rgb(1,0,0, alpha=0.1))
corplt(df4, 1, 4, rgb(1,0,0, alpha=0.1))
mtext("Sensitivity index", SOUTH<-1, line=2, adj=0.5, cex=1.5, outer=TRUE)
mtext("Sensitivity index", WEST<-2, line=2, adj=0.2, cex=1.5, outer=TRUE) 
mtext("Sensitivity index", WEST<-2, line=2, adj=0.75, cex=1.5, outer=TRUE) 
dev.off()
