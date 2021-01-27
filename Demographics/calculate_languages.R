# Demographics Analyses

# Run a sample script
sample_language <- search_category_keyword(2019, "acs5", "Language Spoken")

facts_spanish   <- search_label_keyword(year = 2019, survey = "acs5", keyword = "Spanish")
facts_filipino  <- search_label_keyword(year = 2019, survey = "acs5", keyword = "Filipino")
facts_chinese   <- search_label_keyword(year = 2019, survey = "acs5", keyword = "Chinese")
facts_russian   <- search_label_keyword(year = 2019, survey = "acs5", keyword = "Russian")
facts_viet      <- search_label_keyword(year = 2019, survey = "acs5", keyword = "Vietnamese")
facts_arabic    <- search_label_keyword(year = 2019, survey = "acs5", keyword = "Arabic")

# Language
facts_LEP <- search_label_keyword(2017, "acs1", "speak english less than")

# Write to a workbook
demographics <- createWorkbook()
addWorksheet(demographics, "Spanish")
addWorksheet(demographics, "Filipino")
addWorksheet(demographics, "Chinese")
addWorksheet(demographics, "Russian")
addWorksheet(demographics, "Vietnamese")
addWorksheet(demographics, "Arabic")

writeData(demographics, "Spanish", facts_spanish)
writeData(demographics, "Filipino", facts_filipino)
writeData(demographics, "Chinese", facts_chinese)
writeData(demographics, "Russian", facts_russian)
writeData(demographics, "Vietnamese", facts_viet)
writeData(demographics, "Arabic", facts_arabic)
saveWorkbook(demographics, file = "Demographics.xslx", overwrite = TRUE)
