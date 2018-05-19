# Define and initialize the state variables
y <- c("Q_fat" = 0, # Quantity of butadiene in fat (mg)
       "Q_wp" = 0, # ~ in well-perfused (mg)
       "Q_pp" = 0, # ~ in poorly-perfused (mg)
       "Q_met" = 0) # ~ metabolized (mg)

# Define the model parameters
# Units:
# Volumes: liter
# Time: minute
# Flows: liter / minute
parameters <- c("BDM" = 73, # Body mass (kg)
               "Height" = 1.6, # Body height (m)
               "Age" = 40, # in years
               "Sex" = 1, # code 1 is male, 2 is female
               "Flow_pul" = 5, # Pulmonary ventilation rate (L/min)
               "Pct_Deadspace" = 0.7, # Fraction of pulmonary deadspace
               "Vent_Perf" = 1.14, # Ventilation over perfusion ratio
               "Pct_LBDM_wp" = 0.2, # wp tissue as fraction of lean mass
               "Pct_Flow_fat" = 0.1, # Fraction of cardiac output to fat
               "Pct_Flow_pp" = 0.35, # ~ to pp
               "PC_art" = 2, # Blood/air partition coefficient
               "PC_fat" = 22, # Fat/blood ~
               "PC_wp" = 0.8, # wp/blood ~
               "PC_pp" = 0.8, # pp/blood ~
               "Kmetwp" = 0.25) # Rate constant for metabolism

min_per_week <- 60 * 24 * 7

x1 <- seq(1, min_per_week, 1440)
x2 <- seq(480, min_per_week, 1440)
duration <- as.vector(matrix(c(x1, x2), nrow = 2, byrow = TRUE))
exposure <- rep(c(10,0.1),length(duration)/2)
C_inh <- approxfun(x = duration, y = exposure, method="constant", f=0, rule=2)

# Check the input concentration profile just defined
plot(C_inh(1:min_per_week), xlab = "Time (min)",
     ylab = "Butadiene air concentration (ppm)", type = "l")

# Define the model equations
bd.model = function(t, y, parameters) {
  with (as.list(y), {
    with (as.list(parameters), {
      
      # Define the fixed parameters
      Height = 1.6
      Age = 40
      Sex = 1
      
      # Define some useful constants
      MW_bu = 54.0914 # butadiene molecular weight (in grams)
      ppm_per_mM = 24450 # ppm to mM under normal conditions
      # Conversions from/to ppm
      ppm_per_mg_per_l = ppm_per_mM / MW_bu
      mg_per_l_per_ppm = 1 / ppm_per_mg_per_l
      # Calculate Flow_alv from total pulmonary flow
      Flow_alv = Flow_pul * (1 - Pct_Deadspace)
      # Calculate total blood flow from Flow_alv and the V/P ratio
      Flow_tot = Flow_alv / Vent_Perf
      # Calculate fraction of body fat
      Pct_BDM_fat = (1.2 * BDM / (Height * Height) - 10.8
                     *(2 - Sex) +
                       0.23 * Age - 5.4) * 0.01
      # Actual volumes, 10% of body mass (bones…) get no butadiene
      Eff_V_fat = Pct_BDM_fat * BDM
      Eff_V_wp = Pct_LBDM_wp * BDM * (1 - Pct_BDM_fat)
      Eff_V_pp = 0.9 * BDM - Eff_V_fat - Eff_V_wp
      # Calculate actual blood flows from total flow and percent flows
      Flow_fat = Pct_Flow_fat * Flow_tot
      Flow_pp = Pct_Flow_pp * Flow_tot
      Flow_wp = Flow_tot * (1 - Pct_Flow_pp - Pct_Flow_fat)
      # Calculate the concentrations
      C_fat = Q_fat / Eff_V_fat
      C_wp = Q_wp / Eff_V_wp
      C_pp = Q_pp / Eff_V_pp
      # Venous blood concentrations at the organ exit
      Cout_fat = C_fat / PC_fat
      Cout_wp = C_wp / PC_wp
      Cout_pp = C_pp / PC_pp
      # Sum of Flow * Concentration for all compartments
      dQ_ven = Flow_fat * Cout_fat + Flow_wp * Cout_wp + Flow_pp * Cout_pp
      C_inh.current = C_inh(t) # to avoid calling C_inh() twice
      # Arterial blood concentration
      # Convert input given in ppm to mg/l to match other units
      C_art = (Flow_alv * C_inh.current * mg_per_l_per_ppm + dQ_ven) / (Flow_tot + Flow_alv / PC_art)
      # Venous blood concentration (mg/L)
      C_ven = dQ_ven / Flow_tot
      # Alveolar air concentration (mg/L)
      C_alv = C_art / PC_art
      # Exhaled air concentration (ppm!)
      if (C_alv <= 0) {
        C_exh = 10E-30 # avoid round off errors
      } else {
        C_exh = (1 - Pct_Deadspace) * C_alv * ppm_per_mg_per_l +
          Pct_Deadspace * C_inh.current
      }
      # Quantity metabolized in liver (included in well-perfused)
      dQmet_wp = Kmetwp * Q_wp
      # Differentials for quantities
      dQ_fat = Flow_fat * (C_art - Cout_fat)
      dQ_wp = Flow_wp * (C_art - Cout_wp) - dQmet_wp
      dQ_pp = Flow_pp * (C_art - Cout_pp)
      dQ_met = dQmet_wp
      # The function bd.model must return at least the derivatives
      list(c(dQ_fat, dQ_wp, dQ_pp, dQ_met), # derivatives
           c("C_ven" = C_ven, "C_art" = C_art)) # extra outputs
    }) # end with parameters
  }) # end with y
} # end bd.model

