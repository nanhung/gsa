# Need file
# apap.setpoint.all.in
# apap_compare_plt.R
# apap.pbpk_v2.model
# !!!Remember to compile apap.pbpk_v2.model

if(!require(readr)) {
  install.packages("readr"); require(readr)
}
if(!require(data.table)) {
  install.packages("data.table"); require(data.table)
}

# 21 Original parameters
APAP_21.1 <- as.data.frame(read_table2("apap21.c01.out"))
APAP_21.2 <- as.data.frame(read_table2("apap21.c02.out"))
APAP_21.3 <- as.data.frame(read_table2("apap21.c03.out"))
APAP_21.4 <- as.data.frame(read_table2("apap21.c04.out"))

# 11 Sensitivity parameters
APAP_11.1 <- as.data.frame(read_table2("apap11s.c01.out"))
APAP_11.2 <- as.data.frame(read_table2("apap11s.c02.out"))
APAP_11.3 <- as.data.frame(read_table2("apap11s.c03.out"))
APAP_11.4 <- as.data.frame(read_table2("apap11s.c04.out"))

# 20 Sensitivity parameters
APAP_20.1 <- as.data.frame(read_table2("apap20d.c01.out"))
APAP_20.2 <- as.data.frame(read_table2("apap20d.c02.out"))
APAP_20.3 <- as.data.frame(read_table2("apap20d.c03.out"))
APAP_20.4 <- as.data.frame(read_table2("apap20d.c04.out"))

# 58  parameters
APAP_58.1 <- as.data.frame(read_table2("apap58.c01.out"))
APAP_58.2 <- as.data.frame(read_table2("apap58.c02.out"))
APAP_58.3 <- as.data.frame(read_table2("apap58.c03.out"))
APAP_58.4 <- as.data.frame(read_table2("apap58.c04.out"))

# 10  parameters
APAP_10.1 <- as.data.frame(read_table2("apap10d.c01.out"))
APAP_10.2 <- as.data.frame(read_table2("apap10d.c02.out"))
APAP_10.3 <- as.data.frame(read_table2("apap10d.c03.out"))
APAP_10.4 <- as.data.frame(read_table2("apap10d.c04.out"))


#
source("apap_data.R") # load data

# Create function to make dataframe
if(!require(data.table)) {
  install.packages("data.table"); require(data.table)}
if(!require(reshape2)) { #melt
  install.packages("reshape2"); require(reshape2)}
if(!require(PerformanceAnalytics)) { #kurtosis
  install.packages("PerformanceAnalytics"); require(PerformanceAnalytics)}

org<-rbind(tail(APAP_21.1, 25), tail(APAP_21.2, 25), tail(APAP_21.3, 25), tail(APAP_21.4, 25))
sen<-rbind(tail(APAP_11.1, 25), tail(APAP_11.2, 25), tail(APAP_11.3, 25), tail(APAP_11.4, 25))
add<-rbind(tail(APAP_20.1, 25), tail(APAP_20.2, 25), tail(APAP_20.3, 25), tail(APAP_20.4, 25))
all<-rbind(tail(APAP_58.1, 25), tail(APAP_58.2, 25), tail(APAP_58.3, 25), tail(APAP_58.4, 25))

add2<-rbind(tail(APAP_10.1, 25), tail(APAP_10.2, 25), tail(APAP_10.3, 25), tail(APAP_10.4, 25))


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
setpt11.df<-function(data, par1st, parlast){
  sim.str<-which(colnames(data)==par1st)
  sim.end<-which(colnames(data)==parlast)
  j<-sim.str:sim.end
  
  df0<-data.frame(data[,j])
  
  write.table(df0, file="apap.setpt.dat", row.names=TRUE, sep="\t")
  system("./mcsim.apap.pbpk_v2 apap.setpt11s.in")
  data.frame(fread(("apap.setpt11s.out")))
}

