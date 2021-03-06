if(!require(ggplot2)) {
  install.packages("ggplot2"); require(ggplot2)}
if(!require(scales)) {
  install.packages("scales"); require(scales)} # to access break formatting functions
if(!require(grid)) {
  install.packages("grid"); require(grid)} # to use grob
if(!require(gridExtra)) {
  install.packages("gridExtra"); require(gridExtra)}
if(!require(cowplot)) {
  install.packages("cowplot"); require(cowplot)}
#library(jpeg)

# Change facet label
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

mdata <- melt(df.9, id=c("Time","variable","exp")) 
names(mdata)<-c("Time","chem","exp","variable","value")
mdata$point<-c(mdata$value[1:246],rep(NA,1230))
mdata$point2<-"Experiment data"
mdata$line<-c(rep(NA,246),mdata$value[247:1476])
mdata$line2<-c(rep("A",492), # OMP
               rep("B",246), # OIP
               rep("D",246), #FIP01
               rep("E",246), #FMP
               rep("C",246)) #FIP05


p1<-ggplot(mdata) + geom_point(aes(x = Time, y = exp(point)/1000, shape=point2)) +
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x, n=3),
                labels = trans_format("log10", math_format(10^.x))) +
  geom_line(aes(x = Time, y = exp(line)/1000, color=line2)) +
  scale_colour_manual(values = c("grey", "red", "green", "blue", "black"),
                      labels=c("OMP", 
                               "OIP",
                               expression(FIP["05"]), 
                               expression(FIP["01"]),
                               "FMP")) +
  facet_grid(chem~exp) + theme_bw() + xlim(0, 13) +
  theme(legend.position="top", legend.title = element_blank(),text = element_text(size=15)) +
  labs(x="Time, hr",
       y=expression("Plasma concentration, "~mu*g/L))

# r2
p11<-ggplot(r2df, aes(x=set, y= r2, fill = set))+
  labs(x="",
       y=bquote(~italic(R)^2)) +
  geom_col(color = "white")+
  coord_cartesian(ylim=c(0.7,1.0)) +
  scale_fill_manual(values = c("grey", "red", "green", "blue", "black")) +
  scale_x_discrete(labels=c("OMP", 
                            "OIP",
                            expression(FIP["05"]), 
                            expression(FIP["01"]),
                            "FMP"))+
  guides(fill=FALSE) +
  facet_grid(~gp) + theme_bw()+
  theme(text = element_text(size=15),
        axis.text.x = element_text(angle = 45, hjust = 1))

#pdf(file="EXP.pdf", width = 16, height = 9)
png(file="setpt0.png",width=5600,height=2000,res=300)
p1
dev.off()


#
df.a <- melt(df.9, id=c("Time","variable","value","exp")) 
names(df.a)<-c("Time","Chem","Obs","Exp","prd.typ","prd.val")
df.a$Obs<-exp(df.a$Obs)/1000
df.a$prd.val<-exp(df.a$prd.val)/1000

org_fit  = lm(log(df.a[1:246,6]) ~ offset(log(df.a[1:246,3])) - 1 ) # omitting slope intercept
sen_fit  = lm(log(df.a[247:491,6]) ~ offset(log(df.a[247:491,3])) - 1) # omitting intercept
add_fit  = lm(log(df.a[492:738,6]) ~ offset(log(df.a[492:738,3])) - 1) # omitting intercept
all_fit  = lm(log(df.a[739:984,6]) ~ offset(log(df.a[739:984,3])) - 1) # omitting intercept
add2_fit  = lm(log(df.a[985:1230,6]) ~ offset(log(df.a[985:1230,3])) - 1) # omitting intercept

org_prd_fit <- predict(org_fit, interval = 'prediction')
org_prd_fit[,3]-org_prd_fit[,1] # 0.312
sen_prd_fit <- predict(sen_fit, interval = 'prediction')
sen_prd_fit[,3]-sen_prd_fit[,1] # 0.394
add_prd_fit <- predict(add_fit, interval = 'prediction')
add_prd_fit[,3]-add_prd_fit[,1] # 0.216
all_prd_fit <- predict(all_fit, interval = 'prediction')
all_prd_fit[,3]-all_prd_fit[,1] # 0.198
add2_prd_fit <- predict(add2_fit, interval = 'prediction')
add2_prd_fit[,3]-add2_prd_fit[,1] # 0.313

