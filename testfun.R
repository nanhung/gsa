infile.name <- "APAP.setpoint.in"
outfile.name <- "setpoint.csv"
conditions <- "mgkg_flag = 0; OralExp_APAP = NDoses(2, 1 0, 0 0.75); OralDur_APAP = 0.75; OralDose_APAP_mg = 1000.0; IVExp_APAP = 0.; IVDose_APAP_mg = 0.;"

parameters<-c("lnTg", "lnTp",
              "lnCYP_Km","lnCYP_VmaxC",
              "lnSULT_Km_apap","lnSULT_Ki","lnSULT_Km_paps","lnSULT_VmaxC",
              "lnUGT_Km","lnUGT_Ki","lnUGT_Km_GA","lnUGT_VmaxC",
              "lnKm_AG","lnVmax_AG","lnKm_AS","lnVmax_AS",
              "lnkGA_syn","lnkPAPS_syn",
              "lnCLC_APAP","lnCLC_AG","lnCLC_AS")
output <- c("lnCPL_APAP_mcgL", "lnCPL_AG_mcgL", "lnCPL_AS_mcgL")
times <- seq(from = 0.01, to = 12.01, by = 0.4)
rtol <- 1e-6
atol <- 1e-9


mName<-"APAP_PBPK_thera"

filenames <- c( tempfile(), tempfile() )
for( f in  filenames ){
  cat("We wish you a Merry Christmas!\n\nBest regards\n", file=f)
}

## Replace Merry Christmas with Happy New Year
for( f in filenames ){
  
  x <- readLines(f)
  y <- gsub( "Merry Christmas", "Happy New Year", x )
  cat(y, file=f, sep="\n")
  
}

## Review output
for( f in filenames ){ 
  cat(readLines(f), sep="\n")
}


tmp <-readLines("http://ftp.gnu.org/gnu/mcsim/")
y <- gsub("mcsim", tmp)




