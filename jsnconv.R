# V1 -----
jsn<-function(n, nboot){
  X1 <- J.X.df(n); X2 <- J.X.df(n);
  J.S <- soboljansen(NULL, X1, X2, conf = 0.95, nboot = nboot)
  J.S$X <- log(J.S$X)
  J.S.APAP.df <- cbind(1, J.S$X)
  write.table(J.S.APAP.df, file="apap_setpoint.dat", row.names=FALSE, sep="\t")
  system("./mcsim.apap.pbpk_v2 apap.setpoint_v1.in")
  J.S.APAP.mcsim.df <- as.data.frame(fread("apap_setpoint.csv", head = T))
  tell(J.S, J.S.APAP.mcsim.df[,23])
}

j.s.4000<-jsn(4000, 1000)
#Read 92000 rows and 46 (of 46) columns from 0.032 GB file in 00:00:03
j.s.8000<-jsn(8000, 1000)
#Read 184000 rows and 46 (of 46) columns from 0.064 GB file in 00:00:05
j.s.16000<-jsn(16000, 1000)
#Read 368000 rows and 46 (of 46) columns from 0.128 GB file in 00:00:10


max(j.s.4000$S[,5]-j.s.4000$S[,4]) # 0.08688998
max(j.s.8000$S[,5]-j.s.8000$S[,4]) # 0.05786181
max(j.s.16000$S[,5]-j.s.16000$S[,4]) # 0.04303337


max(j.s.4000$T[,5]-j.s.4000$T[,4]) # 0.06668348
max(j.s.8000$T[,5]-j.s.8000$T[,4]) # 0.04303337
max(j.s.16000$T[,5]-j.s.16000$T[,4]) # 0.03406756


# V2 -----
jsn<-function(n, nboot){
  X1 <- J.X.df(n); X2 <- J.X.df(n);
  J.S <- soboljansen(NULL, X1, X2, conf = 0.95, nboot = nboot)
  J.S$X <- log(J.S$X)
  J.S.APAP.df <- cbind(1, J.S$X)
  write.table(J.S.APAP.df, file="apap_setpoint.dat", row.names=FALSE, sep="\t")
  system("./mcsim.apap.pbpk_v2 apap.setpoint_v2.in")
  J.S.APAP.mcsim.df <- as.data.frame(fread("apap_setpoint.csv", head = T))
  tell(J.S, J.S.APAP.mcsim.df[,60])
}


j.s.16000<-jsn(16000, 1000)
#Read 960000 rows and 83 (of 83) columns from 0.639 GB file in 00:00:45

max(j.s.4000$S[,5]-j.s.4000$S[,4]) 
max(j.s.8000$S[,5]-j.s.8000$S[,4]) 
max(j.s.16000$S[,5]-j.s.16000$S[,4]) # 0.04631187

max(j.s.4000$T[,5]-j.s.4000$T[,4]) 
max(j.s.8000$T[,5]-j.s.8000$T[,4]) 
max(j.s.16000$T[,5]-j.s.16000$T[,4]) # 0.03524233
