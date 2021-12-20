# # source(paste0(.z$RX, "A11getStat", ".R")) ====================================================#

## ---- A11A-get2sSE ----
f_get2sSE <- function(s1, n1, s2, n2) {
  # f_get2sSE(1, 11, 2, 22)
  # #Return Standard Error SE for Two Sample t-test 
  # #Same for both cases of known or unknown Standard Deviation 
  # # And Prints LaTex and R Equivalents for Notebook
  xx  <- round(sqrt({s1^2 /n1 + s2^2 /n2}), 4)
  cat(paste0("- \\@ref(eq:se-2s-sd) ${\\sigma}_{({\\overline{x}}_1 - {\\overline{x}}_2)} = \\sqrt{\\frac{{", s1, "}^2}{", n1, "} + \\frac{{", s2, "}^2}{", n2, "}} = ", xx,"$\n"))
  cat(paste0("- ", "`", "sqrt(", s1, "^2/", n1, " + ", s2, "^2/", n2, ")", "`", " \\textcolor{pink}{$\\#\\mathcal{R}$}", "\n"))
  return(xx)
}

## ---- A11B-get2sDof ----
f_get2sDof <- function(s1, n1, s2, n2) {
  # f_get2sDof(1, 11, 2, 22)
  # # Return Degrees of Freedom for Two Sample t-test for unknown Standard Deviation
  # Value rounded down to provide a larger t-value and a more conservative interval estimate
  xx  <- floor({s1^2 / n1 + s2^2 / n2 }^2 / {{s1^2 / n1}^2/{n1-1} + {s2^2 / n2}^2/{n2-1}})
  cat(paste0("- ", "`", "floor({", s1,"^2 / ", n1, " + ", s2, "^2 / ", n2, " }^2 / {{", s1, "^2 / ", n1, "}^2/{", n1, "-1} + {", s2, "^2 / ", n2, "}^2/{", n2, "-1}})", "`", " \\textcolor{pink}{$\\#\\mathcal{R}$}", "\n"))
  return(xx)
}