sen.1<-setpt11.df(sen, "lnTg(1.1)","lnCLC_AS(1.1)") # Do analysis
sen.1.1<-sen.1[which(colnames(sen.1)=="lnCPL_APAP_mcgL_1.1"):which(colnames(sen.1)=="lnCPL_AS_mcgL_1.10")] # Extract output
sen.2<-setpt11.df(sen, "lnTg(1.2)","lnCLC_AS(1.2)") # Do analysis
sen.2.1<-sen.2[which(colnames(sen.2)=="lnCPL_APAP_mcgL_2.1"):which(colnames(sen.2)=="lnCPL_AS_mcgL_2.11")] # Extract output
sen.3<-setpt11.df(sen, "lnTg(1.3)","lnCLC_AS(1.3)") # Do analysis
sen.3.1<-sen.3[which(colnames(sen.3)=="lnCPL_APAP_mcgL_3.1"):which(colnames(sen.3)=="lnCPL_AS_mcgL_3.8")] # Extract output
sen.4<-setpt11.df(sen, "lnTg(1.4)","lnCLC_AS(1.4)") # Do analysis
sen.4.1<-sen.4[which(colnames(sen.4)=="lnCPL_APAP_mcgL_4.1"):which(colnames(sen.4)=="lnCPL_AS_mcgL_4.10")] # Extract output
sen.5<-setpt11.df(sen, "lnTg(1.5)","lnCLC_AS(1.5)") # Do analysis
sen.5.1<-sen.5[which(colnames(sen.5)=="lnCPL_APAP_mcgL_5.1"):which(colnames(sen.5)=="lnCPL_AS_mcgL_5.10")] # Extract output
sen.6<-setpt11.df(sen, "lnTg(1.6)","lnCLC_AS(1.6)") # Do analysis
sen.6.1<-sen.6[which(colnames(sen.6)=="lnCPL_APAP_mcgL_6.1"):which(colnames(sen.6)=="lnCPL_AS_mcgL_6.10")] # Extract output
sen.7<-setpt11.df(sen, "lnTg(1.7)","lnCLC_AS(1.7)") # Do analysis
sen.7.1<-sen.7[which(colnames(sen.7)=="lnCPL_APAP_mcgL_7.1"):which(colnames(sen.7)=="lnCPL_AS_mcgL_7.12")] # Extract output
sen.8<-setpt11.df(sen, "lnTg(1.8)","lnCLC_AS(1.8)") # Do analysis
sen.8.1<-sen.8[which(colnames(sen.8)=="lnCPL_APAP_mcgL_8.1"):which(colnames(sen.8)=="lnCPL_AS_mcgL_8.11")] # Extract output

#
setpt20.df<-function(data, par1st, parlast){
  sim.str<-which(colnames(data)==par1st)
  sim.end<-which(colnames(data)==parlast)
  j<-sim.str:sim.end
  
  df0<-data.frame(data[,j])
  
  write.table(df0, file="apap.setpt.dat", row.names=TRUE, sep="\t")
  system("./mcsim.apap.pbpk_v2 apap.setpt20d.in")
  data.frame(fread(("apap.setpt20d.out")))
}

add.1<-setpt20.df(add, "lnTg(1.1)","lnPM_APAP(1.1)") # Do analysis
add.1.1<-add.1[which(colnames(add.1)=="lnCPL_APAP_mcgL_1.1"):which(colnames(add.1)=="lnCPL_AS_mcgL_1.10")] # Extract output
add.2<-setpt20.df(add, "lnTg(1.2)","lnPM_APAP(1.2)") # Do analysis
add.2.1<-add.2[which(colnames(add.2)=="lnCPL_APAP_mcgL_2.1"):which(colnames(add.2)=="lnCPL_AS_mcgL_2.11")] # Extract output
add.3<-setpt20.df(add, "lnTg(1.3)","lnPM_APAP(1.3)") # Do analysis
add.3.1<-add.3[which(colnames(add.3)=="lnCPL_APAP_mcgL_3.1"):which(colnames(add.3)=="lnCPL_AS_mcgL_3.8")] # Extract output
add.4<-setpt20.df(add, "lnTg(1.4)","lnPM_APAP(1.4)") # Do analysis
add.4.1<-add.4[which(colnames(add.4)=="lnCPL_APAP_mcgL_4.1"):which(colnames(add.4)=="lnCPL_AS_mcgL_4.10")] # Extract output
add.5<-setpt20.df(add, "lnTg(1.5)","lnPM_APAP(1.5)") # Do analysis
add.5.1<-add.5[which(colnames(add.5)=="lnCPL_APAP_mcgL_5.1"):which(colnames(add.5)=="lnCPL_AS_mcgL_5.10")] # Extract output
add.6<-setpt20.df(add, "lnTg(1.6)","lnPM_APAP(1.6)") # Do analysis
add.6.1<-add.6[which(colnames(add.6)=="lnCPL_APAP_mcgL_6.1"):which(colnames(add.6)=="lnCPL_AS_mcgL_6.10")] # Extract output
add.7<-setpt20.df(add, "lnTg(1.7)","lnPM_APAP(1.7)") # Do analysis
add.7.1<-add.7[which(colnames(add.7)=="lnCPL_APAP_mcgL_7.1"):which(colnames(add.7)=="lnCPL_AS_mcgL_7.12")] # Extract output
add.8<-setpt20.df(add, "lnTg(1.8)","lnPM_APAP(1.8)") # Do analysis
add.8.1<-add.8[which(colnames(add.8)=="lnCPL_APAP_mcgL_8.1"):which(colnames(add.8)=="lnCPL_AS_mcgL_8.11")] # Extract output

