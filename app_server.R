library(shiny)
library(ggplot2)

co2_data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

# Average CO2 emissions change in most recent year from year prior,
# both percentage and absolute value
most_recent <- co2_data %>%
  filter(year == max(year, na.rm = T))
avg_growth_pct <- round(mean(most_recent$co2_growth_prct), 3)
avg_growth_abs <- round(mean(most_recent$co2_growth_abs), 3)

# Country with highest consumption-based CO2, cumulative over all time
highest_consump <- co2_data %>%
  group_by(country) %>%
  summarise(total_consump = sum(consumption_co2, na.rm = T)) %>%
  filter(total_consump == max(total_consump, na.rm = T)) %>%
  pull(country)

# Year with highest average CO2 per capita
high_per_capita <- co2_data %>%
  group_by(year) %>%
  summarise(avg_per_capita = mean(co2_per_capita, na.rm = T)) %>%
  filter(avg_per_capita == max(avg_per_capita, na.rm = T)) %>%
  pull(year)

# Percent of countries that increased CO2 emissions in the most recent year
num_increased <- most_recent %>%
  filter(co2_growth_abs > 0) %>%
  nrow()
num_countries <- length(unique(co2_data$country))
percent_increased <- round(num_increased / num_countries, 3) * 100

server <- function(input, output) {
  
}