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
  titlePanel("Interactive Visualization"),
  selectInput(
    inputId = "source", 
    choices = c("Cement", "Coal", "Flaring", "Gas", "Oil"),
    label = "CO2 Emissions Source per Capita"
  ),
  selectInput(
    inputId = "color", 
    choices = c("red", "green", "purple"), 
    label = "Choose a line color"
  ),
  plotlyOutput(outputId = "line"),
  p("This chart is included because it demonstrates the different trends 
    of different sources of CO2 emissions. It can be used to reflect 
    upon technological advancement, as well as target which sources are
    most responsible for climate change. Takeaways from this chart are 
    that flaring and oil have reached the highest averages in any one 
    year. However, they have both seen declines after the mid-20th century. 
    On the contrary, gas and concrete have seen increasing averages
    recently.")
)

ui <- navbarPage(
  "CO2 Emissions",
  intro,
  visual
)