#
setpt58.df<-function(data, par1st, parlast){
  sim.str<-which(colnames(data)==par1st)
  sim.end<-which(colnames(data)==parlast)
  j<-sim.str:sim.end
  
  df0<-data.frame(data[,j])
  
  write.table(df0, file="apap.setpt.dat", row.names=TRUE, sep="\t")
  system("./mcsim.apap.pbpk_v2 apap.setpt58.in")
  data.frame(fread(("apap.setpt58.out")))
}

all.1<-setpt58.df(all, "lnTg(1.1)","lnPS_AS(1.1)") # Do analysis
all.1.1<-all.1[which(colnames(all.1)=="lnCPL_APAP_mcgL_1.1"):which(colnames(all.1)=="lnCPL_AS_mcgL_1.10")] # Extract output
all.2<-setpt58.df(all, "lnTg(1.2)","lnPS_AS(1.2)") # Do analysis
all.2.1<-all.2[which(colnames(all.2)=="lnCPL_APAP_mcgL_2.1"):which(colnames(all.2)=="lnCPL_AS_mcgL_2.11")] # Extract output
all.3<-setpt58.df(all, "lnTg(1.3)","lnPS_AS(1.3)") # Do analysis
all.3.1<-all.3[which(colnames(all.3)=="lnCPL_APAP_mcgL_3.1"):which(colnames(all.3)=="lnCPL_AS_mcgL_3.8")] # Extract output
all.4<-setpt58.df(all, "lnTg(1.4)","lnPS_AS(1.4)") # Do analysis
all.4.1<-all.4[which(colnames(all.4)=="lnCPL_APAP_mcgL_4.1"):which(colnames(all.4)=="lnCPL_AS_mcgL_4.10")] # Extract output
all.5<-setpt58.df(all, "lnTg(1.5)","lnPS_AS(1.5)") # Do analysis
all.5.1<-all.5[which(colnames(all.5)=="lnCPL_APAP_mcgL_5.1"):which(colnames(all.5)=="lnCPL_AS_mcgL_5.10")] # Extract output
all.6<-setpt58.df(all, "lnTg(1.6)","lnPS_AS(1.6)") # Do analysis
all.6.1<-all.6[which(colnames(all.6)=="lnCPL_APAP_mcgL_6.1"):which(colnames(all.6)=="lnCPL_AS_mcgL_6.10")] # Extract output
all.7<-setpt58.df(all, "lnTg(1.7)","lnPS_AS(1.7)") # Do analysis
all.7.1<-all.7[which(colnames(all.7)=="lnCPL_APAP_mcgL_7.1"):which(colnames(all.7)=="lnCPL_AS_mcgL_7.12")] # Extract output
all.8<-setpt58.df(all, "lnTg(1.8)","lnPS_AS(1.8)") # Do analysis
all.8.1<-all.8[which(colnames(all.8)=="lnCPL_APAP_mcgL_8.1"):which(colnames(all.8)=="lnCPL_AS_mcgL_8.11")] # Extract output

#
setpt10.df<-function(data, par1st, parlast){
  sim.str<-which(colnames(data)==par1st)
  sim.end<-which(colnames(data)==parlast)
  j<-sim.str:sim.end
  
  df0<-data.frame(data[,j])
  
  write.table(df0, file="apap.setpt.dat", row.names=TRUE, sep="\t")
  system("./mcsim.apap.pbpk_v2 apap.setpt10d.in")
  data.frame(fread(("apap.setpt10d.out")))
}

