# Install and load packages
install.packages(c("dplyr", "tidycensus", "tidyverse", "googleCloudStorageR", "skimr", "dplyr", "bigrquery"), repos = "https://cloud.r-project.org")
library(dplyr) 
library(tidycensus)
library(tidyverse)
library(googleCloudStorageR)
library(skimr) 
library(dplyr) 
library(bigrquery)

# Download the 2023 1-year PUMS data for renters in New York state via Census API
ny_pums <- get_pums(
  variables = c("PUMA", "PINCP", "COW", "INDP", "GRPIP"),
  state = "NY",
  year = 2023,
  survey = "acs1",
  variables_filter = list(TEN = 3),
  recode = TRUE
)
