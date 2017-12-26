if(!require(Hmisc)) {
  install.packages("Hmisc"); require(Hmisc)} # plot CDF
setwd(paste(getwd(), "/perc", sep=""))

# Total
setpt0.df <- cbind(1, log(df.pri))
write.table(setpt0.df, file="perc.setpoint.dat", row.names=FALSE, sep="\t")
system("./mcsim.perc perc.setpt3.in")
sim0 <- as.data.frame(fread("perc.setpoint.out", head = T))

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

EP.plt<-function(X0, X1, X2, colval, main){
  all<-log(X0[,ncol(setpt1.df)+colval], 10)
  sen<-log(X1[,ncol(setpt1.df)+colval], 10)
  ins<-log(X2[,ncol(setpt1.df)+colval], 10)

  all.ecdf <- ecdf(all)
  sen.ecdf <- ecdf(sen)
  ins.ecdf <- ecdf(ins)
  
  r<-range(c(all,sen,ins))
  r1<-range(all)
  r2<-range(sen)
  r3<-range(ins)
  
  plot(all, 1-all.ecdf(all), col="black", xlab="", ylab="", main=main,
       xlim=r, ylim=c(0,1), type = 'n') 
  polygon(x = c(min(r1), min(r1), max(r1), max(r1)), y = c(-1, 2, 2, -1), col = rgb(0,0,0, alpha=0.1), border = NA)
  polygon(x = c(min(r2), min(r2), max(r2), max(r2)), y = c(-1, 2, 2, -1), col = rgb(1,0,0, alpha=0.1), border = NA)
  polygon(x = c(min(r3), min(r3), max(r3), max(r3)), y = c(-1, 2, 2, -1), col = rgb(0,0,1, alpha=0.1) , border = NA)
  
  par(new=TRUE)
  plot(all, 1-all.ecdf(all), col="black", xlab="", ylab="", 
       axes=FALSE, ann=FALSE,
       xlim=r, ylim=c(0,1)) 
  
  par(new=TRUE)
  plot(sen, 1-sen.ecdf(sen), col="red", xlab="", ylab="",
       xlim=r, ylim=c(0,1)) 

  par(new=TRUE)
  plot(ins, 1-ins.ecdf(ins), col="blue",
       axes=FALSE, ann=FALSE,
       xlim=r, ylim=c(0,1))
  
  text(r2[1], 0.5, labels = round((max(r2)-min(r2))/(max(r)-min(r)), 2), cex=1)
  text(r3[1], 0.5, labels = round((max(r3)-min(r3))/(max(r)-min(r)), 2), cex=1)
}

ratio.plt<-function(X0, X1, X2, colval){
  all<-X0[,ncol(setpt1.df)+colval]
  sen<-X1[,ncol(setpt1.df)+colval]
  ins<-X2[,ncol(setpt1.df)+colval]
  
  r1<-range(all)
  r2<-range(sen)
  r3<-range(ins)
  
  
  print(max(r1)/(max(r3)))
}

ratio.plt(sim0, sim1, sim2, 1)
ratio.plt(sim0, sim1, sim2, 5)
ratio.plt(sim0, sim1, sim2, 9)
ratio.plt(sim0, sim1, sim2, 2)
ratio.plt(sim0, sim1, sim2, 6)
ratio.plt(sim0, sim1, sim2, 10)

EP.plt2<-function(X0, X1, X2, colval, main){
  all<-X0[,ncol(setpt1.df)+colval]
  sen<-X1[,ncol(setpt1.df)+colval]
  ins<-X2[,ncol(setpt1.df)+colval]
  
  all.ecdf <- ecdf(all)
  sen.ecdf <- ecdf(sen)
  ins.ecdf <- ecdf(ins)
  
  r<-range(c(all,sen,ins))
  r1<-range(all)
  r2<-range(sen)
  r3<-range(ins)
  
  plot(all, 1-all.ecdf(all), col="black", xlab="", ylab="", main=main,
       xlim=c(0,1), ylim=c(0,1), type = 'n') 
  polygon(x = c(min(r1), min(r1), max(r1), max(r1)), y = c(-1, 2, 2, -1), col = rgb(0,0,0, alpha=0.1), border = NA)
  polygon(x = c(min(r2), min(r2), max(r2), max(r2)), y = c(-1, 2, 2, -1), col = rgb(1,0,0, alpha=0.1), border = NA)
  polygon(x = c(min(r3), min(r3), max(r3), max(r3)), y = c(-1, 2, 2, -1), col = rgb(0,0,1, alpha=0.1) , border = NA)
  
  par(new=TRUE)
  plot(all, 1-all.ecdf(all), col="black", xlab="", ylab="", 
       axes=FALSE, ann=FALSE,
       xlim=c(0,1), ylim=c(0,1)) 
  
  par(new=TRUE)
  plot(sen, 1-sen.ecdf(sen), col="red", xlab="", ylab="",
       axes=FALSE, ann=FALSE,
       xlim=c(0,1), ylim=c(0,1)) 
  
  par(new=TRUE)
  plot(ins, 1-ins.ecdf(ins), col="blue",
       axes=FALSE, ann=FALSE,
       xlim=c(0,1), ylim=c(0,1))
  
  text(r2[2]+0.05, 1.0, labels = round((max(r2)-min(r2))/(max(r)-min(r)), 2), cex=1, col="red")
  text(r3[2], 1.0, labels = round((max(r3)-min(r3))/(max(r)-min(r)), 2), cex=1, col="blue")
}

