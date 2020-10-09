library(dplyr)
library(ggplot2)

##### INTAKE METHOD #####
X5_curr <- X5_intake %>%
  filter(Year == "Fiscal Year 2019-2020")
summary(X5_curr)

# Intake method: Of 59 submissions,
# 28 intake, 11 survey, 10 telephonic

##### CLIENT INFORMATION #####
X6_curr <- X6_client  %>%
  filter(Year == "Fiscal Year 2019-2020")

sum(X6_curr$Total.Clients, na.rm = TRUE)
sum(X6_curr$LEP.Total, na.rm = TRUE)
sum(X6_curr$LEP.CAN, na.rm = TRUE)
sum(X6_curr$LEP.MAN, na.rm = TRUE)
sum(X6_curr$LEP.SPA, na.rm = TRUE)
sum(X6_curr$LEP.FIL, na.rm = TRUE)
sum(X6_curr$LEP.VIET, na.rm = TRUE)
sum(X6_curr$LEP.RUS, na.rm = TRUE)
sum(X6_curr$LEP.OTHER, na.rm = TRUE)

##### TRANSLATIONS ####
X7_curr <- X7_translations %>%
  filter(Year == "Fiscal Year 2019-2020")

sum(X7_curr$Translations.CHI, na.rm = TRUE)
sum(X7_curr$Translations.SPA, na.rm = TRUE)
sum(X7_curr$Translations.FIL, na.rm = TRUE)
sum(X7_curr$Translations.VIET, na.rm = TRUE)
sum(X7_curr$Translations.RUS, na.rm = TRUE)
sum(X7_curr$Translations.OTHER, na.rm = TRUE)

#### INTERPRETATIONS - PHONE ####
X8_curr <- X8_interpret_phone %>%
  filter(Year == "Fiscal Year 2019-2020")

sum(X8_curr$Calls.Total.LEP, na.rm = TRUE)
sum(X8_curr$Calls.CAN, na.rm = TRUE)
sum(X8_curr$Calls.MAN, na.rm = TRUE)
sum(X8_curr$Calls.SPA, na.rm = TRUE)
sum(X8_curr$Calls.FIL, na.rm = TRUE)
sum(X8_curr$Calls.VIET, na.rm = TRUE)
sum(X8_curr$Calls.RUS, na.rm = TRUE)
sum(X8_curr$Calls.OTHER, na.rm = TRUE)

#### INTERPRETATIONS - PERSON ####

X9_curr <- X9_interpret_person %>%
  filter(Year == "Fiscal Year 2019-2020")

sum(X9_curr$Interpretations.Total, na.rm = TRUE)
sum(X9_curr$Interpretations.CAN, na.rm = TRUE)
sum(X9_curr$Interpretations.MAN, na.rm = TRUE)
sum(X9_curr$Interpretations.SPA, na.rm = TRUE)
sum(X9_curr$Interpretations.FIL, na.rm = TRUE)
sum(X9_curr$Interpretations.VIET, na.rm = TRUE)
sum(X9_curr$Interpretations.RUS, na.rm = TRUE)
sum(X9_curr$Interpretations.OTHER, na.rm = TRUE)

#### STAFFING - All Multilingual ####
X11_curr <- X11_staffing %>%
  filter(Year == "Fiscal Year 2019-2020")

sum(X11_curr$Staff.Total, na.rm = TRUE)
sum(X11_curr$Staff.Total.Multilingual, na.rm = TRUE)

sum(X11_curr$Staff.CAN, na.rm = TRUE)
sum(X11_curr$Staff.MAN, na.rm = TRUE)
sum(X11_curr$Staff.SPA, na.rm = TRUE)
sum(X11_curr$Staff.FIL, na.rm = TRUE)
sum(X11_curr$Staff.VIET, na.rm = TRUE)
sum(X11_curr$Staff.RUS, na.rm = TRUE)
sum(X11_curr$Staff.OTHER, na.rm = TRUE)

#### STAFFING - Certified ####

sum(X11_curr$Staff.Total.Multilingual.Cert, na.rm = TRUE)
sum(X11_curr$Staff.Cert.CAN, na.rm = TRUE)
sum(X11_curr$Staff.Cert.MAN, na.rm = TRUE)
sum(X11_curr$Staff.Cert.SPA, na.rm = TRUE)
sum(X11_curr$Staff.Cert.FIL, na.rm = TRUE)
sum(X11_curr$Staff.Cert.VIET, na.rm = TRUE)
sum(X11_curr$Staff.Cert.RUS, na.rm = TRUE)
sum(X11_curr$Staff.Cert.OTHER, na.rm = TRUE)

#### CERTIFICATIONS ####

X12_curr <- X12_bilingual_cert %>%
  filter(Year == "Fiscal Year 2019-2020")
summary(X12_curr)

#### LANGAUGE POLICIES ####
X13_curr <- X13_dep_lao %>%
  filter(Year == "Fiscal Year 2019-2020")
summary(X13_curr)

#### SERVICES ASSESSMENT ####
X14_curr <- X14_services_assess %>%
  filter(Year == "Fiscal Year 2019-2020")

#### BUDGET ####
X18_curr <- X18_budget %>%
  filter(Year == "Fiscal Year 2019-2020")

sum(X18_curr$`Total Lang Services Budget`, na.rm = TRUE)
