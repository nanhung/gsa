if(!require(readr)) {
  install.packages("readr"); require(readr)
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

#
org21.1<-APAP_21.1[902:1001, c(2, 9, 13, 15, c(17:22), 6, 10, 5, 14, 16, 216)]
org21.2<-APAP_21.2[902:1001, c(2, 9, 13, 15, c(17:22), 6, 10, 5, 14, 16, 216)]
org21.3<-APAP_21.3[902:1001, c(2, 9, 13, 15, c(17:22), 6, 10, 5, 14, 16, 216)]
org21.4<-APAP_21.4[902:1001, c(2, 9, 13, 15, c(17:22), 6, 10, 5, 14, 16, 216)]
org21.tot <- do.call(rbind, list(org21.1,org21.2,org21.3,org21.4))

#
sen11.1<-APAP_11.1[902:1001, c(2, c(4:12), 3, 116)]
sen11.2<-APAP_11.2[902:1001, c(2, c(4:12), 3, 116)]
sen11.3<-APAP_11.3[902:1001, c(2, c(4:12), 3, 116)]
sen11.4<-APAP_11.4[902:1001, c(2, c(4:12), 3, 116)]
sen11.tot <- do.call(rbind, list(sen11.1,sen11.2,sen11.3,sen11.4))

add20.1<-APAP_20.1[902:1001, c(2,5,7,9,c(11:16),4,6,3,8,10,c(17:21),206)]
add20.2<-APAP_20.2[902:1001, c(2,5,7,9,c(11:16),4,6,3,8,10,c(17:21),206)]
add20.3<-APAP_20.3[902:1001, c(2,5,7,9,c(11:16),4,6,3,8,10,c(17:21),206)]
add20.4<-APAP_20.4[902:1001, c(2,5,7,9,c(11:16),4,6,3,8,10,c(17:21),206)]

n<-2702:3001
all58.1<-APAP_58.1[n, c(2,9,13,15,c(17:22),6,10,5,14,16,23,38,39,42,43,586)]
all58.2<-APAP_58.2[n, c(2,9,13,15,c(17:22),6,10,5,14,16,23,38,39,42,43,586)]
all58.3<-APAP_58.3[n, c(2,9,13,15,c(17:22),6,10,5,14,16,23,38,39,42,43,586)]
all58.4<-APAP_58.4[n, c(2,9,13,15,c(17:22),6,10,5,14,16,23,38,39,42,43,586)]
all58.tot <- do.call(rbind, list(all58.1,all58.2,all58.3,all58.4))

distplt<-function(main, n, xlim, yup, v){
  plot(density(org21.tot[,n]),col="blue", xlim=xlim,
       lwd = 2, xlab = " ",ylab = " ", main=main, ylim=c(0,yup))
  lines(density(sen11.tot[,n]),col="red", lwd = 2)
  lines(density(add20.2[,n]),col="green", lwd = 2)
  lines(density(all58.tot[,n]),col="darkgreen", lwd = 2)
  abline(v = v, col="grey20")
}

# 
distplt2<-function(main, n, xlim, yup, v){
  plot(density(org21.tot[,n]),col="blue", xlim=xlim,
       lwd = 2, xlab = " ",ylab = " ", main=main, ylim=c(0,yup))
  #lines(density(sen11.tot[,n]),col="red", lwd = 2)
  lines(density(add20.2[,n]),col="green", lwd = 2)
  lines(density(all58.tot[,n]),col="darkgreen", lwd = 2)
  abline(v = v, col="grey20")
}

distplt3<-function(main,n, yup, v){
  plot(density(add20.2[,n]),col="green",lwd = 2, xlab = " ",ylab = " ", main=main, 
       #xlim=xlim, 
       ylim=c(0,yup))
  lines(density(all58.tot[,n]),col="darkgreen", lwd = 2)
  abline(v = v, col="grey20")
}

#pdf(file="paradistrb.pdf", width = 12, height = 8)
png(file="paradistrb.png",width=3000,height=2400,res=250)
layout(matrix(c(1,1,1,1,1,
                2,3,4,5,6,
                7,8,9,10,11,
                12,13,14,15,16,
                17,17,17,17,17,
                18,19,20,21,22,
                23,23,23,23,23), ncol=5, byrow = T),
       heights=c(1.5,
                 3,
                 3,
                 3,
                 1.5,
                 3,
                 6))

par(mar=c(1,1,1,1))
plot.new()
text(0.5,0.5,"Original parmeters",cex=1.5,font=2)
par(mar=c(2,4,2,0.5))

distplt("lnTg", 1, c(-2,0), 2.2, -1.4552)
distplt("lnSULT_VmaxC", 2, c(4.0,7.0), 2, NA)
distplt("lnUGT_VmaxC", 3, c(7.2,10.6), 4, NA)
distplt("lnVmax_AG", 4, c(9.3,11.5), 3, NA)
distplt("lnVmax_AS", 5, c(11,15), 2.0, NA)
distplt("lnkGA_syn", 6, c(6,14), 0.5, NA)
distplt("lnkPAPS_syn", 7, c(6,14), 0.5, NA)
distplt("lnCLC_APAP", 8, c(-6.5,-2), 1.5, NA)
distplt("lnCLC_AG", 9, c(-2.5,-1.), 4, NA)
distplt("lnCLC_AS", 10, c(-2.5,-1.), 4, NA)
distplt("lnSULT_Km_apap", 11, c(4.5,8.0), 2, 5.703)
distplt("lnUGT_Km", 12, c(7.6,9.6), 2, 8.6995)
distplt2("lnCYP_VMax", 13, c(-3.0,5.0), 0.5, NA)
distplt2("lnKm_AG", 14, c(8.9,10.9), 2, 9.903)
distplt2("lnKm_AS", 15, c(9.1,10.8), 2, 10.039)
plot.new()
text(0.5,0.5,"Additional parmeters",cex=1.5,font=2)
distplt3("lnQCC", 16, 2.0, 2.785011)
distplt3("lnBP_APAP", 17, 3, -0.1053605)
distplt3("lnPF_APAP", 18, 2.0, -0.8051967)
distplt3("lnPL_APAP", 19, 2.0, -0.3410828)
distplt3("lnPM_APAP", 20, 2.0, -0.375421)

par(mar=c(4,5,2,1))
plot(density(org21.tot[,16]),col="blue",lwd = 2, main="", 
     ylim=c(0,0.08), xlim=c(0,250), ylab="Density", xlab="LnData", frame.plot = FALSE,
     cex.lab=1.5, font.lab=2) # size and bold
axis(side = 1)
lines(density(sen11.tot[,12]),col="red", lwd = 2)
lines(density(add20.1[,21]),col="green", lwd = 2)
lines(density(all58.tot[,21]),col="darkgreen", lwd = 2)

text(40,0.06,"Original sensitive parmeters",cex=1.2, col="red")
text(110,0.06,"Original all parmeters",cex=1.2, col="blue")
text(135,0.05,"All sensitive parmeters",cex=1.2, col="green")
text(190,0.05,"All model parmeters",cex=1.2, col="darkgreen")

dev.off()

