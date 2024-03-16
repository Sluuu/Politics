#### Preamble ####
# Purpose: Downloads and saves the data from CES2020
# Author: Sean Liu
# Date: 16 March 2024
# Contact: yuhsiang.liu@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(tidyverse)
library(arrow)


#### Clean data ####
ces2020 <-
  read_csv(
    "data/raw_data/ces2020.csv",
    col_types =
      cols(
        "votereg" = col_integer(),
        "CC20_410" = col_integer(),
        "employ" = col_integer(),
        "educ" = col_integer(),
        "race" = col_integer(),
        "gender" = col_integer()
      )
  )

ces2020

ces2020 <-
  ces2020 |>
  filter(votereg == 1,
         CC20_410 %in% c(1, 2)) |>
  mutate(
    voted_for = if_else(CC20_410 == 1, "Biden", "Trump"),
    voted_for = as_factor(voted_for),
    employment_stat = case_when(
      employ == 1 ~ "Full-time",
      employ == 2 ~ "Part-time",
      employ == 3 ~ "Temporarily laid off",
      employ == 4 ~ "Unemployed",
      employ == 5 ~ "Retired",
      employ == 6 ~ "Permanently disabled",
      employ == 7 ~ "Homemaker",
      employ == 8 ~ "Student"
      ),
    education = case_when(
      educ == 1 ~ "No HS",
      educ == 2 ~ "High school graduate",
      educ == 3 ~ "Some college",
      educ == 4 ~ "2-year",
      educ == 5 ~ "4-year",
      educ == 6 ~ "Post-grad"
    ),
    race = case_when(
      race == 1 ~ "White",
      race == 2 ~ "Black",
      race == 3 ~ "Hispanic",
      race == 4 ~ "Asian",
      race == 5 ~ "Native American",
      race == 6 ~ "Middle Eastern",
      race == 7 ~ "Two or more races"
    ),
    gender = if_else(gender == 1, "Male", "Female"),
    education = factor(
      education,
      levels = c(
        "No HS",
        "High school graduate",
        "Some college",
        "2-year",
        "4-year",
        "Post-grad"
      )
    )
  ) |>
  select(voted_for, employment_stat, education, race, gender)

#### Save data ####
write_parquet(ces2020, "data/analysis_data/analysis_data.parquet")
