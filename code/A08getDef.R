## ---- A08 ----
# # source(paste0(.z$RX, "A08getDef", ".R")) =====================================================#

## ---- A08A-getDef ----
f_getDef <- function(x) {
# #Get the Referenced Definition. Ex: f_getDef("Data")
  cat(paste0("\n\n", "\\@ref(def:", x, ") ", knitr:::knit_code$get(x), collapse = "\n\n"))
# #xxCLOSE: f_getDef()
}

## ---- A08B-getExm ----
f_getExm <- function(x) {
# #Get the Referenced Definition. Ex: f_getExm("Hypothesis-Mean")
  cat(paste0("\n\n", "\\@ref(exm:", x, ") ", knitr:::knit_code$get(x), collapse = "\n\n"))
# #xxCLOSE: f_getExm()
}

## ---- A08Z ----
#f_rmExist()
