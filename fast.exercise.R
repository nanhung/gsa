# devtools::install_github("nanhung/ViSA")

library(ViSA)
library(dplyr)
library(deSolve)
#library(ggplot2)
# sensitivty

#### Sobol model

set.seed(1234)
x<-rfast99(factors = 20, n = 100,
           q = "qunif", q.arg = list(min = 0, max = 1), replicate = 10, conf = 0.99)

n <- length(x$s)
factors <- x$factors
replicate <- x$replicate

out <- 1 # Not time dependent

y <- array(dim = c(n * factors, replicate, out), NA)

for (i in 1 : x$rep) {
  y[,i,]<-sensitivity::sobol.fun(x$a[,i,]) 
}

tell.rfast99(x, y[,,1])

x %>% plot; abline(0.01, 0, lty = 2) 

x %>% converge

####

sobol.fun<-function (parameters) {
  a <- c(0, 1, 4.5, 9, 99, 99, 99, 99)
  y <- 1
  for (j in 1:8) {
    y <- y * (abs(4 * parameters[j] - 2) + a[j])/(1 + a[j])
  }
  y
}

x<-rfast99(factors = 20, n = 100,
           q = "qunif", q.arg = list(min = 0, max = 1), replicate = 10, conf = 0.99)

y<-solve_fun(x, model = sobol.fun)

tell2(x, y)


check(x)
check(x, SI = 0.05, CI = 0.05)

##### the Verhulst model of population dynamics

Verhulst <- function(parameters, times)
{
  output <- parameters[1]/(1 + (parameters[1]/parameters[2] - 1) * exp(-parameters[3] * times))
  return(output)
}

#
q = "qunif"
q.arg = list(list(min=100, max=1000), 
             list(min=1, max=40),
             list(min = 0.05, max = 0.2))

set.seed(1234)
x<-rfast99(factors=c("K","Y0","a"),
           n = 200, q = q, q.arg = q.arg, rep = 10, conf = 0.99)

times <- seq(from = 5, to = 100, by = 5)

y<-solve_fun(x, times, model = Verhulst)

tell2(x,y)

check.rfast99(x)
check.rfast99(x, SI = 0.05, CI = 0.05)

##### MCSim under R (use deSolve package)
# pros: Don't need to create in file
# cons: ?

compile <- function (mName)
  if (.Platform$OS.type == "windows") {
    message("The current function haven't supprot Windows system")
  } else {  # Unix; good luck
    if (is.loaded("derivs", PACKAGE=mName))
      dyn.unload(paste0(mName,.Platform$dynlib.ext))
    if(file.exists(paste0(mName, ".model"))){
      system (paste0("mod -R ", mName, ".model ", mName,".c")) # model to c file
    }
    system (paste0("R CMD SHLIB ", mName, ".c")) # create .o and .so files
    dyn.load(paste(mName, .Platform$dynlib.ext, sep=""))
    
    if(file.exists(paste0(mName, "_inits.R"))){
      source(paste0(mName, "_inits.R"))
    }
  }





mName = "pbtk1comp"
compile(mName)

q = "qunif"
q.arg = list(list(min = 0.7, max = 1.3),
             list(min = 0.1, max = 0.4),
             list(min = 0.9, max = 1.2))

x<-rfast99(factors = c("vdist", "ke", "kgutabs"),
           n = 100, q = q, q.arg = q.arg, rep = 10, conf = 0.99)

times <- seq(from = 0.5, to = 24.5, by = 1)
parameters<-initparms1comp()
initState <- initState1comp(parms=parameters)
initState[1] <- 1

y<-solve_fun(x, times, parameters = parameters, initState, outnames = "Ccompartment",
             dllname = mName, func = "derivs1comp", jacfunc = "jac1comp", initfunc = "initmod1comp")

tell2(x,y)


check(x)
check(x, SI = 0.05, CI = 0.05)

## Check each time point; time = 0.5
# tell(x, y[,,"0.5"]) %>% converge
# x

#####

plot(rownames(x$mSI), x$mSI[,1], ylim=c(0,1), type="l", xlab="Time", ylab = "Sensitivity index")
lines(rownames(x$mSI), x$mSI[,2])
lines(rownames(x$mSI), x$mSI[,3])
abline(0.05, 0, lty = 2); abline(0.01, 0, lty = 3)

plot(rownames(x$tSI), x$tSI[,1], ylim=c(0,1), type="l", xlab="Time", ylab = "Sensitivity index")
lines(rownames(x$tSI), x$tSI[,2])
lines(rownames(x$tSI), x$tSI[,3])
abline(0.05, 0, lty = 2); abline(0.01, 0, lty = 3)

#####

for ( i in 1:dim(y)[3]){
  tell.rfast99(x, y[,,i]) %>% plot; abline(0.01, 0, lty = 2); abline(0.01, 0, lty = 2); abline(0.05, 0, lty = 3)
  mtext(paste("Time = ", dimnames(y)[[3]][i],"hr")) 
}

####
tell(x, y[,,1]) %>% converge
tell(x, y[,,2]) %>% converge
tell(x, y[,,3]) %>% converge
tell(x, y[,,4]) %>% converge

####

testX <- reshape::melt(x$tSI)  %>% 
  mutate(category = cut(value, breaks=c(-Inf, 0.01, 0.05, Inf), labels=c("0-0.01","0.01-0.05",">0.05")))

cols <- c("0-0.01" = "grey", "4" = "pink", "0.01-0.05" = "pink", ">0.05" = "red")

ggplot(testX, aes( X1, X2)) + 
  geom_tile(aes(fill = category), colour = "white") +
  scale_fill_manual(values= cols)+
  scale_x_continuous(expand=c(0,0)) +
  scale_y_discrete(expand=c(0,0)) + 
  labs(title="Sensitivity index", x="Time", y="Parameters") + 
  theme(axis.text.x = element_text(size=10, hjust = 1), 
        axis.text.y = element_text(size=10), legend.title=element_blank(),
        legend.position="top")


###

testX <- reshape::melt(x$mCI)  %>% 
  mutate(category = cut(value, breaks=c(-Inf, 0.05, 0.1, Inf), labels=c("0-0.05","0.05-0.1",">0.1")))

cols2 <- c("0-0.05" = "grey", "4" = "pink", "0.05-0.1" = "pink", ">0.1" = "red")

ggplot(testX, aes( X1, X2)) + 
  geom_tile(aes(fill = category), colour = "white") +
  scale_fill_manual(values= c("grey", "pink", "red"))+
  scale_x_continuous(expand=c(0,0)) +
  scale_y_discrete(expand=c(0,0)) + 
  labs(title="Convergence index", x="Time", y="Parameters") + 
  theme(axis.text.x = element_text(size=10, hjust = 1), 
        axis.text.y = element_text(size=10), legend.title=element_blank(),
        legend.position="top")

