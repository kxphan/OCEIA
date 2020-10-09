library(tidyverse)
library(tidycensus)

# Get the tract information 
test <- getPopTract(c("B06007_005", "B06007_008"), 2018, "acs5")
tract_data <- test %>%
  group_by(GEOID) %>%
  summarise(total=sum(total))
tract_data$GEOID <- as.numeric(tract_data$GEOID)

# Import matching tract to zip code data
zip.to.tract$V2 <- as.numeric(zip.to.tract$V2)

# Merge together
data.94112 <- merge(tract_data, zip.to.tract, by.x = "GEOID", by.y = "V2")

# Get total population over five years old (sanity check)
pop.total.tract <- getPopTract(c("B06007_001"), 2018, "acs5") %>%
  group_by(GEOID) %>%
  summarise(total = sum(total))
pop.total.tract$GEOID <- as.numeric(pop.total.tract$GEOID)

# Merge for 94112 total population
total.94112 <- merge(pop.total.tract, zip.to.tract, by.x = "GEOID", by.y = "V2")

############ Language Specific Information #############
# Calculating Spanish: C16001_005
spanish.tract <- getPopTract(c("C16001_005"), 2018, "acs5") %>%
  group_by(GEOID) %>%
  summarise(total = sum(total))
spanish.tract$GEOID <- as.numeric(spanish.tract$GEOID)
spanish.94112 <- merge(spanish.tract, zip.to.tract, by.x = "GEOID", by.y = "V2")

# Calculating Chinese: C16001_023
chinese.tract <- getPopTract(c("C16001_023"), 2018, "acs5") %>%
  group_by(GEOID) %>%
  summarise(total = sum(total))
chinese.tract$GEOID <- as.numeric(chinese.tract$GEOID)
chinese.94112 <- merge(chinese.tract, zip.to.tract, by.x = "GEOID", by.y = "V2")

# Calculating Filipino: C16001_029
filipino.tract <- getPopTract(c("C16001_029"), 2018, "acs5") %>%
  group_by(GEOID) %>%
  summarise(total = sum(total))
filipino.tract$GEOID <- as.numeric(filipino.tract$GEOID)
filipino.94112 <- merge(filipino.tract, zip.to.tract, by.x = "GEOID", by.y = "V2")

sum(total.94112$total)
sum(data.94112$total)
sum(spanish.94112$total)
sum(chinese.94112$total)
sum(filipino.94112$total)

