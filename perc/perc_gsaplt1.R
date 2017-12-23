setwd(paste(getwd(), "/perc", sep=""))
source("perc_gsa.R")
if(!require(scatterplot3d)) {
  install.packages("scatterplot3d"); require(scatterplot3d)} 

# Parameter distribution
pdf(file="fig1.pdf", width = 9, height = 7)
#png(file="fig2.png",width=2000,height=1200,res=250)
par(mfrow=c(4,4), mar=c(2,2,2,1), oma = c(3,3,2,0))
for(i in 1:16)
{
  if (is.na(df.pst[1,i])==TRUE){
    plot(density(log(df.pri[,i])), main = names(df.pri)[i], xlab="", ylab="",
         col=2, lwd = 2)
  }else{
    plot(density(log(df.pst[,i])), main = names(df.pri)[i], xlab="", ylab="",
         xlim=c(log(min(df.pri[,i])),log(max(df.pri[,i]))), col=3, lwd = 2)
    lines(density(log(df.pri[,i])), col=2, lwd = 2)
  }
}
mtext("Density", WEST<-2, line=0.6, cex=1, outer=TRUE) 
mtext("Logarithm parameter value", South<-1, line=0.6, cex=1, outer=TRUE) 
dev.off()


setpt1.df <- cbind(1, log(df.pri))
write.table(setpt1.df, file="perc.setpoint.dat", row.names=FALSE, sep="\t")
system("./mcsim.perc perc.setpt1.in")
sim1 <- as.data.frame(fread("perc.setpoint.out", head = T))

setpt2.df <- cbind(1, log(df.pst))
write.table(setpt2.df, file="perc.setpoint.dat", row.names=FALSE, sep="\t")
system("./mcsim.perc perc.setpt1.in")
sim2 <- as.data.frame(fread("perc.setpoint.out", head = T))

time<-c(60, 120, 239.9, 245, 270, 360, 480, 720, 1440, 2880)/60

conc<-function(conc1st, conclast){
  sim.str<-which(names(sim1)==conc1st)
  sim.end<-which(names(sim1)==conclast)
  sim.str:sim.end
}

C_exh_ug_1<-conc("C_exh_ug_1.1", "C_exh_ug_1.10")
C_ven_ug_1<-conc("C_ven_ug_1.1", "C_ven_ug_1.10")
Q_met_1<-conc("Q_met_ug_1.1", "Q_met_ug_1.10")
C_exh_ug_2<-conc("C_exh_ug_2.1", "C_exh_ug_2.10")
C_ven_ug_2<-conc("C_ven_ug_2.1", "C_ven_ug_2.10")
Q_met_2<-conc("Q_met_ug_2.1", "Q_met_ug_2.10")
C_exh_ug_3<-conc("C_exh_ug_3.1", "C_exh_ug_3.10")
C_ven_ug_3<-conc("C_ven_ug_3.1", "C_ven_ug_3.10")
Q_met_3<-conc("Q_met_ug_3.1", "Q_met_ug_3.10")

#
TK.plt<-function(j, mtext, col, ylim, ylwr, yupr){
  for (i in 1:dim(sim1)[1]) {
    if (i == 1) {
      plot(time, sim1[i,j], xlab = "", ylab = "", yaxt="n",
           main = "", las = 1, col = "grey", pch = 20, cex.lab = 1.5,
           type = "l", log = "y", ylim = ylim)
      mtext(mtext, cex = 1, col = col)
      
      ticks <- seq(ylwr, yupr, by=2)
      labels <- sapply(ticks, function(i) as.expression(bquote(10^ .(i))))
      axis(2, at=c(10^ticks[1], 10^ticks[2], 10^ticks[3], 10^ticks[4], 10^ticks[5]),
           labels=labels)
      
      
    } else {
      plot(time, sim1[i,j], xlab = "", ylab = "", xaxt = "n", yaxt = "n",
           main = "", las = 1, col = "grey", pch = 20, lwd= 0.1,
           type = "l", log = "y", ylim = ylim) 
    }
    par(new=T)
  }
  par(new=F)
  
  for (i in 1:dim(sim2)[1]) {
    lines(time, sim2[i,j], lwd= 0.1, col=col)  
  }
}

pdf(file="fig2.pdf", width = 9, height = 7)
#png(file="fig2.png",width=2000,height=1200,res=250)
par(mfrow=c(3,3), mar = c(2, 2, 3, 1), oma = c(3,3,2,0))
TK.plt(C_exh_ug_1, expression(paste("Exhaled air, ",mu, "g/L")), "blue", c(1E-4, 1E4), -4, 4)
TK.plt(C_exh_ug_2, expression(paste("Exhaled air, ",mu, "g/L")), "blue", c(1E-4, 1E4), -4, 4)
TK.plt(C_exh_ug_3, expression(paste("Exhaled air, ",mu, "g/L")), "red", c(1E-4, 1E4), -4, 4)

TK.plt(C_ven_ug_1, expression(paste("Blood, ",mu, "g/L")), "blue", c(1E-3, 1E5), -3, 5)
TK.plt(C_ven_ug_2, expression(paste("Blood, ",mu, "g/L")), "blue", c(1E-3, 1E5), -3, 5)
TK.plt(C_ven_ug_3, expression(paste("Blood, ",mu, "g/L")), "red", c(1E-3, 1E5), -3, 5)

TK.plt(Q_met_1, expression(paste("Metabolized, ",mu, "g")), "blue", c(1E-1, 1E7), -1, 7)
TK.plt(Q_met_2, expression(paste("Metabolized, ",mu, "g")), "blue", c(1E-1, 1E7), -1, 7)
TK.plt(Q_met_3, expression(paste("Metabolized, ",mu, "g")), "red", c(1E-1, 1E7), -1, 7)

