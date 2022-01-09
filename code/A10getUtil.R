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

## ---- A10B-pNum ----
f_pNum <- function(x, digits = 2L) {
  # #Print Numbers
  # #round(), rounds to a number of decimal places
  # #signif() rounds to a specific number of significant places
  # #if(){} else if(){} else{} is NOT vectorised
  #ifelse(abs(x) < 0.0000001, 0*sign(x), ifelse(abs(x) > 1, round(x, digits), signif(x, digits + 1L)))
  ifelse(abs(x) < 0.0000001, 0*sign(x), floor(x) + signif(x %% 1, digits))
}



