# The init.R file must be executed before this R file.

# Load a string and table libraries
library(knitr)
library(stringr)

# Duplicate np_data to avoid manipulating the original data frame.
df <- np_data

# Group by year and calculate sum.
df <- df %>% 
  select(Year, Initial.Approval, Initial.Denial, Continuing.Approval, Continuing.Denial) %>% 
  group_by(Year) %>% 
  summarize(
    Initial.Approval = sum(Initial.Approval),
    Initial.Denial = sum(Initial.Denial),
    Continuing.Approval = sum(Continuing.Approval),
    Continuing.Denial = sum(Continuing.Denial),
  )

# Calculate the total approval and denial
df <- df %>% 
  mutate(Total.Approval = Initial.Approval + Continuing.Approval) %>% 
  mutate(Total.Denial = Initial.Denial + Continuing.Denial)

# Calculate the approval rate
df <- df %>% 
  mutate(
    "Approval.Rate(%)" =
      round(Total.Approval / (Total.Approval + Total.Denial) * 100.0, digits=1)
  )

# Remove dot in columns for wordwrap
colnames(df) <- str_replace_all(colnames(df), "\\.", "<br>")

kable(
  head(df, 10),
  caption = "The Table of H1 Visa Approval and Denials from 2018 to 2022")

