# https://link.springer.com/article/10.1208/s12248-017-0102-8
# https://link.springer.com/article/10.1007/s13318-018-0537-z

library(pksensi)
mName <- "acat2cpt_v3.0"
compile_model(mName, app = "mcsim")

subject <- "2849"
t <- c(0.5, 0.75, 1, 1.5, 2, 3, 4, 6, 8, 24, 48)
C <- c(NA, NA, 78.3, NA, 63.6, 24.6, 29.7, 16.7, 10.4, 5.57, 2.84)
df <- data.frame(subject, t, C)


# dose (mg/kg) * BDM (kg) / MW * 1000 # uM

MW <- 239.743
Mol_vol <- MW/1.5
Solubility <- 312e6

params <- c("K_precip", 
            "lnPeff", 
            "lnV_central",
            "lnKelim")

q <- "qunif"
q.arg <-list(list(0.72, 7.2), 
             list(-7.8, -4),
             list(6, 7),
             list(-3.2, -1.7)) # half lives 10-15 hr
#times <- c(0.25, 0.5, 0.75, 1, 1.5, 2, 3, 4, 6, 8, 24, 48)
times <- seq(0.01, 49.01, 1)
output <- c("C_central", "Q_periph", "Q_liver", "Q_gi_lu_d", "Q_gi_ep", "Q_gi_w", "Q_total")
set.seed(1234)
x <- rfast99(params = params, n = 512, q = q, q.arg = q.arg, replicate = 1) 

fix_params <- c("f_Abs_stom = 1",
                "f_Abs_duod = 1",
                "f_Abs_jeju = 1",
                "f_Abs_ileum = 1",
                "f_Abs_cecum = 1",
                "f_Abs_colon = 1",
                "lnFu_plasma = 0", 
                "lnFu_stom = 0", 
                "lnFu_duod = 0", 
                "lnFu_jeju = 0", 
                "lnFu_ileum = 0",
                "lnFu_cecum = 0",
                "lnFu_colon = 0", 
                "lnFu_liver = 0",
                "lnFu_vitro_stom = 0",
                "lnFu_vitro_duod = 0",
                "lnFu_vitro_jeju = 0", 
                "lnFu_vitro_ileum = 0",
                "lnFu_vitro_cecum = 0", 
                "lnFu_vitro_colon = 0",
                "lnFu_vitro_liver = 0",
                "lnVmax_eff_stom = -13",
                "lnVmax_eff_duod = -13",
                "lnVmax_eff_jeju = -13",
                "lnVmax_eff_ileum = -13",
                "lnVmax_eff_cecum = -13",
                "lnVmax_eff_colon = -13",
                "lnVmax_eff_liver = -13",
                "lnVmax_inf_stom = -13",
                "lnVmax_inf_duod = -13",
                "lnVmax_inf_jeju = -13",
                "lnVmax_inf_ileum = -13",
                "lnVmax_inf_cecum = -13",
                "lnVmax_inf_colon = -13",
                "lnVmax_inf_liver = -13",
                "lnKm_eff = 6",
                "lnKm_inf = 6",
                "G_immediate_d = 1",    
                "G_immediate_u = 0",   
                "G_delayed_d  = 0",    
                "G_delayed_u  = 0",
                "lnKm_met_vitro = 1.824549",
                "lnVmax_met_vitro = -13",
                "lnKe_over_a_epit = -6.9",
                "lnKe_over_a_tiss = 0",
                "lnKc2p = -13",
                "lnKp2c = 0")
give_dose <- "Oral_dose_rate = NDoses(2, 3128.35 0, 0 0.1)" # 75mg

conditions <- c(fix_params, give_dose, 
                paste("MM =", MW),
                paste("Mol_vol =", Mol_vol),
                paste("Solubility =", Solubility))

generate_infile(params = params,
                vars = output,
                time = times, 
                condition = conditions) 

y <- solve_mcsim(x, mName = mName, 
                 params = params,
                 vars = output,
                 time = times,
                 condition = conditions,
                 generate.infile = F)

#par(mfrow = c(2,3))
pksim(y, var = 1)
points(df$t, df$C/MW) # uM
#pksim(y, var = 2)
#pksim(y, var = 3)
#pksim(y, var = 4)
#pksim(y, var = 5)
#pksim(y, var = 6)
#pksim(y, var = 7)



#pksim(y, log = T)
#points(df$t, log(df$C/MW)) # uM
