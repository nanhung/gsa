if(!require(Hmisc)) {
  install.packages("Hmisc"); require(Hmisc)} # plot CDF

# Inh
setpt1.df <- cbind(1, log(df.sen.g1))
write.table(setpt1.df, file="perc.setpoint.dat", row.names=FALSE, sep="\t")
system("./mcsim.perc perc.setpt3.in")
sim1 <- as.data.frame(fread("perc.setpoint.out", head = T))
setpt2.df <- cbind(1, log(df.ins.g1))
write.table(setpt2.df, file="perc.setpoint.dat", row.names=FALSE, sep="\t")
system("./mcsim.perc perc.setpt3.in")
sim2 <- as.data.frame(fread("perc.setpoint.out", head = T))

# Oral
setpt3.df <- cbind(1, log(df.sen.g3))
write.table(setpt3.df, file="perc.setpoint.dat", row.names=FALSE, sep="\t")
system("./mcsim.perc perc.setpt3.in")
sim3 <- as.data.frame(fread("perc.setpoint.out", head = T))
setpt4.df <- cbind(1, log(df.ins.g3))
write.table(setpt4.df, file="perc.setpoint.dat", row.names=FALSE, sep="\t")
system("./mcsim.perc perc.setpt3.in")
sim4 <- as.data.frame(fread("perc.setpoint.out", head = T))

# Define plot
EP.plt<-function(X1, X2, colval, main){
  sen<-log(X1[,ncol(setpt1.df)+colval], 10)
  ins<-log(X2[,ncol(setpt1.df)+colval], 10)

  sen.ecdf <- ecdf(sen)
  ins.ecdf <- ecdf(ins)
  r<-range(c(sen,ins))
  plot(sen, 1-sen.ecdf(sen), col="grey", xlab="", ylab="", main=main,
       xlim=r, ylim=c(0,1)) 

  par(new=TRUE)
  plot(ins, 1-ins.ecdf(ins), col="blue",
       axes=FALSE, ann=FALSE,
       xlim=r, ylim=c(0,1))
}

EP.plt2<-function(X1, X2, colval, main){
  sen<-X1[,ncol(setpt1.df)+colval]
  ins<-X2[,ncol(setpt1.df)+colval]
  
  sen.ecdf <- ecdf(sen)
  ins.ecdf <- ecdf(ins)
  plot(sen, 1-sen.ecdf(sen), col="grey", xlab="", ylab="", main=main,
       xlim=c(0,1), ylim=c(0,1)) 
  
  par(new=TRUE)
  plot(ins, 1-ins.ecdf(ins), col="blue",
       axes=FALSE, ann=FALSE,
       xlim=c(0,1), ylim=c(0,1))
}

#
pdf(file="fig5.pdf", width = 8, height = 6)
par(mfrow=c(2,3), mar = c(4, 2, 3, 1), oma = c(3,3,2,0))
EP.plt(sim1,sim2,1, "Exhaled air, AUC")
legend("bottomleft", c("High sensity parameter","Low sensity parameter"), cex=1, 
       col=c("grey","blue"), pch=21,  bty="n");
EP.plt(sim1,sim2,5, "Exhaled air, C")
EP.plt(sim3,sim4,9, "Exhaled air, AUC")
EP.plt(sim1,sim2,2, "Blood, AUC")
EP.plt(sim1,sim2,6, "Blood, C")
EP.plt(sim3,sim4,10, "Blood, AUC")
mtext("Inhalation", NORTH<-3, line=0, adj=0.32, cex=1.2, outer=TRUE, col="grey20")
mtext("Ingestion", NORTH<-3, line=0, adj=0.88, cex=1.2, outer=TRUE, col="grey20")
mtext("Estimated  logarithm concentration at 48-hr or AUC during the period", South<-1, line=0, cex=1.0, outer=TRUE) 
mtext("Exceedance probability", WEST<-2, line=1.5, cex=1.0, outer=TRUE) 
dev.off()

#
time<-c(60, 120, 239.9, 245, 270, 360, 480, 720, 1440, 2880, 30240)/60/24
Pct_cumulative_1<-conc("Pct_cumulative_4.1", "Pct_cumulative_4.11")
Pct_cumulative_2<-conc("Pct_cumulative_5.1", "Pct_cumulative_5.11")
Pct_cumulative_3<-conc("Pct_cumulative_6.1", "Pct_cumulative_6.11")

TK.plt2<-function(X1, X2, j, col, xlab, ylab){
  for (i in 1:dim(X1)[1]) {
    if (i == 1) {
      plot(time, X1[i,j], xlab = xlab, ylab = ylab, ylim=c(0,1),
           main = "", las = 1, col = "grey", pch = 20, cex.lab = 1,
           type = "l")
      
    } else {
      plot(time, X1[i,j], xlab = "", ylab = "", xaxt = "n", yaxt = "n",
           main = "", las = 1, col = "grey", pch = 20, lwd= 0.1, ylim=c(0,1),
           type = "l") 
    }
    par(new=T)
  }
  par(new=F)
  for (i in 1:dim(X2)[1]) {
    lines(time, X2[i,j], lwd= 0.1, col=col)  
  }
}

#
pdf(file="fig6.pdf", width = 8, height = 6)
par(mfrow=c(2,3), mar = c(3,2,1, 1), oma = c(3,3,2,0))
EP.plt2(sim1,sim2,3, "")
legend("topright", c("High sensity parameter","Low sensity parameter"), cex=1, 
       col=c("grey","blue"), pch=21,  bty="n");
EP.plt2(sim1,sim2,7, "")
EP.plt2(sim3,sim4,11, "")
EP.plt2(sim1,sim2,4, "")
EP.plt2(sim1,sim2,8, "")
EP.plt2(sim3,sim4,12, "")

par(fig=c(0.06,0.32, 0.1,0.44), mar = c(4,4,1,1), new=TRUE)
TK.plt2(sim1, sim2, Pct_cumulative_1, "blue", "", "")
par(fig=c(0.39,0.65, 0.1,0.44), mar = c(4,4,1,1), new=TRUE)
TK.plt2(sim1, sim2, Pct_cumulative_2, "blue", "", "")
par(fig=c(0.73,0.99, 0.1,0.44), mar = c(4,4,1,1), new=TRUE)
TK.plt2(sim3, sim4, Pct_cumulative_3, "blue", "", "")

mtext("Inhalation", NORTH<-3, line=0, adj=0.32, cex=1.2, outer=TRUE, col="grey20")
mtext("Ingestion", NORTH<-3, line=0, adj=0.88, cex=1.2, outer=TRUE, col="grey20")
mtext("Cumulative fraction", South<-1, line=0, cex=1.0, outer=TRUE) 
mtext("Exceedance probability", WEST<-2, line=1.5, cex=1.0, outer=TRUE) 
dev.off()

