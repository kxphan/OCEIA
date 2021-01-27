## All functions used to calculate populations. 
## May require some cleaning and documentation.

# Load in the tract-to-place CSV
tract_to_place <- read.csv("tract-to-place.csv", header = TRUE)

# Clean it!
tract_to_place$GEOID <- paste0("0", tract_to_place$GEOID)

# Get all populations
getPop <- function(var, year, survey){
  get_acs(geography = "county",
          variables = var,
          county    = county_bay,
          state     = census_state,
          year      = year,
          cache_table = TRUE,
          survey    = survey) %>%
    group_by(NAME, variable) %>%
    summarize(total = sum(estimate))
}

getPopTract <- function(var, year, survey){
  get_acs(geography = "tract",
          variables = var,
          county    = census_county,
          state     = census_state,
          year      = year,
          cache_table = TRUE,
          survey    = survey) %>%
    group_by(GEOID, NAME, variable) %>%
    summarize(total = sum(estimate))
}

# Sample of filtering by multiple counties
getPopBay <- function(var, year, survey) {
  getPop(var, year, survey) %>%
    group_by(variable) %>%
    summarise(total=sum(total))
}

# Sample of filtering by a county
getPopSF <- function(var, year, survey) {
  getPop(var, year, survey) %>%
  filter(NAME=="San Francisco County, California")
}

getDistrict <- function(var, year, survey, district){
  temp1 <- getPopTract(var, year, survey)
  temp2 <- tract_to_place %>% 
    filter(District == district)
  merge(temp1, temp2, by = "GEOID") %>%
    group_by(District, variable) %>%
    summarize(total = sum(total))
}

getDistrictSum <- function(var, year, survey, district){
  temp1 <- getPopTract(var, year, survey)
  temp2 <- tract_to_place %>% 
    filter(District == district)
  merge(temp1, temp2, by = "GEOID") %>%
    group_by(District) %>%
    summarize(total = sum(total))
}

# Sample of filtering by a city/place
getPopOak <- function(var, year, survey) {
  get_acs(geography = "place",
          variables = var,
          state     = census_state,
          year      = year,
          survey = survey) %>%
    filter(NAME=="Oakland city, California") %>%
    group_by(variable) %>%
    summarize(total=sum(estimate))
}

# Search through each of the labels for a specific keyword.
search_label_keyword <- function(year, survey, keyword) {
  dataset <- load_variables(year = year, dataset = survey, cache = TRUE) 
  dataset %>% 
    subset(stringr::str_detect(base::tolower(label), base::tolower(keyword)))
  dataset_results <- getPopSF(dataset$name, year, survey)
  merge(dataset, dataset_results, by.x='name', by.y='variable')
}

# search through each of the concepts for a specific keyword
search_category_keyword <-function(year, survey, keyword) {
  dataset <- load_variables(year, survey, cache = TRUE) 
  dataset %>% 
    filter(str_detect(tolower(dataset$concept), tolower(keyword)))
  merge(dataset, getPopSF(dataset$name, year, survey), by.x='name', by.y='variable')
}

# Turn tracts --> Supervisor Districts
tract2geo <- function(dataset){
  dataset$GEOID <- substring(dataset$GEOID, 2)
  
  # Merge with the dataset
  temp <- merge(dataset, map.oldgeo.newgeo, 
                by.x = 'GEOID', by.y = 'GEOID10', all = TRUE)
  
  select_vars <- c("GEOID", "GEOID20", "variable", "total")
  temp <- temp[select_vars]
  
  result <- merge(temp, neighborhood,
                  by.x = "GEOID20", "TRACTID")
  
  select_vars <- c("variable", "GEOID", "Neighborhood", "District", "total")
  result <- result[select_vars]
  result[complete.cases(result), ]
}

tract2sup <- function(dataset){
  result <- tract2geo(dataset) %>%
    group_by(District) %>%
    summarize(total = sum(total))
}