add2.1<-setpt10.df(add2, "lnSULT_VmaxC(1.1)","lnBP_APAP(1.1)") # Do analysis
add2.1.1<-add2.1[which(colnames(add2.1)=="lnCPL_APAP_mcgL_1.1"):which(colnames(add2.1)=="lnCPL_AS_mcgL_1.10")] # Extract output
add2.2<-setpt10.df(add2, "lnSULT_VmaxC(1.2)","lnBP_APAP(1.2)") # Do analysis
add2.2.1<-add2.2[which(colnames(add2.2)=="lnCPL_APAP_mcgL_2.1"):which(colnames(add2.2)=="lnCPL_AS_mcgL_2.11")] # Extract output
add2.3<-setpt10.df(add2, "lnSULT_VmaxC(1.3)","lnBP_APAP(1.3)") # Do analysis
add2.3.1<-add2.3[which(colnames(add2.3)=="lnCPL_APAP_mcgL_3.1"):which(colnames(add2.3)=="lnCPL_AS_mcgL_3.8")] # Extract output
add2.4<-setpt10.df(add2, "lnSULT_VmaxC(1.4)","lnBP_APAP(1.4)") # Do analysis
add2.4.1<-add2.4[which(colnames(add2.4)=="lnCPL_APAP_mcgL_4.1"):which(colnames(add2.4)=="lnCPL_AS_mcgL_4.10")] # Extract output
add2.5<-setpt10.df(add2, "lnSULT_VmaxC(1.5)","lnBP_APAP(1.5)") # Do analysis
add2.5.1<-add2.5[which(colnames(add2.5)=="lnCPL_APAP_mcgL_5.1"):which(colnames(add2.5)=="lnCPL_AS_mcgL_5.10")] # Extract output
add2.6<-setpt10.df(add2, "lnSULT_VmaxC(1.6)","lnBP_APAP(1.6)") # Do analysis
add2.6.1<-add2.6[which(colnames(add2.6)=="lnCPL_APAP_mcgL_6.1"):which(colnames(add2.6)=="lnCPL_AS_mcgL_6.10")] # Extract output
add2.7<-setpt10.df(add2, "lnSULT_VmaxC(1.7)","lnBP_APAP(1.7)") # Do analysis
add2.7.1<-add2.7[which(colnames(add2.7)=="lnCPL_APAP_mcgL_7.1"):which(colnames(add2.7)=="lnCPL_AS_mcgL_7.12")] # Extract output
add2.8<-setpt10.df(add2, "lnSULT_VmaxC(1.8)","lnBP_APAP(1.8)") # Do analysis
add2.8.1<-add2.8[which(colnames(add2.8)=="lnCPL_APAP_mcgL_8.1"):which(colnames(add2.8)=="lnCPL_AS_mcgL_8.11")] # Extract output

#
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
prd.a.1<-c(apply(all.1.1[,j10], 2, median), apply(all.1.1[,k10], 2, median), apply(all.1.1[,l10], 2, median))
prd.d2.1<-c(apply(add2.1.1[,j10], 2, median), apply(add2.1.1[,k10], 2, median), apply(add2.1.1[,l10], 2, median))
#df.1<-data.frame(obs.1, prd.o.1, prd.s.1, prd.d.1, prd.a.1, "A")
df.1<-data.frame(obs.1, prd.o.1, prd.s.1, prd.d.1, prd.a.1, prd.d2.1, "A")

obs.2<-melt(APAP.2, id.vars = "Time")
prd.o.2<-c(apply(org.2.1[,j11], 2, median), apply(org.2.1[,k11], 2, median), apply(org.2.1[,l11], 2, median))
prd.s.2<-c(apply(sen.2.1[,j11], 2, median), apply(sen.2.1[,k11], 2, median), apply(sen.2.1[,l11], 2, median))
prd.d.2<-c(apply(add.2.1[,j11], 2, median), apply(add.2.1[,k11], 2, median), apply(add.2.1[,l11], 2, median))
prd.a.2<-c(apply(all.2.1[,j11], 2, median), apply(all.2.1[,k11], 2, median), apply(all.2.1[,l11], 2, median))
prd.d2.2<-c(apply(add2.2.1[,j11], 2, median), apply(add2.2.1[,k11], 2, median), apply(add2.2.1[,l11], 2, median))
#df.2<-data.frame(obs.2, prd.o.2, prd.s.2, prd.d.2, prd.a.2, "B")
df.2<-data.frame(obs.2, prd.o.2, prd.s.2, prd.d.2, prd.a.2, prd.d2.2, "B")

