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

## ---- A10C-wl ----
f_wl  <- function(...) {
# #Converts a list of multiple Wide Tibbles to list of multiple Long Tibbles
  w_bb <- f_namedList(...)
  cw_bb <- names(w_bb)
  l_bb <- w_bb %>% lapply(f_z_wl) 
# #Change last character "w" with "l"
  names(l_bb) <- sub(pattern = "w$", replacement = "l", cw_bb)
  list2env(l_bb, .GlobalEnv)
  #invisible(lapply(names(L), function(x) assign(x, L[[x]], .GlobalEnv)))
  print(names(l_bb))
}

## ---- A10D-z-wl ----
f_z_wl <- function(x) { 
# #Actual Function that apply standardise pipe to all Tibbles for wide to long
  x %>% 
    pivot_longer(everything(), names_to = "Keys", values_to = "Values") %>% 
    mutate(across(Keys, factor, levels = unique(Keys), labels = unique(Keys)))
}

## ---- A10E-namedList ----
f_namedList <- function(...) {
# #Creates Named List by using object names
  structure(list(...), names = as.list(substitute(list(...)))[-1L])
}