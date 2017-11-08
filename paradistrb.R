if(!require(readr)) {
  install.packages("readr"); require(readr)
}

# 21 Original parameters
APAP_21.1 <- as.data.frame(read_table2("apap21.c01.out"))
APAP_21.2 <- as.data.frame(read_table2("apap21.c02.out"))
APAP_21.3 <- as.data.frame(read_table2("apap21.c03.out"))
APAP_21.4 <- as.data.frame(read_table2("apap21.c04.out"))

# 14 Sensitivity parameters
APAP_14.1 <- as.data.frame(read_table2("apap14.c01.out"))
APAP_14.2 <- as.data.frame(read_table2("apap14.c02.out"))
APAP_14.3 <- as.data.frame(read_table2("apap14.c03.out"))
APAP_14.4 <- as.data.frame(read_table2("apap14.c04.out"))

# 21 Sensitivity parameters
APAP_19.1 <- as.data.frame(read_table2("apap19s.c01.out"))
APAP_19.2 <- as.data.frame(read_table2("apap19s.c04.out"))
APAP_19.3 <- as.data.frame(read_table2("apap19s.c06.out"))
APAP_19.4 <- as.data.frame(read_table2("apap19s.c08.out"))

# 58  parameters
APAP_58.1 <- as.data.frame(read_table2("apap58.c01.out"))
APAP_58.2 <- as.data.frame(read_table2("apap58.c02.out"))
APAP_58.3 <- as.data.frame(read_table2("apap58.c03.out"))
APAP_58.4 <- as.data.frame(read_table2("apap58.c04.out"))

org21.1<-APAP_21.1[902:1001, c(2,6,9,10,13,14,15,16,17,18,19,20,21,22,216)]
org21.2<-APAP_21.2[902:1001, c(2,6,9,10,13,14,15,16,17,18,19,20,21,22,216)]
org21.3<-APAP_21.3[902:1001, c(2,6,9,10,13,14,15,16,17,18,19,20,21,22,216)]
org21.4<-APAP_21.4[902:1001, c(2,6,9,10,13,14,15,16,17,18,19,20,21,22,216)]
org21.tot <- do.call(rbind, list(org21.1,org21.2,org21.3,org21.4))

sen14.1<-APAP_14.1[902:1001, c(c(2:15),146)]
sen14.2<-APAP_14.2[902:1001, c(c(2:15),146)]
sen14.3<-APAP_14.3[902:1001, c(c(2:15),146)]
sen14.4<-APAP_14.4[902:1001, c(c(2:15),146)]
sen14.tot <- do.call(rbind, list(sen14.1,sen14.2,sen14.3,sen14.4))

sen19.1<-APAP_19.1[902:1001, c(c(2:20),196)]
sen19.2<-APAP_19.2[902:1001, c(c(2:20),196)]
sen19.3<-APAP_19.3[902:1001, c(c(2:20),196)]
sen19.4<-APAP_19.4[902:1001, c(c(2:20),196)]
sen19.tot <- do.call(rbind, list(sen19.1,sen19.2,sen19.3,sen19.4))

n<-902:1001
all58.1<-APAP_58.1[n, c(c(2,6,9,10,13,14,15,16,17,18,19,20,21,22,23,38,39,42,43),586)]
all58.2<-APAP_58.2[n, c(c(2,6,9,10,13,14,15,16,17,18,19,20,21,22,23,38,39,42,43),586)]
all58.3<-APAP_58.3[n, c(c(2,6,9,10,13,14,15,16,17,18,19,20,21,22,23,38,39,42,43),586)]
all58.4<-APAP_58.4[n, c(c(2,6,9,10,13,14,15,16,17,18,19,20,21,22,23,38,39,42,43),586)]
all58.tot <- do.call(rbind, list(all58.1, all58.2, all58.3, all58.4))


