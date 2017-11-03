# Need file
# apap.setpoint.all.in
# apap_compare_plt.R
# apap.pbpk_v2.model
# !!!Remember to compile apap.pbpk_v2.model

#0705
source("APAP_post.R") # load posterior
source("apap_data.R") # load data

# Create function to make dataframe
if(!require(data.table)) {
  install.packages("data.table"); require(data.table)}
if(!require(reshape2)) { #melt
  install.packages("reshape2"); require(reshape2)}
if(!require(PerformanceAnalytics)) { #kurtosis
  install.packages("PerformanceAnalytics"); require(PerformanceAnalytics)}

org<-rbind(tail(APAP_21.1, 25), tail(APAP_21.2, 25), tail(APAP_21.3, 25), tail(APAP_21.4, 25))
sen<-rbind(tail(APAP_14.1, 25), tail(APAP_14.2, 25), tail(APAP_14.3, 25), tail(APAP_14.4, 25))
add<-rbind(tail(APAP_19.1, 25), tail(APAP_19.2, 25), tail(APAP_19.3, 25), tail(APAP_19.4, 25))

setpt21.df<-function(data, par1st, parlast){
  sim.str<-which(colnames(data)==par1st)
  sim.end<-which(colnames(data)==parlast)
  j<-sim.str:sim.end
  
  df0<-data.frame(data[,j])
  
  write.table(df0, file="apap.setpt.dat", row.names=TRUE, sep="\t")
  system("./mcsim.apap.pbpk_v2 apap.setpt21.in")
  data.frame(fread(("apap.setpt21.out")))
}

org.1<-setpt21.df(org, "lnTg(1.1)","lnCLC_AS(1.1)") # Do analysis
org.1.1<-org.1[which(colnames(org.1)=="lnCPL_APAP_mcgL_1.1"):which(colnames(org.1)=="lnCPL_AS_mcgL_1.10")] # Extract output
org.2<-setpt21.df(org, "lnTg(1.2)","lnCLC_AS(1.2)") # Do analysis
org.2.1<-org.2[which(colnames(org.2)=="lnCPL_APAP_mcgL_2.1"):which(colnames(org.2)=="lnCPL_AS_mcgL_2.11")] # Extract output
org.3<-setpt21.df(org, "lnTg(1.3)","lnCLC_AS(1.3)") # Do analysis
org.3.1<-org.3[which(colnames(org.3)=="lnCPL_APAP_mcgL_3.1"):which(colnames(org.3)=="lnCPL_AS_mcgL_3.8")] # Extract output
org.4<-setpt21.df(org, "lnTg(1.4)","lnCLC_AS(1.4)") # Do analysis
org.4.1<-org.4[which(colnames(org.4)=="lnCPL_APAP_mcgL_4.1"):which(colnames(org.4)=="lnCPL_AS_mcgL_4.10")] # Extract output
org.5<-setpt21.df(org, "lnTg(1.5)","lnCLC_AS(1.5)") # Do analysis
org.5.1<-org.5[which(colnames(org.5)=="lnCPL_APAP_mcgL_5.1"):which(colnames(org.5)=="lnCPL_AS_mcgL_5.10")] # Extract output
org.6<-setpt21.df(org, "lnTg(1.6)","lnCLC_AS(1.6)") # Do analysis
org.6.1<-org.6[which(colnames(org.6)=="lnCPL_APAP_mcgL_6.1"):which(colnames(org.6)=="lnCPL_AS_mcgL_6.10")] # Extract output
org.7<-setpt21.df(org, "lnTg(1.7)","lnCLC_AS(1.7)") # Do analysis
org.7.1<-org.7[which(colnames(org.7)=="lnCPL_APAP_mcgL_7.1"):which(colnames(org.7)=="lnCPL_AS_mcgL_7.12")] # Extract output
org.8<-setpt21.df(org, "lnTg(1.8)","lnCLC_AS(1.8)") # Do analysis
org.8.1<-org.8[which(colnames(org.8)=="lnCPL_APAP_mcgL_8.1"):which(colnames(org.8)=="lnCPL_AS_mcgL_8.11")] # Extract output

