# # source(paste0(.z$RX, "000Packages", ".R")) ===================================================#

if (!("conflicted" %in% (.packages()))) {
  pkg <- character(0)
  pkg <- c(pkg, "conflicted")
  pkg <- c(pkg, "ggplot2", "tibble", "tidyr", "readr", "purrr", "dplyr", "stringr", "forcats")
  pkg <- c(pkg, "data.table", "gifski", "nycflights13", "gapminder", "Lahman", "lubridate")
  pkg <- c(pkg, "kableExtra", "readxl", "mice", "VIM", "moments", "qcc", "ggpmisc", "microbenchmark")
  pkg <- c(pkg, "compiler")
  #lapply(pkg, FUN = library, character.only = TRUE)
  lapply(pkg, FUN = function(x) {suppressMessages(library(x, character.only = TRUE))})
#
# #Precedence
  invisible(suppressMessages(conflict_prefer("filter", "dplyr")))
# #Cleanup
  rm(pkg)
} else print("Loaded!")
