## ---- A02 ----
# # source("A02rmExist.R")) ======================================================================#

## ---- A02A-rmExist ----
f_rmExist <- function(...) {
# #To delete objects only if they exist i.e. "f_rmExist(z)"
  x <- vapply(as.list(match.call()[-1]), FUN = deparse, FUN.VALUE = character(1)) 
  rm(list = x[vapply(x, FUN = exists, FUN.VALUE = logical(1))], envir = parent.frame())
# #xxCLOSE: f_rmExist()
}

## ---- A02Z ----
# #f_rmExist()
