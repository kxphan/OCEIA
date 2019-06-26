# All functions used to calculate populations. May require some cleaning and documentation.

agg <- function(var) {
  var %>%
    summarize(total=sum(total))
}
getPop <- function(var){
  get_acs(geography = "county",
          variables = var,
          county    = county_bay,
          state     = census_state,
          year      = census_yr) %>%
    group_by(NAME, variable) %>%
    summarize(total=sum(estimate))
}
getPopBay <- function(var) {
  getPop(var) %>%
    group_by(variable) %>%
    summarise(total=sum(total))
}
getPopSF <- function(var) {
  getPop(var) %>%
  filter(NAME=="San Francisco County, California") #%>%
    #summarize(total=sum(total))
}
getPopOak <- function(var) {
  get_acs(geography = "place",
          variables = var,
          state     = census_state,
          year      = census_yr) %>%
    filter(NAME=="Oakland city, California") %>%
    group_by(variable) %>%
    summarize(total=sum(estimate))
}

getPal <- function(domain) {
  colorBin(
    palette="YlOrRd",
    domain = domain,
    bins = 9,
    pretty = FALSE
  )
}

detach(package:plyr)
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

combine <- function(dataset) {
  # Get names of neighborhoods first
  dataset <- merge(dataset, sf_nbhd,
                   by.x="GEOID",
                   by.y="GEOID") %>%
    group_by(Neighborhood) %>%
    summarize(total=sum(total))

  dataset$NAME.x <- NULL
  dataset$NAME.y <- NULL
  dataset$GEOID <- NULL
  dataset$NAMELSAD <- NULL

  # Merge to get the polygons
  dataset <- merge(dataset, analysis_nbhd,
                   by.x="Neighborhood",
                   by.y="nhood")

  return(dataset)
}
