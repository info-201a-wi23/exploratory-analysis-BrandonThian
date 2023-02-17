# The init.R file must be executed before this R file.

# Load a chart library
library(ggplot2)

# Turn off scientific notation
options(scipen = 999)

# Duplicate np_data to avoid manipulating the original data frame.
df <- np_data

# Leave only NAICS and Employer columns first for join/query performance.
df <- df %>%
  select(NAICS, Employer)

# Join with the NAICS code info dataframe.
df <- left_join(df, np_naics, by = "NAICS")

# Group by NAICS and calculate the number of employers.
# Since a sector uses multiple NACIS codes, it should group by sector name, not NACIS..
df <- df %>%
  select(Sector, Employer) %>%
  group_by(Sector) %>%
  summarize(Sponsers = n()) %>%
  arrange(-Sponsers)

# Draw a bar chart.
ggplot(df) +
  aes(
    x = Sponsers,
    y = reorder(Sector, Sponsers, sum)
  ) +
  geom_bar(
    stat = "identity",
    fill = "#6070FF",
    width = 0.75,
    show.legend = FALSE,
  ) +
  geom_text(
    aes(label = Sponsers),
    size = 3,
    hjust = -0.1,
    vjust = 0.3,
    color = "#404040",
  ) +
  labs(
    title = paste0(
      "The Number of Sponsors by Industry Sector (",
      min(data_years),
      "~",
      max(data_years),
      ")"
    ),
    x = "The Number of Sponsors",
    y = "Industry Sectors",
  ) +
  xlim(0, 80000)