mtext("Concentration", WEST<-2, line=0.6, cex=1, outer=TRUE) 
mtext("Time, hr", South<-1, line=0.6, cex=1, outer=TRUE) 
mtext("Inhalation = 72 ppm", NORTH<-3, line=-1, adj=0.3, cex=1.2, outer=TRUE, col="blue")
mtext("Ingestion = 72 mg", NORTH<-3, line=-1, adj=0.93, cex=1.2, outer=TRUE, col="red")
dev.off()


# 3dPhase plane (not finish)
df<-data.frame(as.numeric(sim1[1,C_exh_ug_1]),
               as.numeric(sim1[1,C_ven_ug_1]),
               as.numeric(sim1[1,Q_met_1]))
colfunc <- colorRampPalette(c("maroon", "red"))
df1<-cbind(df, c(colfunc(10)[1], colfunc(10)[2], colfunc(10)[3], colfunc(10)[4], colfunc(10)[5],
                 colfunc(10)[6], colfunc(10)[7],colfunc(10)[8], colfunc(10)[9], colfunc(10)[10]))
names(df1)<-c("C_exh_ug","C_ven_ug","Q_met", "col")



with(df1, {
  scatterplot3d(C_exh_ug,   # x axis
                C_ven_ug,     # y axis
                Q_met,    # z axis,
                xlab = "Exhaled air",
                ylab = "Blood",
                zlab = "Exhaled + Metabolized",
                type = 'b',color = col)

})



#
set.seed(1234)
morr <- morris(model = NULL, factors = 16, r = 100, 
               design = list(type = "oat", levels = 5, grid.jump = 3), 
               binf = c(log(LeanBodyWt_min),
                        log(Flow_pul_min),
                        log(Vent_Perf_min),
                        log(Pct_M_fat_min), 
                        log(Pct_LM_liv_min), 
                        log(Pct_LM_wp_min),
                        log(Pct_Flow_fat_min), 
                        log(Pct_Flow_liv_min), 
                        log(Pct_Flow_pp_min), 
                        log(PC_fat_min), 
                        log(PC_liv_min), 
                        log(PC_wp_min), 
                        log(PC_pp_min), 
                        log(PC_art_min),
                        log(sc_Vmax_min), 
                        log(Km_min)
               ),
               bsup = c(log(LeanBodyWt_max),
                        log(Flow_pul_max),
                        log(Vent_Perf_max),
                        log(Pct_M_fat_max), 
                        log(Pct_LM_liv_max), 
                        log(Pct_LM_wp_max),
                        log(Pct_Flow_fat_max), 
                        log(Pct_Flow_liv_max), 
                        log(Pct_Flow_pp_max), 
                        log(PC_fat_max), 
                        log(PC_liv_max), 
                        log(PC_wp_max), 
                        log(PC_pp_max), 
                        log(PC_art_max),
                        log(sc_Vmax_max), 
                        log(Km_max)), scale = TRUE)                  

morr.perc.df <- cbind(1, morr$X) 
nrow(morr$X) # nrow=17408
write.table(morr.perc.df, file="perc.setpoint.dat", row.names=FALSE, sep="\t")
system("./mcsim.perc perc.setpt2.in")
sim.morris <- as.data.frame(fread("perc.setpoint.out", head = T))


mor.1.1 <- tell(morr, sim.morris[,ncol(morr$X)+2])
mor.1.2 <- tell(morr, sim.morris[,ncol(morr$X)+3])
mor.1.3 <- tell(morr, sim.morris[,ncol(morr$X)+4])

mor.2.1 <- tell(morr, sim.morris[,ncol(morr$X)+5])
mor.2.2 <- tell(morr, sim.morris[,ncol(morr$X)+6])
mor.2.3 <- tell(morr, sim.morris[,ncol(morr$X)+7])

mor.3.1 <- tell(morr, sim.morris[,ncol(morr$X)+8])
mor.3.2 <- tell(morr, sim.morris[,ncol(morr$X)+9])
mor.3.3 <- tell(morr, sim.morris[,ncol(morr$X)+10])

mu.star.1.1 <- apply(mor.1.1$ee, 2, function(x) mean(abs(x)))
mu.star.1.2 <- apply(mor.1.2$ee, 2, function(x) mean(abs(x)))
mu.star.1.3 <- apply(mor.1.3$ee, 2, function(x) mean(abs(x)))
mu.star.2.1 <- apply(mor.2.1$ee, 2, function(x) mean(abs(x)))
mu.star.2.2 <- apply(mor.2.2$ee, 2, function(x) mean(abs(x)))
mu.star.2.3 <- apply(mor.2.3$ee, 2, function(x) mean(abs(x)))
mu.star.3.1 <- apply(mor.3.1$ee, 2, function(x) mean(abs(x)))
mu.star.3.2 <- apply(mor.3.2$ee, 2, function(x) mean(abs(x)))
mu.star.3.3 <- apply(mor.3.3$ee, 2, function(x) mean(abs(x)))

sigma.1.1 <- apply(mor.1.1$ee, 2, sd)
sigma.1.2 <- apply(mor.1.2$ee, 2, sd)
sigma.1.3 <- apply(mor.1.3$ee, 2, sd)
sigma.2.1 <- apply(mor.2.1$ee, 2, sd)
sigma.2.2 <- apply(mor.2.2$ee, 2, sd)
sigma.2.3 <- apply(mor.2.3$ee, 2, sd)
sigma.3.1 <- apply(mor.3.1$ee, 2, sd)
sigma.3.2 <- apply(mor.3.2$ee, 2, sd)
sigma.3.3 <- apply(mor.3.3$ee, 2, sd)

