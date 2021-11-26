## ---- A05 ----
# # source(paste0(.z$RX, "A05ThemeGG", ".R")) ====================================================#
#if (!("f_" %in% ls(envir = .GlobalEnv))) source(paste0(.z$RX, "A00AllUDF", ".R"))
if (!("ggplot2" %in% (.packages()))) library("ggplot2")

## ---- A05A-ThemeGG ----
f_theme_gg <- function(base_size = 14) {
# #Create a Default Theme 
# #https://benjaminlouis-stat.fr/en/blog/2020-05-21-astuces-ggplot-rmarkdown/
  theme_bw(base_size = base_size) %+replace%
    theme(
      # The whole figure
      plot.title = element_text(size = rel(1), face = "bold", margin = margin(0,0,5,0), hjust = 0),
      # Area where the graph is located
      panel.grid.minor = element_blank(),
      panel.border = element_blank(),
      # The axes
      axis.title = element_text(size = rel(0.85), face = "bold"),
      axis.text = element_text(size = rel(0.70), face = "bold"),
# # Removed, arrow = arrow(length = unit(0.3, "lines"), type = "closed")
      axis.line = element_line(color = "black"),
      # The legend
      legend.title = element_text(size = rel(0.85), face = "bold"),
      legend.text = element_text(size = rel(0.70), face = "bold"),
      legend.key = element_rect(fill = "transparent", colour = NA),
      legend.key.size = unit(1.5, "lines"),
      legend.background = element_rect(fill = "transparent", colour = NA),
      # Labels in the case of facetting
      strip.background = element_rect(fill = "#17252D", color = "#17252D"),
      strip.text = element_text(size = rel(0.85), face = "bold", color = "white", margin = margin(5,0,5,0))
    )
# #xxCLOSE: f_theme_gg()
}

## ---- A05B-SetTheme ----
# #Change default ggplot2 theme 
theme_set(f_theme_gg()) 

#f_rmExist()
## ---- A05Z ----
