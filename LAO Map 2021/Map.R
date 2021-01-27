# Load things up
library("tools")
library("maps")
library("ggplot2")
library("sf")
library("tidyverse")
library(leaflet)
library(tmap)

districts <- Current_Supervisor_Districts
lang_map <- merge(districts, lang_by_district, by.x = "supdistpad", by.y = "District")
lang_map$geometry <- lang_map$the_geom

test <- read_sf(lang_map$geometry)
