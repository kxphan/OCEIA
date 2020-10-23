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

LEP.CAN   <- sum(X6_curr$LEP.CAN, na.rm = TRUE)
LEP.MAN   <- sum(X6_curr$LEP.MAN, na.rm = TRUE)
LEP.SPA   <- sum(X6_curr$LEP.SPA, na.rm = TRUE)
LEP.FIL   <- sum(X6_curr$LEP.FIL, na.rm = TRUE)
LEP.VIET  <- sum(X6_curr$LEP.VIET, na.rm = TRUE)
LEP.RUS   <- sum(X6_curr$LEP.RUS, na.rm = TRUE)
LEP.OTHER <- sum(X6_curr$LEP.OTHER, na.rm = TRUE)

LEP.Client.All <- c(LEP.CAN, LEP.MAN, LEP.SPA, LEP.FIL, LEP.VIET, LEP.RUS, LEP.OTHER)
LEP.Client.Percentage <- LEP.Client.All/LEP.Total
LEP.Total <- LEP.CAN + LEP.MAN + LEP.SPA + LEP.FIL + LEP.VIET + LEP.RUS + LEP.OTHER

LEP.plot <- barplot(height = LEP.Client.All,
                    names.arg = c("Cantonese", "Mandarin", "Spanish",
                                  "Filipino", "Vietnamese", "Russian",
                                  "Other"),
                    ylab = "Number of Clients",
                    col = "#69b3a2",
                    cex.axis = 0.75,
                    cex.lab = 0.75,
                    las = 2
                    )

##### TRANSLATIONS ####
X7_curr <- X7_translations %>%
  filter(Year == "Fiscal Year 2019-2020")

Translations.CHI   <- sum(X7_curr$Translations.CHI, na.rm = TRUE)
Translations.SPA   <- sum(X7_curr$Translations.SPA, na.rm = TRUE)
Translations.FIL   <- sum(X7_curr$Translations.FIL, na.rm = TRUE)
Translations.VIET  <- sum(X7_curr$Translations.VIET, na.rm = TRUE)
Translations.RUS   <- sum(X7_curr$Translations.RUS, na.rm = TRUE)
Translations.OTHER <- sum(X7_curr$Translations.OTHER, na.rm = TRUE)

Translations.All <- c(Translations.CHI, Translations.SPA, Translations.FIL, Translations.VIET,
                      Translations.RUS, Translations.OTHER)
Translations.Percentage <- Translations.All / sum(Translations.All)

LEP.plot <- barplot(height = Translations.All,
                    names.arg = c("Chinese", "Spanish",
                                  "Filipino", "Viet", "Russian",
                                  "Other"),
                    ylab = "Number of Translations",
                    col = "#69b3a2",
                    cex.axis = 0.75,
                    cex.lab = 0.75,
                    las = 2
)
#### INTERPRETATIONS - PHONE ####
X8_curr <- X8_interpret_phone %>%
  filter(Year == "Fiscal Year 2019-2020")

sum(X8_curr$Calls.Total.LEP, na.rm = TRUE)
Calls.CAN   <- sum(X8_curr$Calls.CAN, na.rm = TRUE)
Calls.MAN   <- sum(X8_curr$Calls.MAN, na.rm = TRUE)
Calls.SPA   <- sum(X8_curr$Calls.SPA, na.rm = TRUE)
Calls.FIL   <- sum(X8_curr$Calls.FIL, na.rm = TRUE)
Calls.VIET  <- sum(X8_curr$Calls.VIET, na.rm = TRUE)
Calls.RUS   <- sum(X8_curr$Calls.RUS, na.rm = TRUE)
Calls.OTHER <- sum(X8_curr$Calls.OTHER, na.rm = TRUE)

Calls.All <- c(Calls.CAN, Calls.MAN, Calls.SPA, Calls.FIL,
               Calls.VIET, Calls.RUS, Calls.OTHER)
Calls.Percentage <- Calls.All / sum(Calls.All)

barplot(height = Calls.All,
        names.arg = c("Cantonese", "Mandarin", "Spanish",
                      "Filipino", "Viet", "Russian",
                      "Other"),
        ylab = "Number of Phone Interpretations",
        col = "#69b3a2",
        cex.axis = 0.75,
        cex.lab = 0.75,
        las = 2
)

#### INTERPRETATIONS - PERSON ####

X9_curr <- X9_interpret_person %>%
  filter(Year == "Fiscal Year 2019-2020")

sum(X9_curr$Interpretations.Total, na.rm = TRUE)

Interpret.CAN  <- sum(X9_curr$Interpretations.CAN, na.rm = TRUE)
Interpret.MAN  <- sum(X9_curr$Interpretations.MAN, na.rm = TRUE)
Interpret.SPA  <- sum(X9_curr$Interpretations.SPA, na.rm = TRUE)
Interpret.FIL  <- sum(X9_curr$Interpretations.FIL, na.rm = TRUE)
Interpret.VIET <- sum(X9_curr$Interpretations.VIET, na.rm = TRUE)
Interpret.RUS  <- sum(X9_curr$Interpretations.RUS, na.rm = TRUE)
Interpret.OTHER <- sum(X9_curr$Interpretations.OTHER, na.rm = TRUE)

Interpret.All <- c(Interpret.CAN, Interpret.MAN, Interpret.SPA,
                   Interpret.FIL, Interpret.VIET, Interpret.RUS,
                   Interpret.OTHER)
Interpret.Percentage <- Interpret.All / sum(Interpret.All)

