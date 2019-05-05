# Update the version of pksensi
# devtools::install_github("nanhung/pksensi") 
library(pksensi)

mName <- "PFOA"
compile_model(mName)

# Input
n <- 1000
parameters <- c("ka","Qfilc","Vcc","k12","Rv2v1","Vfilc","Tmc","KT","Free")  
outputs <- c("Ccentral", "AUC", "A_gut","A_total")
times <- seq(0.5, 432.5, 1)

dist<-rep("LogNormal", 9)
q.arg<-list(list(209.284,	19.826),
            list(0.093,	2.541),
            list(0.566,	1.905),
            list(3.43E-03,	3.93E+03),
            list(1.232,	2.212),
            list(1.55E-04,	240.53),
            list(2.276,	1.143),
            list(0.031,	2.38),
            list(0.012,	2.137))


conditions <- c("## Group 1 Strain = CD-1 (F) Dosed 1 mg/kg/day at GD-1-17",
                "Dose  = NDoses(  34  , 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0  , 0 0.05 24 24.05 48 48.05 72 72.05 96	96.05	120	120.05	144	144.05	168	168.05	192	192.05	216	216.05	240	240.05	264	264.05	288	288.05	312	312.05	336	336.05	360	360.05	384	384.05 )")

# Generate input file "PFOA_MC.in"
generate_infile(rtol = 1e-13, atol = 1e-15, 
                params = parameters, vars = outputs, time = times, 
                n = n, dist = dist, q.arg = q.arg, condition = conditions) 

# Solve MCSim to "PFOA.mc.Lau.out"
set.seed(2222)
y<-solve_mcsim(mName = "PFOA", params = parameters, rtol = 1e-13, atol = 1e-15,
               vars = outputs, n = n, dist = dist, q.arg = q.arg, condition = conditions,
               time = times)

# Plot
pksim(y, vars = "Ccentral")
pksim(y, vars = "Ccentral", log = T)
#pksim(y, vars = "AUC")
#pksim(y, vars = "A_gut")
#pksim(y, vars = "A_total")