prd_fit<-do.call(rbind, list(org_prd_fit, sen_prd_fit, add_prd_fit, all_prd_fit, add2_prd_fit))

df.b <-cbind(na.omit(df.a), prd_fit)
df.b$res<-log(df.b$Obs, 10)-log(df.b$prd.val, 10)
df.b$prd.typ<-with(df.b, factor(prd.typ, levels = c("prd.a","prd.d", "prd.d2","prd.s","prd.o")))

abs(mean(subset(df.b, prd.typ=="prd.o")$res)) #0.000689
abs(mean(subset(df.b, prd.typ=="prd.s")$res)) #0.0054
abs(mean(subset(df.b, prd.typ=="prd.d")$res)) #0.00128
abs(mean(subset(df.b, prd.typ=="prd.a")$res)) #0.000143
abs(mean(subset(df.b, prd.typ=="prd.d2")$res)) #0.00701

sd(subset(df.b, prd.typ=="prd.o")$res) #0.0689
sd(subset(df.b, prd.typ=="prd.s")$res) #0.0868
sd(subset(df.b, prd.typ=="prd.d")$res) #0.0477
sd(subset(df.b, prd.typ=="prd.a")$res) #0.0437
sd(subset(df.b, prd.typ=="prd.d2")$res) #0.0689

#stat<-c(rep("Mean",5), rep("SD",5))
gp<-c("O21","O11(0.05)","F10(0.05)","F20(0.01)","F58")
#value<-c(abs(mean(subset(df.b, prd.typ=="prd.o")$res)),
#         abs(mean(subset(df.b, prd.typ=="prd.s")$res)),
#         abs(mean(subset(df.b, prd.typ=="prd.d")$res)),
#         abs(mean(subset(df.b, prd.typ=="prd.a")$res)),
#         abs(mean(subset(df.b, prd.typ=="prd.d2")$res)),
#         sd(subset(df.b, prd.typ=="prd.o")$res),
#         sd(subset(df.b, prd.typ=="prd.s")$res),
#         sd(subset(df.b, prd.typ=="prd.a")$res),
#         sd(subset(df.b, prd.typ=="prd.a")$res), 
#         sd(subset(df.b, prd.typ=="prd.d2")$res))
#df.res <- data.frame(stat,gp,value)
mean<-c(mean(subset(df.b, prd.typ=="prd.o")$res),
        mean(subset(df.b, prd.typ=="prd.s")$res),
        mean(subset(df.b, prd.typ=="prd.d2")$res),
        mean(subset(df.b, prd.typ=="prd.d")$res),
        mean(subset(df.b, prd.typ=="prd.a")$res))
sd<-c(sd(subset(df.b, prd.typ=="prd.o")$res),
      sd(subset(df.b, prd.typ=="prd.s")$res),
      sd(subset(df.b, prd.typ=="prd.d2")$res),
      sd(subset(df.b, prd.typ=="prd.d")$res),
      sd(subset(df.b, prd.typ=="prd.a")$res))
df.res<-data.frame(gp,mean,sd)

df.res$gp <- with(df.res, factor(gp, levels = c("O21","O11(0.05)","F10(0.05)","F20(0.01)","F58")))

# dot (mean sd)
#pd = position_dodge(0.8)
#p3<-ggplot(df.res, aes(x = gp, y = mean)) + 
#  xlab("") + ylab(expression(Log[10] ~ residual)) +
#  geom_abline(slope = 0, intercept = 0, linetype="dotted") +
#  ylim(-0.1, 0.1) +
#  geom_point(aes(colour = gp), size  = 4) +
#  geom_errorbar(aes(ymin  = mean - sd, ymax  = mean + sd), width = 0.2, size  = 0.4, position = pd) +
#  scale_colour_manual(values = c("grey","red","green","blue", "black")) + 
#  guides(fill=FALSE, colour=FALSE) + theme_bw() +
#  theme(axis.title = element_text(face = "bold"),
#        text = element_text(size=20),
#        axis.text.x = element_text(angle = 45, hjust = 1),
#        panel.grid.minor=element_blank(),
#        panel.grid.major.y=element_blank(),
#        panel.grid.major.x=element_blank())

