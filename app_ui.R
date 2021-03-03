# UI
library(shiny)
library(ggplot2)

intro <- tabPanel(
  titlePanel("Introduction"),
  h3("Dataset"),
  verbatimTextOutput("intro_text"),
  h3("Summary"),
  textOutput("summary_text")
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