obs.3<-melt(APAP.3, id.vars = "Time")
prd.o.3<-c(apply(org.3.1[,j08], 2, median), apply(org.3.1[,k08], 2, median), apply(org.3.1[,l08], 2, median))
prd.s.3<-c(apply(sen.3.1[,j08], 2, median), apply(sen.3.1[,k08], 2, median), apply(sen.3.1[,l08], 2, median))
prd.d.3<-c(apply(add.3.1[,j08], 2, median), apply(add.3.1[,k08], 2, median), apply(add.3.1[,l08], 2, median))
prd.a.3<-c(apply(all.3.1[,j08], 2, median), apply(all.3.1[,k08], 2, median), apply(all.3.1[,l08], 2, median))
prd.d2.3<-c(apply(add2.3.1[,j08], 2, median), apply(add2.3.1[,k08], 2, median), apply(add2.3.1[,l08], 2, median))
#df.3<-data.frame(obs.3, prd.o.3, prd.s.3, prd.d.3, prd.a.3, "C")
df.3<-data.frame(obs.3, prd.o.3, prd.s.3, prd.d.3, prd.a.3, prd.d2.3, "C")

obs.4<-melt(APAP.4, id.vars = "Time")
prd.o.4<-c(apply(org.4.1[,j10], 2, median), apply(org.4.1[,k10], 2, median), apply(org.4.1[,l10], 2, median))
prd.s.4<-c(apply(sen.4.1[,j10], 2, median), apply(sen.4.1[,k10], 2, median), apply(sen.4.1[,l10], 2, median))
prd.d.4<-c(apply(add.4.1[,j10], 2, median), apply(add.4.1[,k10], 2, median), apply(add.4.1[,l10], 2, median))
prd.a.4<-c(apply(all.4.1[,j10], 2, median), apply(all.4.1[,k10], 2, median), apply(all.4.1[,l10], 2, median))
prd.d2.4<-c(apply(add.4.1[,j10], 2, median), apply(add.4.1[,k10], 2, median), apply(add.4.1[,l10], 2, median))
#df.4<-data.frame(obs.4, prd.o.4, prd.s.4, prd.d.4, prd.a.4, "D")
df.4<-data.frame(obs.4, prd.o.4, prd.s.4, prd.d.4, prd.a.4, prd.d2.4, "D")

obs.5<-melt(APAP.5, id.vars = "Time")
prd.o.5<-c(apply(org.5.1[,j10], 2, median), apply(org.5.1[,k10], 2, median), apply(org.5.1[,l10], 2, median))
prd.s.5<-c(apply(sen.5.1[,j10], 2, median), apply(sen.5.1[,k10], 2, median), apply(sen.5.1[,l10], 2, median))
prd.d.5<-c(apply(add.5.1[,j10], 2, median), apply(add.5.1[,k10], 2, median), apply(add.5.1[,l10], 2, median))
prd.a.5<-c(apply(all.5.1[,j10], 2, median), apply(all.5.1[,k10], 2, median), apply(all.5.1[,l10], 2, median))
prd.d2.5<-c(apply(add2.5.1[,j10], 2, median), apply(add2.5.1[,k10], 2, median), apply(add2.5.1[,l10], 2, median))

#df.5<-data.frame(obs.5, prd.o.5, prd.s.5, prd.d.5, prd.a.5, "E")
df.5<-data.frame(obs.5, prd.o.5, prd.s.5, prd.d.5, prd.a.5, prd.d2.5, "E")

obs.6<-melt(APAP.6, id.vars = "Time")
prd.o.6<-c(apply(org.6.1[,j10], 2, median), apply(org.6.1[,k10], 2, median), apply(org.6.1[,l10], 2, median))
prd.s.6<-c(apply(sen.6.1[,j10], 2, median), apply(sen.6.1[,k10], 2, median), apply(sen.6.1[,l10], 2, median))
prd.d.6<-c(apply(add.6.1[,j10], 2, median), apply(add.6.1[,k10], 2, median), apply(add.6.1[,l10], 2, median))
prd.a.6<-c(apply(all.6.1[,j10], 2, median), apply(all.6.1[,k10], 2, median), apply(all.6.1[,l10], 2, median))
prd.d2.6<-c(apply(add2.6.1[,j10], 2, median), apply(add2.6.1[,k10], 2, median), apply(add2.6.1[,l10], 2, median))
#df.6<-data.frame(obs.6, prd.o.6, prd.s.6, prd.d.6, prd.a.6, "F")
df.6<-data.frame(obs.6, prd.o.6, prd.s.6, prd.d.6, prd.a.6, prd.d2.6, "F")