#
pdf(file="fig5.pdf", width = 8, height = 6)
par(mfrow=c(2,3), mar = c(4, 2, 3, 1), oma = c(3,3,2,0))
EP.plt(sim0, sim1, sim2, 1, "Exhaled air, AUC")
legend("bottomleft", c("All parameter","High sensity parameter","Low sensity parameter"), cex=1, 
       col=c("black","red","blue"), pch=21,  bty="n");
EP.plt(sim0, sim1,sim2,5, "Exhaled air, C")
EP.plt(sim0, sim3,sim4,9, "Exhaled air, AUC")
EP.plt(sim0, sim1,sim2,2, "Blood, AUC")
EP.plt(sim0, sim1,sim2,6, "Blood, C")
EP.plt(sim0, sim3,sim4,10, "Blood, AUC")
mtext("Inhalation", NORTH<-3, line=0, adj=0.32, cex=1.2, outer=TRUE, col="grey20")
mtext("Ingestion", NORTH<-3, line=0, adj=0.88, cex=1.2, outer=TRUE, col="grey20")
mtext("Estimated  logarithm AUC/steady-state concentration", South<-1, line=0, cex=1.0, outer=TRUE) 
mtext("Exceedance probability", WEST<-2, line=1.5, cex=1.0, outer=TRUE) 
dev.off()

#
conc<-function(conc1st, conclast){
  sim.str<-which(names(sim1)==conc1st)
  sim.end<-which(names(sim1)==conclast)
  sim.str:sim.end
}

time<-c(60, 120, 239.9, 245, 270, 360, 480, 720, 1440, 2880, 30240)/60/24
Pct_cumulative_1<-conc("Pct_cumulative_4.1", "Pct_cumulative_4.11")
Pct_cumulative_2<-conc("Pct_cumulative_5.1", "Pct_cumulative_5.11")
Pct_cumulative_3<-conc("Pct_cumulative_6.1", "Pct_cumulative_6.11")

TK.plt2<-function(X0, X1, X2, j, xlab, ylab){
  for (i in 1:dim(X0)[1]) {
    if (i == 1) {
      plot(time, X0[i,j], xlab = xlab, ylab = ylab, ylim=c(0,1),
           main = "", las = 1, col = "black", pch = 20, cex.lab = 1,
           type = "l")
      
    } else {
      plot(time, X0[i,j], xlab = "", ylab = "", xaxt = "n", yaxt = "n",
           main = "", las = 1, col = "black", pch = 20, lwd= 0.1, ylim=c(0,1),
           type = "l") 
    }
    par(new=T)
  }
  par(new=F)
  for (i in 1:dim(X1)[1]) {
    lines(time, X1[i,j], lwd= 0.1, col="red")  
  }
  par(new=F)
  for (i in 1:dim(X2)[1]) {
    lines(time, X2[i,j], lwd= 0.1, col="blue")  
  }
}

#
pdf(file="fig6.pdf", width = 8, height = 3)
par(mfrow=c(1,3), mar = c(3,2,1, 1), oma = c(3,3,2,0))
#EP.plt2(sim0, sim1, sim2, 3, "")
#EP.plt2(sim0, sim1, sim2,7, "")
#EP.plt2(sim0, sim3, sim4,11, "")
EP.plt2(sim0, sim1, sim2,4, "")
legend("bottomright", c("All parameter","High sensity parameter","Low sensity parameter"), cex=1, 
       col=c("black","red","blue"), pch=21,  bty="n", cex=0.6);
EP.plt2(sim0, sim1, sim2,8, "")
EP.plt2(sim0, sim3, sim4,12, "")

#par(fig=c(0.06,0.32, 0.1,0.44), mar = c(4,4,1,1), new=TRUE)
par(fig=c(0.06,0.32, 0.2,0.94), mar = c(4,4,1,1), new=TRUE)
TK.plt2(sim0, sim1, sim2, Pct_cumulative_1, "Time", "Cumulative fraction")
par(fig=c(0.39,0.65, 0.2,0.94), mar = c(4,4,1,1), new=TRUE)
TK.plt2(sim0, sim1, sim2, Pct_cumulative_2, "", "")
par(fig=c(0.73,0.99, 0.2,0.94), mar = c(4,4,1,1), new=TRUE)
TK.plt2(sim0, sim3, sim4, Pct_cumulative_3, "", "")

mtext("Inhalation", NORTH<-3, line=0, adj=0.32, cex=1.2, outer=TRUE, col="grey20")
mtext("Ingestion", NORTH<-3, line=0, adj=0.88, cex=1.2, outer=TRUE, col="grey20")
mtext("Cumulative fraction", South<-1, line=0, cex=1.0, outer=TRUE) 
mtext("Exceedance probability", WEST<-2, line=1.5, cex=1.0, outer=TRUE) 
dev.off()

