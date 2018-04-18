set.seed(1234)
morr <- morris(model = NULL, factors = 16, r = 100, 
               design = list(type = "oat", levels = 5, grid.jump = 3), 
               binf = c(log(LeanBodyWt_min),
                        log(Flow_pul_min),
                        log(Vent_Perf_min),
                        log(Pct_M_fat_min), 
                        log(Pct_LM_liv_min), 
                        log(Pct_LM_wp_min),
                        log(Pct_Flow_fat_min), 
                        log(Pct_Flow_liv_min), 
                        log(Pct_Flow_pp_min), 
                        log(PC_fat_min), 
                        log(PC_liv_min), 
                        log(PC_wp_min), 
                        log(PC_pp_min), 
                        log(PC_art_min),
                        log(sc_Vmax_min), 
                        log(Km_min)
               ),
               bsup = c(log(LeanBodyWt_max),
                        log(Flow_pul_max),
                        log(Vent_Perf_max),
                        log(Pct_M_fat_max), 
                        log(Pct_LM_liv_max), 
                        log(Pct_LM_wp_max),
                        log(Pct_Flow_fat_max), 
                        log(Pct_Flow_liv_max), 
                        log(Pct_Flow_pp_max), 
                        log(PC_fat_max), 
                        log(PC_liv_max), 
                        log(PC_wp_max), 
                        log(PC_pp_max), 
                        log(PC_art_max),
                        log(sc_Vmax_max), 
                        log(Km_max)), scale = TRUE)                  

morr.perc.df <- cbind(1, morr$X) 
nrow(morr$X) # nrow=17408
write.table(morr.perc.df, file="perc.setpoint.dat", row.names=FALSE, sep="\t")
system("./mcsim.perc perc.setpt2.in")
sim.morris <- as.data.frame(fread("perc.setpoint.out", head = T))


mor.1.1 <- tell(morr, sim.morris[,ncol(morr$X)+2])
mor.1.2 <- tell(morr, sim.morris[,ncol(morr$X)+3])
mor.1.3 <- tell(morr, sim.morris[,ncol(morr$X)+4])

mor.2.1 <- tell(morr, sim.morris[,ncol(morr$X)+5])
mor.2.2 <- tell(morr, sim.morris[,ncol(morr$X)+6])
mor.2.3 <- tell(morr, sim.morris[,ncol(morr$X)+7])

mor.3.1 <- tell(morr, sim.morris[,ncol(morr$X)+8])
mor.3.2 <- tell(morr, sim.morris[,ncol(morr$X)+9])
mor.3.3 <- tell(morr, sim.morris[,ncol(morr$X)+10])

mu.star.1.1 <- apply(mor.1.1$ee, 2, function(x) mean(abs(x)))
mu.star.1.2 <- apply(mor.1.2$ee, 2, function(x) mean(abs(x)))
mu.star.1.3 <- apply(mor.1.3$ee, 2, function(x) mean(abs(x)))
mu.star.2.1 <- apply(mor.2.1$ee, 2, function(x) mean(abs(x)))
mu.star.2.2 <- apply(mor.2.2$ee, 2, function(x) mean(abs(x)))
mu.star.2.3 <- apply(mor.2.3$ee, 2, function(x) mean(abs(x)))
mu.star.3.1 <- apply(mor.3.1$ee, 2, function(x) mean(abs(x)))
mu.star.3.2 <- apply(mor.3.2$ee, 2, function(x) mean(abs(x)))
mu.star.3.3 <- apply(mor.3.3$ee, 2, function(x) mean(abs(x)))

sigma.1.1 <- apply(mor.1.1$ee, 2, sd)
sigma.1.2 <- apply(mor.1.2$ee, 2, sd)
sigma.1.3 <- apply(mor.1.3$ee, 2, sd)
sigma.2.1 <- apply(mor.2.1$ee, 2, sd)
sigma.2.2 <- apply(mor.2.2$ee, 2, sd)
sigma.2.3 <- apply(mor.2.3$ee, 2, sd)
sigma.3.1 <- apply(mor.3.1$ee, 2, sd)
sigma.3.2 <- apply(mor.3.2$ee, 2, sd)
sigma.3.3 <- apply(mor.3.3$ee, 2, sd)