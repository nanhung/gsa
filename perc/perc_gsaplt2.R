if(!require(Hmisc)) {
  install.packages("Hmisc"); require(Hmisc)} # plot CDF

setpt1.df <- cbind(1, log(df.sen.g1))
write.table(setpt1.df, file="perc.setpoint.dat", row.names=FALSE, sep="\t")
system("./mcsim.perc perc.setpt2.in")
sim1 <- as.data.frame(fread("perc.setpoint.out", head = T))

setpt2.df <- cbind(1, log(df.ins.g1))
write.table(setpt2.df, file="perc.setpoint.dat", row.names=FALSE, sep="\t")
system("./mcsim.perc perc.setpt2.in")
sim2 <- as.data.frame(fread("perc.setpoint.out", head = T))

setpt3.df <- cbind(1, log(df.sen.g3))
write.table(setpt3.df, file="perc.setpoint.dat", row.names=FALSE, sep="\t")
system("./mcsim.perc perc.setpt2.in")
sim3 <- as.data.frame(fread("perc.setpoint.out", head = T))
setpt4.df <- cbind(1, log(df.ins.g3))
write.table(setpt4.df, file="perc.setpoint.dat", row.names=FALSE, sep="\t")
system("./mcsim.perc perc.setpt2.in")
sim4 <- as.data.frame(fread("perc.setpoint.out", head = T))



EP.plt<-function(X1, X2, colval, main){
  sen<-log(X1[,ncol(setpt1.df)+colval], 10)
  ins<-log(X2[,ncol(setpt1.df)+colval], 10)
  sen.ecdf <- ecdf(sen)
  ins.ecdf <- ecdf(ins)
  r<-range(c(sen,ins))
  plot(sen, 1-sen.ecdf(sen), col="red", xlab="", ylab="", main=main,
       xlim=r, ylim=c(0,1)) 

  par(new=TRUE)
  plot(ins, 1-ins.ecdf(ins), col="blue",
       axes=FALSE, ann=FALSE,
       xlim=r, ylim=c(0,1))
}


pdf(file="fig5.pdf", width = 8, height = 8)
par(mfrow=c(3,3), mar = c(4, 2, 3, 1), oma = c(3,3,2,0))
EP.plt(sim1,sim2,1, "Exhaled air, AUC")
legend("bottomleft", c("High sensity parameter","Low sensity parameter"), cex=1, 
       col=c("red","blue"), pch=21,  bty="n");
EP.plt(sim1,sim2,4, "Exhaled air, C")
EP.plt(sim3,sim4,7, "Exhaled air, AUC")
EP.plt(sim1,sim2,2, "Blood, AUC")
EP.plt(sim1,sim2,5, "Blood, C")
EP.plt(sim3,sim4,8, "Blood, AUC")
EP.plt(sim1,sim2,3, "Metabolized, C")
EP.plt(sim1,sim2,6, "Metabolized, C")
EP.plt(sim3,sim4,9, "Metabolized, C")
mtext("Inhalation", NORTH<-3, line=0, adj=0.32, cex=1.2, outer=TRUE, col="grey20")
mtext("Ingestion", NORTH<-3, line=0, adj=0.88, cex=1.2, outer=TRUE, col="grey20")
mtext("Estimated  logarithm concentration at 48-hr or AUC during the period", South<-1, line=0, cex=1.0, outer=TRUE) 
mtext("Exceedance probability", WEST<-2, line=1.5, cex=1.0, outer=TRUE) 
dev.off()