df.b$prd.typ2<-with(df.b, factor(prd.typ, levels = rev(c("prd.a","prd.d", "prd.d2","prd.s","prd.o"))))
p3<-ggplot(df.b, aes(prd.typ2, res)) + 
  xlab("") + ylab(expression(Log[10] ~ residual)) +
  geom_abline(slope = 0, intercept = 0, linetype="dotted") +
  geom_violin(aes(colour = prd.typ), alpha = 0.6) +
  scale_colour_manual(values = c("black","blue","green","red", "grey")) +
  scale_x_discrete(labels=c("prd.a" = "FMP", 
                            "prd.d" = expression(FIP["01"]),
                            "prd.d2" = expression(FIP["05"]),
                            "prd.s" = "OIP",
                            "prd.o" = "OMP"))+
  theme_bw()+ guides(colour=FALSE) +
  geom_boxplot(aes(colour = prd.typ), width=0.2, fill="white")+
  theme(axis.title = element_text(face = "bold"),
        text = element_text(size=20),
        axis.text.x = element_text(angle = 45, hjust = 1),
        panel.grid.minor=element_blank(),
        panel.grid.major.y=element_blank(),
        panel.grid.major.x=element_blank())

#p3<- ggplot(df.res, aes(x=gp, y=value, fill=stat)) + theme_bw() +
#  xlab("") + ylab(expression(Log[10] ~ residual)) + labs(fill = "") +
#  geom_bar(stat="identity", color="black", position=position_dodge()) +
#  scale_fill_manual(values =c("grey80", "grey40")) + 
#  theme(legend.justification=c("right", "top"), 
#        axis.text.x = element_text(angle = 45, hjust = 1),
#        legend.position=c(1,1), 
#        text = element_text(size=20),
#        legend.background = element_rect(fill=alpha('white', 0.1)),
#        panel.grid.minor = element_blank())

g<-ggplotGrob(p3)
#imgfile <- readJPEG("venn.jpg")
#g2<- rasterGrob(imgfile, interpolate=TRUE)

p2<-ggplot(df.b, aes(Obs, prd.val)) + 
  xlab("") + ylab(expression("in-silico prediction of plasma concentration, "~mu*g/L)) +
  theme_bw() + geom_abline(slope = 1, intercept = 0)+ 
  theme(legend.position="top") + annotation_logticks(sides = "lb") +
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x, n=3),
                labels = trans_format("log10", math_format(10^.x))) +
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x, n=3),
                labels = trans_format("log10", math_format(10^.x)))+
  geom_ribbon(aes(y = exp(fit), ymin = exp(lwr), ymax = exp(upr), fill = prd.typ), alpha = 0.1) +
  scale_fill_manual(values=c("black", "blue", "green", "red", "grey")) + 
  guides(fill=FALSE) + # remove "fill" legend 
  geom_point(aes(colour = prd.typ), alpha = 0.6) +
  annotation_custom(grob=g, xmin = log(2), xmax = log(8),
                    ymin=log(0.4), ymax=log(1.5)) +
  #annotation_custom(grob=g2, xmin = log(0.6), xmax = log(1.8),
  #                  ymin=log(2), ymax=log(15)) +
  scale_color_manual(values=c("black", "blue", "green", "red", "grey"),
                     name="",
                     breaks=c("prd.o", "prd.s", "prd.d2", "prd.d", "prd.a"),
                     labels=c("OMP", 
                              "OIP",
                              expression(FIP["05"]), 
                              expression(FIP["01"]),
                              "FMP")) + 
  theme(legend.justification=c(0,1), 
        legend.position=c(0.8,0.7), 
        text = element_text(size=20),
        legend.background = element_rect(fill=alpha('white', 0.1)),
        panel.grid.minor = element_blank()) # Hide the minor grid lines because they don't align with the ticks

p3<-ggplot(df.b, aes(Obs, res)) + 
  geom_abline(slope = 0, intercept = 0) +
  geom_point(aes(colour = prd.typ), alpha = 0.6) +
  scale_colour_manual(values = c("black","blue","green","red", "grey")) + 
  guides(colour=FALSE) +
  labs(x=expression("in-vivo observation of plasma concentration, "~mu*g/L),
       y=expression(Log[10] ~ residual)) +
  theme_bw() + annotation_logticks(sides = "b") +
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x, n=3),
                labels = trans_format("log10", math_format(10^.x))) +
  ylim(-0.6, 0.6) +
  theme(text = element_text(size=20),
        panel.grid.minor = element_blank())