#
setpt14.df<-function(data, par1st, parlast){
  sim.str<-which(colnames(data)==par1st)
  sim.end<-which(colnames(data)==parlast)
  j<-sim.str:sim.end
  
  df0<-data.frame(data[,j])
  
  write.table(df0, file="apap.setpt.dat", row.names=TRUE, sep="\t")
  system("./mcsim.apap.pbpk_v2 apap.setpt14s.in")
  data.frame(fread(("apap.setpt14s.out")))
}

sen.1<-setpt14.df(sen, "lnTg(1.1)","lnCLC_AS(1.1)") # Do analysis
sen.1.1<-sen.1[which(colnames(sen.1)=="lnCPL_APAP_mcgL_1.1"):which(colnames(sen.1)=="lnCPL_AS_mcgL_1.10")] # Extract output
sen.2<-setpt14.df(sen, "lnTg(1.2)","lnCLC_AS(1.2)") # Do analysis
sen.2.1<-sen.2[which(colnames(sen.2)=="lnCPL_APAP_mcgL_2.1"):which(colnames(sen.2)=="lnCPL_AS_mcgL_2.11")] # Extract output
sen.3<-setpt14.df(sen, "lnTg(1.3)","lnCLC_AS(1.3)") # Do analysis
sen.3.1<-sen.3[which(colnames(sen.3)=="lnCPL_APAP_mcgL_3.1"):which(colnames(sen.3)=="lnCPL_AS_mcgL_3.8")] # Extract output
sen.4<-setpt14.df(sen, "lnTg(1.4)","lnCLC_AS(1.4)") # Do analysis
sen.4.1<-sen.4[which(colnames(sen.4)=="lnCPL_APAP_mcgL_4.1"):which(colnames(sen.4)=="lnCPL_AS_mcgL_4.10")] # Extract output
sen.5<-setpt14.df(sen, "lnTg(1.5)","lnCLC_AS(1.5)") # Do analysis
sen.5.1<-sen.5[which(colnames(sen.5)=="lnCPL_APAP_mcgL_5.1"):which(colnames(sen.5)=="lnCPL_AS_mcgL_5.10")] # Extract output
sen.6<-setpt14.df(sen, "lnTg(1.6)","lnCLC_AS(1.6)") # Do analysis
sen.6.1<-sen.6[which(colnames(sen.6)=="lnCPL_APAP_mcgL_6.1"):which(colnames(sen.6)=="lnCPL_AS_mcgL_6.10")] # Extract output
sen.7<-setpt14.df(sen, "lnTg(1.7)","lnCLC_AS(1.7)") # Do analysis
sen.7.1<-sen.7[which(colnames(sen.7)=="lnCPL_APAP_mcgL_7.1"):which(colnames(sen.7)=="lnCPL_AS_mcgL_7.12")] # Extract output
sen.8<-setpt14.df(sen, "lnTg(1.8)","lnCLC_AS(1.8)") # Do analysis
sen.8.1<-sen.8[which(colnames(sen.8)=="lnCPL_APAP_mcgL_8.1"):which(colnames(sen.8)=="lnCPL_AS_mcgL_8.11")] # Extract output

#
setpt19.df<-function(data, par1st, parlast){
  sim.str<-which(colnames(data)==par1st)
  sim.end<-which(colnames(data)==parlast)
  j<-sim.str:sim.end
  
  df0<-data.frame(data[,j])
  
  write.table(df0, file="apap.setpt.dat", row.names=TRUE, sep="\t")
  system("./mcsim.apap.pbpk_v2 apap.setpt19s.in")
  data.frame(fread(("apap.setpt19s.out")))
}

