# This script calculates all of the Census Hard to Count variables in San Francisco.

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