#pdf(file="fig7.pdf", width = 10, height = 12)
#png(file="fig3.png",width=3600,height=4200,res=300)
jpeg(file="fig4.jpg",width=3600,height=4200,res=300)
#grid.arrange(p2,p3, ncol=1, heights=c(3,1))
plot_grid(p2,p3, ncol=1, rel_heights=c(3,1), label_size = 20, labels="AUTO")
dev.off()

#pdf(file="fig6.pdf", width = 18, height = 10)
#png(file="fig4.png",width=5400,height=3600,res=300)
jpeg(file="fig5.jpg",width=5400,height=3600,res=300)
#grid.arrange(p1,p11, ncol=1, heights=c(3,1))
plot_grid(p1,p11, ncol=1, rel_heights=c(5,2), label_size = 20, labels="AUTO")
dev.off()


############## seminar ############

jpeg(file="fig4-1.jpg",width=3600,height=3200,res=300)
ggplot(df.b, aes(Obs, prd.val)) + 
  xlab(expression("in-vivo prediction of plasma concentration, "~mu*g/L)) +
  ylab(expression("in-silico prediction of plasma concentration, "~mu*g/L)) +
  theme_bw() + geom_abline(slope = 1, intercept = 0)+ 
  theme(legend.position="top") + annotation_logticks(sides = "lb") +
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x, n=3),
                labels = trans_format("log10", math_format(10^.x))) +
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x, n=3),
                labels = trans_format("log10", math_format(10^.x)))+
  geom_ribbon(aes(y = exp(fit), ymin = exp(lwr), ymax = exp(upr), fill = prd.typ), alpha = 0.1) +
  scale_fill_manual(values=c("black", "blue", "green", "red", "grey")) + 
  guides(fill=FALSE) + # remove "fill" legend 
  geom_point(aes(colour = prd.typ), alpha = 0.6) +
  annotation_custom(grob=g, xmin = log(2), xmax = log(8),
                    ymin=log(0.4), ymax=log(1.5)) +
  #annotation_custom(grob=g2, xmin = log(0.6), xmax = log(1.8),
  #                  ymin=log(2), ymax=log(15)) +
  scale_color_manual(values=c("black", "blue", "green", "red", "grey"),
                     name="",
                     breaks=c("prd.o", "prd.s", "prd.d2", "prd.d", "prd.a"),
                     labels=c("OMP", 
                              "OIP",
                              expression(FIP["05"]), 
                              expression(FIP["01"]),
                              "FMP")) + 
  theme(legend.justification=c(0,1), 
        legend.position=c(0.8,0.7), 
        text = element_text(size=20),
        legend.background = element_rect(fill=alpha('white', 0.1)),
        panel.grid.minor = element_blank()) # Hide the minor grid lines because they don't align with the ticks
dev.off()

################### IC2018 #########



p2<-ggplot(df.b, aes(Obs, prd.val)) + 
  xlab("") + ylab(expression("in-silico prediction of plasma concentration, "~mu*g/L)) +
  theme_bw() + geom_abline(slope = 1, intercept = 0)+ 
  theme(legend.position="top") + annotation_logticks(sides = "lb") +
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x, n=3),
                labels = trans_format("log10", math_format(10^.x))) +
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x, n=3),
                labels = trans_format("log10", math_format(10^.x)))+
  geom_ribbon(aes(y = exp(fit), ymin = exp(lwr), ymax = exp(upr), fill = prd.typ), alpha = 0.1) +
  scale_fill_manual(values=c("black", "blue", "green", "red", "grey")) + 
  guides(fill=FALSE) + # remove "fill" legend 
  geom_point(aes(colour = prd.typ), alpha = 0.6) +
  annotation_custom(grob=g, xmin = log(2), xmax = log(8),
                    ymin=log(0.4), ymax=log(1.5)) +
  #annotation_custom(grob=g2, xmin = log(0.6), xmax = log(1.8),
  #                  ymin=log(2), ymax=log(15)) +
  scale_color_manual(values=c("black", "blue", "green", "red", "grey"),
                     name="",
                     breaks=c("prd.o", "prd.s", "prd.d2", "prd.d", "prd.a"),
                     labels=c("OMP", 
                              "OIP",
                              expression(FIP["05"]), 
                              expression(FIP["01"]),
                              "FMP")) + 
  theme(legend.justification=c(0,1), 
        legend.position=c(0.8,0.7), 
        text = element_text(size=20),
        legend.background = element_rect(fill=alpha('white', 0.1)),
        panel.grid.minor = element_blank()) # Hide the minor grid lines because they don't align with the ticks

