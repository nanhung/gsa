species<-"Mouse.M.Kim.multistrain"
tce.vers<-"TCE.2.0.gamma.IS";
calib.file.name<-paste(tce.vers,".",species,".calib.in",sep="");
err1<-"1e-5, 0.3e-8";
set.seed(12345);
n.chains<-1;
n.restart<-1;
n.iter.start<-5000;
thin.vec<-c(50,50,50,50,50,50,50,100,100);
# MCMC files
for (n.c in 1:n.chains) {
  n.iter.tot<-0;
  for (n.r in 1:n.restart) {
    infile.name<-paste(tce.vers,".",species,".pop.",
                       n.c+n.r/10,".in",sep="");
    outfile.name<-paste(tce.vers,".",species,".pop.",
                        n.c+n.r/10,".out",sep="");
    if (n.r == 1) {
      restart.name<-"";
      n.iter.now <- n.iter.start;
      n.iter.tot <- n.iter.tot+n.iter.now;
      n.print.prev <- 0;
    } else {
      restart.name<-paste(tce.vers,".",species,".pop.",
                          n.c+(n.r-1)/10,".out",sep="");
      n.print.prev <- n.iter.now/thin.vec[n.r-1];
      n.iter.now <- n.iter.tot; # double total
      n.iter.tot <- n.iter.tot+n.iter.now;
    }
    cat("# USEPA TCE Model version ",tce.vers,"\n#\n#",
        "Data from Chiu et al. (2009):\n#",
        "Kept only Male B6C3F1 sex/strain\n#",
        "Kept only inhalation, IV, and oil gavage TCE dosing\n#",
        "Kept all TCA dosing\n#",
        "Added Kim individual data in B6C3F1\n#",
        "Added Branford individual data in other strains\n#",
        "TCA and DCA have background subtracted\n\n",
        file=infile.name,sep="");
    cat("Integrate(Lsodes, ",err1," , 1)\nMCMC (\"",
        outfile.name,"\",\n\"",restart.name,"\",\"\",\n",
        n.iter.now+n.print.prev,", 0, ",thin.vec[n.r],", ",
        n.iter.now+n.print.prev,", ",
        exp(runif(1,min=0,max=log(2147483646.0))),");\n\n",
        file=infile.name,append=TRUE,sep="");
    shell(paste("type",calib.file.name,">>",infile.name));
  }
}
