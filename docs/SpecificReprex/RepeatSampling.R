# #source(paste0(.z$RX, "RepeatSampling", ".R"))
# #Using Air Time of Flights dataset from nycflights13 Package
# #Take 10 Samples, Get Mean, Repear 2000 Times
set.seed(3)
bb <- na.omit(nycflights13::flights$air_time)
nn <- 10L
rr <- 2000L
hh <- tibble(ee = replicate(rr, mean(sample(bb, size = nn))))
ylim_hh <- 200
cap_hh <- "B12P08"
# #Population Mean
mu_hh <- round(mean(bb), 1)
# #
B12P08 <- hh %>% { ggplot(data = ., mapping = aes(x = ee)) + 
  geom_histogram(bins = 50, alpha = 0.4, fill = '#FDE725FF') + 
  geom_vline(aes(xintercept = mean(.data[["ee"]])), color = '#440154FF') +
  geom_text(aes(label = TeX(r'($E(\bar{x})$)', output = "character"), 
                x = mean(.data[["ee"]]), y = -Inf), 
            color = '#440154FF', hjust = 1.5, vjust = -1.5, parse = TRUE, check_overlap = TRUE) + 
  geom_vline(aes(xintercept = mu_hh), color = '#3B528BFF') +
  geom_text(aes(label = TeX(r'($\mu$)', output = "character"), x = mu_hh, y = -Inf),
            color = '#3B528BFF', hjust = -1, vjust = -2, parse = TRUE, check_overlap = TRUE) + 
  coord_cartesian(xlim = c(0, 800), ylim = c(0, ylim_hh)) + 
  theme(plot.title.position = "panel") + 
  labs(x = TeX(r'($\bar{x} \, (\neq x)$)'), y = TeX(r'(Frequency of $\, \bar{x}$)'), 
       subtitle = TeX(sprintf(
         "($\\mu$=%.0f) $E(\\bar{x}) \\, =$%.0f $\\sigma_{\\bar{x}} \\, =$%.0f",
                             mu_hh, round(mean(.[[1]]), 1), round(sd(.[[1]])))),
       caption = cap_hh, 
       title = paste0("Sampling Distribution (N = ", nn, ") & Repeat Sampling = ", nrow(.)))
}