library(dplyr)
factor <- c(rep("Expert", 238),rep("EFAST", 238),rep("All", 238))
value <- c(res.Oall, res.Asen, res.Aall)
X <- data.frame(factor,value)
mu <- plyr::ddply(X, "factor", summarize, mean.conc=mean(value))
p3<-ggplot(X, aes(x=value, color=factor)) +
  xlab("Residual") + ylab("Density") +
  geom_density() + scale_color_discrete(name=" ") +
  geom_vline(data=mu, aes(xintercept=mean.conc, color=factor),
             linetype="dashed") +
  theme_minimal()
g<-ggplotGrob(p3)


df.ic2018a <- df.b %>% filter(prd.typ2 %in% c("prd.o", "prd.d", "prd.a"))
p2<-ggplot(df.ic2018a, aes(Obs, prd.val)) + 
  xlab("in-vivo observation of plasma concentration, "~mu*g/L) + ylab(expression("in-silico prediction of plasma concentration, "~mu*g/L)) +
  theme_bw() + geom_abline(slope = 1, intercept = 0)+ 
  theme(legend.position="top") + annotation_logticks(sides = "lb") +
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x, n=3),
                labels = trans_format("log10", math_format(10^.x))) +
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x, n=3),
                labels = trans_format("log10", math_format(10^.x))) +
  geom_ribbon(aes(y = exp(fit), ymin = exp(lwr), ymax = exp(upr), fill = prd.typ), alpha = 0.2) +
  annotation_custom(grob=g, xmin = log(1.8), xmax = log(9),
                    ymin=log(0.5), ymax=log(1.7)) +
  geom_point(aes(colour = prd.typ), alpha = 0.6, size=0.8)+
  scale_fill_discrete(name="Group",
                      breaks=c("prd.a", "prd.d", "prd.o"),
                      labels=c("All parameters", "EFAST-judged parameters", "Expert-judged parameters")) + 
  scale_color_discrete(name="Group",
                       breaks=c("prd.a", "prd.d", "prd.o"),
                       labels=c("All parameters", "EFAST-judged parameters", "Expert-judged parameters"))

png(file="fig3.png",width=2800,height=2400,res=300)
p2
dev.off()

# Change facet label
mdata$line2<-c(rep(NA,246),
               rep("A",246),# OMP
               rep("B",246), # OIP
               rep("D",246), #FIP01
               rep("E",246), #FMP
               rep("C",246)) #FIP05

df.mdata <- mdata[c(1:492, 739:1230),]
nrow(df.mdata)

p1<-ggplot(df.mdata) + geom_point(aes(x = Time, y = exp(point)/1000, shape=point2)) +
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x, n=3),
                labels = trans_format("log10", math_format(10^.x))) +
  geom_line(aes(x = Time, y = exp(line)/1000, color=line2)) +
  scale_colour_manual(values = c("blue", "green", "red", "white"),
                      labels=c("Expert", 
                               "EFAST",
                               "All", 
                               " ")) +
  facet_grid(chem~exp) + theme_bw() + xlim(0, 13) +
  theme(legend.position="top", legend.title = element_blank(),text = element_text(size=12)) +
  labs(x="Time, hr",
       y=expression("Plasma concentration, "~mu*g/L))


r2df2 <- r2df %>% filter(set %in% c("Original all parameters",
                                    "All sensitive parameters (0.01)",
                                    "All model parameters"))

p11<-ggplot(r2df2, aes(x=set, y= r2, fill = set))+
  labs(x="",
       y=bquote(~italic(R)^2)) +
  geom_col(color = "white")+
  coord_cartesian(ylim=c(0.7,1.0)) +
  scale_fill_manual(values = c("blue", "green", "red")) +
  scale_x_discrete(labels=c("Expert", 
                            "EFAST",
                            "All"))+
  guides(fill=FALSE) +
  facet_grid(~gp) + theme_bw()+
  theme(text = element_text(size=12),
        axis.text.x = element_text(angle = 45, hjust = 1))

png(file="fig4.png",width=3200,height=2400,res=300)
plot_grid(p1,p11, ncol=1, rel_heights=c(5,2), label_size = 20, labels="AUTO")
dev.off()
