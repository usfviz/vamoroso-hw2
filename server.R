library(shiny)
library(ggplot2)
library(plotly)

shinyServer(function(input, output) {
  
  dataset <- reactive({
    full_c[full_c$year %in% input$year,]
  })
  
  output$dynamicPlot <- renderPlotly({
    
    p <- ggplot(dataset(), aes(x = life_ex, y = fertility, key = Country.Name)) 
    
    p + geom_point(aes(size = population, color = Region), alpha = .6) + 
      xlim(c(0,90)) + ylim(c(0,9)) + 
      xlab('Life Expectancy') + 
      ylab('Fertility Rate') +
      scale_size(range = c(1, input$population), guide = FALSE) 
    
    
    
  })
  
})
