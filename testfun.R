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

<<<<<<< HEAD
filenames <- c( tempfile(), tempfile() )
for( f in  filenames ){
  cat("We wish you a Merry Christmas!\n\nBest regards\n", file=f)
=======
install_mcsim = function(version = "6.0.1", directory = NULL) {
  if (.Platform$OS.type == "windows") {
    stop("The current function haven't supprot Windows system")
  } else {
    message("Start install")
    version<-version
    URL <- sprintf('http://ftp.gnu.org/gnu/mcsim/mcsim-%s.tar.gz', version)
    tf <- tempfile()
    download.file(URL, tf, mode = "wb")
    
    name <- Sys.info()[['user']]
    
    if (is.null(directory)){
      if (Sys.info()[['sysname']] == "Darwin"){
        exdir <- paste0("/Users/", name, sprintf('/mcsim-%s', version))
      } else if (Sys.info()[['sysname']] == "Linux") {
        exdir <- paste0("/home/", name, sprintf('/mcsim-%s', version))   
      } else if (Sys.info()[['sysname']] == "Windows") {
        exdir <- paste0("C:", sprintf('/mcsim-%s', version))
      }
    } else {exdir <- directory}
    
    utils::untar(tf, exdir = exdir)
    
    current.wd <- getwd()
    
    if (is.null(directory)){
      if (Sys.info()[['sysname']] == "Darwin"){
        setwd(paste0("/Users/", name, sprintf('/mcsim-%s', version)))
      } else if (Sys.info()[['sysname']] == "Linux") {
        setwd(paste0("/home/", name, sprintf('/mcsim-%s', version)))    
      } else if (Sys.info()[['sysname']] == "Windows") {
        setwd(paste0("C:/", name, sprintf('/mcsim-%s', version)))
      }
    } else {setwd(paste0(directory, sprintf('/mcsim-%s', version)))}
    
    mcsim.directory <-getwd()
    
    system("./configure")
    system("make")
    system("make check")
    
    input <- getPass::getPass("Authentication is required to install MCSim (Password): ")
    
    if (Sys.info()[['sysname']] == "Darwin"){
      system("sudo -kS make install", input=input)
    } else if (Sys.info()[['sysname']] == "Linux"){
      system("sudo -kS sh -c 'make install; ldconfig'", input=input)
    }
    
    cat("\n")
    message(paste0("The MCSim is installed under ", mcsim.directory))
    setwd(current.wd)
  }
>>>>>>> db76d5c6d38fcadad67f7f912f2775bd7368b2b9
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




