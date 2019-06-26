# This script calculates all of the Census Hard to Count variables in San Francisco.
# =================================

# Racial Minorities --> Does this mean all non-whites?
minorities <-
  result(c("B02001_003", "B02001_004", "B02001_005", "B02001_006",
         "B02001_007", "B02001_008"))

# Young Children (0-4)
young_children <-
  result(c("B01001_003","B01001_027"))

# Young people (18-24)
young_ppl <-
  result(c("B01001_007","B01001_008","B01001_009","B01001_010",
         "B01001_031","B01001_032","B01001_033","B01001_034"))

# Seniors 65+
seniors <-
  result(c("B01001_020","B01001_021","B01001_022","B01001_023",
         "B01001_024","B01001_025","B01001_044","B01001_045","B01001_046",
         "B01001_047","B01001_048","B01001_049"))

# The Latinx Community
latinx <-
  result(c("B03001_003"))

# People with Disabilities
disabilities <-
  result(c("C18120_004","C18120_007","C18120_010"))

# Immigrants & Non-Citizens
non_citizens <-
  result(c("B05001_005", "B05001_006"))

# Non-High School Graduates
non_hs_grads <-
  result(c("B15003_002","B15003_003", "B15003_004","B15003_005",
         "B15003_006","B15003_007","B15003_008","B15003_009",
         "B15003_010","B15003_011","B15003_012","B15003_013",
         "B15003_014","B15003_015", "B15003_016"))

# People who are Unemployed
unemployed <-
  result(c("B23025_005")) # 16 yr

# LEP Communities
LEP <-
  result(c("B16004_006","B16004_009","B16004_012","B16004_015","B16004_020",
         "B16004_023","B16004_026","B16004_029","B16004_034","B16004_037",
         "B16004_040","B16004_043"))

# Veterans
veterans <-
  result(c("B21001_002"))

# Non-family Households
non_fam_households <-
  result(c("B11001_007"))

# Renters
renter <-
  result(c("B25003_003"))

# Crowded Households
crowded_household <-
  result(c("B25014_006","B25014_007", "B25014_012", "B25014_013"))

# Vacant Households
vacant <-
  result(c("B25002_003"))

# Households Receiving Public Assistance
public_assistance <-
  result(c("B19057_002"))

# Households in Multi-Unit Structures
multi_unit <-
  result(c("B25024_005", "B25024_006", "B25024_007",
         "B25024_008", "B25024_009"))

# Households without a Broadband Subscription
no_broadband <-
  result(c("B28001_007","B28001_008","B28001_003",
           "B28001_006","B28001_005"))

# ====================================

# Combine HTC Variables to get neighborhoods
#=================
# Read in CSV on neighborhoods corresponding with tracts
sf_nbhd <- read.csv(file="tract-to-nbhd.csv", head=TRUE, sep=",")
sf_nbhd$GEOID <- ifelse(nchar(sf_nbhd$GEOID)<11, paste0("0",sf_nbhd$GEOID), sf_nbhd$GEOID)

# Import the analysis neigborhood shapefile
analysis_nbhd <- read_sf(dsn=".", layer = "analysis-nbhd")

# HTC Group
#==================
htc_group = list("crowded_household", "disabilities", "latinx", "LEP", "minorities", "no_broadband",
                 "non_citizens", "non_fam_households", "non_hs_grads", "public_assistance", "renter",
                 "seniors", "unemployed", "vacant", "veterans", "young_children", "young_ppl")
# Get neighborhood level
for (group in htc_group) {
  obj <- get(group)
  ds <- combine(obj)
  assign(paste0("nbhd_",group),ds)
}

# Get Palettes
for (group in htc_group) {
  obj <- get(paste0("nbhd_",group))
  temp_total <- obj$total
  assign(paste0("pal_", group),getPal(temp_total))
}

# Leaflet Map
#==================

