#rm(list=ls())
if(!require(readr)) {
  install.packages("readr"); require(readr)}
if(!require(cowplot)) {
  install.packages("cowplot"); require(cowplot)} #plot_grid
if(!require(scales)) {
  install.packages("scales"); require(scales)} # to access break formatting functions


require(reshape2)

source("valid.R")
levels(df.9$variable)
levels(df.9$variable) <- c("APAP", "APAP-G", "APAP-S")

levels(df.9$exp)
levels(df.9$exp) <- c("Group A, 325 mg",
                      "Group B, 1000 mg",
                      "Group C, 1000 mg",
                      "Group D, 1000 mg",
                      "Group E, 20 mg/kg",
                      "Group F, 20 mg/kg",
                      "Group G, 20 mg/kg",
                      "Group H, 80 mg/kg")


df0<-df.9[,c(1,2,3,9)]

system("./mcsim.apap.pbpk_v2 apap21.mtc.in")
df21<-data.frame(fread(("apap21.mtc.out")))
system("./mcsim.apap.pbpk_v2 apap58.mtc.in")
df58<-data.frame(fread(("apap58.mtc.out")))

df1<-df21[,23:ncol(df21)]
df2<-df58[,60:ncol(df58)]

DF1<-cbind(df0, t(df1))
DF2<-cbind(df0, t(df2))



mdata1 <- melt(DF1, id=names(DF1)[1:4])
names(mdata1)<-c("Time","variable","value","exp","sim.gp","sim.val")
mdata2 <- melt(DF2, id=names(DF2)[1:4])  
names(mdata2)<-c("Time","variable","value","exp","sim.gp","sim.val")

p1<-
ggplot() +
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x, n=3),
                labels = trans_format("log10", math_format(10^.x))) +
  geom_line(data = mdata1, aes(x = Time, y = exp(sim.val)/1000, group = sim.gp), color="grey")+
  facet_grid(variable~exp) + theme_bw()+
  geom_point(data = mdata1, aes(x = Time, y = exp(value)/1000), size = 1.4)+
  coord_cartesian(xlim=c(0,13),ylim=range(exp(df.9$value)/1000, na.rm=T))+
  labs(x="Time, hr",
       y=expression("Plasma concentration, "~mu*g/L))
p2<-
  ggplot() +
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x, n=3),
                labels = trans_format("log10", math_format(10^.x))) +
  geom_line(data = mdata2, aes(x = Time, y = exp(sim.val)/1000, group = sim.gp), color="grey")+
  facet_grid(variable~exp) + theme_bw()+
  geom_point(data = mdata2, aes(x = Time, y = exp(value)/1000), size = 1.4)+
  coord_cartesian(xlim=c(0,13),ylim=range(exp(df.9$value)/1000, na.rm=T))+
  labs(x="Time, hr",
       y=expression("Plasma concentration, "~mu*g/L))


jpeg(file="figs1.jpg",width=4000,height=2400,res=300)
plot_grid(p1,p2, ncol=1, rel_heights=c(1,1), label_size = 20, labels="AUTO")
dev.off()