distplt<-function(main, n, xlim, yup, v){
  plot(density(org21.tot[,n]),col="blue", xlim=xlim,
       lwd = 2, xlab = " ",ylab = " ", main=main, ylim=c(0,yup))
  lines(density(sen14.tot[,n]),col="red", lwd = 2)
  lines(density(sen19.tot[,n]),col="green", lwd = 2)
  lines(density(all58.tot[,n]),col="darkgreen", lwd = 2)
  abline(v = v, col="grey20")
}


distplt2<-function(main,n, yup, v){
  plot(density(sen19.tot[,n]),col="green",lwd = 2, xlab = " ",ylab = " ", main=main, 
       #xlim=xlim, 
       ylim=c(0,yup))
  lines(density(all58.tot[,n]),col="darkgreen", lwd = 2)
  abline(v = v, col="grey20")
}

#pdf(file="paradistrb.pdf", width = 12, height = 8)
png(file="paradistrb.png",width=4000,height=2800,res=250)
layout(matrix(c(1,1,1,1,1,1,1,
                2,3,4,5,6,7,8,
                9,10,11,12,13,14,15,
                16,16,16,16,16,16,16,
                17,18,19,20,21,22,23,
                24,24,24,24,24,24,24), ncol=7, byrow = T),
       heights=c(1.5,
                 3,
                 3,
                 1.5,
                 3,
                 6))

par(mar=c(1,1,1,1))
plot.new()
text(0.5,0.5,"Original parmeters",cex=1.5,font=2)
par(mar=c(2,4,2,0.5))

distplt("lnTg", 1, c(-2,0), 2, -1.4552)
distplt("lnSULT_Km_apap", 2, c(4.5,8.0), 2, 5.703)
distplt("lnSULT_VmaxC", 3, c(4.0,7.0), 2, NA)
distplt("lnUGT_Km", 4, c(7.2,9.6), 2, 8.6995)
distplt("lnUGT_VmaxC", 5, c(7.2,9.6), 2, NA)
distplt("lnkGA_syn", 10, c(8,14), 0.6, NA)
distplt("lnkPAPS_syn", 11, c(6,14), 0.6, NA)
distplt("lnKm_AG", 6, c(9,10.6), 2, 9.903)
distplt("lnVmax_AG", 7, c(9,11.6), 1.5, NA)
distplt("lnKm_AS", 8, c(9,10.6), 2, 10.039)
distplt("lnVmax_AS", 9, c(11.5,15.5), 1.5, NA)
distplt("lnCLC_APAP", 12, c(-6.5,-2.5), 2, NA)
distplt("lnCLC_AG", 13, c(-2.5,-1.), 4, NA)
distplt("lnCLC_AS", 14, c(-2.5,-1.), 4, NA)

plot.new()
text(0.5,0.5,"Additional parmeters",cex=1.5,font=2)

distplt2("lnQCC", 15, 3, 2.785011)
distplt2("lnBP_APAP", 16, 3, -0.1053605)
distplt2("lnPF_APAP", 17, 3, -0.8051967)
distplt2("lnPL_APAP", 18, 3, -0.3410828)
distplt2("lnPM_APAP", 19, 3, -0.375421)

plot.new()
plot.new()

par(mar=c(4,5,2,1))
plot(density(org21.tot[,15]),col="blue",lwd = 2, main="", 
     ylim=c(0,0.08), xlim=c(0,250), ylab="Density", xlab="LnData", frame.plot = FALSE,
     cex.lab=1.5, font.lab=2) # size and bold
axis(side = 1)
lines(density(sen14.tot[,15]),col="red", lwd = 2)
lines(density(sen19.tot[,20]),col="green", lwd = 2)
lines(density(all58.tot[,20]),col="darkgreen", lwd = 2)

text(60,0.06,"Original sensitive parmeters",cex=1.2, col="red")
text(110,0.06,"Original all parmeters",cex=1.2, col="blue")
text(135,0.05,"All sensitive parmeters",cex=1.2, col="green")
text(200,0.05,"All model parmeters",cex=1.2, col="darkgreen")

dev.off()

