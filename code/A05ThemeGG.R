# # source(paste0(.z$RX, "A05ThemeGG", ".R")) ====================================================#
if (!("ggplot2" %in% (.packages()))) library("ggplot2")

## ---- A05-ThemeGG ----
f_theme_gg <- function(base_size = 14) {
# #Create a Default Theme 
  theme_bw(base_size = base_size) %+replace%
    theme(
      # #The whole figure
      plot.title = element_text(size = rel(1), face = "bold", 
	                            margin = margin(0,0,5,0), hjust = 0),
      # #Area where the graph is located
      panel.grid.minor = element_blank(),
      panel.border = element_blank(),
      # #The axes
      axis.title = element_text(size = rel(0.85), face = "bold"),
      axis.text = element_text(size = rel(0.70), face = "bold"),
#      arrow = arrow(length = unit(0.3, "lines"), type = "closed"),
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
}

## ---- A05-SetThemeNLists ----
# #Change default ggplot2 theme 
theme_set(f_theme_gg()) 
#
# #List of Specific sets. Note '+' is replaced by ','
k_gglayer_bar <- list(
  scale_fill_viridis_d(),
  theme(panel.grid.major.x = element_blank(), axis.line = element_blank(),
        panel.border = element_rect(colour = "black", fill=NA, size=1),
        legend.position = 'none', axis.title.y.right = element_blank())
)
#
# #Pie
k_gglayer_pie <- list(
  scale_fill_viridis_d(),
  #theme_void(),
  theme(#panel.background = element_rect(fill = "white", colour = "white"),
		#plot.background = element_rect(fill = "white",colour = "white"),
		axis.line = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        axis.title = element_blank(),
        #panel.border = element_rect(colour = "black", fill=NA, size=1),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        legend.position = 'none')
)
#
# #Histogram
k_gglayer_hist <- list(
  scale_fill_viridis_c(direction = -1, alpha = 0.9),
  theme(panel.grid.major.x = element_blank(), axis.line.y = element_blank(),
        panel.border = element_blank(), axis.ticks.y = element_blank(), 
        legend.position = 'none')
)
#
# #Scatter Plot Trendline
