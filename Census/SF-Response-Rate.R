rm(list=ls(all=TRUE))

# NOTE: Make sure to import response rate data downloaded from
# census website, and to have neighborhood names imported as well

library(dplyr)
library(tidyverse)
library(stringr)

# RESPONSE RATE DATA ==========================
# San Francisco Response Rate Tracts
SFRRData <- RRdata %>%
  filter(str_detect(GEO_ID, "1400000US06075"))

# Edit out the 14...0US of GEOID column strings. Only use once.
names(SFRRData)[1] <- "TRACTID"
SFRRData$TRACTID <- substring(SFRRData$TRACTID, 11)
  
# Edit up neighborhood csv. You don't need to do this if your
# csv file already only consists of these three columns
# and nothing else.
neighborhood <- neighborhood %>%
  select(TRACTID, Neighborhood, District)
neighborhood$TRACTID <- substring(neighborhood$TRACTID, 2)

# Merge neighborhood and SFRRData together
SFRRData <- inner_join(SFRRData, neighborhood, by="TRACTID")
SFRRData <- SFRRData %>%
  select(TRACTID, Neighborhood, District, RESP_DATE, DRRINT, DRRALL, CRRALL)

SFRRData$TRACTID <- as.numeric(as.character(SFRRData$TRACTID))

# Merge SFRRData with old tracts (for future joining)
SFRRData.Historic <- merge(SFRRData, map.oldgeo.newgeo, 
                                by.x = "TRACTID", by.y = "GEOID20")
# RACE DATA ==========================

# Clean up race data, make sure it's imported beforehand. 
names(race.data)[1] <- "TRACTID"
race.data$TRACTID <- substring(race.data$TRACTID, 11)

# Update race data so that it matches with new crosswalks
race.data <- merge(race.data, map.oldgeo.newgeo,
                   by.x = "TRACTID",
                   by.y = "GEOID10",
                   all = TRUE)
race.data <- merge(race.data, hispanic,
                   by.x = "TRACTID",
                   by.y = "GEO_ID")
race.data$White.non.hispanic <- race.data$White - race.data$Hispanic.Latino

# Calculate percentage of race makeup in tract
race.data$white.pct <- race.data$White.non.hispanic/race.data$Total.x
race.data$blk.pct <- race.data$Black/race.data$Total
race.data$ai.pct <- race.data$American.Indian/race.data$Total
race.data$as.pct <- race.data$Asian/race.data$Total
race.data$nhpi.pct <- race.data$NHPI/race.data$Total
race.data$oth.pct <- race.data$Other/race.data$Total
race.data$mult.pct <- race.data$Multi/race.data$Total
race.data$hisp.pct <- race.data$Hispanic.Latino/race.data$Total.x

SF.race.pct <- race.data %>%
  select(white.pct, blk.pct, ai.pct, as.pct, hisp.pct, nhpi.pct,
         oth.pct, mult.pct)

# Select tracts with highest value 
t1 <- max.col(SF.race.pct,
              "first")
value <- SF.race.pct[cbind(1:nrow(SF.race.pct), t1)]
cluster <- names(SF.race.pct)[t1]
res <- data.frame(value, cluster)

# Attach the tract
SF.race.pct$TRACTID <- race.data$GEOID20
SF.race.pct$OLDID <- race.data$TRACTID
SF.race.pct$plurality <- res$cluster

# Make sure mergeable tracts are readable as strings
SF.race.pct$TRACTID <- as.numeric(as.character(SF.race.pct$TRACTID))

# Merge with response rate tracts
MergeRRData <- inner_join(SF.race.pct, SFRRData, by = "TRACTID")

# Select Asian-plurality tracts
Asian.Plurality <- MergeRRData %>%
  filter(str_detect(plurality, "as.pct")) %>%
  select(TRACTID, Neighborhood, District, RESP_DATE, DRRINT, DRRALL, CRRALL)

White.Plurality <- MergeRRData %>%
  filter(str_detect(plurality, "white.pct")) %>%
  select(TRACTID, Neighborhood, District, RESP_DATE, DRRINT, DRRALL, CRRALL)

