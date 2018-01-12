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

# 10 Sensitivity parameters
APAP_10.1 <- as.data.frame(read_table2("apap10d.c01.out"))
APAP_10.2 <- as.data.frame(read_table2("apap10d.c02.out"))
APAP_10.3 <- as.data.frame(read_table2("apap10d.c03.out"))
APAP_10.4 <- as.data.frame(read_table2("apap10d.c04.out"))

# 20 Sensitivity parameters
APAP_20.1 <- as.data.frame(read_table2("apap20d.c05.out"))
APAP_20.2 <- as.data.frame(read_table2("apap20d.c06.out"))
APAP_20.3 <- as.data.frame(read_table2("apap20d.c07.out"))
APAP_20.4 <- as.data.frame(read_table2("apap20d.c08.out"))

# 58  parameters
APAP_58.1 <- as.data.frame(read_table2("apap58.c01.out"))
APAP_58.2 <- as.data.frame(read_table2("apap58.c02.out"))
APAP_58.3 <- as.data.frame(read_table2("apap58.c03.out"))
APAP_58.4 <- as.data.frame(read_table2("apap58.c04.out"))

org21.1<-tail(APAP_21.1, 100)
org21.2<-tail(APAP_21.2, 100)
org21.3<-tail(APAP_21.3, 100)
org21.4<-tail(APAP_21.4, 100)
org21.tot <- do.call(rbind, list(org21.1,org21.2,org21.3,org21.4))

sen11.1<-tail(APAP_11.1, 100)
sen11.2<-tail(APAP_11.2, 100)
sen11.3<-tail(APAP_11.3, 100)
sen11.4<-tail(APAP_11.4, 100)
sen11.tot <- do.call(rbind, list(sen11.1,sen11.2,sen11.3,sen11.4))

add10.1<-tail(APAP_10.1, 100)
add10.2<-tail(APAP_10.2, 100)
add10.3<-tail(APAP_10.3, 100)
add10.4<-tail(APAP_10.4, 100)
add10.tot <- do.call(rbind, list(add10.1,add10.2,add10.3,add10.4))

add20.1<-tail(APAP_20.1, 100)
add20.2<-tail(APAP_20.2, 100)
add20.3<-tail(APAP_20.3, 100)
add20.4<-tail(APAP_20.4, 100)
add20.tot <- do.call(rbind, list(add20.1,add20.2,add20.3,add20.4))

all58.1<-tail(APAP_58.1, 100)
all58.2<-tail(APAP_58.2, 100)
all58.3<-tail(APAP_58.3, 100)
all58.4<-tail(APAP_58.4, 100)
all58.tot <- do.call(rbind, list(all58.1,all58.2,all58.3,all58.4))

org21.tot["M_lnTg(1)"]
sen11.tot["M_lnTg(1)"]
add20.tot["M_lnTg(1)"]
all58.tot["M_lnTg(1)"]

denplt5<-function(name1, name2, v){
  myData <- data.frame(org21.tot[name1], sen11.tot[name1], add10.tot[name1], add20.tot[name1], all58.tot[name1])
  dens <- apply(myData, 2, density)
  plot(NA, xlim=range(sapply(dens, "[", "x")), ylim=range(sapply(dens, "[", "y")), ylab="", xlab="", main = name2)
  mapply(lines, dens, col=c("red4", "red", "green", "springgreen3", "darkgreen"), lwd=2)
  abline(v = v, col="grey20")
}

denplt4<-function(name1, name2, v){
  myData <- data.frame(org21.tot[name1], sen11.tot[name1], add20.tot[name1], all58.tot[name1])
  dens <- apply(myData, 2, density)
  plot(NA, xlim=range(sapply(dens, "[", "x")), ylim=range(sapply(dens, "[", "y")), ylab="", xlab="", main = name2)
  mapply(lines, dens, col=c("red4", "red", "springgreen3", "darkgreen"), lwd=2)
  abline(v = v, col="grey20")
}

denplt3<-function(name1, name2, v){
  myData <- data.frame(org21.tot[name1], add20.tot[name1], all58.tot[name1])
  dens <- apply(myData, 2, density)
  plot(NA, xlim=range(sapply(dens, "[", "x")), ylim=range(sapply(dens, "[", "y")), ylab="", xlab="", main = name2)
  mapply(lines, dens, col=c("red4", "springgreen3", "darkgreen"), lwd=2)
  abline(v = v, col="grey20")
}