add.1<-setpt19.df(add, "lnTg(1.1)","lnPM_APAP(1.1)") # Do analysis
add.1.1<-add.1[which(colnames(add.1)=="lnCPL_APAP_mcgL_1.1"):which(colnames(add.1)=="lnCPL_AS_mcgL_1.10")] # Extract output
add.2<-setpt19.df(add, "lnTg(1.2)","lnPM_APAP(1.2)") # Do analysis
add.2.1<-add.2[which(colnames(add.2)=="lnCPL_APAP_mcgL_2.1"):which(colnames(add.2)=="lnCPL_AS_mcgL_2.11")] # Extract output
add.3<-setpt19.df(add, "lnTg(1.3)","lnPM_APAP(1.3)") # Do analysis
add.3.1<-add.3[which(colnames(add.3)=="lnCPL_APAP_mcgL_3.1"):which(colnames(add.3)=="lnCPL_AS_mcgL_3.8")] # Extract output
add.4<-setpt19.df(add, "lnTg(1.4)","lnPM_APAP(1.4)") # Do analysis
add.4.1<-add.4[which(colnames(add.4)=="lnCPL_APAP_mcgL_4.1"):which(colnames(add.4)=="lnCPL_AS_mcgL_4.10")] # Extract output
add.5<-setpt19.df(add, "lnTg(1.5)","lnPM_APAP(1.5)") # Do analysis
add.5.1<-add.5[which(colnames(add.5)=="lnCPL_APAP_mcgL_5.1"):which(colnames(add.5)=="lnCPL_AS_mcgL_5.10")] # Extract output
add.6<-setpt19.df(add, "lnTg(1.6)","lnPM_APAP(1.6)") # Do analysis
add.6.1<-add.6[which(colnames(add.6)=="lnCPL_APAP_mcgL_6.1"):which(colnames(add.6)=="lnCPL_AS_mcgL_6.10")] # Extract output
add.7<-setpt19.df(add, "lnTg(1.7)","lnPM_APAP(1.7)") # Do analysis
add.7.1<-add.7[which(colnames(add.7)=="lnCPL_APAP_mcgL_7.1"):which(colnames(add.7)=="lnCPL_AS_mcgL_7.12")] # Extract output
add.8<-setpt19.df(add, "lnTg(1.8)","lnPM_APAP(1.8)") # Do analysis
add.8.1<-add.8[which(colnames(add.8)=="lnCPL_APAP_mcgL_8.1"):which(colnames(add.8)=="lnCPL_AS_mcgL_8.11")] # Extract output



R2 <- function(obs, prd){
  1 - (sum((obs-prd)^2, na.rm=TRUE)/sum((obs-mean(obs, na.rm=TRUE))^2, na.rm=TRUE))
}

j08<-1:8;k08<-9:16;l08<-17:24;
j10<-1:10;k10<-11:20;l10<-21:30
j11<-1:11;k11<-12:22;l11<-23:33
j12<-1:12;k12<-13:24;l12<-25:36


# r-square
obs.1<-melt(APAP.1, id.vars = "Time")
prd.o.1<-c(apply(org.1.1[,j10], 2, median), apply(org.1.1[,k10], 2, median), apply(org.1.1[,l10], 2, median))
prd.s.1<-c(apply(sen.1.1[,j10], 2, median), apply(sen.1.1[,k10], 2, median), apply(sen.1.1[,l10], 2, median))
prd.d.1<-c(apply(add.1.1[,j10], 2, median), apply(add.1.1[,k10], 2, median), apply(add.1.1[,l10], 2, median))

df.1<-data.frame(obs.1, prd.o.1, prd.s.1, prd.d.1)

obs.2<-melt(APAP.2, id.vars = "Time")
prd.o.2<-c(apply(org.2.1[,j11], 2, median), apply(org.2.1[,k11], 2, median), apply(org.2.1[,l11], 2, median))
prd.s.2<-c(apply(sen.2.1[,j11], 2, median), apply(sen.2.1[,k11], 2, median), apply(sen.2.1[,l11], 2, median))
prd.d.2<-c(apply(add.2.1[,j11], 2, median), apply(add.2.1[,k11], 2, median), apply(add.2.1[,l11], 2, median))
df.2<-data.frame(obs.2, prd.o.2, prd.s.2, prd.d.2)

obs.3<-melt(APAP.3, id.vars = "Time")
prd.o.3<-c(apply(org.3.1[,j08], 2, median), apply(org.3.1[,k08], 2, median), apply(org.3.1[,l08], 2, median))
prd.s.3<-c(apply(sen.3.1[,j08], 2, median), apply(sen.3.1[,k08], 2, median), apply(sen.3.1[,l08], 2, median))
prd.d.3<-c(apply(add.3.1[,j08], 2, median), apply(add.3.1[,k08], 2, median), apply(add.3.1[,l08], 2, median))
df.3<-data.frame(obs.3, prd.o.3, prd.s.3, prd.d.3)

