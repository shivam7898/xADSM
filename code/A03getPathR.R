## ---- A03 ----
# # source(paste0(.z$RX, "A03getPathR", ".R")) ===================================================#

## ---- A03A ----
f_getPathR <- function(...) {
# #To convert FileNames to their Absolute Path with extension
# #Character vectors of passed FileNames
  x <- vapply(as.list(match.call()[-1]), FUN = deparse, FUN.VALUE = character(1)) 
# #Prepend Path and Append extension to All FileNames
  y <- vapply(x, function(x) paste0(.z$RX, x, ".R"), FUN.VALUE = character(1))
  return(y)
# #xxCLOSE: f_getPathR()
}

## ---- A03Z ----
