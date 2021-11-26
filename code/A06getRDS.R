## ---- A06 ----
# # source(paste0(.z$RX, "A06getRDS", ".R")) =====================================================#

## ---- A06A ----
f_getRDS <- function(x) {
# #Check if the File exists and then Read the Object
  obj_name <- deparse(substitute(x))
  obj_path <- paste0(.z$XL, obj_name, ".rds")
  if (file.exists(obj_path)) {
	return(readRDS(obj_path))
  } else {
    print(paste0("File Not Found: ", obj_path))
	return(NULL)
  }
# #xxCLOSE: f_getRDS()
}

## ---- A06B ----
f_dontOverwriteRDS <- function(x) {
# #Never Overwrite Object. Once an Object is written as NULL even then it wouldn't overwrite
  obj_name <- deparse(substitute(x))
  obj_path <- paste0(.z$XL, obj_name, ".rds")
  if (!file.exists(obj_path)) saveRDS(x, obj_path)
# #xxCLOSE: f_dontOverwriteRDS()
}

## ---- A06C ----
f_setRDS <- function(x) {
# #Overwrite Object, if file not found or if object is different (Reduce Writing Operation)
  obj_name <- deparse(substitute(x))
  obj_path <- paste0(.z$XL, obj_name, ".rds")
  if (file.exists(obj_path)) {
    obj_temp <- readRDS(obj_path)
# #Write Object if it is differnt from existing one
	if(!identical(obj_temp, x)) saveRDS(x, obj_path)
  } else {
    saveRDS(x, obj_path)
  }
# #xxCLOSE: f_setRDS()
}

## ---- A06Z ----
#f_rmExist()
