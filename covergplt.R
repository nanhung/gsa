if(!require(ggplot2)) {
  install.packages("ggplot2"); require(ggplot2)}
if(!require(scales)) {
  install.packages("scales"); require(scales)} # to access break formatting functions
if(!require(gridExtra)) {
  install.packages("gridExtra"); require(gridExtra)}


Model<-c(rep("M21", 8))
est<-c(rep("FST-M", 4), rep("FST-T", 4))
n<-c(1024, 2048, 4096, 8192, 1024, 2048, 4096, 8192)
time<-c(0.004997222, 0.009613889, 0.01955278, 0.03773056, 
        0.004997222, 0.009613889, 0.01955278, 0.03773056)
ind<-c(0.30,0.066,0.033,0.015,
       0.32,0.074,0.037,0.0312)

df2<-data.frame(Model,est,n, time, ind)

Model<-c(rep("M58", 8))
est<-c(rep("FST-M", 4), rep("FST-T", 4))
n<-c(1024, 2048, 4096, 8192, 1024, 2048, 4096, 8192)
time<-c(0.02165278, 0.0418,0.08,0.1637583,
        0.02165278, 0.0418,0.08,0.1637583)
ind<-c(0.279, 0.189, 0.124,0.0528,
       0.283, 0.189, 0.1254523, 0.05349)

df3<-data.frame(Model,est,n, time, ind)


Model<-c(rep("M21", 8))
est<-c(rep("JSN-M", 4), rep("JSN-T", 4))
n<-c(1024, 2048, 4096, 8192, 1024, 2048, 4096, 8192)
time<-c(0.007863889, 0.01502778, 0.03026389, 0.06427222,
        0.007863889, 0.01502778, 0.03026389, 0.06427222)
ind<-c(0.31,0.28,0.16,0.128,
       0.18,0.14,0.07,0.061)

df4<-data.frame(Model,est,n, time, ind)

Model<-c(rep("M58", 8))
est<-c(rep("JSN-M", 4), rep("JSN-T", 4))
n<-c(1024, 2048, 4096, 8192, 1024, 2048, 4096, 8192)
time<-c(0.02681389, 0.05308333, 0.1117833, 0.2280167,
        0.02681389, 0.05308333, 0.1117833, 0.2280167)
ind<-c(0.353,0.239,0.165,0.118,
       0.201,0.143,0.093,0.08)

df5<-data.frame(Model,est,n, time, ind)

Model<-c(rep("M21", 8))
est<-c(rep("OWN-M", 4), rep("OWN-T", 4))
n<-c(1024, 2048, 4096, 8192, 1024, 2048, 4096, 8192)
time<-c(1.204761, 2.462789, 4.955328, 10.62021)
ind<-c(0.206,0.148,0.104,0.071,
       0.327,0.217,0.162,0.116)

df6<-data.frame(Model,est,n, time, ind)



dft<-do.call(rbind, list(df2,df3,df4,df5,df6))

dft$linetype<-c(rep("2",4), rep("1",4), rep("2",4), rep("1",4),
                rep("2",4), rep("1",4), rep("2",4), rep("1",4),
                rep("2",4), rep("1",4))

dft$color<-c(rep("2",16), rep("3",16), rep("4",8))
levels(dft$Model) <- c("Original 21 Parameters", "All 58 parameters")

pdf(file="fig2.pdf", width = 10, height = 7)
#png(file="fig2.png",width=2000,height=1200,res=250)
p1<-ggplot(dft, aes(x = n, y = ind)) + facet_grid(Model~.) + 
  geom_line(aes(color = color, linetype = linetype), size = 0.8) +
  geom_point(aes(color = color), size = 1.4) + theme_bw() +
  xlab("Sample number, n") + ylab("Convergence index") +
  labs(colour="Estimator",linetype="Order") +
  scale_color_discrete(labels=c("eFAST", "Jansen", "Owen")) +
  scale_linetype_discrete(labels=c("Total effect", "Main effect")) +
  theme(strip.background = element_blank(), # remove box
        strip.text.y = element_blank(), 
        legend.position=c(0.86, 0.84), # change legend position
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

