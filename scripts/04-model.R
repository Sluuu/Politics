#### Preamble ####
# Purpose: Downloads and saves the data from CES2020
# Author: Sean Liu
# Date: 16 March 2024
# Contact: yuhsiang.liu@mail.utoronto.ca
# License: MIT



#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(dplyr)
#### Read data ####
analysis_data <- read_parquet("data/analysis_data/analysis_data.parquet")
set.seed(853)

ces2020_reduced <- 
  ces2020 |> 
  slice_sample(n = 10000)

#### Model Data ####
political_preferences <-
  stan_glm(
    voted_for ~ employment_stat + education + race + gender,
    data = ces2020,
    family = binomial(link = "logit"),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = 
      normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 853
  )




#### Save model ####
saveRDS(
  political_preferences,
  file = "political_preferences.rds"
)


