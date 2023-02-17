# Load a duplicate data frame to prevent overwriting the original dataframe
df <- np_data

# Selecting only Employer and Year columns
df <- df %>%
  select(Employer, State)

# Remove duplicates
df <- unique(df)

# Count number of employers (sponsors) by state
total_sponsors_by_state <- df %>% 
                            group_by(State) %>%
                              summarize(number_per_state = n())

# Load state shapefile
state_shape <- map_data("state")

# Join state_shape with state_abbreviations
state_shape <- left_join(state_shape, state_abbreviations, by = c("region" = "State"))

# Join total_sponors_by_state with state_shape
total_sponsors_by_state <- left_join(total_sponsors_by_state, state_shape, by = c("State" = "Abbr"))
  
# Load blank theme for map
blank_theme <- theme_bw() +
  theme(
    axis.line = element_blank(), # remove axis lines
    axis.text = element_blank(), # remove axis labels
    axis.ticks = element_blank(), # remove axis ticks
    axis.title = element_blank(), # remove axis titles
    plot.background = element_blank(), # remove gray background
    panel.grid.major = element_blank(), # remove major grid lines
    panel.grid.minor = element_blank(), # remove minor grid lines
    panel.border = element_blank(), # remove border around plot
  )

# Plotting map
ggplot(total_sponsors_by_state) +
  geom_polygon(mapping = aes(x = long, 
                             y = lat, 
                             group = group, 
                             fill = number_per_state)) +
  scale_fill_continuous(low = "yellow",
                        high = "red",
                        labels = label_number_si()) +
  labs(title = 'Number of H1-B Sponsors by US State from 2020 to 2022', fill = 'Number of Sponsors') + 
  coord_map() +
  blank_theme