options(scipen = 6)
pdf(file="fig3x.pdf", width = 8, height = 8)
#png(file="fig2.png",width=2000,height=1200,res=250)
par(mfrow=c(3,3), mar = c(2, 2, 3, 1), oma = c(3,3,1,0))
xlab <- expression(paste(mu,"*"))
labels <- c("LeanBodyWt", "Flow_pul", "Vent_Perf", 
            "Pct_M_fat", "Pct_LM_liv", "Pct_LM_wp",
            "Pct_Flow_fat", "Pct_Flow_liv", "Pct_Flow_pp",
            "PC_fat", "PC_liv", "PC_wp", "PC_pp", "PC_art",
            "sc_Vmax", "Km")

plot(mu.star.1.1, sigma.1.1, main = "4-hr exposure \n Exhaled air",
     col = "white", xlab = "", ylab = "",
     xlim=NULL)
text(mu.star.1.1, sigma.1.1, labels = labels, cex=0.8)
plot(mu.star.2.1, sigma.2.1, main = "48-hr exposure \n Exhaled air",
     col = "white", xlab = "", ylab = "",
     xlim=NULL)
text(mu.star.2.1, sigma.2.1, labels = labels, cex=0.8)
plot(mu.star.3.1, sigma.3.1, main = "1-time oral dose \n Exhaled air",
     col = "white", xlab = "", ylab = "",
     xlim=NULL)
text(mu.star.3.1, sigma.3.1, labels = labels, cex=0.8)

plot(mu.star.1.2, sigma.1.2, main = "Blood",
     col = "white", xlab = "", ylab = "",
     xlim=NULL)
text(mu.star.1.2, sigma.1.2, labels = labels, cex=0.8)
plot(mu.star.2.2, sigma.2.2, main = "Blood",
     col = "white", xlab = "", ylab = "",
     xlim=NULL)
text(mu.star.2.2, sigma.2.2, labels = labels, cex=0.8)
plot(mu.star.3.2, sigma.3.2, main = "Blood",
     col = "white", xlab = "", ylab = "",
     xlim=NULL)
text(mu.star.3.2, sigma.3.2, labels = labels, cex=0.8)

plot(mu.star.1.3, sigma.1.3, main = "Metabolized",
     col = "white", xlab = "", ylab = "",
     xlim=NULL)
text(mu.star.1.3, sigma.1.3, labels = labels, cex=0.8)
plot(mu.star.2.3, sigma.2.3, main = "Metabolized",
     col = "white", xlab = "", ylab = "",
     xlim=NULL)
text(mu.star.2.3, sigma.2.3, labels = labels, cex=0.8)
plot(mu.star.3.3, sigma.3.3, main = "Metabolized",
     col = "white", xlab = "", ylab = "",
     xlim=NULL)
text(mu.star.3.3, sigma.3.3, labels = labels, cex=0.8)
mtext(expression(~sigma), WEST<-2, line=0.7, cex=1, outer=TRUE) 
mtext(expression(paste(mu,"*")), South<-1, line=0.7, cex=1, outer=TRUE) 
dev.off()

#
q <- rep("qtri", 16)
q.arg <- list(list(log(LeanBodyWt_min), log(LeanBodyWt_max), log(LeanBodyWt)),
              list(log(Flow_pul_min), log(Flow_pul_max), log(Flow_pul)),
              list(log(Vent_Perf_min), log(Vent_Perf_max), log(Vent_Perf)),
              list(log(Pct_M_fat_min), log(Pct_M_fat_max), log(Pct_M_fat)),
              list(log(Pct_LM_liv_min), log(Pct_LM_liv_max), log(Pct_LM_liv)),
              list(log(Pct_LM_wp_min), log(Pct_LM_wp_max), log(Pct_LM_wp)),
              list(log(Pct_Flow_fat_min), log(Pct_Flow_fat_max), log(Pct_Flow_fat)),
              list(log(Pct_Flow_liv_min), log(Pct_Flow_liv_max), log(Pct_Flow_liv)),
              list(log(Pct_Flow_pp_min), log(Pct_Flow_pp_max), log(Pct_Flow_pp)),
              list(log(PC_fat_min), log(PC_fat_max), log(PC_fat)),
              list(log(PC_liv_min), log(PC_liv_max), log(PC_liv)),
              list(log(PC_wp_min), log(PC_wp_max), log(PC_wp)),
              list(log(PC_pp_min), log(PC_pp_max), log(PC_pp)),
              list(log(PC_art_min), log(PC_art_max), log(PC_art)),
              list(log(sc_Vmax_min), log(sc_Vmax_max), log(sc_Vmax)),
              list(log(Km_min), log(Km_max), log(Km)))

fast <- fast99(model = NULL, factors = 16, n = 8192, M = 4, q = q, q.arg = q.arg)

fast.perc.df <- cbind(1, fast$X) # nrow = 131072
write.table(fast.perc.df, file="perc.setpoint.dat", row.names=FALSE, sep="\t")
system("./mcsim.perc perc.setpt2.in")
sim.fast <- as.data.frame(fread("perc.setpoint.out", head=T)) 

fst.1.1 <- tell(fast, sim.fast[,ncol(fast$X)+2])
fst.1.2 <- tell(fast, sim.fast[,ncol(fast$X)+3])
fst.1.3 <- tell(fast, sim.fast[,ncol(fast$X)+4])

