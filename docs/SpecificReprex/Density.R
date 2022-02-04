# #source(paste0(.z$RX, "Density", ".R"))
# #Using Air Time of Flights dataset from nycflights13 Package : Output Plot Object: B12P02
hh <- tibble(ee = na.omit(nycflights13::flights$air_time))
ttl_hh <- "Flights: Air Time"
cap_hh <- "B12P02"
# #Basics
median_hh <- round(median(hh[[1]]), 1)
mean_hh <- round(mean(hh[[1]]), 1)
sd_hh <- round(sd(hh[[1]]), 1)
len_hh <- nrow(hh)
# #Get Quantiles and Ranges of mean +/- sigma 
density_hh <- density(hh[[1]])
density_hh_tbl <- tibble(x = density_hh$x, y = density_hh$y)
sig3r_hh <- density_hh_tbl %>% filter(x >= {mean_hh + 3 * sd_hh})
sig3l_hh <- density_hh_tbl %>% filter(x <= {mean_hh - 3 * sd_hh})
sig2r_hh <- density_hh_tbl %>% filter(x >= {mean_hh + 2 * sd_hh}, {x < mean_hh + 3 * sd_hh})
sig2l_hh <- density_hh_tbl %>% filter(x <= {mean_hh - 2 * sd_hh}, {x > mean_hh - 3 * sd_hh})
sig1r_hh <- density_hh_tbl %>% filter(x >= {mean_hh + sd_hh}, {x < mean_hh + 2 * sd_hh})
sig1l_hh <- density_hh_tbl %>% filter(x <= {mean_hh - sd_hh}, {x > mean_hh - 2 * sd_hh})
sig0r_hh <- density_hh_tbl %>% filter(x > mean_hh, {x < mean_hh + 1 * sd_hh})
sig0l_hh <- density_hh_tbl %>% filter(x < mean_hh, {x > mean_hh - 1 * sd_hh})
#
# #Change x-Axis Ticks interval
xbreaks_hh <- seq(-3, 3)
xpoints_hh <- mean_hh + xbreaks_hh * sd_hh
#
# # Latex Labels 
xlabels_hh <- c(TeX(r'($\,\,\mu - 3 \sigma$)'), TeX(r'($\,\,\mu - 2 \sigma$)'), 
                TeX(r'($\,\,\mu - 1 \sigma$)'), TeX(r'($\mu$)'), TeX(r'($\,\,\mu + 1 \sigma$)'), 
                TeX(r'($\,\,\mu + 2 \sigma$)'), TeX(r'($\,\,\mu + 3\sigma$)'))
# #Arrow
arr_y <- 0.007 #mean(density_hh_tbl$y) #
arr_lst <- list(list("99.7%", xpoints_hh[1], xpoints_hh[7], arr_y),
                list("95.4%", xpoints_hh[2], xpoints_hh[6], arr_y),
                list("68.3%", xpoints_hh[3], xpoints_hh[5], arr_y))
arr_hh <- arr_lst[[2]]
#
B12P02 <- hh %>% { ggplot(data = ., mapping = aes(x = ee)) + 
  geom_density(alpha = 0.2, colour = "#21908CFF") + 
  geom_area(data = sig3l_hh, aes(x = x, y = y), fill = '#440154FF') + 
  geom_area(data = sig3r_hh, aes(x = x, y = y), fill = '#440154FF') + 
  geom_area(data = sig2l_hh, aes(x = x, y = y), fill = '#3B528BFF') + 
  geom_area(data = sig2r_hh, aes(x = x, y = y), fill = '#3B528BFF') + 
  geom_area(data = sig1l_hh, aes(x = x, y = y), fill = '#21908CFF') + 
  geom_area(data = sig1r_hh, aes(x = x, y = y), fill = '#21908CFF') + 
  geom_area(data = sig0l_hh, aes(x = x, y = y), fill = '#5DC863FF') + 
  geom_area(data = sig0r_hh, aes(x = x, y = y), fill = '#5DC863FF') + 
  scale_x_continuous(breaks = xpoints_hh, labels = xlabels_hh) + 
  annotate("segment", x = xpoints_hh[4] - 0.5 * sd_hh, xend = arr_hh[[2]], y = arr_hh[[4]], 
            yend = arr_hh[[4]], arrow = arrow(type = "closed", length = unit(0.02, "npc"))) + 
  annotate("segment", x = xpoints_hh[4] + 0.5 * sd_hh, xend = arr_hh[[3]], y = arr_hh[[4]], 
            yend = arr_hh[[4]], arrow = arrow(type = "closed", length = unit(0.02, "npc"))) + 
  annotate(geom = "text", x = xpoints_hh[4], y = arr_hh[[4]], label = arr_hh[[1]]) + 
  theme(plot.title.position = "panel") + 
  labs(x = "x", y = "Density", 
       subtitle = paste0("(N=", nrow(.), "; ", "Mean= ", round(mean(.[[1]]), 1), 
                         "; Median= ", round(median(.[[1]]), 1), "; SD= ", round(sd(.[[1]]), 1),
                         ")"), 
        caption = cap_hh, title = ttl_hh)
}