denplt33<-function(name1, name2, v){
  myData <- data.frame(add10.tot[name1], add20.tot[name1], all58.tot[name1])
  dens <- apply(myData, 2, density)
  plot(NA, xlim=range(sapply(dens, "[", "x")), ylim=range(sapply(dens, "[", "y")), ylab="", xlab="", main = name2)
  mapply(lines, dens, col=c("green", "springgreen3", "darkgreen"), lwd=2)
  abline(v = v, col="grey20")
}

denplt2<-function(name1, name2, v){
  myData <- data.frame(add20.tot[name1], all58.tot[name1])
  dens <- apply(myData, 2, density)
  plot(NA, xlim=range(sapply(dens, "[", "x")), ylim=range(sapply(dens, "[", "y")), ylab="", xlab="", main = name2)
  mapply(lines, dens, col=c("springgreen3", "darkgreen"), lwd=2)
  abline(v = v, col="grey20")
}



#pdf(file="fig5.pdf", width = 14, height = 12)
png(file="paradistrb.png",width=3500,height=3000,res=300)
layout(matrix(c(1,1,1,1,1,1,1,
                2,3,4,5,6,7,8,
                9,10,11,12,13,14,15,
                16,16,16,16,16,16,16,
                17,18,19,20,21,22,0,
                23,23,23,23,23,23,23), ncol=7, byrow = T),
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

denplt4("M_lnTg(1)", "lnTg", -1.4552)
denplt5("M_lnSULT_VmaxC(1)", "lnSULT_VmaxC", NA)
denplt5("M_lnUGT_VmaxC(1)", "lnUGT_VmaxC", NA)
denplt5("M_lnVmax_AG(1)", "lnVmax_AG", NA)
denplt5("M_lnVmax_AS(1)", "lnVmax_AS", NA)
denplt5("M_lnkGA_syn(1)", "lnkGA_syn", NA)
denplt5("M_lnkPAPS_syn(1)", "lnkPAPS_syn", NA)
denplt5("M_lnCLC_APAP(1)", "lnCLC_APAP", NA)
denplt5("M_lnCLC_AG(1)", "lnCLC_AG", NA)
denplt5("M_lnCLC_AS(1)", "lnCLC_AS", NA)
denplt4("M_lnSULT_Km_apap(1)", "lnSULT_Km_apap", 5.703)
denplt3("M_lnUGT_Km(1)", "lnUGT_Km", 8.6995)
denplt3("M_lnKm_AG(1)", "lnKm_AG",  9.903)
denplt3("M_lnKm_AS(1)", "lnKm_AS",  10.039)
plot.new()
text(0.5,0.5,"Additional parmeters",cex=1.5,font=2)
denplt2("M_lnQCC(1)", "lnQCC", 2.785011)
denplt33("M_lnBP_APAP(1)", "lnBP_APAP", -0.1053605)
denplt2("M_lnPF_APAP(1)", "lnPF_APAP", -0.8051967)
denplt2("M_lnPL_APAP(1)", "lnPL_APAP", -0.3410828)
denplt2("M_lnPM_APAP(1)", "lnPM_APAP", -0.375421)
denplt2("M_lnPS_APAP(1)", "lnPS_APAP", -0.375421)

par(mar=c(4,5,2,1))
name1<-"LnData"
myData <- data.frame(org21.tot[name1], sen11.tot[name1], add10.tot[name1], add20.tot[name1], all58.tot[name1])
dens <- apply(myData, 2, density)
plot(NA, xlim=range(sapply(dens, "[", "x")), ylim=range(sapply(dens, "[", "y")), 
     ylab="Density", xlab="LnData", frame.plot = FALSE, cex.lab=1.5, font.lab=2)
mapply(lines, dens, col=c("red4", "red", "green", "springgreen3", "darkgreen"), lwd=2)

text(95,0.065,"21 parameters / original set",cex=1.2, col="red4")
text(70,0.07,"11 parameters / original set (0.05)",cex=1.2, col="red")
text(40, 0.06,"10 parameters / full set (0.05)",cex=1.2, col="green")
text(135,0.05,"20 parameters / full set (0.01)",cex=1.2, col="springgreen3")
text(190,0.05,"58 parameters / full set",cex=1.2, col="darkgreen")

dev.off()

