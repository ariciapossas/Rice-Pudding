
library(tidyverse)
library(readxl)
library(biogrowth)

pudding <- list(
  exp4 = list(
    data = read_excel("./data/pudding1.xlsx", sheet = "exp4"),
    conditions = tibble(time = c(0,38), temperature = c(4, 4))
  ),
  exp8 = list(
    data = read_excel("./data/pudding1.xlsx", sheet = "exp8"),
    conditions = tibble(time = c(0,19), temperature = c(8, 8))
  ),
  exp12 = list(
    data = read_excel("./data/pudding1.xlsx", sheet = "exp12"),
    conditions = tibble(time = c(0,28), temperature = c(12, 12))
  ),
  exp18 = list(
    data = read_excel("./data/pudding1.xlsx", sheet = "exp18"),
    conditions = tibble(time = c(0,13), temperature = c(18, 18))
  ),
  exp25 = list(
    data = read_excel("./data/pudding1.xlsx", sheet = "exp25"),
    conditions = tibble(time = c(0,6), temperature = c(25, 25))
  )
)

#ya sé que es mejor hacer con la "map" haha

sec_names <- c(temperature = "Zwietering")

known <- list(Nmax = 1.4e8,N0 = 1e3, Q0 = 1, #initial values for the primary model
              temperature_n = 1,
              temperature_xopt = 35
              )

start <- list(mu_opt = 0.8, 
              temperature_xmin = 2
              )                          

global_fit <- fit_multiple_growth(start, pudding, known, sec_names)

summary(global_fit)

plot(global_fit)