fst.2.1 <- tell(fast, sim.fast[,ncol(fast$X)+5])
fst.2.2 <- tell(fast, sim.fast[,ncol(fast$X)+6])
fst.2.3 <- tell(fast, sim.fast[,ncol(fast$X)+7])

fst.3.1 <- tell(fast, sim.fast[,ncol(fast$X)+8])
fst.3.2 <- tell(fast, sim.fast[,ncol(fast$X)+9])
fst.3.3 <- tell(fast, sim.fast[,ncol(fast$X)+10])

#
fast.table<-function(dataset){
  rbind(print(dataset)[1:16], print(dataset)[17:32]-print(dataset)[1:16])
}

f.table.1.1 <- fast.table(fst.1.1)
f.table.2.1 <- fast.table(fst.2.1)
f.table.3.1 <- fast.table(fst.3.1)
f.table.1.2 <- fast.table(fst.1.2)
f.table.2.2 <- fast.table(fst.2.2)
f.table.3.2 <- fast.table(fst.3.2)
f.table.1.3 <- fast.table(fst.1.3)
f.table.2.3 <- fast.table(fst.2.3)
f.table.3.3 <- fast.table(fst.3.3)

# pst (not used)
q <- rep("qnormTrunc", 16)
q.arg <- list(list(log(LeanBodyWt.obs.mu), log(LeanBodyWt.obs.sig), log(LeanBodyWt_min), log(LeanBodyWt_max)),
              list(log(Flow_pul.obs.mu), log(Flow_pul.obs.sig), log(Flow_pul_min), log(Flow_pul_max)),
              list(log(Vent_Perf.pst.mu), log(Vent_Perf.pst.sig), log(Vent_Perf_min), log(Vent_Perf_max)),
              list(log(Pct_M_fat.obs.mu), log(Pct_M_fat.obs.sig), log(Pct_M_fat_min), log(Pct_M_fat_max)),
              list(log(Pct_LM_liv.pst.mu), log(Pct_LM_liv.pst.sig), log(Pct_LM_liv_min), log(Pct_LM_liv_max)),
              list(log(Pct_LM_wp.pst.mu), log(Pct_LM_wp.pst.sig), log(Pct_LM_wp_min), log(Pct_LM_wp_max)),
              list(log(Pct_Flow_fat.pst.mu), log(Pct_Flow_fat.pst.sig), log(Pct_Flow_fat_min), log(Pct_Flow_fat_max)),
              list(log(Pct_Flow_liv.pst.mu), log(Pct_Flow_liv.pst.sig), log(Pct_Flow_liv_min), log(Pct_Flow_liv_max)),
              list(log(Pct_Flow_pp.pst.mu), log(Pct_Flow_pp.pst.sig), log(Pct_Flow_pp_min), log(Pct_Flow_pp_max)),
              list(log(PC_fat.pst.mu), log(PC_fat.pst.sig), log(PC_fat_min), log(PC_fat_max)),
              list(log(PC_liv.pst.mu), log(PC_liv.pst.sig), log(PC_liv_min), log(PC_liv_max)),
              list(log(PC_wp.pst.mu), log(PC_wp.pst.sig), log(PC_wp_min), log(PC_wp_max)),
              list(log(PC_pp.pst.mu), log(PC_pp.pst.sig), log(PC_pp_min), log(PC_pp_max)),
              list(log(PC_art.pst.mu), log(PC_art.pst.sig), log(PC_art_min), log(PC_art_max)),
              list(log(sc_Vmax.pst.mu), log(sc_Vmax.pst.sig), log(sc_Vmax_min), log(sc_Vmax_max)),
              list(log(Km.pst.mu), log(Km.pst.sig), log(Km_min), log(Km_max)))

fst2 <- fast99(model = NULL, factors = 16, n = 8192, M = 4, q = q, q.arg = q.arg)
fst2.perc.df <- cbind(1, fst2$X) # nrow = 131072
write.table(fst2.perc.df, file="perc.setpoint.dat", row.names=FALSE, sep="\t")
system("./mcsim.perc perc.setpt2.in")
sim.fst2 <- as.data.frame(fread("perc.setpoint.out", head=T)) 

fst2.1.1 <- tell(fst2, sim.fst2[,ncol(morr$X)+2])
fst2.1.2 <- tell(fst2, sim.fst2[,ncol(morr$X)+3])
fst2.1.3 <- tell(fst2, sim.fst2[,ncol(morr$X)+4])

fst2.2.1 <- tell(fst2, sim.fst2[,ncol(morr$X)+5])
fst2.2.2 <- tell(fst2, sim.fst2[,ncol(morr$X)+6])
fst2.2.3 <- tell(fst2, sim.fst2[,ncol(morr$X)+7])

fst2.3.1 <- tell(fst2, sim.fst2[,ncol(morr$X)+8])
fst2.3.2 <- tell(fst2, sim.fst2[,ncol(morr$X)+9])
fst2.3.3 <- tell(fst2, sim.fst2[,ncol(morr$X)+10])

f2.table.1.1 <- fast.table(fst2.1.1)
f2.table.2.1 <- fast.table(fst2.2.1)
f2.table.3.1 <- fast.table(fst2.3.1)
f2.table.1.2 <- fast.table(fst2.1.2)
f2.table.2.2 <- fast.table(fst2.2.2)
f2.table.3.2 <- fast.table(fst2.3.2)
f2.table.1.3 <- fast.table(fst2.1.3)
f2.table.2.3 <- fast.table(fst2.2.3)
f2.table.3.3 <- fast.table(fst2.3.3)

