library(dplyr)
library(tidyverse)
library(stringr)

imm_var <- "B05002_013"
imm_pop_tract <- getPopTract(imm_var, census_yr, census_dset)
imm_test <- tract2sup(imm_pop_tract)

