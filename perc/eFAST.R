q <- rep("qtri", 16)
q.arg <- list(list(log(LeanBodyWt_min), log(LeanBodyWt_max), log(LeanBodyWt)),
              list(log(Flow_pul_min), log(Flow_pul_max), log(Flow_pul)),
              list(log(Vent_Perf_min), log(Vent_Perf_max), log(Vent_Perf)),
              list(log(Pct_M_fat_min), log(Pct_M_fat_max), log(Pct_M_fat)),
              list(log(Pct_LM_liv_min), log(Pct_LM_liv_max), log(Pct_LM_liv)),
              list(log(Pct_LM_wp_min), log(Pct_LM_wp_max), log(Pct_LM_wp)),
              list(log(Pct_Flow_fat_min), log(Pct_Flow_fat_max), log(Pct_Flow_fat)),
              list(log(Pct_Flow_liv_min), log(Pct_Flow_liv_max), log(Pct_Flow_liv)),
              list(log(Pct_Flow_pp_min), log(Pct_Flow_pp_max), log(Pct_Flow_pp)),
              list(log(PC_fat_min), log(PC_fat_max), log(PC_fat)),
              list(log(PC_liv_min), log(PC_liv_max), log(PC_liv)),
              list(log(PC_wp_min), log(PC_wp_max), log(PC_wp)),
              list(log(PC_pp_min), log(PC_pp_max), log(PC_pp)),
              list(log(PC_art_min), log(PC_art_max), log(PC_art)),
              list(log(sc_Vmax_min), log(sc_Vmax_max), log(sc_Vmax)),
              list(log(Km_min), log(Km_max), log(Km)))

fast <- fast99(model = NULL, factors = 16, n = 8192, M = 4, q = q, q.arg = q.arg)

fast.perc.df <- cbind(1, fast$X) # nrow = 131072
write.table(fast.perc.df, file="perc.setpoint.dat", row.names=FALSE, sep="\t")
system("./mcsim.perc perc.setpt2.in")
sim.fast <- as.data.frame(fread("perc.setpoint.out", head=T)) 

fst.1.1 <- tell(fast, sim.fast[,ncol(fast$X)+2])
fst.1.2 <- tell(fast, sim.fast[,ncol(fast$X)+3])
fst.1.3 <- tell(fast, sim.fast[,ncol(fast$X)+4])

fst.2.1 <- tell(fast, sim.fast[,ncol(fast$X)+5])
fst.2.2 <- tell(fast, sim.fast[,ncol(fast$X)+6])
fst.2.3 <- tell(fast, sim.fast[,ncol(fast$X)+7])

fst.3.1 <- tell(fast, sim.fast[,ncol(fast$X)+8])
fst.3.2 <- tell(fast, sim.fast[,ncol(fast$X)+9])
fst.3.3 <- tell(fast, sim.fast[,ncol(fast$X)+10])
