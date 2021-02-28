# UI
library(shiny)
library(ggplot2)

intro <- tabPanel(
  titlePanel("Introduction"),
  h3("Summary"),
  p("Carbon dioxide, or CO2, is the primary greenhouse gas emitted
    through human activities, as well as the primary driver of global
    climate change. This page will analyze the following variables
    from the Our World in Data dataset on CO2 emissions:"),
  p("1. CO2 Growth Percent (co2_growth_pct) - percentage change in CO2 
    emissions from one year relative to the previous year"),
  p("2. Co2 Growth Absolute (co2_growth_abs) - annual change in CO2
    emissions from one year relative to the previous year, measured in million tonnes"),
  p("3. Consumption CO2 (consumption_co2) - annual consumption-based
    CO2 emissions, measured in million tonnes per year"),
  p("4. CO2 Per Capita (co2_per_capita) - average per capita CO2
    emissions, measured in tonnes per year."),
  hr(),
  p("The average CO2 emissions change in the most recent year from
    the year prior is", avg_growth_pct, "% OR", avg_growth_abs,
    "million tonnes"),
  p("The country with the highest amount of cumulative
    consumption-based CO2 emissions is", highest_consump),
  p("The year with highest average CO2 per capita was", high_per_capita),
  p("The number of countries that increased CO2 emissions
    in the most recent year was", num_increased, "out of", num_countries,
    "or", percent_increased, "% of them.")
)

visual <- tabPanel(
  titlePanel("Interactive Visualization")
)

ui <- navbarPage(
  "Climate Change",
  intro,
  visual
)