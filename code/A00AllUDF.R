## ---- A00 ----
# # source(paste0(.z$RX, "A00AllUDF", ".R")) =====================================================#

## ---- A00A-AllUDF ----
if(identical(0L, length(ls(pattern = "f_$")))) {
  source(paste0(.z$RX, "A01sanity", ".R"))
  source(paste0(.z$RX, "A02rmExist", ".R"))
  source(paste0(.z$RX, "A03getPathR", ".R"))
  source(paste0(.z$RX, "A04ls", ".R"))
  source(paste0(.z$RX, "A05ThemeGG", ".R"))
  source(paste0(.z$RX, "A06getRDS", ".R"))
  source(paste0(.z$RX, "A07getObject", ".R"))
  source(paste0(.z$RX, "A08getDef", ".R"))
  source(paste0(.z$RX, "A09isPrime", ".R"))
  source(paste0(.z$RX, "A10getUtil", ".R"))
  source(paste0(.z$RX, "A11getStat", ".R"))
  source(paste0(.z$RX, "A12pKbl", ".R"))
} else print("Functions not loaded again.")
## ---- A00Z ----
# #f_rmExist()