# 
pdf(file="fig3.pdf", width = 9, height = 8)
par(mfrow=c(3,3), mar = c(4, 2, 3, 1), oma = c(3,3,1,0))
bp11<-barplot(f.table.1.1, ylim = c(0,1), col=c("white","grey"))
text(bp11, par('usr')[3], labels = labels, srt = 45, adj = c(1.1,1.1), xpd = TRUE, cex=.9)
bp21<-barplot(f.table.2.1, ylim = c(0,1), col=c("white","grey"))
text(bp21, par('usr')[3], labels = labels, srt = 45, adj = c(1.1,1.1), xpd = TRUE, cex=.9)
bp31<-barplot(f.table.3.1, ylim = c(0,1), col=c("white","grey"))
text(bp31, par('usr')[3], labels = labels, srt = 45, adj = c(1.1,1.1), xpd = TRUE, cex=.9)

bp12<-barplot(f.table.1.2, ylim = c(0,1), col=c("white","grey"))
text(bp12, par('usr')[3], labels = labels, srt = 45, adj = c(1.1,1.1), xpd = TRUE, cex=.9)
bp22<-barplot(f.table.2.2, ylim = c(0,1), col=c("white","grey"))
text(bp22, par('usr')[3], labels = labels, srt = 45, adj = c(1.1,1.1), xpd = TRUE, cex=.9)
bp32<-barplot(f.table.3.2, ylim = c(0,1), col=c("white","grey"))
text(bp32, par('usr')[3], labels = labels, srt = 45, adj = c(1.1,1.1), xpd = TRUE, cex=.9)

bp13<-barplot(f.table.1.3, ylim = c(0,1), col=c("white","grey"))
text(bp13, par('usr')[3], labels = labels, srt = 45, adj = c(1.1,1.1), xpd = TRUE, cex=.9)
bp23<-barplot(f.table.2.3, ylim = c(0,1), col=c("white","grey"))
text(bp23, par('usr')[3], labels = labels, srt = 45, adj = c(1.1,1.1), xpd = TRUE, cex=.9)
bp33<-barplot(f.table.3.3, ylim = c(0,1), col=c("white","grey"))
text(bp33, par('usr')[3], labels = labels, srt = 45, adj = c(1.1,1.1), xpd = TRUE, cex=.9)

# subplot
par(fig=c(0.05,0.25,0.74,0.98), new=TRUE)
plot(mu.star.1.1, sigma.1.1, main = "",
     col = "white", xlab = "", ylab = "",
     xlim=NULL)
text(mu.star.1.1, sigma.1.1, labels = labels, cex=0.8)
mtext(expression(~sigma), side=2, line=2, cex.lab=0.4)
mtext(expression(paste(mu,"*")), side=1, line=2, cex.lab=0.4)

par(fig=c(0.38,0.58,0.74,0.98), new=TRUE)
plot(mu.star.2.1, sigma.2.1, main = "",
     col = "white", xlab = "", ylab = "",
     xlim=NULL)
text(mu.star.2.1, sigma.2.1, labels = labels, cex=0.8)
par(fig=c(0.72,0.92,0.74,0.98), new=TRUE)
plot(mu.star.3.1, sigma.3.1, main = "",
     col = "white", xlab = "", ylab = "",
     xlim=NULL)
text(mu.star.3.1, sigma.3.1, labels = labels, cex=0.8)

par(fig=c(0.05,0.25,0.42,0.66), new=TRUE)
plot(mu.star.1.2, sigma.1.2, main = "",
     col = "white", xlab = "", ylab = "",
     xlim=NULL)
text(mu.star.1.2, sigma.1.2, labels = labels, cex=0.8)
par(fig=c(0.38,0.58,0.42,0.66), new=TRUE)
plot(mu.star.2.2, sigma.2.2, main = "",
     col = "white", xlab = "", ylab = "",
     xlim=NULL)
text(mu.star.2.2, sigma.2.2, labels = labels, cex=0.8)
par(fig=c(0.72,0.92,0.42,0.66), new=TRUE)
plot(mu.star.3.2, sigma.3.2, main = "",
     col = "white", xlab = "", ylab = "",
     xlim=NULL)
text(mu.star.3.2, sigma.3.2, labels = labels, cex=0.8)


par(fig=c(0.05,0.25,0.08,0.32), new=TRUE)
plot(mu.star.1.3, sigma.1.3, main = "",
     col = "white", xlab = "", ylab = "",
     xlim=NULL)
text(mu.star.1.3, sigma.1.3, labels = labels, cex=0.8)
par(fig=c(0.38,0.58,0.08,0.32), new=TRUE)
plot(mu.star.2.3, sigma.2.3, main = "",
     col = "white", xlab = "", ylab = "",
     xlim=NULL)
text(mu.star.2.3, sigma.2.3, labels = labels, cex=0.8)
par(fig=c(0.72,0.92,0.08,0.32), new=TRUE)
plot(mu.star.3.3, sigma.3.3, main = "",
     col = "white", xlab = "", ylab = "",
     xlim=NULL)
text(mu.star.3.3, sigma.3.3, labels = labels, cex=0.8)

mtext("Sobol sensitivity index", WEST<-2, line=0.7, cex=1.2, outer=TRUE) 
mtext("Parameter", South<-1, line=0.7, cex=1.2, outer=TRUE) 
dev.off()

# Sensitivity ranking
sen.rank<-function(dataset){
  df<- cbind(labels, as.data.frame(dataset))
  transform(df, rank = ave(df[,2], 
                           FUN = function(x) rank(x, ties.method = "first")))
}

