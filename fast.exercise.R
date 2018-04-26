library(sensitivity) # sobol.fun
library(ViSA)
library(dplyr)

set.seed(1234)
x<-rfast99(factors = 40, n = 100,
           q = "qunif", q.arg = list(min = 0, max = 1), replicate = 10, conf = 0.99)




n <- length(x$s)
factors <- length(x$factors)
replicate <- x$replicate

y <- array(1:replicate*n*factors, dim = c(n * factors, replicate))

for (i in 1 : x$rep) {
  y[,i]<-sensitivity::sobol.fun(x$a[,i,]) 
}

tell(x, y)

x

x %>% plot; abline(0.01, 0, lty = 2)

x %>% converge

#####

source("pbtk1comp_inits.R")

mName <- "pbtk1comp"
system (paste("R CMD SHLIB ", mName, ".c", sep = "")) # create .o and .so files
dyn.load(paste(mName, .Platform$dynlib.ext, sep=""))


q = "qunif"
q.arg = list(list(min = 0.7, max = 1.3),
             list(min = 0.1, max = 0.4),
             list(min = 0.9, max = 1.2))

x<-rfast99(factors = c("vdist", "ke", "kgutabs"),
           n = 200, q = q, q.arg = q.arg, rep = 10, conf = 0.99)

times <- seq(from = 0.5, to = 24.5, by = 1)
n <- length(x$s)
factors <- length(x$factors)
replicate <- x$rep
out <- length(times)
y <- array(1:replicate*n*factors*out, 
           dim = c(n * factors, replicate, out))

# define
parameters<-initparms1comp()
Y <- initState1comp(parms=parameters)
Y[1] <- 1



#
for (k in 1 : dim(y)[3]) { #outputs
  
  # Specific time or variable
  inputs = c(0, times[k])
  
  for (i in 1 : dim(y)[2]) { # replicate
    for (j in 1 : dim(y)[1]) { # Model evaluation
      parameters["vdist"] <- x$a[j,i,"vdist"]
      parameters["ke"] <- x$a[j,i,"ke"]
      parameters["kgutabs"] <- x$a[j,i,"kgutabs"]

      # Integrate
      tmp <- ode(Y, inputs, func = "derivs1comp", parms = parameters, 
                 jacfunc = "jac1comp", dllname = mName, 
                 initfunc = "initmod1comp", nout = 1, outnames = "Ccompartment")
      y[j,i,k] <- tmp[2, "Ccompartment"]
    }
  }
}


for ( i in 1:24){
  tell(x, y[,,i]) %>% plot; abline(0.01, 0, lty = 2); abline(0.01, 0, lty = 2)
  mtext(paste("Time = ", times[i],"hr"))  
}

for ( i in 1:length(times)){
  if ( i == 1) { # initialize
    results <- tell(x, y[,,i])$S[,"original"]
  } else { # accumulate
    results <- rbind(results, tell(x, y[,,i])$S[,"original"])
  }
}
colnames(results) <- names(parameters)
rownames(results) <- times


plot(rownames(results), results[,1], ylim=c(0,1), type="l", xlab="Time", ylab = "Sensitivity index")
lines(rownames(results), results[,2])
lines(rownames(results), results[,3])




tell(x, y[,,1]) %>% converge
tell(x, y[,,2]) %>% converge
tell(x, y[,,3]) %>% converge
tell(x, y[,,4]) %>% converge

