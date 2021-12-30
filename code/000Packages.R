# # source(paste0(.z$RX, "000Packages", ".R")) ===================================================#

if (!("conflicted" %in% (.packages()))) {
  pkg <- character(0)
  pkg <- c(pkg, "conflicted")
  pkg <- c(pkg, "ggplot2", "tibble", "tidyr", "readr", "purrr", "dplyr", "stringr", "forcats")
  pkg <- c(pkg, "kableExtra", "readxl", "latex2exp", "e1071", "lubridate", "car", "zoo")
  pkg <- c(pkg, "data.table", "gifski", "nycflights13", "gapminder", "Lahman")
  pkg <- c(pkg, "mice", "VIM", "qcc", "ggpmisc", "microbenchmark")
  pkg <- c(pkg, "compiler", "viridisLite", "scales", "psych")
  #lapply(pkg, FUN = library, character.only = TRUE)
  lapply(pkg, FUN = function(x) {suppressMessages(library(x, character.only = TRUE))})
#
# #Precedence
# # dplyr::filter | stats::filter
  invisible(suppressMessages(conflict_prefer("filter", "dplyr")))
# # ggplot2::annotate | ?::  
  invisible(suppressMessages(conflict_prefer("annotate", "ggplot2")))
# # dplyr::lag | stats::lag
  invisible(suppressMessages(conflict_prefer("lag", "dplyr"))) 
# # lubridate::week | data.table::week
  invisible(suppressMessages(conflict_prefer("week", "lubridate"))) 
# # lubridate::year | data.table::year
  invisible(suppressMessages(conflict_prefer("year", "lubridate")))  
# # lubridate::month | data.table::month
  invisible(suppressMessages(conflict_prefer("month", "lubridate")))  
# #Cleanup
  rm(pkg)
} else print("Packages not loaded again.")
