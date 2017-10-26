if(!require(readr)) {
  install.packages("readr"); require(readr)
}

# 21 Original parameters
APAP_21.1 <- as.data.frame(read_table2("apap21.c02.out"))
APAP_21.2 <- as.data.frame(read_table2("apap21.c03.out"))
APAP_21.3 <- as.data.frame(read_table2("apap21.c04.out"))
APAP_21.4 <- as.data.frame(read_table2("apap21.c05.out"))

# 14 Sensitivity parameters
APAP_14.1 <- as.data.frame(read_table2("apap14.c01.out"))
APAP_14.2 <- as.data.frame(read_table2("apap14.c02.out"))
APAP_14.3 <- as.data.frame(read_table2("apap14.c03.out"))
APAP_14.4 <- as.data.frame(read_table2("apap14.c04.out"))

# 21 Sensitivity parameters
APAP_21s.1 <- as.data.frame(read_table2("apap21s.c01.out"))
APAP_21s.2 <- as.data.frame(read_table2("apap21s.c02.out"))
APAP_21s.3 <- as.data.frame(read_table2("apap21s.c03.out"))
APAP_21s.4 <- as.data.frame(read_table2("apap21s.c04.out"))

org21.1<-APAP_21.1[902:1001, c(2,6,9,10,13,14,15,16,17,18,19,20,21,22,5,216)]
org21.2<-APAP_21.2[902:1001, c(2,6,9,10,13,14,15,16,17,18,19,20,21,22,5,216)]
org21.3<-APAP_21.3[902:1001, c(2,6,9,10,13,14,15,16,17,18,19,20,21,22,5,216)]
org21.4<-APAP_21.4[902:1001, c(2,6,9,10,13,14,15,16,17,18,19,20,21,22,5,216)]
org21.tot <- do.call(rbind, list(org21.1,org21.2,org21.3,org21.4))

sen14.1<-APAP_14.1[902:1001, c(c(2:15),146)]
sen14.2<-APAP_14.2[902:1001, c(c(2:15),146)]
sen14.3<-APAP_14.3[902:1001, c(c(2:15),146)]
sen14.4<-APAP_14.4[902:1001, c(c(2:15),146)]
sen14.tot <- do.call(rbind, list(sen14.1,sen14.2,sen14.3,sen14.4))

sen21s.1<-APAP_21s.1[902:1001, c(c(2:22),216)]
sen21s.2<-APAP_21s.2[902:1001, c(c(2:22),216)]
sen21s.3<-APAP_21s.3[902:1001, c(c(2:22),216)]
sen21s.4<-APAP_21s.4[902:1001, c(c(2:22),216)]
sen21s.tot <- do.call(rbind, list(sen21s.1,sen21s.2,sen21s.3,sen21s.4))

distplt<-function(main, n, yup){
  plot(density(org21.tot[,n]),col="blue",lwd = 2, xlab = " ",ylab = " ", main=main, ylim=c(0,yup))
  lines(density(sen14.tot[,n]),col="red", lwd = 2)
  lines(density(sen21s.tot[,n]),col="green", lwd = 2)
}


distplt2<-function(main,n,yup, v, xlim){
  plot(density(sen21s.tot[,n]),col="green",lwd = 2, xlab = " ",ylab = " ", main=main, 
       xlim=xlim, ylim=c(0,yup))
  #lines(density(all.2.tot[,n]),col="darkgreen", lwd = 2)
  abline(v = v, col="blue")
}

pdf(file="paradistrb.pdf", width = 12, height = 8)
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

distplt("lnTg", 1, 2)
distplt("lnSULT_Km_apap", 2, 2)
distplt("lnSULT_VmaxC", 3, 2)
distplt("lnUGT_Km", 4, 2)
distplt("lnUGT_VmaxC", 5, 2)
distplt("lnkGA_syn", 10, 2)
distplt("lnkPAPS_syn", 11, 2)
distplt("lnVmax_AG", 6, 4)
distplt("lnKm_AG", 7, 4)
distplt("lnVmax_AS", 8, 4)
distplt("lnKm_AS", 9, 4)
distplt("lnCLC_APAP", 12, 4)
distplt("lnCLC_AG", 13, 4)
distplt("lnCLC_AS", 14, 4)

plot.new()
text(0.5,0.5,"Additional parmeters",cex=1.5,font=2)

distplt("lnCYP_VmaxC", 15, 2.5)
distplt2("lnQCC", 16, 2.5, 2.785011, c(2,4))
distplt2("lnBP_APAP", 17, 2.5, -0.1053605, c(-1,0.1))
distplt2("lnPF_APAP", 18, 2.5, -0.8051967, c(-1,1))
distplt2("lnPL_APAP", 19, 2.5, -0.3410828, c(-1,2))
distplt2("lnPM_APAP", 20, 2.5, -0.375421, c(-1,1))
distplt2("lnPS_APAP", 21, 2.5, -0.5008753, c(-2,1.5))


par(mar=c(4,5,2,1))
plot(density(org21.tot[,16]),col="blue",lwd = 2, main="", 
     ylim=c(0,0.08), xlim=c(0,300), ylab="Density", xlab="LnData", frame.plot = FALSE,
     cex.lab=1.5, font.lab=2) # size and bold
axis(side = 1)
lines(density(sen14.tot[,15]),col="red", lwd = 2)
lines(density(sen21s.tot[,22]),col="green", lwd = 2)

text(50,0.06,"Original sensitive parmeters",cex=1.2, col="red")
text(110,0.06,"Original all parmeters",cex=1.2, col="blue")
text(140,0.05,"All sensitive parmeters",cex=1.2, col="green")

dev.off()