obs.7<-melt(APAP.7, id.vars = "Time")
prd.o.7<-c(apply(org.7.1[,j12], 2, median), apply(org.7.1[,k12], 2, median), apply(org.7.1[,l12], 2, median))
prd.s.7<-c(apply(sen.7.1[,j12], 2, median), apply(sen.7.1[,k12], 2, median), apply(sen.7.1[,l12], 2, median))
prd.d.7<-c(apply(add.7.1[,j12], 2, median), apply(add.7.1[,k12], 2, median), apply(add.7.1[,l12], 2, median))
prd.a.7<-c(apply(all.7.1[,j12], 2, median), apply(all.7.1[,k12], 2, median), apply(all.7.1[,l12], 2, median))
prd.d2.7<-c(apply(add2.7.1[,j12], 2, median), apply(add2.7.1[,k12], 2, median), apply(add2.7.1[,l12], 2, median))

#df.7<-data.frame(obs.7, prd.o.7, prd.s.7, prd.d.7, prd.a.7, "G")
df.7<-data.frame(obs.7, prd.o.7, prd.s.7, prd.d.7, prd.a.7, prd.d2.7, "G")

obs.8<-melt(APAP.8, id.vars = "Time")
prd.o.8<-c(apply(org.8.1[,j11], 2, median), apply(org.8.1[,k11], 2, median), apply(org.8.1[,l11], 2, median))
prd.s.8<-c(apply(sen.8.1[,j11], 2, median), apply(sen.8.1[,k11], 2, median), apply(sen.8.1[,l11], 2, median))
prd.d.8<-c(apply(add.8.1[,j11], 2, median), apply(add.8.1[,k11], 2, median), apply(add.8.1[,l11], 2, median))
prd.a.8<-c(apply(all.8.1[,j11], 2, median), apply(all.8.1[,k11], 2, median), apply(all.8.1[,l11], 2, median))
prd.d2.8<-c(apply(add2.8.1[,j11], 2, median), apply(add2.8.1[,k11], 2, median), apply(add2.8.1[,l11], 2, median))

#df.8<-data.frame(obs.8, prd.o.8, prd.s.8, prd.d.8, prd.a.8, "H")
df.8<-data.frame(obs.8, prd.o.8, prd.s.8, prd.d.8, prd.a.8, prd.d2.8, "H")

names(df.1)<-names(df.2)<-names(df.3)<-names(df.4)<-names(df.5)<-names(df.6)<-names(df.7)<-names(df.8)<-c("Time","variable","value","prd.o","prd.s","prd.d", "prd.a", "prd.d2", "exp")
df.9<-do.call(rbind, list(df.1,df.2,df.3,df.4,df.5,df.6,df.7,df.8))

# 
options(digits=3)
R2(obs.1$value, as.numeric(prd.o.1)) # .868
R2(obs.1$value, as.numeric(prd.s.1)) # .853
R2(obs.1$value, as.numeric(prd.d.1)) # .949
R2(obs.1$value, as.numeric(prd.a.1)) # .962
R2(obs.1$value, as.numeric(prd.d2.1)) # .865
#R2(obs.1.1$value, as.numeric(prd.o.1.1)) 

R2(obs.2$value, as.numeric(prd.o.2)) # .983
R2(obs.2$value, as.numeric(prd.s.2)) # .982
R2(obs.2$value, as.numeric(prd.d.2)) # .994
R2(obs.2$value, as.numeric(prd.a.2)) # .995
R2(obs.2$value, as.numeric(prd.d2.2)) # .972

R2(obs.3$value, as.numeric(prd.o.3)) # .939 
R2(obs.3$value, as.numeric(prd.s.3)) # .921
R2(obs.3$value, as.numeric(prd.d.3)) # .971
R2(obs.3$value, as.numeric(prd.a.3)) # .981
R2(obs.3$value, as.numeric(prd.d2.3)) # .938