# G1
mm1.1R<-sen.rank(mu.star.1.1)
mm1.2R<-sen.rank(mu.star.1.2)
mm1.3R<-sen.rank(mu.star.1.3)
ms1.1R<-sen.rank(sigma.1.1)
ms1.2R<-sen.rank(sigma.1.2)
ms1.3R<-sen.rank(sigma.1.3)
fm1.1R<-sen.rank(print(fst.1.1)[1:16])
fi1.1R<-sen.rank(print(fst.1.1)[17:32]-print(fst.1.1)[1:16])
fm1.2R<-sen.rank(print(fst.1.2)[1:16])
fi1.2R<-sen.rank(print(fst.1.2)[17:32]-print(fst.1.2)[1:16])
fm1.3R<-sen.rank(print(fst.1.3)[1:16])
fi1.3R<-sen.rank(print(fst.1.3)[17:32]-print(fst.1.3)[1:16])

Rank1<-c(mm1.1R[,3],mm1.2R[,3],mm1.3R[,3],ms1.1R[,3],ms1.2R[,3],ms1.3R[,3],
         fm1.1R[,3],fm1.2R[,3],fm1.3R[,3],fi1.1R[,3],fi1.2R[,3],fi1.3R[,3])
labels3.df1 <- mm1.1R[order(mm1.1R[,3]),] 

#G2
mm2.1R<-sen.rank(mu.star.2.1)
mm2.2R<-sen.rank(mu.star.2.2)
mm2.3R<-sen.rank(mu.star.2.3)
ms2.1R<-sen.rank(sigma.2.1)
ms2.2R<-sen.rank(sigma.2.2)
ms2.3R<-sen.rank(sigma.2.3)
fm2.1R<-sen.rank(print(fst.2.1)[1:16])
fi2.1R<-sen.rank(print(fst.2.1)[17:32]-print(fst.2.1)[1:16])
fm2.2R<-sen.rank(print(fst.2.2)[1:16])
fi2.2R<-sen.rank(print(fst.2.2)[17:32]-print(fst.2.2)[1:16])
fm2.3R<-sen.rank(print(fst.2.3)[1:16])
fi2.3R<-sen.rank(print(fst.2.3)[17:32]-print(fst.2.3)[1:16])

Rank2<-c(mm2.1R[,3],mm2.2R[,3],mm2.3R[,3],ms2.1R[,3],ms2.2R[,3],ms2.3R[,3],
         fm2.1R[,3],fm2.2R[,3],fm2.3R[,3],fi2.1R[,3],fi2.2R[,3],fi2.3R[,3])
labels3.df2 <- mm2.1R[order(mm2.1R[,3]),] 

#G3
mm3.1R<-sen.rank(mu.star.3.1)
mm3.2R<-sen.rank(mu.star.3.2)
mm3.3R<-sen.rank(mu.star.3.3)
ms3.1R<-sen.rank(sigma.3.1)
ms3.2R<-sen.rank(sigma.3.2)
ms3.3R<-sen.rank(sigma.3.3)
fm3.1R<-sen.rank(print(fst.3.1)[1:16])
fi3.1R<-sen.rank(print(fst.3.1)[17:32]-print(fst.3.1)[1:16])
fm3.2R<-sen.rank(print(fst.3.2)[1:16])
fi3.2R<-sen.rank(print(fst.3.2)[17:32]-print(fst.3.2)[1:16])
fm3.3R<-sen.rank(print(fst.3.3)[1:16])
fi3.3R<-sen.rank(print(fst.3.3)[17:32]-print(fst.3.3)[1:16])

Rank3<-c(mm3.1R[,3],mm3.2R[,3],mm3.3R[,3],ms3.1R[,3],ms3.2R[,3],ms3.3R[,3],
         fm3.1R[,3],fm3.2R[,3],fm3.3R[,3],fi3.1R[,3],fi3.2R[,3],fi3.3R[,3])
labels3.df3 <- mm2.1R[order(mm3.1R[,3]),] 

#
var<-c(rep("Exh.Morris.mu",16),rep("Bld.Morris.mu",16),rep("Met.Morris.mu",16),rep("Exh.Morris.sig",16),rep("Bld.Morris.sig",16),rep("Met.Morris.sig",16),
       rep("Exh.eFAST.M",16),rep("Bld.eFAST.M",16),rep("Met.eFAST.M",16),rep("Exh.eFAST.I",16),rep("Bld.eFAST.I",16),rep("Met.eFAST.I",16))

q_params<-c(rep(labels,12))

df1 <- data.frame(var, Rank1, q_params) # G1
df2 <- data.frame(var, Rank2, q_params) # G2
df3 <- data.frame(var, Rank3, q_params) # G3

labels2<-c("Exh.Morris.mu", "Bld.Morris.mu","Met.Morris.mu",
           "Exh.Morris.sig","Bld.Morris.sig","Met.Morris.sig",
           "Exh.eFAST.M","Bld.eFAST.M","Met.eFAST.M",
           "Exh.eFAST.I","Bld.eFAST.I","Met.eFAST.I")

colfunc <- colorRampPalette(c("blue", "red"))

mean.rank1<-data.frame(labels); mean.rank1$avg.rank<-""
mean.rank2<-data.frame(labels); mean.rank2$avg.rank<-""
mean.rank3<-data.frame(labels); mean.rank3$avg.rank<-""

#
for(i in 1:16){ # Total mean ranking G1
  mean.rank1[i,2]<-mean(subset(df1, q_params == labels[i])[,2])
}
order.mr1<-mean.rank1[order(-as.numeric(mean.rank1[,2])),] 