Test_Map <- leaflet(analysis_nbhd) %>%
  addTiles() %>%
  addPolygons(
    smoothFactor = 0.2, fillOpacity = 0.5, color = "#444444", weight = 1,
    highlightOptions = highlightOptions(color = "white", weight = 2, bringToFront = TRUE),
    popup = paste(
      "<h2>", nbhd_renter$Neighborhood, "</h2>",
      "<ul>",
      "<li>Total Renters: ",nbhd_renter$total,"</li>",
      "<li> Crowded Households:", nbhd_crowded_household$total,"</li>",
      "<li> Disabilities:", nbhd_disabilities$total,"</li>",
      "<li> Latinx:", nbhd_latinx$total,"</li>",
      "<li> Limited English Proficiency:", nbhd_LEP$total,"</li>",
      "<li> Minorities:", nbhd_minorities$total,"</li>",
      "<li> No Broadband:", nbhd_no_broadband$total,"</li>",
      "<li> Non-Citizens:", nbhd_non_citizens$total,"</li>",
      "<li> Non-Family Households:", nbhd_non_fam_households$total,"</li>",
      "<li> Non-High School Graduates:", nbhd_non_hs_grads$total,"</li>",
      "<li> Public Assistance:", nbhd_public_assistance$total,"</li>",
      "<li> Renter:", nbhd_renter$total,"</li>",
      "<li> Seniors:", nbhd_seniors$total,"</li>",
      "<li> Unemployed:", nbhd_unemployed$total,"</li>",
      "<li> Vacant Housing Units:", nbhd_vacant$total,"</li>",
      "<li> Veterans:", nbhd_veterans$total,"</li>",
      "<li> Young Children:", nbhd_young_children$total,"</li>",
      "<li> Young Adults:", nbhd_young_ppl$total,"</li>",
      "</ul>"
    ),
    fillColor = ~pal_renter(nbhd_renter$total), group="Renters"
  ) %>%
  addPolygons (group="No Broadband",
    smoothFactor = 0.2, fillOpacity = 0.5, color = "#444444", weight = 1,
    fillColor = ~pal_no_broadband(nbhd_no_broadband$total),
    highlightOptions = highlightOptions(color = "white", weight = 2, bringToFront = TRUE)
  ) %>%
  addPolygons (group="Crowded Household",
    smoothFactor = 0.2, fillOpacity = 0.5, color = "#444444", weight = 1,
    fillColor = ~pal_crowded_household(nbhd_crowded_household$total),
    highlightOptions = highlightOptions(color = "white", weight = 2,
                                        bringToFront = TRUE)
  ) %>%
  addPolygons ( group="Disability",
    smoothFactor = 0.2, fillOpacity = 0.5, color = "#444444", weight = 1,
    fillColor = ~pal_disabilities(nbhd_disabilities$total),
    highlightOptions = highlightOptions(color = "white", weight = 2,
                                        bringToFront = TRUE)
  ) %>%
  addPolygons (group="Latinx",
    smoothFactor = 0.2, fillOpacity = 0.5, color = "#444444", weight = 1,
    fillColor = ~pal_latinx(nbhd_latinx$total),
    highlightOptions = highlightOptions(color = "white", weight = 2,
                                        bringToFront = TRUE)
  ) %>%
  addPolygons (group="LEP",
    smoothFactor = 0.2, fillOpacity = 0.5, color = "#444444", weight = 1,
    fillColor = ~pal_LEP(nbhd_LEP$total),
    highlightOptions = highlightOptions(color = "white", weight = 2,
                                        bringToFront = TRUE)
  ) %>%
  # Minorities
  addPolygons (group="Minorities",
    smoothFactor = 0.2, fillOpacity = 0.5, color = "#444444", weight = 1,
    fillColor = ~pal_minorities(nbhd_minorities$total),
    highlightOptions = highlightOptions(color = "white", weight = 2,
                                        bringToFront = TRUE)
  ) %>%

  # Non Citizens and Immigrants
  addPolygons (group="Non-Citizens",
    smoothFactor = 0.2, fillOpacity = 0.5, color = "#444444", weight = 1,
    fillColor = ~pal_non_citizens(nbhd_non_citizens$total),
    highlightOptions = highlightOptions(color = "white", weight = 2,
                                        bringToFront = TRUE)
  ) %>%
  # Non-Family Households
  addPolygons (group="Non-Family Households",
    smoothFactor = 0.2, fillOpacity = 0.5, color = "#444444", weight = 1,
    fillColor = ~pal_non_fam_households(nbhd_non_fam_households$total),
    highlightOptions = highlightOptions(color = "white", weight = 2,
                                        bringToFront = TRUE)
  ) %>%
  # Non High School Graduates
  addPolygons (group="Non-HS Grads",
    smoothFactor = 0.2, fillOpacity = 0.5, color = "#444444", weight = 1,
    fillColor = ~pal_non_hs_grads(nbhd_non_hs_grads$total),
    highlightOptions = highlightOptions(color = "white", weight = 2,
                                        bringToFront = TRUE)
  ) %>%
  # Public Assistance
  addPolygons (group="Public Assistance",
    smoothFactor = 0.2, fillOpacity = 0.5, color = "#444444", weight = 1,
    fillColor = ~pal_public_assistance(nbhd_public_assistance$total),
    highlightOptions = highlightOptions(color = "white", weight = 2,
                                        bringToFront = TRUE)
  ) %>%
  # Seniors
  addPolygons (group="Seniors",
    smoothFactor = 0.2, fillOpacity = 0.5, color = "#444444", weight = 1,
    fillColor = ~pal_seniors(nbhd_seniors$total),
    highlightOptions = highlightOptions(color = "white", weight = 2,
                                        bringToFront = TRUE)
  ) %>%
  # Unemployed
  addPolygons (group="Unemployed",
    smoothFactor = 0.2, fillOpacity = 0.5, color = "#444444", weight = 1,
    fillColor = ~pal_unemployed(nbhd_unemployed$total),
    highlightOptions = highlightOptions(color = "white", weight = 2,
                                        bringToFront = TRUE)
  ) %>%
  # Vacant Units
  addPolygons (group="Vacant Units",
    smoothFactor = 0.2, fillOpacity = 0.5, color = "#444444", weight = 1,
    fillColor = ~pal_vacant(nbhd_vacant$total),
    highlightOptions = highlightOptions(color = "white", weight = 2,
                                        bringToFront = TRUE)
  ) %>%
  # Veterans
  addPolygons (group="Veterans",
    smoothFactor = 0.2, fillOpacity = 0.5, color = "#444444", weight = 1,
    fillColor = ~pal_veterans(nbhd_veterans$total),
    highlightOptions = highlightOptions(color = "white", weight = 2,
                                        bringToFront = TRUE)
  ) %>%
  # Young Children
  addPolygons (group="Young Children",
    smoothFactor = 0.2, fillOpacity = 0.5, color = "#444444", weight = 1,
    fillColor = ~pal_young_children(nbhd_young_children$total),
    highlightOptions = highlightOptions(color = "white", weight = 2,
                                        bringToFront = TRUE)
  ) %>%
  # Young People
  addPolygons (group="Young People",
    smoothFactor = 0.2, fillOpacity = 0.5, color = "#444444", weight = 1,
    fillColor = ~pal_young_ppl(nbhd_young_ppl$total),
    highlightOptions = highlightOptions(color = "white", weight = 2,
                                        bringToFront = TRUE)
  ) %>%
  hideGroup(c("No Broadband","Crowded Household", "Disability",
              "Latinx", "LEP", "Minorities", "Non-Citizens",
              "Non-Family Households", "Non-HS Grads", "Public Assistance",
              "Seniors", "Unemployed", "Vacant Units", "Veterans",
              "Young Children", "Young People")) %>%
  addLayersControl(
    overlayGroups = c("No Broadband","Crowded Household", "Disability",
                      "Latinx", "LEP", "Minorities", "Non-Citizens",
                      "Non-Family Households", "Non-HS Grads", "Public Assistance",
                      "Renters", "Seniors", "Unemployed", "Vacant Units", "Veterans",
                      "Young Children", "Young People"),
    options = layersControlOptions(collapsed=FALSE)
  )


htmlwidgets::saveWidget(Test_Map, file = "test_map.html", selfcontained = FALSE)
rm(list=ls())
