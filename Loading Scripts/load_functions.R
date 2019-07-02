## All functions used to calculate populations. 
## May require some cleaning and documentation.

detach(package:plyr)

# Get all populations
getPop <- function(var){
  get_acs(geography = "county",
          variables = var,
          county    = county_bay,
          state     = census_state,
          year      = census_yr,
          cache_table = TRUE) %>%
    group_by(NAME, variable) %>%
    summarize(total=sum(estimate))
}

# Sample of filtering by multiple counties
getPopBay <- function(var) {
  getPop(var) %>%
    group_by(variable) %>%
    summarise(total=sum(total))
}

# Sample of filtering by a county
getPopSF <- function(var) {
  getPop(var) %>%
  filter(NAME=="San Francisco County, California") #%>%
    #summarize(total=sum(total))
}

# Sample of filtering by a city/place
getPopOak <- function(var) {
  get_acs(geography = "place",
          variables = var,
          state     = census_state,
          year      = census_yr) %>%
    filter(NAME=="Oakland city, California") %>%
    group_by(variable) %>%
    summarize(total=sum(estimate))
}

# previously was called "result", may need to rename function in other scripts.
result <- function(var) {
  get_acs(geography=census_geog,
          variables = var,
          state = census_state,
          county = census_county,
          geometry = FALSE,
          year = census_yr,
          cache=TRUE) %>%
    group_by(NAME, GEOID) %>%
    summarise(total = sum(estimate)) %>%
    filter(total > 0)
}

# Search through each of the labels for a specific keyword.
search_label_keyword <- function(year, survey, keyword) {
  load_variables(census_yr, census_dset, cache = TRUE) %>% 
    filter(str_detect(tolower(label), tolower(keyword)))
}

# search through each of the concepts for a specific keyword
search_category_keyword <-function(year, survey, keyword) {
  load_variables(census_yr, census_dset, cache = TRUE) %>% 
    filter(str_detect(tolower(concept), tolower(keyword)))
}

# Join the results from getPop with label of variable. 
# (For example, B02015_001 --> Estimate!!Total)
# Currently only using San Francisco numbers.
# TODO: Expand to all other options and functions.
get_results_keyword <- function(dataset) {
  merge(dataset, getPopSF(dataset$name), by.x='name', by.y='variable')
}

# Run a sample script
sample_two <- search_category_keyword(2017, "acs5", "Language Spoken")
sample_one <- search_label_keyword(2017, "acs5", "Spanish")
sample_final <- get_results_keyword(sample_one)