for(i in 1:16){ # Total mean ranking G2
  mean.rank2[i,2]<-mean(subset(df2, q_params == labels[i])[,2])
}
order.mr2<-mean.rank2[order(-as.numeric(mean.rank2[,2])),] 

for(i in 1:16){ # Total mean ranking G3
  mean.rank3[i,2]<-mean(subset(df3, q_params == labels[i])[,2])
}
order.mr3<-mean.rank3[order(-as.numeric(mean.rank3[,2])),] 


pdf(file="fig4.pdf", width = 9, height = 8)
par(mfrow=c(3,2), mar=c(5,7,1,1))
# G1
plot(subset(df1, q_params == labels[1])[,2], type="b", col=colfunc(16)[8], 
     axes=FALSE, xlab="",ylab="",
     ylim=c(0,16))
text(c(1:12), -1.2, labels = labels2, srt = 45, adj = c(1.1,1.1), xpd = TRUE, cex=.9)
text(0, c(1.4:16.4), labels = labels3.df1[,1], col=colfunc(16),
     adj = c(1.1,1.1), xpd = TRUE, cex=.9)
axis(1, at=1:12, labels = c(rep("",12)))
axis(2, at=1:16, labels = c(rep("",16)))

lines(subset(df1, q_params == labels[2])[,2], type="b", col=colfunc(16)[mm1.1R[ which(mm1.1R$labels==labels[2]), 3]])
lines(subset(df1, q_params == labels[3])[,2], type="b", col=colfunc(16)[mm1.1R[ which(mm1.1R$labels==labels[3]), 3]])
lines(subset(df1, q_params == labels[4])[,2], type="b", col=colfunc(16)[mm1.1R[ which(mm1.1R$labels==labels[4]), 3]])
lines(subset(df1, q_params == labels[5])[,2], type="b", col=colfunc(16)[mm1.1R[ which(mm1.1R$labels==labels[5]), 3]])
lines(subset(df1, q_params == labels[6])[,2], type="b", col=colfunc(16)[mm1.1R[ which(mm1.1R$labels==labels[6]), 3]])
lines(subset(df1, q_params == labels[7])[,2], type="b", col=colfunc(16)[mm1.1R[ which(mm1.1R$labels==labels[7]), 3]])
lines(subset(df1, q_params == labels[8])[,2], type="b", col=colfunc(16)[mm1.1R[ which(mm1.1R$labels==labels[8]), 3]])
lines(subset(df1, q_params == labels[9])[,2], type="b", col=colfunc(16)[mm1.1R[ which(mm1.1R$labels==labels[9]), 3]])
lines(subset(df1, q_params == labels[10])[,2], type="b", col=colfunc(16)[mm1.1R[ which(mm1.1R$labels==labels[10]), 3]])
lines(subset(df1, q_params == labels[11])[,2], type="b", col=colfunc(16)[mm1.1R[ which(mm1.1R$labels==labels[11]), 3]])
lines(subset(df1, q_params == labels[12])[,2], type="b", col=colfunc(16)[mm1.1R[ which(mm1.1R$labels==labels[12]), 3]])
lines(subset(df1, q_params == labels[13])[,2], type="b", col=colfunc(16)[mm1.1R[ which(mm1.1R$labels==labels[13]), 3]])
lines(subset(df1, q_params == labels[14])[,2], type="b", col=colfunc(16)[mm1.1R[ which(mm1.1R$labels==labels[14]), 3]])
lines(subset(df1, q_params == labels[15])[,2], type="b", col=colfunc(16)[mm1.1R[ which(mm1.1R$labels==labels[15]), 3]])
lines(subset(df1, q_params == labels[16])[,2], type="b", col=colfunc(16)[mm1.1R[ which(mm1.1R$labels==labels[16]), 3]])

# average rank barchart
par(mar=c(5,6,3,3))
bp2.1<-barplot(rev(as.numeric(order.mr1[,2])), ylim = c(0,16), xlab="Ranking",horiz=TRUE)
text(par('usr')[3], bp2.1, labels = rev(order.mr1[,1]), adj = c(1.1,1.1), xpd = TRUE, cex=.9)

# G2
par(mar=c(5,7,1,1))
plot(subset(df2, q_params == labels[1])[,2], type="b", col=colfunc(16)[8], 
     axes=FALSE, xlab="",ylab="",
     ylim=c(0,16))
text(c(1:12), -1.2, labels = labels2, srt = 45, adj = c(1.1,1.1), xpd = TRUE, cex=.9)
text(0, c(1.4:16.4), labels = labels3.df2[,1], col=colfunc(16),
     adj = c(1.1,1.1), xpd = TRUE, cex=.9)
axis(1, at=1:12, labels = c(rep("",12)))
axis(2, at=1:16, labels = c(rep("",16)))

