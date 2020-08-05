library(dplyr)
library(tidyverse)
library(stringr)

imm_var <- "B05012_003"
imm_pop_tract <- getPopTract(imm_var, census_yr, census_dset)
imm_test <- tract2sup(imm_pop_tract)

## Get total population
pop_supe <- tract2sup(getPopTract("B01003_001", 2018, census_dset))

## By country of origin
#countries.csv
countries_ds <- countries
countries_ds$id <- substring(countries_ds$id, 10)
countries_ds$id <- substring(countries_ds$id, 2)

# Merge with the dataset
temp <- merge(countries_ds, map.oldgeo.newgeo, 
              by.x = 'id', by.y = 'GEOID10', all = TRUE)

countries_col <- as.vector(countries_col$countries_col)
test_vec <- c("id", "GEOID20", countries_col)
temp <- temp[test_vec]

result <- merge(temp, neighborhood,
                by.x = "GEOID20", "TRACTID")

select_vars <- c("GEOID20", "Neighborhood", "District", countries_col)

result <- result[select_vars]
result[complete.cases(result), ]

# Categorize by supervisor district

write.csv(result, "countries-per-district.csv")
## Get population over time?