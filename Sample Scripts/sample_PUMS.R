# This script provides a sample run of PUMS data. It may be incomplete.

# Import PUMS file
 pums2016 <- read.csv("psam_p06.csv")
 pums2017 <- read.csv("pums1yr.csv")

# San Francisco - FIPS County Code 075, State Code 06

get_acs(geography=census_geog,
        year = census_yr,
        variables = c("B16001_077","C16001_023"),
        state = census_state,
        county= census_county)

# Evaluate PUMS Language Dat
# LANX: b, 1
# LANP: 2000 (Mandarin), 2050 (Cantonese)
# ENG: 2, 3, 4

categories <- as.data.frame(unique(pums2016$LANP))
num_lang <- length(unique(pums2016$LANP))
sf <- filter(pums2016, pums2016$PUMA == "7501") #& PUMA <= 7507)

# Chinese Language
cantonese <- tally(filter(pums2016, (PUMA >= 7501 & PUMA <= 7507) & LANP == 2050))
other_chinese <- tally(filter(pums2016, (PUMA >= 7501 & PUMA <= 7507) & LANP == 2030))
mandarin <- tally(filter(pums2016, (PUMA >= 7501 & PUMA <= 7507) & LANP == 2000 & ENG != 1))
chinese <- tally(filter(pums2016, (PUMA >= 7501 & PUMA <= 7507) & LANP == 1970 & ENG != 1))

# Filipino Languages
fil <- tally(filter(pums2016, (PUMA >= 7501 & PUMA <= 7507) & LANP == 2910))
tagalog <- tally(filter(pums2016, (PUMA >= 7501 & PUMA <= 7507) & LANP == 2920))
cebuano <- tally(filter(pums2016, (PUMA >= 7501 & PUMA <= 7507) & LANP == 2950))
ilocano <- tally(filter(pums2016, (PUMA >= 7501 & PUMA <= 7507) & LANP == 3150))
other_fil <- tally(filter(pums2016, (PUMA >= 7501 & PUMA <= 7507) & LANP == 3190))
