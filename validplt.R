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

p1<-ggplot(df.9)+ 
  labs(x="Time, hr",
       y=expression("Plasma concentration, "~mu*g/L)) +
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x, n=3),
                labels = trans_format("log10", math_format(10^.x))) +
  facet_grid(variable~exp) + theme_bw() + xlim(0, 13) +
  theme(text = element_text(size=20)) + 
  geom_line(aes(x = Time, y = exp(prd.o)/1000), size = 0.6, color = "blue") + 
  geom_line(aes(x = Time, y = exp(prd.s)/1000), size = 0.6, color = "red", linetype = "dashed") +
  geom_line(aes(x = Time, y = exp(prd.d)/1000), size = 0.6, color = "green") +
  geom_line(aes(x = Time, y = exp(prd.a)/1000), size = 0.6, color = "darkgreen", linetype = "dashed") +
  geom_point(aes(x = Time, y = exp(value)/1000), size = 1.4)

# r2
p11<-ggplot(r2df, aes(x=set, y= r2, fill = set))+
  labs(x="",
       y=bquote(~italic(R)^2)) +
  geom_col(color = "white")+
  coord_cartesian(ylim=c(0.7,1.0)) +
  scale_fill_manual(values =c("darkblue", "red", "green", "darkgreen")) +
  guides(fill=FALSE) +
  facet_grid(~gp) + theme_bw()+
  theme(text = element_text(size=20),
        axis.text.x = element_blank())

#
df.a <- melt(df.9, id=c("Time","variable","value","exp")) 
names(df.a)<-c("Time","Chem","Obs","Exp","prd.typ","prd.val")
df.a$Obs<-exp(df.a$Obs)/1000
df.a$prd.val<-exp(df.a$prd.val)/1000

org_fit  = lm(log(df.a[1:246,6]) ~ offset(log(df.a[1:246,3])) - 1 ) # omitting slope intercept
sen_fit  = lm(log(df.a[247:491,6]) ~ offset(log(df.a[247:491,3])) - 1) # omitting intercept
add_fit  = lm(log(df.a[492:738,6]) ~ offset(log(df.a[492:738,3])) - 1) # omitting intercept
all_fit  = lm(log(df.a[739:984,6]) ~ offset(log(df.a[739:984,3])) - 1) # omitting intercept

org_prd_fit <- predict(org_fit, interval = 'prediction')
org_prd_fit[,3]-org_prd_fit[,1] # 0.312
sen_prd_fit <- predict(sen_fit, interval = 'prediction')
sen_prd_fit[,3]-sen_prd_fit[,1] # 0.316
add_prd_fit <- predict(add_fit, interval = 'prediction')
add_prd_fit[,3]-add_prd_fit[,1] # 0.216
all_prd_fit <- predict(all_fit, interval = 'prediction')
all_prd_fit[,3]-all_prd_fit[,1] # 0.197

prd_fit<-do.call(rbind, list(org_prd_fit, sen_prd_fit, add_prd_fit, all_prd_fit))

df.b <-cbind(na.omit(df.a), prd_fit)
df.b$res<-log(df.b$Obs, 10)-log(df.b$prd.val, 10)

abs(mean(subset(df.b, prd.typ=="prd.o")$res)) #0.000689
abs(mean(subset(df.b, prd.typ=="prd.s")$res)) #0.0054
abs(mean(subset(df.b, prd.typ=="prd.d")$res)) #0.00128
abs(mean(subset(df.b, prd.typ=="prd.a")$res)) #0.000143

sd(subset(df.b, prd.typ=="prd.o")$res) #0.0689
sd(subset(df.b, prd.typ=="prd.s")$res) #0.0868
sd(subset(df.b, prd.typ=="prd.d")$res) #0.0477
sd(subset(df.b, prd.typ=="prd.a")$res) #0.0437

