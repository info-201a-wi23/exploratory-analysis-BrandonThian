# This is a file to handle global data.
# Feel free to add initialization code for global here.
library(dplyr)

# Turn off scientific notation
options(scipen = 999)

# Load csv data and combine them.
# Data source: https://www.uscis.gov/tools/reports-and-studies/h-1b-employer-data-hub/h-1b-employer-data-hub-files

# Data year range definition. Currently, we use from 2018 to 2022.
data_years <- c(2018:2022)

# The header column is slightly different each year, so we need to unify them.
data_columns <- c(
  "Year", "Employer", "Initial.Approval", "Initial.Denial", "Continuing.Approval", "Continuing.Denial",
  "NAICS", "Tax.ID", "State", "City", "ZIP"
)

# Initialize np_data with an empty data frame
np_data <- NULL

# Load each data and merge them
for (year in data_years) {
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

  if (is.null(np_data)) {
    np_data <- np
  } else {
    np_data <- full_join(np_data, np)
  }
}

# Definition of NAICS codes.
# Data source: https://www.census.gov/naics/
np_naics <- data.frame(
  "NAICS" = c(
    11, 21, 22,
    23, 31, 32,
    33, 42, 44,
    45, 48, 49,
    51, 52, 53,
    54, 55, 56,
    61, 62, 71,
    72, 81, 92,
    99
  ),
  "Sector" = c(
    "Agriculture, Forestry, Fishing and Hunting", "Mining", "Utilities",
    "Construction", "Manufacturing", "Manufacturing",
    "Manufacturing", "Wholesale Trade", "Retail Trade",
    "Retail Trade", "Transportation and Warehousing", "Transportation and Warehousing",
    "Information", "Finance and Insurance	", "Real Estate Rental and Leasing",
    "Professional, Scientific, and Technical Services", "Management of Companies and Enterprises", "Administrative, Support, Waste, and Remediation",
    "Educational Services", "Health Care and Social Assistance", "Arts, Entertainment, and Recreation",
    "Accommodation and Food Services", "Other Services (except Public Administration)", "Public Administration",
    "Etc"
  ),
  stringsAsFactors = FALSE
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
# np_naics   : NAICS code directory. (NAICS: code, Sector: Job sector explanation)
# data_years : A list of years in the data frame.
