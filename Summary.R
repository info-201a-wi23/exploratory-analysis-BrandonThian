# The init.R file must be executed before this R file.

# Load a string and table libraries
library(dplyr)
library(stringr)

# Duplicate np_data to avoid manipulating the original data frame.
df <- np_data

# Initialize a summary info list
summary <- list()


# Q1. The total number of records. 
summary$Total_record <- Total_record <- nrow(df)

# Q2. The state that has the highest number of sponsor
state_df <- df %>% 
  group_by(State) %>% 
  summarize(Sponsor = n())
summary$max_state <- state_df %>%
  filter(Sponsor == max(Sponsor, na.rm = TRUE)) %>%
  pull(State)

#Q3. The state that has the lowest number of sponsor 


summary$min_state <- state_df %>%
  filter(Sponsor == min(Sponsor, na.rm = TRUE)) %>%
  pull(State)



#Q4. The number of sponsor that has the highest number of sponsor 
summary$max_sponsor <- state_df %>%
  filter(Sponsor == max(Sponsor, na.rm = TRUE)) %>%
  pull(Sponsor)



#Q5. The number of sponsor that has the lowest number of sponsor

summary$min_sponsor <- state_df %>%
  filter(Sponsor == min(Sponsor, na.rm = TRUE)) %>%
  pull(Sponsor)
