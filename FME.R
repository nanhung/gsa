HIV_R <- function (pars, V_0 = 50000, dV_0 = -200750, T_0 = 100) {
  
  derivs <- function(time, y, pars) {
    with (as.list(c(pars, y)), {
      dT <- lam - rho * T - bet * T * V
      dI <- bet * T * V - delt * I
      dV <- n * delt * I - c * V - bet * T * V
      
      return(list(c(dT, dI, dV), logV = log(V)))
    })
  }
  
  # initial conditions
  I_0   <- with(as.list(pars), (dV_0 + c * V_0) / (n * delt))
  y     <- c(T = T_0, I = I_0, V = V_0)
  
  times <- c(seq(0, 0.8, 0.1), seq(2, 60, 2))
  out   <- deSolve::ode(y = y, parms = pars, times = times, func = derivs)
  
  as.data.frame(out)
}

pars <- c(bet = 0.00002, rho = 0.15, delt = 0.55, c = 5.5, lam = 80, n = 900)
out <- HIV_R(pars = pars)

par(mfrow = c(1, 2))
plot(out$time, out$logV, main = "Viral load", ylab = "log(V)",
     xlab = "time", type = "b")
plot(out$time, out$T, main = "CD4+ T", ylab = "-", xlab = "time", type = "b")
par(mfrow = c(1, 1))

set.seed(1234)
DataLogV <- cbind(time = out$time,
                  logV = out$logV + rnorm(sd = 0.45, n = length(out$logV)),
                  sd = 0.45)

ii    <- which (out$time %in% seq(0, 56, by = 4))
DataT <- cbind(time = out$time[ii],
               T = out$T[ii] + rnorm(sd = 4.5, n = length(ii)),
               sd = 4.5)
head(DataT)

HIVcost <- function (pars) {
  out <- HIV_R(pars)
  cost <- FME::modCost(model = out, obs = DataLogV, err = "sd")
  return(FME::modCost(model = out, obs = DataT, err = "sd", cost = cost))
}

HIVcost(pars)$model

plot(HIVcost(pars), xlab="time", legpos="topright")


ref  <- HIV_R(pars)
pert <- HIV_R(pars*c(1.1,1,1,1,1,1))
ss   <- (pert$logV-ref$logV)/pert$logV
plot(ref$time,ref$logV,type="l",lwd=2,xlab="time",ylab="logV",
     main="local sensitivity, parameter bet")
lines(pert$time,pert$logV,lwd=2,lty=2)
arrseq <- seq(9,36,6)#c(10,30,50,70,90)
arrows(ref$time[arrseq],ref$logV[arrseq],
       ref$time[arrseq],pert$logV[arrseq], length= 0.075)

legend("bottomright",c("bet=2e-5","bet=2.2e-5"),lty=c(1,2))
par(new=TRUE)
par(fig=c(0.5,0.99,0.5,0.95))
plot(ref$time,ss,type="l",lwd=2,
     xlab="",ylab="",axes=FALSE,frame.plot=TRUE)
points(ref$time[arrseq],ss[arrseq])
title("Sensitivity functions ",line=0.5,cex.main=1)
par(fig=c(0,1,0,1))

Sfun <- FME::sensFun(HIVcost, pars)
summary(Sfun)

plot(Sfun, which = c("logV", "T"), xlab="time", lwd = 2)

pairs(Sfun, which = c("logV", "T"), col = c("blue", "green"))

ident <- FME::collin(Sfun)
head(ident, n = 20)

plot(ident, log="y")


FME::collin(Sfun, parset = c("bet", "rho", "delt", "c", "lam", "n"))

FME::collin(Sfun, N=5)


HIVcost2 <- function(lpars) HIVcost(c(exp(lpars), n = 900))

Pars <- pars[1:5] * 2
Fit <- FME::modFit(f = HIVcost2, p = log(Pars))
exp(coef(Fit))
deviance(Fit)

ini   <- HIV_R(pars = c(Pars, n = 900))
final <- HIV_R(pars = c(exp(coef(Fit)), n = 900))

#
par(mfrow = c(1,2))
plot(DataLogV, xlab = "time", ylab = "logV", ylim = c(7, 11))
lines(ini$time, ini$logV, lty = 2)
lines(final$time, final$logV)
legend("topright", c("data", "initial", "fitted"),
       lty = c(NA,2,1), pch = c(1, NA, NA))
plot(DataT, xlab = "time", ylab = "T")
lines(ini$time, ini$T, lty = 2)
lines(final$time, final$T)
par(mfrow = c(1, 1))


var0 <- Fit$var_ms_unweighted
cov0 <- summary(Fit)$cov.scaled * 2.4^2/5
MCMC <- FME::modMCMC(f = HIVcost2, p = Fit$par, niter = 5000, jump = cov0,
                var0 = var0, wvar0 = 0.1, updatecov = 50)

save(MCMC, file="mcmc.Rdata")
load("mcmc.Rdata")

MCMC$pars <- exp(MCMC$pars)
summary(MCMC)

par(mar=c(4, 4, 3, 1) + .1)
plot(MCMC, Full = TRUE)

pairs(MCMC, nsample = 1000,cex.labels=1.4,cex=0.7)

sR <- FME::sensRange(func = HIV_R, parms = pars, parInput = MCMC$par)
plot(summary(sR), xlab = "time")


#####


parRange <- cbind(min = 0.75 * pars, max = 1.25 * pars)
crlfun <- function (pars)  return(meanVirus = mean(HIV_R(pars)$V))

CRL <- FME::modCRL(fun = crlfun, parRange = parRange, num = 500)

cor(CRL)[7, ]
plot(CRL, ylab = "number of virions", trace = TRUE)