obs.4<-melt(APAP.4, id.vars = "Time")
prd.o.4<-c(apply(org.4.1[,j10], 2, median), apply(org.4.1[,k10], 2, median), apply(org.4.1[,l10], 2, median))
prd.s.4<-c(apply(sen.4.1[,j10], 2, median), apply(sen.4.1[,k10], 2, median), apply(sen.4.1[,l10], 2, median))
prd.d.4<-c(apply(add.4.1[,j10], 2, median), apply(add.4.1[,k10], 2, median), apply(add.4.1[,l10], 2, median))
df.4<-data.frame(obs.4, prd.o.4, prd.s.4, prd.d.4)

obs.5<-melt(APAP.5, id.vars = "Time")
prd.o.5<-c(apply(org.5.1[,j10], 2, median), apply(org.5.1[,k10], 2, median), apply(org.5.1[,l10], 2, median))
prd.s.5<-c(apply(sen.5.1[,j10], 2, median), apply(sen.5.1[,k10], 2, median), apply(sen.5.1[,l10], 2, median))
prd.d.5<-c(apply(add.5.1[,j10], 2, median), apply(add.5.1[,k10], 2, median), apply(add.5.1[,l10], 2, median))
df.5<-data.frame(obs.5, prd.o.5, prd.s.5, prd.d.5)

obs.6<-melt(APAP.6, id.vars = "Time")
prd.o.6<-c(apply(org.6.1[,j10], 2, median), apply(org.6.1[,k10], 2, median), apply(org.6.1[,l10], 2, median))
prd.s.6<-c(apply(sen.6.1[,j10], 2, median), apply(sen.6.1[,k10], 2, median), apply(sen.6.1[,l10], 2, median))
prd.d.6<-c(apply(add.6.1[,j10], 2, median), apply(add.6.1[,k10], 2, median), apply(add.6.1[,l10], 2, median))
df.6<-data.frame(obs.6, prd.o.6, prd.s.6, prd.d.6)

obs.7<-melt(APAP.7, id.vars = "Time")
prd.o.7<-c(apply(org.7.1[,j12], 2, median), apply(org.7.1[,k12], 2, median), apply(org.7.1[,l12], 2, median))
prd.s.7<-c(apply(sen.7.1[,j12], 2, median), apply(sen.7.1[,k12], 2, median), apply(sen.7.1[,l12], 2, median))
prd.d.7<-c(apply(add.7.1[,j12], 2, median), apply(add.7.1[,k12], 2, median), apply(add.7.1[,l12], 2, median))
df.7<-data.frame(obs.7, prd.o.7, prd.s.7, prd.d.7)

obs.8<-melt(APAP.8, id.vars = "Time")
prd.o.8<-c(apply(org.8.1[,j11], 2, median), apply(org.8.1[,k11], 2, median), apply(org.8.1[,l11], 2, median))
prd.s.8<-c(apply(sen.8.1[,j11], 2, median), apply(sen.8.1[,k11], 2, median), apply(sen.8.1[,l11], 2, median))
prd.d.8<-c(apply(add.8.1[,j11], 2, median), apply(add.8.1[,k11], 2, median), apply(add.8.1[,l11], 2, median))
df.8<-data.frame(obs.8, prd.o.8, prd.s.8, prd.d.8)





# 
options(digits=3)
R2(obs.1$value, as.numeric(prd.o.1)) 
R2(obs.1$value, as.numeric(prd.s.1)) 
R2(obs.1$value, as.numeric(prd.d.1))
#R2(obs.1.1$value, as.numeric(prd.o.1.1)) 

R2(obs.2$value, as.numeric(prd.o.2)) #0.978

R2(obs.3$value, as.numeric(prd.o.3)) 

R2(obs.4$value, as.numeric(prd.o.4)) 

R2(obs.5$value, as.numeric(prd.o.5)) 

R2(obs.6$value, as.numeric(prd.o.6)) 

R2(obs.7$value, as.numeric(prd.o.7)) 

R2(obs.8$value, as.numeric(prd.o.8)) 