R2(obs.4$value, as.numeric(prd.o.4)) # .917
R2(obs.4$value, as.numeric(prd.s.4)) # .803
R2(obs.4$value, as.numeric(prd.d.4)) # .953
R2(obs.4$value, as.numeric(prd.a.4)) # .956
R2(obs.4$value, as.numeric(prd.d2.4)) # .953

R2(obs.5$value, as.numeric(prd.o.5)) # .98
R2(obs.5$value, as.numeric(prd.s.5)) # .976
R2(obs.5$value, as.numeric(prd.d.5)) # .992
R2(obs.5$value, as.numeric(prd.a.5)) # .992
R2(obs.5$value, as.numeric(prd.d2.5)) # .958

R2(obs.6$value, as.numeric(prd.o.6)) # .993
R2(obs.6$value, as.numeric(prd.s.6)) # .991
R2(obs.6$value, as.numeric(prd.d.6)) # .995
R2(obs.6$value, as.numeric(prd.a.6)) # .995
R2(obs.6$value, as.numeric(prd.d2.6)) # .987

R2(obs.7$value, as.numeric(prd.o.7)) # .988
R2(obs.7$value, as.numeric(prd.s.7)) # .986
R2(obs.7$value, as.numeric(prd.d.7)) # .994
R2(obs.7$value, as.numeric(prd.a.7)) # .996
R2(obs.7$value, as.numeric(prd.d2.7)) # .987

R2(obs.8$value, as.numeric(prd.o.8)) # .991
R2(obs.8$value, as.numeric(prd.s.8)) # .989
R2(obs.8$value, as.numeric(prd.d.8)) # .989
R2(obs.8$value, as.numeric(prd.a.8)) # .995
R2(obs.8$value, as.numeric(prd.d2.8)) # .979

#
OBS<-c(obs.1$value, obs.2$value, obs.3$value, obs.4$value, 
       obs.5$value, obs.6$value, obs.7$value, obs.8$value)
O.all<-c(as.numeric(prd.o.1), as.numeric(prd.o.2), as.numeric(prd.o.3), as.numeric(prd.o.4), 
         as.numeric(prd.o.5), as.numeric(prd.o.6), as.numeric(prd.o.7), as.numeric(prd.o.8))
O.sen<-c(as.numeric(prd.s.1), as.numeric(prd.s.2), as.numeric(prd.s.3), as.numeric(prd.s.4), 
         as.numeric(prd.s.5), as.numeric(prd.s.6), as.numeric(prd.s.7), as.numeric(prd.s.8))
A.sen<-c(as.numeric(prd.d.1), as.numeric(prd.d.2), as.numeric(prd.d.3), as.numeric(prd.d.4), 
         as.numeric(prd.d.5), as.numeric(prd.d.6), as.numeric(prd.d.7), as.numeric(prd.d.8))
A.all<-c(as.numeric(prd.a.1), as.numeric(prd.a.2), as.numeric(prd.a.3), as.numeric(prd.a.4), 
         as.numeric(prd.a.5), as.numeric(prd.a.6), as.numeric(prd.a.7), as.numeric(prd.a.8))

df<-data.frame(OBS, O.all, O.sen, A.sen, A.all)
df<-na.omit(df)
lndf<-log(df)

lm.Oall<-lm(O.all ~ OBS, data = df)
lm.Osen<-lm(O.sen ~ OBS, data = df)
lm.Asen<-lm(A.sen ~ OBS, data = df)
lm.Aall<-lm(A.all ~ OBS, data = df)

PI_Oall <- predict(lm.Oall, newdata=data.frame(OBS=max(df$OBS)), interval="prediction",
                   level = 0.95)
PI_Osen <- predict(lm.Osen, newdata=data.frame(OBS=max(df$OBS)), interval="prediction",
                   level = 0.95)
PI_Asen <- predict(lm.Asen, newdata=data.frame(OBS=max(df$OBS)), interval="prediction",
                   level = 0.95)
PI_Aall <- predict(lm.Aall, newdata=data.frame(OBS=max(df$OBS)), interval="prediction",
                   level = 0.95)


# residual
res.Oall<-df$O.all-df$OBS
res.Osen<-df$O.sen-df$OBS
res.Asen<-df$A.sen-df$OBS
res.Aall<-df$A.all-df$OBS