# Define the computation output times
times <- seq(from = 0, to = min_per_week, by = 10)
# Call the ODE solver
library(deSolve)
results <- ode(times = times, func = bd.model, y = y, parms = parameters)

# results is basically a table
results
# Plot the results of the simulation
plot(results, col="red")
# End
# End Simple Simulation.

# Monte Carlo simulations
# We assume that a simple simulation has already been run, so that
# y, parameters, C_inh, and bd.model have all been defined and that
# deSolve has been loaded.

library(sensitivity)

factors <- c("BDM", "Flow_pul", "Pct_Deadspace", "Vent_Perf", 
             "Pct_LBDM_wp", "Pct_Flow_fat", "Pct_Flow_pp", 
             "PC_art", "PC_fat", "PC_wp", "PC_pp",
             "Kmetwp")

LL <- 0.9
UL <- 1.1

binf <- c(parameters["BDM"]*LL, 
          parameters["Flow_pul"]*LL,
          parameters["PC_art"]*LL,
          parameters["Kmetwp"]*LL)
bsup <- c(parameters["BDM"]*UL, 
          parameters["Flow_pul"]*UL,
          parameters["PC_art"]*UL,
          parameters["Kmetwp"]*UL)

set.seed(12345)
x <- morris(model = NULL, factors = factors, r = 20,
            design = list(type = "oat", levels = 5, grid.jump = 3), 
            binf = binf, bsup = bsup, scale = TRUE)


for (iteration in 1:nrow(x$X)) { # 1000 Monte Carlo simulations…
  # Sample randomly some parameters

  parameters["BDM"] = x$X[iteration,"BDM"]
  parameters["Flow_pul"] = x$X[iteration,"Flow_pul"]
  parameters["PC_art"] = x$X[iteration,"PC_art"]
  parameters["Kmetwp"] = x$X[iteration,"Kmetwp"]
  
  # Reduce output times eventually. We only care about time 1440,
  # but time zero still needs to be specified
  times = c(0, 480) # the first 8-hour 
  # Integrate
  tmp = ode(times = times, func = bd.model, y = y, parms = parameters)
  if (iteration == 1) { # initialize
    results = tmp[2,-1]
    sampled.parms = c(parameters["BDM"],
                      parameters["Flow_pul"],
                      parameters["PC_art"], parameters["Kmetwp"])
  } else { # accumulate
    results = rbind(results, tmp[2,-1])
    sampled.parms = rbind(sampled.parms,
                          c(parameters["BDM"],
                            parameters["Flow_pul"],
                            parameters["PC_art"], parameters["Kmetwp"]))
  }
} # end Monte Carlo loop

# Save the results, specially if they took a long time to compute
tell(x, results[,"C_ven"])

ee.mean <- apply(abs(x$ee), 2, mean)
ee.sd <- apply(abs(x$ee), 2, sd)
ee.sd / ee.mean



xlim <- c(min(abs(x$ee)), max(abs(x$ee)))
plot(x, xlim=xlim)
abline(0,1) # non-linear and/or non-monotonic
abline(0,0.5, lty = 2) # monotonic
abline(0,0.1, lty = 3) # almost linear

for (i in 1:ncol(x$X)){
  plot(x$X[,i], x$y)  
}


# use load(file="MTC.dat.xz") to read them back in
# Plot the results
hist(sampled.parms[,1])
hist(results[,1])
plot(sampled.parms[,1], results[,1])

# End Monte Carlo Simulations.
#============================