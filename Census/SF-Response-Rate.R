rm(list=ls(all=TRUE))

library(dplyr)
library(tidyverse)
library(stringr)

# San Francisco Response Rate Tracts
SFRRData <- RRdata %>%
  filter(str_detect(GEO_ID, "1400000US06075"))
