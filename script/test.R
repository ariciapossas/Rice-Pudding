

library(tidyverse)
library(readxl)
library(cowplot)

pudding <- read_excel(path = "./data/pudding2.xlsx")
glimpse(pudding)
view(pudding)


plot_model <- function(my_model) {
  
  
  tibble(observed = my_model$model$LM,
         time = my_model$model$time,
         fitted = predict(my_model),
         temp = my_model$model$temp) %>%
    ggplot(aes(x = time)) +
    geom_point(aes(y = observed)) +
    geom_line(aes(y = fitted)) +
    theme_classic() +
    facet_wrap(~temp, scales = "free") +
    ##scale_x_continuous(limits=c(0,200), breaks = c(0, 50, 100, 150, 200)) + 
    #scale_x_continuous(limits = c(0, xmax), breaks = xbreaks) +
    #scale_y_continuous(limits=c(1, 4.5), breaks = c(1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5)) +
    #labs(title = "", x= "Time (days)" , y = "Population (log cfu/g)") +
    ##scale_shape_manual(values = c(1, 2)) +
    theme(legend.position = "none")
  
}

#Global fit: Baranyi + Ratkowsky

lamba <- 0

fit_model <-    pudding %>%
                nls(LM ~ N0 + (b*(temp-temp_min))^2 * (time + (1/(b*(temp-temp_min))^2) * log(exp(-(b*(temp-temp_min))^2*time) + 
                exp(-(b*(temp-temp_min))^2 * lambda) - exp(-(b*(temp-temp_min))^2 * (time + lambda)))) - 
                log(1 + ((exp((b*(temp-temp_min))^2 * (time + (1/(b*(temp-temp_min))^2) * log(exp(-(b*(temp-temp_min))^2*time) +
                exp(-(b*(temp-temp_min))^2 * lambda) - exp(-(b*(temp-temp_min))^2 * (time + lambda)))))-1)/(exp(Nmax-N0)))),
                start=list(N0=3, Nmax=8.4, b = 0.07, temp_min = -3.66),
                data = ., model =TRUE,
                control = nls.control(maxiter = 1000)
                ) 

summary(fit_model)

my_plots <- pudding %>%
            na.omit() %>%
            #split(.$temp) %>%
            nls(LM ~ N0 + (b*(temp-temp_min))^2 * (time + (1/(b*(temp-temp_min))^2) * log(exp(-(b*(temp-temp_min))^2*time) + 
             exp(-(b*(temp-temp_min))^2 * lambda) - exp(-(b*(temp-temp_min))^2 * (time + lambda)))) - 
             log(1 + ((exp((b*(temp-temp_min))^2 * (time + (1/(b*(temp-temp_min))^2) * log(exp(-(b*(temp-temp_min))^2*time) +
             exp(-(b*(temp-temp_min))^2 * lambda) - exp(-(b*(temp-temp_min))^2 * (time + lambda)))))-1)/(exp(Nmax-N0)))),
              start=list(N0=3, Nmax=8.4, b = 0.07, temp_min = -3.66),
              data = ., model =TRUE,
               control = nls.control(maxiter = 1000)
             ) %>%
              plot_model

my_plots

