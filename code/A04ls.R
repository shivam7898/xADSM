## ---- A04 ----
# # source(paste0(.z$RX, "A04ls", ".R")) =========================================================#

## ---- A04A ----
f_ <- function() {
# #List Additional Objects
# #Environments
if(FALSE){
  env <- c(".GlobalEnv", ".z")
# #Packages Base
  pp <- "package:"
  base <- c("stats", "graphics", "grDevices", "datasets", "utils", "methods", "base")
  pbase <- paste0(pp, base)
# #Get All
  aa <- search()
# #Remove Environments 
  aa <- aa[-match(env, aa)]
  bb <- "+2 Env"
# #Remove Packages Base
  aa <- aa[-match(pbase, aa)]
  bb <- paste0(bb, ", +7 base")
# #Remove "tools:rstudio" 
  if("tools:rstudio" %in% aa) {
  aa <- aa[-match("tools:rstudio", aa)]
  bb <- paste0(bb, " +RStudio")
  }
# #Remove "Autoloads" 
  if("Autoloads" %in% aa) {aa <- aa[-match("Autoloads", aa)]}
# #Remove "package:tidyverse" 
  if("package:tidyverse" %in% aa) {
  tidy <- c("tidyverse", "ggplot2", "tibble", "tidyr", "readr", "purrr", "dplyr", "stringr", "forcats")
  ptidy <- paste0(pp, tidy)
  aa <- aa[-match(ptidy, aa)]
  bb <- paste0(bb, ", +9 tidy")
  }
# #Remove "package:Lahman" 
  if("package:Lahman" %in% aa) {
  r4ds <- c("data.table", "gifski", "nycflights13", "gapminder", "Lahman", "lubridate")
  pr4ds <- paste0(pp, r4ds)
  aa <- aa[-match(pr4ds, aa)]
  bb <- paste0(bb, ", +6 r4ds")
  }
# #Replace Term "package:"
  aa <- gsub(pp, "", aa)
  }
# #Print
#  cat("Packages", bb, " :", paste0(aa, collapse=", "), "\n")
  x_cr <- ls(.GlobalEnv)
# #Match object names starting with "f_" i.e. Functions
  x_fun_lg <- grepl("^f_", x_cr)
# #Objects which are NOT functions
  x_cr <- x_cr[!x_fun_lg]
# #Remove some objects which starts from "k_" i.e. for knitr, not to be shown
  x_knit_lg <- grepl("^k_", x_cr)
  x_cr <- x_cr[!x_knit_lg]
# #Match object names starting with "q_" and drop them from the vector
  x_knit_lg <- grepl("^q_", x_cr)
  x_cr <- x_cr[!x_knit_lg]
# #Count Functions
#  cat("Functions (", length(x_cr[x_fun_lg]), ") & Objects (", length(x_no_fun),") : \n")
# #Objects
  #print(x_cr)
  paste0(x_cr, collapse = ", ")
# #xxCLOSE: f_()
}

## ---- A04Z ----
#f_rmExist()

