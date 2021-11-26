## ---- A01 ----
# # source(paste0(.z$RX, "A01sanity", ".R")) =====================================================#

## ---- A01A-sanity ----
f_sanity <- function(x) {
# #To evaluate an object and return SINGLE TRUE or FALSE, NEVER NA, NEVER ERROR.
# #str(substitute(x)) is Symbol i.e. object name without quotes
# #str(deparse(substitute(x))) is character i.e. object name with quotes
  y <- deparse(substitute(x))
  env <- parent.frame()
  if (!exists(y, env)) {
    z <- paste0("Object does not exist: ", y)
  } else if (is.null(x)) {
# #'y' has the 'Object Name' that was passed to the Function, thus it is character(1)
# #'x' is the 'object', thus it may be of length(0) also.
    z <- paste0("Object is NULL: ", y)
  } else if (!identical(1L, length(x))) {
    z <- paste0("Object length is NOT 1. 'length(", y, ")': ", length(x))
  } else if (!is.vector(x)) {
    z <- paste0("Object is NOT a Vector. 'class(", y, ")': ", class(x))
  } else if (!is.atomic(x)) {
    z <- paste0("Object is NOT Atomic. 'class(", y, ")': ", class(x))
  } else if (is.infinite(x)) {
    z <- paste0("Object has Inf: ", y)
  } else if (anyNA(x)) {
    z <- paste0("Object has NA: ", y)
  } else {
# #Object Exists, is NOT NULL, Has Length 1, is Vector, is Atomic, is Finite, is NOT NA.
    return(TRUE)
  }
  print(paste0("f_sanity(): ", z))
  return(FALSE)
# #xxCLOSE: f_sanity()
}

## ---- A01B-sanity ----
f_1T <- function(x) {
# #Retun TRUE only if object pass sanity check and is logical and is TRUE
# #Benefit of NOT using all() but using '&&' is that later arguments are NOT evaluated
# #This results in proper FALSE, rather than being an ERROR on existance check of object
  y <- deparse(substitute(x))
  env <- parent.frame()
  if (!exists(y, env)) {
    z <- paste0("Object does not exist: ", y)
  } else if(f_sanity(x) && is.logical(x) && x) {
    return(TRUE)
  } else {
    z <- paste0("Object invalid: ", y)
  }
  print(paste0("f_1T(): ", z))
  return(FALSE)
# #xxCLOSE: f_1T()
}

## ---- A01C-about ----
f_about <- function(x) {
# # Returns a Named Vector with information about its class, type, NA etc.
# # Minimise the information shown, if it is a duplicate or TRUE for brevity  
  if(all(is.atomic(x), is.vector(x))) {
    if(any(identical(typeof(x), "integer"),identical(typeof(x), "double"))) {
      y <- paste("M=", summary(x)[1], ", X=", summary(x)[6], sep = "")
    } else if(identical(typeof(x), "logical")) {
      y <- paste("F=", summary(x)[2], ", T=", summary(x)[3], sep = "")
    } else if(identical(typeof(x), "character")) {
      y <- paste("N=", summary(x)[1], sep = "")
    } else 
      y <- "NONE"
  } else {
    y <- "NONE"
  }
    
  z <- c("class(x)" = class(x), 
       "typeof(x)" = if(identical(class(x), typeof(x))) "_" else typeof(x),
       #"is(x)[1]" = if(identical(class(x), is(x)[1])) "_" else is(x)[1],
       "length(x)" = length(x), 
       "is.atomic(x)" = if(is.atomic(x)) "_" else is.atomic(x), 
       "is.vector(x)" = if(is.vector(x)) "_" else is.vector(x), 
       "is.numeric(x)" = if(is.numeric(x)) "_" else is.numeric(x), 
       #"is(x)[2]" = is(x)[2], 
       "summary(x)" = y, 
       "anyNA(x) Count (M pos)" = if(anyNA(x)) {
         paste(sum(is.na(x)), " (", min(which(is.na(x))), ")", sep = "") 
         } else "_", 
       "0 ==anyDuplicated(x)" = if(identical(0L, anyDuplicated(x))) {
         "_" } else {
           identical(0L, anyDuplicated(x))}, 
       "n ==length(unique(x))" = if(identical(length(x), length(unique(x)))) {
         "_" } else {
           identical(length(x), length(unique(x)))}, 
       "names(x)" = if(is.null(names(x))) "_" else paste0(length(names(x)), "-", paste0(names(x)[1:2], collapse = ","), ",..."),
       "NA" = NA)
  str(x)
  return(z)
}

## ---- A01Z ----
# #f_rmExist()
