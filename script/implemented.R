
library(tidyverse)
library(readxl)

pudding <- read_excel(path = "./data/pudding2.xlsx")
glimpse(pudding)


plot_model <- function(my_model) {
  
  
  tibble(observed = my_model$model$LM,
         time = my_model$model$time,
         fitted = predict(my_model)) %>%
    ggplot(aes(x = time)) +
    geom_point(aes(y = observed)) +
    geom_line(aes(y = fitted)) +
    theme_classic() +
    ##scale_x_continuous(limits=c(0,200), breaks = c(0, 50, 100, 150, 200)) + 
    scale_x_continuous(limits = c(0, xmax), breaks = xbreaks) +
    scale_y_continuous(limits=c(1, 4.5), breaks = c(1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5)) +
    labs(title = "", x= "Time (days)" , y = "Population (log cfu/g)") +
    ##scale_shape_manual(values = c(1, 2)) +
    theme(legend.position = "none")
  
}

###### Gráficas 

lambda <- 0

(b*(temp-temp_min))^2

my_plots <- pudding %>%
            nls(LM ~ N0 + (b*(temp-temp_min))^2 * (time + (1/(b*(temp-temp_min))^2) * log(exp(-(b*(temp-temp_min))^2*time) + 
            1 - exp(-(b*(temp-temp_min))^2*time))) - 
            log(1 + ((exp((b*(temp-temp_min))^2 * (time + (1/(b*(temp-temp_min))^2)) * log(exp(-(b*(temp-temp_min))^2*time) +
            1 - exp(-(b*(temp-temp_min))^2*time))))-1)/(exp(Nmax-N0)))),
            start=list(N0 = 3.0, b = 0.7, temp_min = -3.6, Nmax= 8.0),
            data = ., model = TRUE)
   %>%
  plot_model


plot_grid(plotlist = my_plots, labels = c("A", "B"), label_size = 14)

tierno %>%
  na.omit() %>%
  split(.$Temperature) %>%
  map(na.omit) %>%
  map(., 
      ~ nls(LM ~ N0 -(Time/D)^p, start = list(N0 = 4, D = 1, p = 1),
            data = ., model = TRUE)
  ) %>%
  map(summary)
