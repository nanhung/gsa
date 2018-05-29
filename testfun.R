solve_fun <- function(x, times = NULL, parameters, initParmsfun = NULL, initState, dllname,
                      func, initfunc, outnames,
                      method ="lsode", rtol=1e-8, atol=1e-12,
                      model = NULL, lnparam = F, output, ...){
  n <- length(x$s)
  no.factors <- ifelse (class(x$factors) == "character", length(x$factors), x$factors)
  replicate <- x$rep
  out <- ifelse (is.null(times), 1, length(times))
  variables <- length(output)
  y <- array(dim = c(n * no.factors, replicate, out, variables), NA) # c(Model Evaluations, replicates, time points, variables)
  
  if (is.null(model) == TRUE){
    
    # Specific time or variable
    inputs = c(0, times) # NEED TIME AT ZERO
    
    for (i in 1 : dim(y)[2]) { # replicate
      for (j in 1 : dim(y)[1]) { # Model evaluation
        for (p in x$factors) {
          parameters[p] <- ifelse (lnparam == T,  exp(x$a[j,i,p]), x$a[j,i,p])
        }
        
        if (!is.null(initParmsfun) == TRUE){
          parms <- do.call(initParmsfun, list(parameters)) # Use the initParms function from _inits.R file, if the file had defined
        } else {
          stop("The 'initParmsfun' must be defined")
          #          parms <- .C("getParms", # "getParms" must actually named in c file
          #                      as.double(parameters),
          #                      parms=double(length(parameters)),
          #                      as.integer(length(parameters)))$parms
          #          names(parms) <- names(parameters)
        }
        
        # Integrate
        tmp <- deSolve::ode(initState, inputs, parms = parms, outnames = outnames, nout = length(outnames),
                            dllname = dllname, func = func, initfunc = initfunc, method = method,
                            rtol=rtol, atol=atol, ...)
        
        for (l in 1:variables){
          for (k in 1 : dim(y)[3]) { #output time
            y[j,i,k,l] <- tmp[k+1, output[l]] # skip zero
          }
        }
      }
    }
  } else {
    for (i in 1 : dim(y)[2]) { # Replicate
      for (j in 1 : dim(y)[1]) { # Model evaluation
        if (lnparam == T) { parameters <- exp(x$a[j,i,])}
        else if (lnparam == F) { parameters <- x$a[j,i,]}
        
        if (is.null(times)) tmp <- model(parameters) else tmp <- model(parameters, times)
        
        for (k in 1 : dim(y)[3]) { # Output time
          y[j,i,k] <- tmp[k]
        }
      }
    }
  }
  dimnames(y)[[3]]<-times
  return(y)
}


pksim <- function(y, variable = 1, log = F, legend = T, ...){
  times <- as.numeric(colnames(y[,1,,variable]))
  quantY <- apply(y, 3, quantile, c(0.50, 0, 1, 0.1, 0.9, 0.25,0.75), na.rm=TRUE)
  ytck <- pretty(c(min(quantY,na.rm=TRUE),max(quantY,na.rm=TRUE)))
  
  if (log == T){
    quantY[quantY <= 0] <- NA # prevent numerical error
    quantY <- log(quantY)
    ytck <- pretty(c(min(quantY, na.rm=TRUE),max(quantY, na.rm=TRUE)))
  }
  
  col.transp = adjustcolor('black', alpha.f = 0.2)
  plot(times, quantY[1,], type="l", xlab="", ylab="",
       ylim=c(min(ytck),max(ytck)), lty=1, las=1, lwd=2, col = 1)#, ...)
  if (any(is.na(quantY[2:3,])) == FALSE)
  {
    polygon(x = c(times, rev(times)), y = c(quantY[2,],quantY[3,seq(from=length(times),to=1,by=-1)]),col=col.transp,lty=0)
  }
  if (any(is.na(quantY[4:5,])) == FALSE)
  {
    polygon(x = c(times, rev(times)), y = c(quantY[4,],quantY[5,seq(from=length(times),to=1,by=-1)]),col=col.transp,lty=0)
  }
  if (any(is.na(quantY[6:7,])) == FALSE)
  {
    polygon(x = c(times, rev(times)), y = c(quantY[6,],quantY[7,seq(from=length(times),to=1,by=-1)]),col=col.transp,lty=0)
  }
  
  if (legend == T){
    legend('topright', # inset=c(0,1), xpd=TRUE, horiz=TRUE,
           legend = c('Median', '25%-75%', '10%-90%', 'min-max'),
           col = c('black','black','black','black'),
           lty = c(1,NA,NA,NA),
           lwd = c(2,NA,NA,NA),
           pch = NA, bty = 'n', text.col = 'black',
           fill = adjustcolor(c(NA, 'black', 'grey30','grey'),
                              alpha.f = 0.5), border = NA, cex = 0.7)
  }
}