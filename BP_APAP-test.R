# Need file
# apap.setpoint.all.in
# apap_compare_plt.R
# apap.pbpk_v2.model
# !!!Remember to compile apap.pbpk_v2.model

rm(list=ls())

if(!require(readr)) {
  install.packages("readr"); require(readr)
}
if(!require(data.table)) {
  install.packages("data.table"); require(data.table)
}

APAP_58.1 <- as.data.frame(read_table2("apap58.c01.out"))
test.data<-tail(APAP_58.1, 1)
j<-2:59
df0<-data.frame(test.data[,j])

# Baseline
write.table(df0, file="apap.setpt.dat", row.names=TRUE, sep="\t")
system("./mcsim.apap.pbpk_v2 apap.setpt58-test.in")
all.0<-data.frame(fread(("apap.setpt58.out")))

t<-seq(0.01, 10.11, 0.1)


all.0.1<-exp(all.0[which(colnames(all.0)=="lnCPL_APAP_mcgL_1.1"):which(colnames(all.0)=="lnCPL_APAP_mcgL_1.102")])/1000 # Extract output
all.0.2<-exp(all.0[which(colnames(all.0)=="lnCPL_AG_mcgL_1.1"):which(colnames(all.0)=="lnCPL_AG_mcgL_1.102")])/1000 # Extract output
all.0.3<-exp(all.0[which(colnames(all.0)=="lnCPL_AS_mcgL_1.1"):which(colnames(all.0)=="lnCPL_AS_mcgL_1.102")])/1000 # Extract output

# BP_APAP 110%
df1<-df0
df1[which(colnames(df0)=="M_lnBP_APAP.1.")]<-log(exp(df0[which(colnames(df0)=="M_lnBP_APAP.1.")])*1.1)

write.table(df1, file="apap.setpt.dat", row.names=TRUE, sep="\t")
system("./mcsim.apap.pbpk_v2 apap.setpt58-test.in")
all.1<-data.frame(fread(("apap.setpt58.out")))

all.1.1<-exp(all.1[which(colnames(all.1)=="lnCPL_APAP_mcgL_1.1"):which(colnames(all.1)=="lnCPL_APAP_mcgL_1.102")])/1000
all.1.2<-exp(all.1[which(colnames(all.1)=="lnCPL_AG_mcgL_1.1"):which(colnames(all.1)=="lnCPL_AG_mcgL_1.102")])/1000
all.1.3<-exp(all.1[which(colnames(all.1)=="lnCPL_AS_mcgL_1.1"):which(colnames(all.1)=="lnCPL_AS_mcgL_1.102")])/1000

# BP_APAP 90%
df2<-df0
df2[which(colnames(df0)=="M_lnBP_APAP.1.")]<-log(exp(df0[which(colnames(df0)=="M_lnBP_APAP.1.")])*0.9)

write.table(df2, file="apap.setpt.dat", row.names=TRUE, sep="\t")
system("./mcsim.apap.pbpk_v2 apap.setpt58-test.in")
all.2<-data.frame(fread(("apap.setpt58.out")))

all.2.1<-exp(all.2[which(colnames(all.2)=="lnCPL_APAP_mcgL_1.1"):which(colnames(all.2)=="lnCPL_APAP_mcgL_1.102")])/1000
all.2.2<-exp(all.2[which(colnames(all.2)=="lnCPL_AG_mcgL_1.1"):which(colnames(all.2)=="lnCPL_AG_mcgL_1.102")])/1000
all.2.3<-exp(all.2[which(colnames(all.2)=="lnCPL_AS_mcgL_1.1"):which(colnames(all.2)=="lnCPL_AS_mcgL_1.102")])/1000

# CLC_APAP 110%
df3<-df0
df3[which(colnames(df3)=="M_lnCLC_APAP.1.")]<-log(exp(df3[which(colnames(df3)=="M_lnCLC_APAP.1.")])*1.1)

write.table(df3, file="apap.setpt.dat", row.names=TRUE, sep="\t")
system("./mcsim.apap.pbpk_v2 apap.setpt58-test.in")
all.3<-data.frame(fread(("apap.setpt58.out")))

all.3.1<-exp(all.1[which(colnames(all.3)=="lnCPL_APAP_mcgL_1.1"):which(colnames(all.3)=="lnCPL_APAP_mcgL_1.102")])/1000
all.3.2<-exp(all.1[which(colnames(all.3)=="lnCPL_AG_mcgL_1.1"):which(colnames(all.3)=="lnCPL_AG_mcgL_1.102")])/1000
all.3.3<-exp(all.1[which(colnames(all.3)=="lnCPL_AS_mcgL_1.1"):which(colnames(all.3)=="lnCPL_AS_mcgL_1.102")])/1000

# CLC_APAP 90%
df4<-df0
df4[which(colnames(df4)=="M_lnCLC_APAP.1.")]<-log(exp(df4[which(colnames(df4)=="M_lnCLC_APAP.1.")])*0.9)

write.table(df4, file="apap.setpt.dat", row.names=TRUE, sep="\t")
system("./mcsim.apap.pbpk_v2 apap.setpt58-test.in")
all.4<-data.frame(fread(("apap.setpt58.out")))

all.4.1<-exp(all.4[which(colnames(all.4)=="lnCPL_APAP_mcgL_1.1"):which(colnames(all.4)=="lnCPL_APAP_mcgL_1.102")])/1000
all.4.2<-exp(all.4[which(colnames(all.4)=="lnCPL_AG_mcgL_1.1"):which(colnames(all.4)=="lnCPL_AG_mcgL_1.102")])/1000
all.4.3<-exp(all.4[which(colnames(all.4)=="lnCPL_AS_mcgL_1.1"):which(colnames(all.4)=="lnCPL_AS_mcgL_1.102")])/1000





# plot
jpeg(file="figs12.jpg",width=3600,height=1000,res=300)
par(mfrow=c(1,3), mar=c(2,2,1,1), oma=c(3,3,0,0))
plot(t, all.0.1, type = "l", ylim=c(0,4), xlab="", ylab="")
lines(t, all.1.1, col=2, lty=5, lwd=2)
lines(t, all.2.1, col=2, lty=5, lwd=2)
lines(t, all.3.1, col=3, lty=3, lwd=3)
lines(t, all.4.1, col=3, lty=3, lwd=3)
text(1.5, 4, "A  APAP", cex=1.5)
     
legend("topright",c("Baseline prediction","10% BP_APAP change", "10% CLC_APAP change"),
       lty=c(1,5,3),lwd=c(1,2,3),col=c(1,2,3))

plot(t, all.0.2, type = "l", ylim=c(0,4), xlab="", ylab="")
lines(t, all.1.2, col=2, lty=5, lwd=2)
lines(t, all.2.2, col=2, lty=5, lwd=2)
lines(t, all.3.2, col=3, lty=3, lwd=3)
lines(t, all.4.2, col=3, lty=3, lwd=3)
text(1.5, 4, "B  APAP-G", cex=1.5)

plot(t, all.0.3, type = "l", ylim=c(0,4), xlab="", ylab="")
lines(t, all.1.3, col=2, lty=5, lwd=2)
lines(t, all.2.3, col=2, lty=5, lwd=2)
lines(t, all.3.3, col=3, lty=3, lwd=3)
lines(t, all.4.3, col=3, lty=3, lwd=3)
text(1.5, 4, "C  APAP-S", cex=1.5)

mtext("Time (hr)", SOUTH<-1, line=1, adj=0.5, outer=TRUE)
mtext(expression("Plasma concentration, "~mu*g/L), WEST<-2, line=1, adj=0.6, outer=TRUE) 
dev.off()
