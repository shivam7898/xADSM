## ---- A12 ----
# # source(paste0(.z$RX, "A12pKbl", ".R")) =======================================================#

## ---- A12A-pKbl ----
f_pKbl <- function(x, caption, headers = names(x), debug = FALSE, maxrows = 30L) {
# #Print Kable Standard Formats: f_pKbl(hh, cap_hh, headers = names_hh, debug = TRUE)
# #Kable Prints FULL DATASET passed to it.
# #names() does NOT work on Matrices but colnames() works
# #even though names() is superior to colnames() in all other aspects
# #We can do a conditional check on type ane then call relevant function but for now
# #Supply colnames() manually if using Matrices
#
  if(nrow(x) > maxrows) {
  #Print only the Head of Big Datasets by checking if it has more rows than maxrows
    x <- head(x)
  }
  txt_colour  <- ifelse(debug, "black", "white")
  result <- kbl(x,
    caption = cap_hh,
    col.names = headers,
    escape = FALSE, align = "c", booktabs = TRUE
    ) %>%
    kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive"),
                  html_font = "Consolas",	font_size = 12,
                  full_width = FALSE,
                  #position = "float_left",
                  fixed_thead = TRUE
    ) %>%
# #Header Row Dark & Bold: RGB (48, 48, 48) =HEX (#303030)
	  row_spec(0, color = "white", background = "#303030", bold = TRUE,
	           extra_css = "border-bottom: 1px solid; border-top: 1px solid"
	  ) %>% row_spec(row = 1:nrow(x), color = txt_colour)
  return(result)
# #xxCLOSE: f_pKbl()
}

## ---- A12B-pKblM ----
f_pKblM <- function(x, caption, isTri = TRUE, negPos = c(-0.0000001, 0.0000001), dig = 1L, ...) {
# #Description: 
# Prints Kable Matrix Standard Format: f_pKblM(hh, cap_hh)
# Calls: f_pKbl()
# #Arguments: 
# x: Matrix
# caption: Table Title with Table Number in "(AXXTYY)" Format
# isTri: When TRUE (Default) prints complete Matrix otherwise Lower Triangle Only
# negPos: Vector of 2 values, to apply 3 colours to labels
# dig: Number of decimal places
# ... : Everything else is passed to f_pKbl()
#
  stopifnot(identical(length(negPos), 2L))
#
# #outcome of upper.tri() is easily compared to as.table(). lower.tri() will need extra step
  if(isTri) x[upper.tri(x, diag = TRUE)] <- NA
#
# #Suppress Warnings because 1 column is completely NA on which mutate(across()) is applied
# #Keeping the column is better to be seen as Matrix in this specific case of Correlation Matrix
# #Warning messages: no non-missing arguments to min; returning Inf
# #Warning messages: no non-missing arguments to max; returning -Inf
#
  x <- suppressWarnings(x %>%
# #Using as.table() gives long, otherwise wide
    #as.table() %>%
    as_tibble(rownames = NA, .name_repair = 'unique') %>%
# #Value based conditional formatting needs to happen before kbl() is called because 
# #mutate() does not work on kbl
# #format() needs to be called inside cell_spec() itself 
# #format cannot be applied later because once the value is modified for kbl() it becomes numeric
# #format cannot be applied before because it changes the value to character 
    mutate(across(everything(),
                  ~ cell_spec(ifelse(is.na(.x), "",
                      format(.x, digits = dig, scientific = FALSE, drop0trailing = TRUE)),
# #Change na_font_size to 1 or higher number to see bigger visual blobs on NA
                      font_size = spec_font_size(abs(.x), na_font_size = 0),
                      color = ifelse(.x < 0 | is.na(.x), "black", "black"),
                      background = case_when(is.na(.x) ~ "black",
                                       .x < negPos[1] ~ "#D8B365",
                                       .x >= negPos[2] ~ "#5AB4AC",
                                       TRUE ~ "grey")))))
  result <- f_pKbl(x, caption = caption, ...)
  return(result)
# #xxCLOSE: f_pKblM()
}