lines(subset(df2, q_params == labels[2])[,2], type="b", col=colfunc(16)[mm2.1R[ which(mm1.1R$labels==labels[2]), 3]])
lines(subset(df2, q_params == labels[3])[,2], type="b", col=colfunc(16)[mm2.1R[ which(mm1.1R$labels==labels[3]), 3]])
lines(subset(df2, q_params == labels[4])[,2], type="b", col=colfunc(16)[mm2.1R[ which(mm1.1R$labels==labels[4]), 3]])
lines(subset(df2, q_params == labels[5])[,2], type="b", col=colfunc(16)[mm2.1R[ which(mm1.1R$labels==labels[5]), 3]])
lines(subset(df2, q_params == labels[6])[,2], type="b", col=colfunc(16)[mm2.1R[ which(mm1.1R$labels==labels[6]), 3]])
lines(subset(df2, q_params == labels[7])[,2], type="b", col=colfunc(16)[mm2.1R[ which(mm1.1R$labels==labels[7]), 3]])
lines(subset(df2, q_params == labels[8])[,2], type="b", col=colfunc(16)[mm2.1R[ which(mm1.1R$labels==labels[8]), 3]])
lines(subset(df2, q_params == labels[9])[,2], type="b", col=colfunc(16)[mm2.1R[ which(mm1.1R$labels==labels[9]), 3]])
lines(subset(df2, q_params == labels[10])[,2], type="b", col=colfunc(16)[mm2.1R[ which(mm1.1R$labels==labels[10]), 3]])
lines(subset(df2, q_params == labels[11])[,2], type="b", col=colfunc(16)[mm2.1R[ which(mm1.1R$labels==labels[11]), 3]])
lines(subset(df2, q_params == labels[12])[,2], type="b", col=colfunc(16)[mm2.1R[ which(mm1.1R$labels==labels[12]), 3]])
lines(subset(df2, q_params == labels[13])[,2], type="b", col=colfunc(16)[mm2.1R[ which(mm1.1R$labels==labels[13]), 3]])
lines(subset(df2, q_params == labels[14])[,2], type="b", col=colfunc(16)[mm2.1R[ which(mm1.1R$labels==labels[14]), 3]])
lines(subset(df2, q_params == labels[15])[,2], type="b", col=colfunc(16)[mm2.1R[ which(mm1.1R$labels==labels[15]), 3]])
lines(subset(df2, q_params == labels[16])[,2], type="b", col=colfunc(16)[mm2.1R[ which(mm1.1R$labels==labels[16]), 3]])

# average rank barchart
par(mar=c(5,6,3,3))
bp2.2<-barplot(rev(as.numeric(order.mr2[,2])), ylim = c(0,16), xlab="Ranking",horiz=TRUE)
text(par('usr')[3], bp2.2, labels = rev(order.mr2[,1]), adj = c(1.1,1.1), xpd = TRUE, cex=.9)


# G3
par(mar=c(5,7,1,1))
plot(subset(df3, q_params == labels[1])[,2], type="b", col=colfunc(16)[8], 
     axes=FALSE, xlab="",ylab="",
     ylim=c(0,16))
text(c(1:12), -1.2, labels = labels2, srt = 45, adj = c(1.1,1.1), xpd = TRUE, cex=.9)
text(0, c(1.4:16.4), labels = labels3.df3[,1], col=colfunc(16),
     adj = c(1.1,1.1), xpd = TRUE, cex=.9)
axis(1, at=1:12, labels = c(rep("",12)))
axis(2, at=1:16, labels = c(rep("",16)))

lines(subset(df3, q_params == labels[2])[,2], type="b", col=colfunc(16)[mm3.1R[ which(mm1.1R$labels==labels[2]), 3]])
lines(subset(df3, q_params == labels[3])[,2], type="b", col=colfunc(16)[mm3.1R[ which(mm1.1R$labels==labels[3]), 3]])
lines(subset(df3, q_params == labels[4])[,2], type="b", col=colfunc(16)[mm3.1R[ which(mm1.1R$labels==labels[4]), 3]])
lines(subset(df3, q_params == labels[5])[,2], type="b", col=colfunc(16)[mm3.1R[ which(mm1.1R$labels==labels[5]), 3]])
lines(subset(df3, q_params == labels[6])[,2], type="b", col=colfunc(16)[mm3.1R[ which(mm1.1R$labels==labels[6]), 3]])
lines(subset(df3, q_params == labels[7])[,2], type="b", col=colfunc(16)[mm3.1R[ which(mm1.1R$labels==labels[7]), 3]])
lines(subset(df3, q_params == labels[8])[,2], type="b", col=colfunc(16)[mm3.1R[ which(mm1.1R$labels==labels[8]), 3]])
lines(subset(df3, q_params == labels[9])[,2], type="b", col=colfunc(16)[mm3.1R[ which(mm1.1R$labels==labels[9]), 3]])
lines(subset(df3, q_params == labels[10])[,2], type="b", col=colfunc(16)[mm3.1R[ which(mm1.1R$labels==labels[10]), 3]])
lines(subset(df3, q_params == labels[11])[,2], type="b", col=colfunc(16)[mm3.1R[ which(mm1.1R$labels==labels[11]), 3]])
lines(subset(df3, q_params == labels[12])[,2], type="b", col=colfunc(16)[mm3.1R[ which(mm1.1R$labels==labels[12]), 3]])
lines(subset(df3, q_params == labels[13])[,2], type="b", col=colfunc(16)[mm3.1R[ which(mm1.1R$labels==labels[13]), 3]])
lines(subset(df3, q_params == labels[14])[,2], type="b", col=colfunc(16)[mm3.1R[ which(mm1.1R$labels==labels[14]), 3]])
lines(subset(df3, q_params == labels[15])[,2], type="b", col=colfunc(16)[mm3.1R[ which(mm1.1R$labels==labels[15]), 3]])
lines(subset(df3, q_params == labels[16])[,2], type="b", col=colfunc(16)[mm3.1R[ which(mm1.1R$labels==labels[16]), 3]])

# average rank barchart
par(mar=c(5,6,3,3))
bp2.3<-barplot(rev(as.numeric(order.mr3[,2])), ylim = c(0,16), xlab="Ranking",horiz=TRUE)
text(par('usr')[3], bp2.3, labels = rev(order.mr3[,1]), adj = c(1.1,1.1), xpd = TRUE, cex=.9)
dev.off()
