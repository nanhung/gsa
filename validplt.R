if(!require(ggplot2)) {
  install.packages("ggplot2"); require(ggplot2)
}
if(!require(scales)) {
  install.packages("scales"); require(scales)} # to access break formatting functions


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

pdf(file="EXP.pdf", width = 16, height = 9)
ggplot(df.9)+ 
  labs(x="Time, hr",
       y=expression("Plasma concentration, "~mu*g/L)) +
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x))) +
  facet_grid(variable~exp) + theme_bw() +
  geom_line(aes(x = Time, y = exp(prd.o)/1000), size = 0.6, color = "blue") + 
  geom_line(aes(x = Time, y = exp(prd.s)/1000), size = 0.6, color = "red", linetype = "dashed") +
  geom_line(aes(x = Time, y = exp(prd.d)/1000), size = 0.6, color = "green") +
  geom_line(aes(x = Time, y = exp(prd.a)/1000), size = 0.6, color = "darkgreen", linetype = "dashed") +
  geom_point(aes(x = Time, y = exp(value)/1000), size = 1.4)
dev.off()


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


pdf(file="valid.pdf", width = 7, height = 7)
ggplot(df.b, aes(Obs, prd.val)) + 
  xlab("in-vivo observation") + ylab("in-silico prediction") +
  theme_bw() + geom_abline(slope = 1, intercept = 0)+ 
  theme(legend.position="top") +
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
              labels = trans_format("log10", math_format(10^.x))) +
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)))+
  geom_ribbon(aes(y = exp(fit), ymin = exp(lwr), ymax = exp(upr), fill = prd.typ), alpha = 0.1) +
  scale_fill_manual(values =c("blue", "red", "green", "darkgreen")) + 
  guides(fill=FALSE) + # remove "fill" legend 
  geom_point(aes(colour = prd.typ), alpha = 0.6)+
  scale_color_manual(values=c("blue", "red", "green", "darkgreen"),
                     name="",
                     breaks=c("prd.o", "prd.s", "prd.d", "prd.a"),
                     labels=c("Original all parameters (21)", "Original sensitive parameters (14)", "All sensitive parameters (19)","All model parameters (58)")) + 
  theme(legend.justification=c(1,0), legend.position=c(1,0), legend.background = element_rect(fill=alpha('white', 0.1)))
dev.off()