Black.Plurality <- MergeRRData %>%
  filter(str_detect(plurality, "blk.pct")) %>%
  select(TRACTID, Neighborhood, District, RESP_DATE, DRRINT, DRRALL, CRRALL)

Hisp.Plurality <- MergeRRData %>%
  filter(str_detect(plurality, "hisp.pct")) %>%
  select(TRACTID, Neighborhood, District, RESP_DATE, DRRINT, DRRALL, CRRALL)

# Doing some calculations
mean(Asian.Plurality$CRRALL)
mean(White.Plurality$CRRALL)
mean(MergeRRData$CRRALL)

# EDUCATION DATA ==========================

# Get population data
pop.data <- race.data %>%
select("TRACTID", "Total.x") %>%
  rename(Total = Total.x)

# Get numbers on bachelors degree
ed.data.bachelors <- ed.data %>%
  select(id, contains("Bachelor.s.degree.or.higher")) %>%
  select(id, contains("Total..Population.25.years.and.over..Bachelor.s.degree.or.higher")) %>%
  rename(TRACTID = id,
         Bachelors.Degree.25.Years.Plus = Estimate..Total..Population.25.years.and.over..Bachelor.s.degree.or.higher)

ed.data.bachelors <- inner_join(ed.data.bachelors, pop.data, by = "TRACTID")

# Get number on high school degrees or less
ed.data.hs <- ed.data %>%
  select(id, contains("Estimate..Total..Population.25.years.and.over..High.school.graduate..includes.equivalency.")) %>%
  rename(TRACTID = id,
         HS.Degree.25.Years.Plus = Estimate..Total..Population.25.years.and.over..High.school.graduate..includes.equivalency.)

ed.data.no.ed <- ed.data %>%
  select(id, 
         contains("Total..Population.25.years.and.over..9th.to.12th.grade..no.diploma"),
         contains("Total..Population.25.years.and.over..Less.than.9th.grade")) %>%
  rename(TRACTID = id,
         Total.9th.to.12th = Estimate..Total..Population.25.years.and.over..9th.to.12th.grade..no.diploma,
         Total.Less.than.9th = Estimate..Total..Population.25.years.and.over..Less.than.9th.grade)

ed.data.no.ed$Total <- 
  ed.data.no.ed$Total.9th.to.12th +
  ed.data.no.ed$Total.Less.than.9th

ed.data.no.ed <- ed.data.no.ed %>%
  rename(Total.HS.Less = Total)

ed.data.hs.less <- inner_join(ed.data.hs, ed.data.no.ed, by = "TRACTID")
ed.data.hs.less$Total.HS.Less <- 
  ed.data.hs.less$HS.Degree.25.Years.Plus +
  ed.data.hs.less$Total.9th.to.12th +
  ed.data.hs.less$Total.Less.than.9th

# Merge into one dataset
ed.compare <- inner_join(ed.data.bachelors, ed.data.hs.less, by = "TRACTID") %>%
  select(TRACTID, Bachelors.Degree.25.Years.Plus, Total.HS.Less, Total)

bs.pct <- ed.compare$Bachelors.Degree.25.Years.Plus/ed.compare$Total
hs.pct <- ed.compare$Total.HS.Less/ed.compare$Total

ed.compare$bs.pct <- bs.pct
ed.compare$hs.pct <- hs.pct

ed.comp.pct <- ed.compare %>%
  select(bs.pct, hs.pct)

# Select the plurality
t1 <- max.col(ed.comp.pct,
              "first")
value <- ed.comp.pct[cbind(1:nrow(ed.comp.pct), t1)]
cluster <- names(ed.comp.pct)[t1]
res <- data.frame(value, cluster)

ed.compare$plurality <- res$cluster

# Merge with response rate
ed.compare <- merge(ed.compare, map.oldgeo.newgeo,
                   by.x = "TRACTID",
                   by.y = "GEOID10",
                   all = TRUE)

ed.compare <- ed.compare %>%
  rename(OLDID = TRACTID,
         TRACTID = GEOID20)

ed.compare <- inner_join(ed.compare, SFRRData, by = "TRACTID")

# Select Plurality
ed.bs.plur <- ed.compare %>%
  filter(str_detect(plurality, "bs.pct")) %>%
  select(TRACTID, Neighborhood, District, RESP_DATE, CRRALL)

