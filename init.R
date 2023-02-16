# This is a file to handle global data.
# Feel free to add initialization code for global here.
library(dplyr)

# Load csv data and combine them.
# Data source: https://www.uscis.gov/tools/reports-and-studies/h-1b-employer-data-hub/h-1b-employer-data-hub-files

# Data year range definition. Currently, we use from 2018 to 2022.
data_range  = c(2018:2022)
  
# The header column is slightly different each year, so we need to unify them.
data_columns = c("Year", "Employer", "Initial.Approval", "Initial.Denial", "Continuing.Approval", "Continuing.Denial",
                 "NAICS", "Tax.ID", "State", "City", "ZIP")

# Initialize np_data with an empty data frame
np_data <- NULL

# Load each data and merge them
for (year in data_range) {
  np <- read.csv(
    paste0("https://www.uscis.gov/sites/default/files/document/data/h1b_datahubexport-", year, ".csv"),
    stringsAsFactors = FALSE,
    col.names = data_columns,
  )

  # Remove comma from integer fields
  np$Initial.Approval <- as.numeric(gsub(",", "", as.character(np$Initial.Approval)))
  np$Initial.Denial <- as.numeric(gsub(",", "", as.character(np$Initial.Denial)))
  np$Continuing.Approval <- as.numeric(gsub(",", "", as.character(np$Continuing.Approval)))
  np$Continuing.Denial <- as.numeric(gsub(",", "", as.character(np$Continuing.Denial)))
  
  if(is.null(np_data)) {
    np_data <- np
  } else {
    np_data <- full_join(np_data, np)
  }
}

# Definition of NAICS codes.
# Note that names(tags) are string type, not integer.
# Data source: https://www.naics.com/search/
naics_list <- c(
  "11" = "Agriculture, Forestry, Fishing and Hunting",
  "21" = "Mining",
  "22" = "Utilities",
  "23" = "Construction",
  "31" = "Manufacturing",
  "32" = "Manufacturing",
  "33" = "Manufacturing",
  "42" = "Wholesale Trade",
  "44" = "Retail Trade",
  "45" = "Retail Trade",
  "48" = "Transportation and Warehousing",
  "49" = "Transportation and Warehousing",
  "51" = "Information",
  "52" = "Finance and Insurance	",
  "53" = "Real Estate Rental and Leasing",
  "54" = "Professional, Scientific, and Technical Services",
  "55" = "Management of Companies and Enterprises",
  "56" = "Administrative and Support and Waste Management and Remediation Services",
  "61" = "Educational Services",
  "62" = "Health Care and Social Assistance",
  "71" = "Arts, Entertainment, and Recreation",
  "72" = "Accommodation and Food Services",
  "81" = "Other Services (except Public Administration)",
  "92" = "Public Administration"
)

# Remove unnecessary variables to avoid complicated team collaboration.
rm(data_columns)
rm(year)
rm(np)

# These are global variables.
# Please don't change the variables directly. (except for the Summary Information section)
# Otherwise, others might get unexpected values after they changed.
#
# np_data    : The entire united data frame.
# naics_list : NAICS code directory. (Key: code, Value: Job area)
# data_range : A list of years in the data frame.

