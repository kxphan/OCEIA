## All functions used to calculate populations. 
## May require some cleaning and documentation.

detach(package:plyr)

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

# Sample of filtering by multiple counties
getPopBay <- function(var, year, survey) {
  getPop(var, year, survey) %>%
    group_by(variable) %>%
    summarise(total=sum(total))
}

# Sample of filtering by a county
getPopSF <- function(var, year, survey) {
  getPop(var, year, survey) %>%
  filter(NAME=="San Francisco County, California") #%>%
    #summarize(total=sum(total))
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
  dataset <- load_variables(year = year, dataset = survey, cache = TRUE) %>% 
    filter(str_detect(tolower(label), tolower(keyword)))
  merge(dataset, getPopSF(dataset$name, year, survey), by.x='name', by.y='variable')
}

# search through each of the concepts for a specific keyword
search_category_keyword <-function(year, survey, keyword) {
  dataset <- load_variables(year, survey, cache = TRUE) %>% 
    filter(str_detect(tolower(concept), tolower(keyword)))
  merge(dataset, getPopSF(dataset$name, year, survey), by.x='name', by.y='variable')
}