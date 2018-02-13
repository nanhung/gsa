if(!require(ggplot2)) {
  install.packages("ggplot2"); require(ggplot2)}
if(!require(scales)) {
  install.packages("scales"); require(scales)} # to access break formatting functions
if(!require(gridExtra)) {
  install.packages("gridExtra"); require(gridExtra)}


Model<-c(rep("M21", 8))
est<-c(rep("FST-M", 4), rep("FST-T", 4))
n<-c(1024, 2048, 4096, 8192, 1024, 2048, 4096, 8192)
time<-c(0.2998333, 0.5768333, 1.1731668, 2.2638, 
        0.2998333, 0.5768333, 1.1731668, 2.2638)
ind<-c(0.30,0.066,0.033,0.015,
       0.32,0.074,0.037,0.0312)

df2<-data.frame(Model,est,n, time, ind)

Model<-c(rep("M58", 8))
est<-c(rep("FST-M", 4), rep("FST-T", 4))
n<-c(1024, 2048, 4096, 8192, 1024, 2048, 4096, 8192)
time<-c(1.299167, 2.508000, 4.800000, 9.825498,
        1.299167, 2.508000, 4.800000, 9.825498)
ind<-c(0.279, 0.189, 0.124,0.0528,
       0.283, 0.189, 0.1254523, 0.05349)

df3<-data.frame(Model,est,n, time, ind)


Model<-c(rep("M21", 8))
est<-c(rep("JSN-M", 4), rep("JSN-T", 4))
n<-c(1024, 2048, 4096, 8192, 1024, 2048, 4096, 8192)
time<-c(0.305, 0.599, 1.8158, 2.389,
        0.305, 0.599, 1.8158, 2.389)
ind<-c(0.31,0.28,0.16,0.128,
       0.18,0.14,0.07,0.061)

df4<-data.frame(Model,est,n, time, ind)

Model<-c(rep("M58", 8))
est<-c(rep("JSN-M", 4), rep("JSN-T", 4))
n<-c(1024, 2048, 4096, 8192, 1024, 2048, 4096, 8192)
time<-c(0.8825, 1.7437, 3.505, 6.914,
        0.8825, 1.7437, 3.505, 6.914)
ind<-c(0.353,0.239,0.165,0.118,
       0.201,0.143,0.093,0.08)

df5<-data.frame(Model,est,n, time, ind)

Model<-c(rep("M21", 8))
est<-c(rep("OWN-M", 4), rep("OWN-T", 4))
n<-c(1024, 2048, 4096, 8192, 1024, 2048, 4096, 8192)
time<-c(0.9115, 1.8275, 3.6628, 7.3558,
        0.9115, 1.8275, 3.6628, 7.3558)
ind<-c(0.206,0.148,0.104,0.071,
       0.327,0.217,0.162,0.116)

df6<-data.frame(Model,est,n, time, ind)

Model<-c(rep("M58", 8))
est<-c(rep("OWN-M", 4), rep("OWN-T", 4))
n<-c(1024, 2048, 4096, 8192, 1024, 2048, 4096, 8192)
time<-c(0.8825, 5.711167, 11.42, 22.89,
        0.8825, 5.711167, 11.42, 22.89)
ind<-c(0.2619562,0.1379795, 0.08455584, 0.04598252,
       0.3937564,0.1810925, 0.1570704, 0.1590402)

df7<-data.frame(Model,est,n, time, ind)

Model<-c(rep("M21", 4), rep("M58", 4))
est<-c(rep("Morris", 4), rep("Morris", 4))
n<-c(1024, 2048, 4096, 8192, 1024, 2048, 4096, 8192)
time<-c(0.5633333, 1.0816667, 2.1766667, 4.3883333,
        1.5, 3.071667,  6.233333, 12.728167)
ind<-c(0.075, 0.063, 0.04, 0.033,
       0.096, 0.059, 0.04, 0.023)
df1<-data.frame(Model,est,n, time, ind)


dft<-do.call(rbind, list(df2,df3,df4,df5,df6,df7,df1))

dft$linetype<-c(rep("2",4), rep("1",4), rep("2",4), rep("1",4),
                rep("2",4), rep("1",4), rep("2",4), rep("1",4),
                rep("2",4), rep("1",4), rep("2",4), rep("1",4),
                rep("2",8))

dft$color<-c(rep("2",16), rep("3",16), rep("4",16), rep("1",8))
levels(dft$Model) <- c("Original 21 Parameters", "All 58 parameters")

#pdf(file="fig1.pdf", width = 10, height = 7)
#png(file="fig1.png",width=2400,height=1600,res=300)
jpeg(file="fig1.jpg",width=2400,height=1600,res=300)
p1<-ggplot(dft, aes(x = n, y = ind)) + facet_grid(Model~.) + 
  geom_line(aes(color = color, linetype = linetype), size = 0.8) +
  geom_point(aes(color = color), size = 1.4) + theme_bw() +
  xlab("Sample number, n") + ylab("Convergence index") +
  labs(colour="Estimator",linetype="Order") +
  scale_color_discrete(labels=c("Morris","eFAST", "Jansen", "Owen")) +
  scale_linetype_discrete(labels=c("Total effect", "Main effect")) +
  theme(strip.background = element_blank(), # remove box
        strip.text.y = element_blank(), legend.box = "horizontal",
        legend.position=c(0.7, 0.84), # change legend position
        legend.background = element_rect(fill=alpha('white', 0.1))) 

p2<-ggplot(dft, aes(x = time, y = ind)) + facet_grid(Model~.) + 
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x))) +
  geom_line(aes(color = color, linetype = linetype), size = 0.8) +
  geom_point(aes(color = color), size = 1.4) + theme_bw() +
  xlab("Computational time, t") +
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        legend.position="none") # remove legend

grid.arrange(p1, p2, ncol=2)
dev.off()