ed.hs.plur <- ed.compare %>%
  filter(str_detect(plurality, "hs.pct")) %>%
  select(TRACTID, Neighborhood, District, RESP_DATE, CRRALL)

# Caclulations
mean(ed.bs.plur$CRRALL)
mean(ed.hs.plur$CRRALL)

median(ed.bs.plur$CRRALL)
median(ed.hs.plur$CRRALL)

# POVERTY DATA =================================

# Clean up/turn into a legible dataset
poverty <- poverty[-c(1),]
write.table(poverty, "poverty.csv", sep=',', row.names=FALSE, col.names=FALSE)
poverty <- read.csv("~/poverty.csv")
names(poverty)[1] <- "TRACTID"
poverty$TRACTID <- substring(poverty$TRACTID, 11)

# Get poverty level data
poverty.level <- poverty %>%
  select(TRACTID, 
         ends_with("Estimate..Below.poverty.level..Population.for.whom.poverty.status.is.determined"),
         ends_with("Estimate..Percent.below.poverty.level..Population.for.whom.poverty.status.is.determined"))

names(poverty.level)[2] = "Total.Below.Poverty.Level"
names(poverty.level)[3] = "Percent.Below.Poverty.Level"

# Merge data together
poverty.level <- merge(poverty.level, SFRRData.Historic, by.x = "TRACTID", by.y = "GEOID10")
poverty.level <- poverty.level %>%
  select("TRACTID", "TRACTID.y", "Neighborhood", "District", "CRRALL", 
                        "Percent.Below.Poverty.Level", "Total.Below.Poverty.Level") %>%
  rename(new.TRACTID = TRACTID.y)

# Convert to numbers
poverty.level$Percent.Below.Poverty.Level <- 
  as.numeric(as.character(poverty.level$Percent.Below.Poverty.Level))

# Filter to poverty level 30% and above
poverty.level.high <- poverty.level %>%
  filter(Percent.Below.Poverty.Level >= 30.0)

poverty.level.low <- poverty.level %>%
  filter(Percent.Below.Poverty.Level < 30.0)

# Calculations
mean(poverty.level.high$CRRALL)
median(poverty.level.high$CRRALL)
mean(poverty.level.low$CRRALL)
median(poverty.level.low$CRRALL)

# LANGUAGE =======================

language.lep <- getPopTract(c("B06007_005", "B06007_008"), 2018, "acs5") %>%
  group_by(GEOID) %>%
  summarise(total = sum(total)) %>%
  rename(TRACTID = GEOID, LEP.Pop = total)

language.lep$TRACTID <- substring(language.lep$TRACTID, 2)

pop.below.5 <- getPopTract(c("B01001_003", "B01001_027"), 2018, "acs5") %>%
  group_by(GEOID) %>%
  summarise(total = sum(total)) %>%
  rename(TRACTID = GEOID, Below.5.Pop = total)

pop.below.5$TRACTID <- substring(pop.below.5$TRACTID, 2)
pop.5.above <- merge(pop.data, pop.below.5, by = "TRACTID")
pop.5.above$pop <- pop.5.above$Total - pop.5.above$Below.5.Pop

language.lep$Total.Above.5.Pop <- pop.5.above$pop

language.lep$Percent <- language.lep$LEP.Pop / language.lep$Total.Above.5.Pop

# Merge everything together
# Merge data together
language.lep <- merge(language.lep, SFRRData.Historic, by.x = "TRACTID", by.y = "GEOID10")
language.lep <- language.lep %>%
  select("TRACTID", "TRACTID.y", "Neighborhood", "District", "CRRALL", 
         "Percent") %>%
  rename(new.TRACTID = TRACTID.y)

# Filter it out
language.lep$Percent <- 
  as.numeric(as.character(language.lep$Percent))

language.lep.high <- language.lep %>%
  filter(Percent >= 0.60)

language.lep.low <- language.lep %>%
  filter(Percent < 0.60)

# Calculations
mean(language.lep.high$CRRALL)
median(language.lep.high$CRRALL)

mean(language.lep.low$CRRALL)
mean(language.lep.low$CRRALL)
