compile <- function (mName, model = F) {
  if (model == T){ # Generate the ".c" file and "_inits.R" from model file 
    if(file.exists(paste0(mName, ".model")) && .Platform$OS.type == "unix"){
      system (paste0("mod -R ", mName, ".model ", mName,".c")) # model to c file
    } else if (.Platform$OS.type == "windows") {
      warning("The current function can't generate c file in Windows system")
    }
  }
  if (is.loaded("derivs", PACKAGE=mName))
    dyn.unload(paste0(mName,.Platform$dynlib.ext))
  
  if (.Platform$OS.type == "windows") {
    if (!(devtools::find_rtools() == TRUE)) {
      warning("The Rtools should be installed first") 
    }
  } 
  system (paste0("R CMD SHLIB ", mName, ".c")) # create .o and .so (or .dll) files
  
  dyn.load(paste0(mName, .Platform$dynlib.ext))
  
  if(file.exists(paste0(mName, "_inits.R"))){
    source(paste0(mName, "_inits.R"))
  }
}