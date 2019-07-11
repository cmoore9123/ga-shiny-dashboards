library(tidyverse)
library(googleAnalyticsR)
library(lubridate)
library(shiny)
library(shinydashboard)
library(DT)

shinyServer(function(input, output, session) {
  
  ga_auth()
  
  
  ga_data <- eventReactive(input$update, {
    
    ga_data <- google_analytics(viewId = '197714008',
                                date_range = c(input$date_range[1], input$date_range[2]), 
                                metrics = 'pageviews',
                                dimensions = c('date', 'pageTitle'),
                                anti_sample = TRUE)
  })
  
  output$ga_table <- renderDataTable({ga_data()})
  
})