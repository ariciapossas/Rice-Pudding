
library(tidyverse)
library(readxl)
library(biogrowth)

pudding <- list(
  exp4 = list(
    data = read_excel("./data/pudding1.xlsx", sheet = "exp4"),
    conditions = tibble(time = c(0,40), temperature = c(4, 4))
  ),
  exp8 = list(
    data = read_excel("./data/pudding1.xlsx", sheet = "exp8"),
    conditions = tibble(time = c(0,40), temperature = c(8, 8))
  ),
  exp12 = list(
    data = read_excel("./data/pudding1.xlsx", sheet = "exp12"),
    conditions = tibble(time = c(0,40), temperature = c(12, 12))
  ),
  exp18 = list(
    data = read_excel("./data/pudding1.xlsx", sheet = "exp18"),
    conditions = tibble(time = c(0,40), temperature = c(18, 18))
  ),
  exp25 = list(
    data = read_excel("./data/pudding1.xlsx", sheet = "exp25"),
    conditions = tibble(time = c(0,40), temperature = c(25, 25))
  )
)

#ya sé que es mejor hacer con la "map" haha

sec_names <- (temperature = "CPM") 

known <- list(Nmax = 1e8, N0 = 1e2, Q0 = 1e-3, #initial values for the primary model
              temperature_n = 1,
              temperature_xmax = 37, 
              temperature_xopt = 35)

start <- list(mu_opt = 4, temperature_xmin = 2)              

global_fit <- fit_multiple_growth(start, pudding, known, sec_names)






