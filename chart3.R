# Load a chart library
library(ggplot2)

# Load a duplicate data frame (np_data) to avoid overwriting the original data frame.
df <- np_data


# Selecting Initial Approval, Continuing.Approval, and Year columns
df <- df %>%
  select(Initial.Approval,Continuing.Approval,Year)

# Summing up the number of approvals by type and year
Initial2020 <- sum(df$Initial.Approval[df$Year == 2020]) 
Initial2021 <- sum(df$Initial.Approval[df$Year == 2021]) 
Initial2022 <- sum(df$Initial.Approval[df$Year == 2022]) 
Continuing2020 <- sum(df$Continuing.Approval[df$Year == 2020])
Continuing2021 <- sum(df$Continuing.Approval[df$Year == 2021])
Continuing2022 <- sum(df$Continuing.Approval[df$Year == 2022])


# apply X-value(year) and y-value(approvals) into data frame
df <- data.frame(year_x <- c(2020,2021,2022),
                 initial_y <- c(Initial2020, Initial2021, Initial2022),
                 Continuing_y <- c(Continuing2020, Continuing2021, Continuing2022))


#Visualize the Line Chart
ggplot(data=df, aes(x=year_x)) + 
  geom_line(aes(y=initial_y, colour="Initial"), linewidth=2) +
  geom_line(aes(y=Continuing_y, colour="Continuing"), linewidth=2) +
  scale_color_manual(name = "Type of Approval", values = c("Initial" = "darkblue", "Continuing" = "red")) +
  
  labs(title = paste0("The Change of The Number of H1-B Visa Sponsors"),
       x = "Pandemic Year",
       y = "Number of Approvals")
 