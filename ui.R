library(tidyverse)
library(googleAnalyticsR)
library(lubridate)
library(shiny)
library(shinydashboard)
library(DT)

shinyUI(function(input, output, session) {
  
  dashboardPage(
    
    dashboardHeader(disable = TRUE),
    
    dashboardSidebar(disable = TRUE),
    
    dashboardBody(
      
      fluidRow(
        
        actionButton(inputId = 'update', label = 'Get Data'),
        
        box(
          
            selectInput(inputId =  'metric_selections',
                        label = 'Metrics',
                        choices = 'metric_selections',
                        multiple = TRUE),
            
            selectInput(inputId =  'dimension_selections',
                        label = 'Dimensions',
                        choices = 'dimension_selections',
                        multiple = TRUE)),
        
        box(
          
          sliderInput(inputId = 'date_range',
                      label = 'Date range',
                      min = as.Date('2019-06-01'),
                      max = today(), value = c(as.Date('2019-06-01'), today())))
        
      ),
      
      fluidRow(
        
        box(
          
          DT::dataTableOutput(outputId = 'ga_table'), width = 12
        )
      )
    )
  )
  
  
})