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

# Average CO2 emissions per capita from different sources by year
avg_sources <- co2_data %>%
  group_by(year) %>%
  summarise(avg_cement = mean(cement_co2_per_capita, na.rm = T),
            avg_coal = mean(coal_co2_per_capita, na.rm = T),
            avg_flaring = mean(flaring_co2_per_capita, na.rm = T),
            avg_gas = mean(gas_co2_per_capita, na.rm = T),
            avg_oil = mean(oil_co2_per_capita, na.rm = T))

colnames(avg_sources) = c("Year", "Cement", "Coal", "Flaring", "Gas", "Oil")

server <- function(input, output) {
  output$line <- renderPlotly({
    co2_plot <- ggplot(data = avg_sources) +
      geom_line(mapping = aes_string(x = 'Year', y = avg_sources[[input$source]]), color = input$color) +
      labs(title = paste("Average CO2 Emissions per Capita from", input$source, "Over Time"),
           y = paste("Average CO2 Emissions\nper Capita from", input$source,"in Million Tonnes\n"))
    ggplotly(co2_plot)
  })
  output$intro_text <- renderText({
    paste(
    "Carbon dioxide, or CO2, is the primary greenhouse gas emitted
    through human activities, as well as the primary driver of global
    climate change. This page will analyze the following variables
    from the Our World in Data dataset on CO2 emissions:",
    "1. CO2 Growth Percent (co2_growth_pct) - percentage change in CO2 
    emissions from one year relative to the previous year",
    "2. Co2 Growth Absolute (co2_growth_abs) - annual change in CO2
    emissions from one year relative to the previous year,
    measured in million tonnes",
    "3. Consumption CO2 (consumption_co2) - annual consumption-based
    CO2 emissions, measured in million tonnes per year",
    "4. CO2 Per Capita (co2_per_capita) - average per capita CO2
    emissions, measured in tonnes per year.", sep = "\n"
    )
  })
  output$summary_text <- renderText({
    paste0("The average CO2 emissions change in the most recent year from
    the year prior is ", avg_growth_pct, "%, or ", avg_growth_abs,
    " million tonnes. The country with the highest amount of cumulative
    consumption-based CO2 emissions is ", highest_consump,
    ". The year with highest average CO2 per capita was ", high_per_capita,
    ". The number of countries that increased CO2 emissions
    in the most recent year was ", num_increased,  " out of ", num_countries,
    " or ", percent_increased, "% of them.")
  })
}