stat<-c(rep("Mean",4), rep("SD",4))
gp<-rep(c("OAP","OSP","ASP","AMP"),2)
value<-c(0.000689, 0.0054, 0.00128, 0.000143, 0.0689, 0.0868, 0.0477, 0.0437)
df.res <- data.frame(stat,gp,value)
df.res$gp <- with(df.res, factor(gp, levels = c("OAP","OSP","ASP","AMP")))

p3<- ggplot(df.res, aes(x=gp, y=value, fill=stat)) + theme_bw() +
  xlab("") + ylab(expression(Log[10] ~ residual)) + labs(fill = "") +
  geom_bar(stat="identity", color="black", position=position_dodge()) +
  scale_fill_manual(values =c("grey80", "grey40")) + 
  
  theme(legend.justification=c("right", "top"), 
        legend.position=c(1,1), 
        text = element_text(size=20),
        legend.background = element_rect(fill=alpha('white', 0.1)),
        panel.grid.minor = element_blank())

g<-ggplotGrob(p3)

p2<-ggplot(df.b, aes(Obs, prd.val)) + 
  xlab("") + ylab("in-silico prediction") +
  theme_bw() + geom_abline(slope = 1, intercept = 0)+ 
  theme(legend.position="top") + annotation_logticks(sides = "lb") +
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x, n=3),
                labels = trans_format("log10", math_format(10^.x))) +
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x, n=3),
                labels = trans_format("log10", math_format(10^.x)))+
  geom_ribbon(aes(y = exp(fit), ymin = exp(lwr), ymax = exp(upr), fill = prd.typ), alpha = 0.1) +
  scale_fill_manual(values =c("darkblue", "red", "green", "darkgreen")) + 
  guides(fill=FALSE) + # remove "fill" legend 
  geom_point(aes(colour = prd.typ), alpha = 0.6) +
  annotation_custom(grob=g, xmin = log(2), xmax = log(8),
                    ymin=log(0.4), ymax=log(1.5)) +
  scale_color_manual(values=c("darkblue", "red", "green", "darkgreen"),
                     name="",
                     breaks=c("prd.o", "prd.s", "prd.d", "prd.a"),
                     labels=c("Original all parameters (21)", "Original sensitive parameters (11)", "All sensitive parameters (20)","All model parameters (58)")) + 
  theme(legend.justification=c(0,1), 
        legend.position=c(0,1), 
        text = element_text(size=20),
        legend.background = element_rect(fill=alpha('white', 0.1)),
        panel.grid.minor = element_blank()) # Hide the minor grid lines because they don't align with the ticks

p3<-ggplot(df.b, aes(Obs, res)) + 
  geom_abline(slope = 0, intercept = 0) +
  geom_point(aes(colour = prd.typ), alpha = 0.6) +
  scale_colour_manual(values =c("darkblue", "red", "green", "darkgreen")) + 
  guides(colour=FALSE) +
  labs(x="in-vivo observation",
       y=expression(Log[10] ~ residual)) +
  theme_bw() + annotation_logticks(sides = "b") +
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x, n=3),
                labels = trans_format("log10", math_format(10^.x))) +
  ylim(-0.6, 0.6) +
  theme(text = element_text(size=20),
        panel.grid.minor = element_blank())

#pdf(file="EXP.pdf", width = 16, height = 9)
#png(file="EXP.png",width=4000,height=1600,res=250)
#p1
#dev.off()

#pdf(file="fig6.pdf", width = 18, height = 10)
png(file="calib.png",width=3600,height=2400,res=250)
#grid.arrange(p1,p11, ncol=1, heights=c(3,1))
plot_grid(p1,p11, ncol=1, rel_heights=c(3,1), label_size = 20, labels="AUTO")
dev.off()

pdf(file="fig7.pdf", width = 10, height = 12)
#png(file="calib.png",width=3600,height=2400,res=250)
#grid.arrange(p2,p3, ncol=1, heights=c(3,1))
plot_grid(p2,p3, ncol=1, rel_heights=c(3,1), label_size = 20, labels="AUTO")
dev.off()

