library(shiny)
library(ggplot2)
library(plotly)

dataset <- full_c

shinyUI(fluidPage(
  titlePanel("World Development Indicators - Fertility vs. Life Expectancy"),
  fluidRow(column(1, plotlyOutput('dynamicPlot', width = 950), width = 12)
  ),
  br(),
  fixedRow(
    column(0, sliderInput("year", label = "Year", min = 1960, max = 2014, value = 1960, step = 1, animate =animationOptions(), sep = '', width =725), width = 8),
    column(0, offset = -2, sliderInput("population", label = "Population", min = 1, max = 20, width = '30%', value = 7, ticks = FALSE), width = 4)
    )))
   