barplot(height = Interpret.All,
        names.arg = c("Cantonese", "Mandarin", "Spanish",
                      "Filipino", "Viet", "Russian",
                      "Other"),
        ylab = "Number of In-Person Interpretations",
        col = "#69b3a2",
        cex.axis = 0.75,
        cex.lab = 0.75,
        las = 2
)

#### STAFFING - All Multilingual ####
X11_curr <- X11_staffing %>%
  filter(Year == "Fiscal Year 2019-2020")

sum(X11_curr$Staff.Total, na.rm = TRUE)
sum(X11_curr$Staff.Total.Multilingual, na.rm = TRUE)

Staff.CAN   <- sum(X11_curr$Staff.CAN, na.rm = TRUE)
Staff.MAN   <- sum(X11_curr$Staff.MAN, na.rm = TRUE)
Staff.SPA   <- sum(X11_curr$Staff.SPA, na.rm = TRUE)
Staff.FIL   <- sum(X11_curr$Staff.FIL, na.rm = TRUE)
Staff.VIET  <- sum(X11_curr$Staff.VIET, na.rm = TRUE)
Staff.RUS   <- sum(X11_curr$Staff.RUS, na.rm = TRUE)
Staff.OTHER <- sum(X11_curr$Staff.OTHER, na.rm = TRUE)

Staff.All <- c(Staff.CAN, Staff.MAN, Staff.SPA,
               Staff.FIL, Staff.VIET, Staff.RUS,
               Staff.OTHER)

barplot(height = Staff.All,
        names.arg = c("Cantonese", "Mandarin", "Spanish",
                      "Filipino", "Viet", "Russian",
                      "Other"),
        ylab = "Number of Employees",
        col = "#69b3a2",
        cex.axis = 0.75,
        cex.lab = 0.75,
        las = 2
)

#### STAFFING - Certified ####

sum(X11_curr$Staff.Total.Multilingual.Cert, na.rm = TRUE)

Cert.CAN <- sum(X11_curr$Staff.Cert.CAN, na.rm = TRUE)
Cert.MAN <- sum(X11_curr$Staff.Cert.MAN, na.rm = TRUE)
Cert.SPA <- sum(X11_curr$Staff.Cert.SPA, na.rm = TRUE)
Cert.FIL <- sum(X11_curr$Staff.Cert.FIL, na.rm = TRUE)
Cert.VIET <- sum(X11_curr$Staff.Cert.VIET, na.rm = TRUE)
Cert.RUS <- sum(X11_curr$Staff.Cert.RUS, na.rm = TRUE)
Cert.OTHER <- sum(X11_curr$Staff.Cert.OTHER, na.rm = TRUE)

Cert.All <- c(Cert.CAN, Cert.MAN, Cert.SPA, Cert.FIL,
              Cert.VIET, Cert.RUS, Cert.OTHER)

barplot(height = Cert.All,
        names.arg = c("Cantonese", "Mandarin", "Spanish",
                      "Filipino", "Viet", "Russian",
                      "Other"),
        ylab = "Number of Employees",
        col = "#69b3a2",
        cex.axis = 0.75,
        cex.lab = 0.75,
        las = 2
)

#### CERTIFICATIONS ####

X12_curr <- X12_bilingual_cert %>%
  filter(Year == "Fiscal Year 2019-2020")
summary(X12_curr)

#### LANGAUGE POLICIES ####
X13_curr <- X13_dep_lao %>%
  filter(Year == "Fiscal Year 2019-2020")
summary(X13_curr)
table(X13_curr$Department.Has.Language.Policy)

#### SERVICES ASSESSMENT ####
X14_curr <- X14_services_assess %>%
  filter(Year == "Fiscal Year 2019-2020")
summary(X14_curr)
table(X14_curr$Curr.Bilingual.Employees.Adequate)
barplot(height = c(40, 8),
        names.arg = c("Yes", "No"),
        ylab = "Number of Departments",
        main = "Current number of bilingual employees adequate?",
        col = c("green", "red"))

table(X14_curr$Availability.Recorded.Messages)
barplot(height = c(17, 17, 16),
        names.arg = c("Excellent", "Adequate", "Needs Improvement"),
        ylab = "Number of Departments",
        xlab = "Quality",
        main = "Recorded Messages",
        col = c("green","yellow", "red"))

table(X14_curr$Quality.LEP.Notices)

barplot(height = c(25, 25, 3),
        names.arg = c("Excellent", "Adequate", "Needs Improvement"),
        ylab = "Number of Departments",
        xlab = "Quality",
        main = "Posted LEP Notices",
        col = c("green","yellow", "red"))

table(X14_curr$Translation.Services.Procedure)

barplot(height = c(30, 18, 3),
        names.arg = c("Excellent", "Adequate", "Needs Improvement"),
        ylab = "Number of Departments",
        xlab = "Quality",
        main = "Translation Service Procedures",
        col = c("green","yellow", "red"))

table(X14_curr$Interpretation.Procedures)

barplot(height = c(27, 22, 2),
        names.arg = c("Excellent", "Adequate", "Needs Improvement"),
        ylab = "Number of Departments",
        xlab = "Quality",
        main = "Interpretation Service Procedures",
        col = c("green","yellow", "red"))

#### BUDGET ####
X18_curr <- X18_budget %>%
  filter(Year == "Fiscal Year 2019-2020")

sum(X18_curr$`Total Lang Services Budget`, na.rm = TRUE)
