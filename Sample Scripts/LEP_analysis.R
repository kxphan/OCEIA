# District LEP Population
LEP_1 <- data.frame(getDistrict(LEP_var, 2018, "acs5", 1))
LEP_2 <- data.frame(getDistrict(LEP_var, 2018, "acs5", 2))
LEP_3 <- data.frame(getDistrict(LEP_var, 2018, "acs5", 3))
LEP_4 <- data.frame(getDistrict(LEP_var, 2018, "acs5", 4))
LEP_5 <- data.frame(getDistrict(LEP_var, 2018, "acs5", 5))
LEP_6 <- data.frame(getDistrict(LEP_var, 2018, "acs5", 6))
LEP_7 <- data.frame(getDistrict(LEP_var, 2018, "acs5", 7))
LEP_8 <- data.frame(getDistrict(LEP_var, 2018, "acs5", 8))
LEP_9 <- data.frame(getDistrict(LEP_var, 2018, "acs5", 9))
LEP_10 <- data.frame(getDistrict(LEP_var, 2018, "acs5", 10))
LEP_11 <- data.frame(getDistrict(LEP_var, 2018, "acs5", 11))

LEP <- rbind(LEP_1, LEP_2, LEP_3, LEP_4, LEP_5, LEP_6, LEP_7,LEP_8, LEP_9, LEP_10, LEP_11)

# Compile LEP population change from 2014-2018
getPopChange <- function(district) {
  LEP2014 <- getDistrictSum(LEP_var_old, 2014, "acs5", district)
  LEP2015 <- getDistrictSum(LEP_var_old, 2015, "acs5", district)
  LEP2016 <- getDistrictSum(LEP_var, 2016, "acs5", district)
  LEP2017 <- getDistrictSum(LEP_var, 2017, "acs5", district)
  LEP2018 <- getDistrictSum(LEP_var, 2018, "acs5", district)
  rbind(LEP2014, LEP2015, LEP2016, LEP2017, LEP2018)
}

# District LEP Household
getDistrictSum(LEP_house, 2018, "acs5", 11)$total
getDistrict("C16002_001",2018, "acs5", 11)$total

# Citizenship Status of LEP Spekaers
getDistrictSum(LEP_native, 2018, "acs5", 1)$total
getDistrictSum(LEP_naturalized, 2018, "acs5", 1)$total
getDistrictSum(LEP_noncitizen, 2018, "acs5", 1)$total
