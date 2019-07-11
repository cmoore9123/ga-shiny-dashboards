library(tidyverse)
library(googleAnalyticsR)
library(lubridate)
library(shiny)
library(shinydashboard)
library(DT)

shinyServer(function(input, output, session) {
  
  ga_auth()
  
  ga_meta_data <- google_analytics_meta()
  
  metrics <- ga_meta_data %>% 
    filter(type == 'METRIC') %>% 
    mutate(metric_name = gsub(pattern = 'ga:', replacement = '', x = name)) %>% 
    select(metric_name) 
  
  dimensions <- ga_meta_data %>% 
    filter(type == 'DIMENSION') %>% 
    mutate(dimension_name = gsub(pattern = 'ga:', replacement = '', x = name)) %>% 
    select(dimension_name) 
  
  updateSelectInput(session = session,
                    inputId = 'metric_selections',
                    choices = metrics$metric_name)
  
  updateSelectInput(session = session,
                    inputId = 'dimension_selections',
                    choices = dimensions$dimension_name)
    
  
  
  ga_data <- eventReactive(input$update, {
    
    ga_data <- google_analytics(viewId = '197714008',
                                date_range = c(input$date_range[1], input$date_range[2]), 
                                metrics = input$metric_selections,
                                dimensions = input$dimension_selections,
                                anti_sample = TRUE)
  })
  
  output$ga_table <- renderDataTable({ga_data()})
  
})