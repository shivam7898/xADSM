# # source(paste0(.z$RX, "A07getObject", ".R")) ==================================================#
if (!("readr" %in% .packages())) library("readr")
if (!("readxl" %in% .packages())) library("readxl")

## ---- A07-getObject ----
f_getObject <- function(x_name, x_source, x_md = "") {
  # #Debugging
  a07bug <- FALSE
  # #Read the File or Object
  # #Ex: xxCars <- f_getObject("xxCars", "S16-cars2.csv", "30051fb47f65810f33cb992015b849cc")
  # #tools::md5sum("xx.csv")
  #
  # #Path to the File 
  loc_src <- paste0(.z$XL, x_source)
  # #Path to the Object
  loc_rds <- paste0(.z$XL, x_name, ".rds")
  #
  # #x_file[1] FILENAME & x_file[2] FILETYPE
  x_file <- strsplit(x_source, "[.]")[[1]]
  #
  if(all(x_md == tools::md5sum(loc_src),  file.exists(loc_rds),
  		file.info(loc_src)$mtime < file.info(loc_rds)$mtime)) {
      # #Read RDS if (exists, newer than source, source not modified i.e. passes md5sum)
      if(a07bug) print("A07 Flag 01: Reading from RDS")
      return(readRDS(loc_rds))
  } else if(!file.exists(loc_src)){
      message("ERROR: File does not exist! : ", loc_src, "\n")
	  stop()
  } else if(x_file[2] == "csv") {
      # #Read CSV as a Tibble
      # #col_double(), col_character(), col_logical(), col_integer()
      # #DATETIME (EXCEL) "YYYY-MM-DD HH:MM:SS" imported as "UTC"
      tbl <- read_csv(loc_src, show_col_types = FALSE)
	  # #Remove Unncessary Attributes
      attr(tbl, "spec") <- NULL
      attr(tbl, "problems") <- NULL
      # #Write Object as RDS
      saveRDS(tbl, loc_rds)
      # #Return Object
      if(a07bug) print("A07 Flag 02: Reading from Source and Saving as RDS")
	  return(tbl)
  } else if(x_file[2] == "xlsx") {
      # #Read All Sheets of Excel in a list
      tbl <- lapply(excel_sheets(loc_src), read_excel, path = loc_src)
      # #Write Object as RDS
      saveRDS(tbl, loc_rds)
      # #Return Object
      return(tbl)
  } else {
      message("f_getObject(): UNKNOWN")
	  stop()
  }
}
