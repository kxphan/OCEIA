## All relevant variables for doing demographics analysis

# Set up environment.
API_KEY <- 'bbd0eb2204dbf8cc07f4f8eee063fe7eca0969cd'
census_api_key(API_KEY, install=TRUE)
options(tibble.print_max = 110)

# All Census Variables
census_yr <- 2017
census_dset <- "acs5"
census_var <- c("")
census_geog <- c("county")
census_state <- c("CA")
census_county <- c(075) # Default San Francisco

# Bay Area Variables
# Sonoma County", "Marin County", "Napa County",
# "Solano County", "Contra Costa County", "San Mateo County",
# "San Francisco County", "Alameda County", "Santa Clara County"
county_bay <- c(097, 041, 055, 095, 013, 081, 075, 001, 085)

# Look at all Census Variables
v17<- load_variables(census_yr, census_dset, cache = TRUE)
v14 <- load_variables(2014, census_dset, cache = TRUE)
v18 <- load_variables(2018, census_dset, cache=TRUE)

# LEP & Citizenship
LEP_native <-  c("B16008_007", "B16008_010", "B16008_015","B16008_018" )
LEP_naturalized <- c("B16008_025", "B16008_028",
                     "B16008_033", "B16008_036")
LEP_noncitizen <- c("B16008_042", "B16008_045",
                    "B16008_050", "B16008_053")
# LEP & Age


# LEP Households
LEP_house <- c("C16002_004", "C16002_007", 
               "C16002_010", "C16002_013")

# LEP Speakers (2014 & 2015 Codes)
i = 1
n = 5
x = c()
x[i] = n
base <- "B16001_"
LEP_var_old <- c()

while(n < 119){
  n <- n+3
  i <- i+1
  x[i] = n
}

for (l in x) {
  if(l < 10) {
    LEP_var_old <- c(LEP_var_old, paste(base,"00",l,sep=""))
  }else if(l < 100 && l >= 10) {
    LEP_var_old <- c(LEP_var_old, paste(base,"0",l,sep=""))
  } else if (l >= 100) {
    LEP_var_old <- c(LEP_var_old, paste(base,l,sep=""))
  }
}

# LEP Speakers (2016-Present Codes)
i = 1
n = 5
x = c()
x[i] = n
base <- "C16001_"
LEP_var <- c()

while(n < 38){
  n <- n+3
  i <- i+1
  x[i] = n
}

for (l in x) {
  if(l < 10) {
    LEP_var <- c(LEP_var, paste(base,"00",l,sep=""))
  }else if(l < 100 && l >= 10) {
    LEP_var <- c(LEP_var, paste(base,"0",l,sep=""))
  } else if (l >= 100) {
    LEP_var <- c(LEP_var, paste(base,l,sep=""))
  }
}
