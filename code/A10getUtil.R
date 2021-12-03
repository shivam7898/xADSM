# # source(paste0(.z$RX, "A10getUtil", ".R")) ==================================#

## ---- A10A-getMode ----
f_getMode <- function(x) {
  # #Calculate Statistical Mode
  # #NOTE: Single Length, All NA, Characters etc. have NOT been validated
  # #https://stackoverflow.com/questions/56552709
  # #https://stackoverflow.com/questions/2547402
  # #Remove NA
  if (anyNA(x)) {
    x <- x[!is.na(x)]
  }
  # #Get Unique Values
  ux <- unique(x)
  # #Match
  ux[which.max(tabulate(match(x, ux)))]
}