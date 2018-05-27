# system.time(source("solvefun.R"))
y0<-solve_fun(x, times, parameters = parameters, initParmsfun = "initParms", 
             initState = initState, outnames = outnames, dllname = mName,
             func = "derivs", initfunc = "initmod", output = "lnCPL_APAP_mcgL", method = "lsode",
             initforc="initforc", forcings=Forcings1)
y1<-solve_fun(x, times, parameters = parameters, initParmsfun = "initParms", 
             initState = initState, outnames = outnames, dllname = mName,
             func = "derivs", initfunc = "initmod", output = "lnCPL_AG_mcgL", method = "lsode",
             initforc="initforc", forcings=Forcings1)
y2<-solve_fun(x, times, parameters = parameters, initParmsfun = "initParms", 
             initState = initState, outnames = outnames, dllname = mName,
             func = "derivs", initfunc = "initmod", output = "lnCPL_AS_mcgL", method = "lsode",
             initforc="initforc", forcings=Forcings1)