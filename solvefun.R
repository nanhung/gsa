# system.time(source("solvefun.R"))
y<-solve_fun(x, times, parameters = parameters, initState = initState, 
             outnames = outnames, dllname = mName,
             func = "derivs", initfunc = "initmod", lnparam = T, output = "C_blood")