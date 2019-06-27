# Calculating all API Population Requests

# Total Population
var <- "B02001_005"

# Breakdown of API Population
var <- c( "B02015_002", "B02015_003", "B02015_004",
          "B02015_005", "B02015_006", "B02015_007",
          "B02015_008", "B02015_009", "B02015_010",
          "B02015_011", "B02015_012", "B02015_013",
          "B02015_014", "B02015_015", "B02015_016",
          "B02015_017", "B02015_018", "B02015_019",
          "B02015_020", "B02015_021", "B02015_022",
          "B02015_023", "B02015_024", "B02015_025"
)

# Age Breakdown
# 0 - 17
var <- c("B01001D_003", "B01001D_004", "B01001D_005", "B01001D_006",
         "B01001D_018", "B01001D_019", "B01001D_020", "B01001D_021")

# 18-64
var <- c("B01001D_007", "B01001D_008", "B01001D_009", "B01001D_010", "B01001D_011", "B01001D_012", "B01001D_013", "B01001D_022", "B01001D_023", "B01001D_024", "B01001D_025", "B01001D_026", "B01001D_027", "B01001D_028")

# 65+
var <- c("B01001D_014", "B01001D_015", "B01001D_016", "B01001D_029", "B01001D_030", "B01001D_031")

# Income Level, Median in the last 12 months
var <- "B20017D_001"

# Percentage in Poverty
var <-"B17020D_002"

# Foreign Born Population
var <- "B06004D_005"

# Naturalized Immigrant Population
var <- c("B05003D_006", "B05003D_011", "B05003D_017", "B05003D_022")

# Homeowners
var <- "B25003D_002"

# Education (HS Graduate)
var <- c("C15002D_009", "C15002D_004")

# Education (BA+)
var <- c("C15002D_011", "C15002D_006")

# Employed (16+)
var <- c("C23002D_020", "C23002D_025", "C23002D_007", "C23002D_012")
