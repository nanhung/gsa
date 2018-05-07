# devtools::install_github("nanhung/ViSA")

library(rfast99)
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

x %>% ViSA::converge # Not used

####

set.seed(1234)
x<-rfast99(factors = 20, n = 1000,
           q = "qunif", q.arg = list(min = 0, max = 1), replicate = 10, conf = 0.99)

y<-solve_fun(x, model = sobol.fun)

tell2(x, y)


check(x)
check(x, SI = 0.05, CI = 0.05)

## Flip-Flop Kinetics ####
FFPK <- function(parameters, times, dose = 500){
  A <- (dose * parameters[1])/( parameters[3]*( parameters[1]- parameters[2]))
  CONC <- A*exp(- parameters[2] * times) - A*exp(- parameters[1] * times)
  return(CONC)
}

q = "qunif"
q.arg = list(list(min = 0.2, max = 1), 
             list(min = 0.2, max = 1),
             list(min = 1, max = 5))

set.seed(1234)
x<-rfast99(factors=c("KA","KE","V"),
           n = 4000, q = q, q.arg = q.arg, rep = 10, conf = 0.99)

times <- seq(from = 0.5, to = 48, by = 0.5)

y<-solve_fun(x, model = FFPK, times = times)

tell2(x,y)

check.rfast99(x)
check.rfast99(x, SI = 0.05, CI = 0.05)


##

plot.rfast99 <- function(x, ...){
  
  nv <- length(colnames(x$tSI))+1
  nc <- ceiling(sqrt(nv))
  nr <- nv/nc
  
  par(mfrow = c(nr, nc), mar = c(4,2,4,1))
  for(i in 1:ncol(x$tSI)){
    plot(times, x$tSI[,i], ylim = c(0, 1), bty = 'n',
         type = 'l', lwd = 2, xlab = 'time', ylab = '', 
         main = colnames(x$tSI)[i])
    col.transp = adjustcolor('black', alpha = 0.4)
    polygon(x = c(times, rev(times)),
            y =c(x$tSI[,i]-x$tCI[,i], rev(x$tSI[,i]+x$tCI[,i])),
            col = col.transp, border = col.transp)
    
    col.transp = adjustcolor('red', alpha = 0.4)
    lines(times, x$mSI[,i], ylim = c(0, 1), bty = 'n',
          lwd = 2, col = 'red')
    polygon(x = c(times, rev(times)),
            y =c(x$mSI[,i]-x$mCI[,i], rev(x$mSI[,i]+x$mCI[,i])),
            col = col.transp, border = col.transp)
  }
  plot.new()
  legend('top', legend = c('total order', 'first order'), col = c('black','red'),
         lty = 'solid', lwd = 1, pch = NA, bty = 'n',
         text.col = 'black', 
         fill = adjustcolor(c('black', 'red'), alpha = 0.4), border = NA, cex = 1.2)
}

plot.rfast99(x)
  

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


####

q = "qunif"
q.arg = list(list(min = 0.7, max = 1.3),
             list(min = 0.1, max = 0.4),
             list(min = 0.9, max = 1.2))





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


####
library(ggplot2)


tidy_index <- function (x, index = "CI") {
  if(!("dplyr" %in% (.packages()))){
    if(!require(dplyr)) install.packages("dplyr") else require(dplyr)
  }
  
  if(index == "CI") {
    m <- reshape::melt(x$mCI) %>% cbind(order = "first order")
    i <- reshape::melt(x$iCI) %>% cbind(order = "interaction")
    t <- reshape::melt(x$tCI) %>% cbind(order = "total order")
    X <- do.call(rbind, list(m, i, t))   
  } else if (index == "SI") {
    m <- reshape::melt(x$mSI) %>% cbind(order = "first order")
    i <- reshape::melt(x$iSI) %>% cbind(order = "interaction")
    t <- reshape::melt(x$tSI) %>% cbind(order = "total order")
    X <- do.call(rbind, list(m, i, t)) 
  }
  names(X) <- c("time", "parameter", "value", "order")
  return(X)
}

##
X <- tidy_index(x, index = "SI") %>% mutate(category = cut(value, breaks=c(-Inf, 0.01, 0.05, Inf), labels=c("0-0.01","0.01-0.05",">0.05")))
cols <- c("0-0.01" = "grey", "4" = "pink", "0.01-0.05" = "pink", ">0.05" = "red")

ggplot(X, aes(time, parameter)) + 
  geom_tile(aes(fill = category), colour = "white") +
  scale_fill_manual(values= cols)+
  scale_x_continuous(expand=c(0,0)) +
  scale_y_discrete(expand=c(0,0)) + 
  facet_grid(~order) +
  labs(title="Sensitivity index", x="Time", y="Parameters") + 
  theme(axis.text.x = element_text(size=10, hjust = 1), 
        axis.text.y = element_text(size=10), legend.title=element_blank(),
        legend.position="top")


###
X <- tidy_index(x, index = "CI") %>% mutate(category = cut(value, breaks=c(-Inf, 0.05, 0.1, Inf), labels=c("0-0.05","0.05-0.1",">0.05")))
cols2 <- c("0-0.05" = "grey", "4" = "pink", "0.05-0.1" = "pink", ">0.1" = "red")

ggplot(X, aes( time, parameter)) + 
  geom_tile(aes(fill = category), colour = "white") +
  scale_fill_manual(values= c("grey", "pink", "red"))+
  scale_x_continuous(expand=c(0,0)) +
  scale_y_discrete(expand=c(0,0)) +
  facet_grid(~order) +
  labs(title="Convergence index", x="Time", y="Parameters") + 
  theme(axis.text.x = element_text(size=10, hjust = 1), 
        axis.text.y = element_text(size=10), legend.title=element_blank(),
        legend.position="top")

