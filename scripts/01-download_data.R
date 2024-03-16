#### Preamble ####
# Purpose: Downloads and saves the data from CES2020
# Author: Sean Liu
# Date: 16 March 2024
# Contact: yuhsiang.liu@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(dataverse)
library(tidyverse)
library(dplyr)

#### Download data ####
ces2020 <-
  get_dataframe_by_name(
    filename = "CES20_Common_OUTPUT_vv.csv",
    dataset = "10.7910/DVN/E9N6PH",
    server = "dataverse.harvard.edu",
    .f = read_csv
  ) |>
  select(votereg, CC20_410, employ, educ, race, gender)





#### Save data ####
write_csv(ces2020, "data/raw_data/ces2020.csv") 

         