d.res.Oall <- density(res.Oall)
d.res.Osen <- density(res.Osen)
d.res.Asen <- density(res.Asen)
d.res.Aall <- density(res.Aall)

#
mean(res.Oall) # -0.00159
mean(res.Osen) # -0.00369
mean(res.Asen) # 0.000686
mean(res.Aall) # -0.000265

sd(res.Oall) # 0.159
sd(res.Osen) # 0.16
sd(res.Asen) # 0.11
sd(res.Aall) # 0.1

#
r2<-c(R2(obs.1$value, as.numeric(prd.o.1)), # .868
      R2(obs.1$value, as.numeric(prd.s.1)), # .853
      R2(obs.1$value, as.numeric(prd.d.1)), # .949
      R2(obs.1$value, as.numeric(prd.a.1)), # .962
      R2(obs.1$value, as.numeric(prd.d2.1)),
      R2(obs.2$value, as.numeric(prd.o.2)), # .983
      R2(obs.2$value, as.numeric(prd.s.2)), # .982
      R2(obs.2$value, as.numeric(prd.d.2)), # .994
      R2(obs.2$value, as.numeric(prd.a.2)), # .995
      R2(obs.2$value, as.numeric(prd.d2.2)),
      R2(obs.3$value, as.numeric(prd.o.3)), # .939 
      R2(obs.3$value, as.numeric(prd.s.3)), # .921
      R2(obs.3$value, as.numeric(prd.d.3)), # .971
      R2(obs.3$value, as.numeric(prd.a.3)), # .981
      R2(obs.3$value, as.numeric(prd.d2.3)),
      R2(obs.4$value, as.numeric(prd.o.4)), # .917
      R2(obs.4$value, as.numeric(prd.s.4)), # .803
      R2(obs.4$value, as.numeric(prd.d.4)), # .953
      R2(obs.4$value, as.numeric(prd.a.4)), # .956
      R2(obs.4$value, as.numeric(prd.d2.4)),
      R2(obs.5$value, as.numeric(prd.o.5)), # .98
      R2(obs.5$value, as.numeric(prd.s.5)), # .976
      R2(obs.5$value, as.numeric(prd.d.5)), # .992
      R2(obs.5$value, as.numeric(prd.a.5)), # .992
      R2(obs.5$value, as.numeric(prd.d2.5)),      
      R2(obs.6$value, as.numeric(prd.o.6)), # .993
      R2(obs.6$value, as.numeric(prd.s.6)), # .991
      R2(obs.6$value, as.numeric(prd.d.6)), # .995
      R2(obs.6$value, as.numeric(prd.a.6)), # .995
      R2(obs.6$value, as.numeric(prd.d2.6)),
      R2(obs.7$value, as.numeric(prd.o.7)), # .988
      R2(obs.7$value, as.numeric(prd.s.7)), # .986
      R2(obs.7$value, as.numeric(prd.d.7)), # .994
      R2(obs.7$value, as.numeric(prd.a.7)), # .996
      R2(obs.7$value, as.numeric(prd.d2.7)),
      R2(obs.8$value, as.numeric(prd.o.8)), # .991
      R2(obs.8$value, as.numeric(prd.s.8)), # .989
      R2(obs.8$value, as.numeric(prd.d.8)), # .989
      R2(obs.8$value, as.numeric(prd.a.8)), # .995
      R2(obs.8$value, as.numeric(prd.d2.8))
      ) 

set<-c(rep(c("Original all parameters",
            "Original sensitive parameters",
            "All sensitive parameters (0.01)",
            "All model parameters",
            "All sensitive parameters (0.05)"
            ),8))

gp<-c(rep("Group A, 325 mg", 5),
      rep("Group B, 1000 mg", 5),
      rep("Group C, 1000 mg", 5),
      rep("Group D, 1000 mg", 5),
      rep("Group E, 20 mg/kg",5),
      rep("Group F, 20 mg/kg",5),
      rep("Group G, 20 mg/kg",5),
      rep("Group H, 80 mg/kg",5))

r2df<-data.frame("R2", set, gp, r2)
r2df$set = with(r2df, factor(set, levels = c("Original all parameters",
                            "Original sensitive parameters",
                            "All sensitive parameters (0.05)",
                            "All sensitive parameters (0.01)",
                            "All model parameters")))