# All relevant variables for doing demographics analysis

# Set up environment.
API_KEY <- 'bbd0eb2204dbf8cc07f4f8eee063fe7eca0969cd'
census_api_key(API_KEY, install=TRUE)
options(tibble.print_max = 110)

census_yr <- 2017
census_dset <- "acs5"
census_var <- c("")
census_geog <- c("county")
census_state <- c("CA")
census_county <- c(075) # Default San Francisco

# Bay Area Variables
# =============
# Sonoma County", "Marin County", "Napa County",
# "Solano County", "Contra Costa County", "San Mateo County",
# "San Francisco County", "Alameda County", "Santa Clara County"
county_bay <- c(097, 041, 055, 095, 013, 081, 075, 001, 085)

# Look at all Census Variables

v15 <- load_variables(census_yr, census_dset, cache = TRUE)
v16 <- load_variables(2012, census_dset)
