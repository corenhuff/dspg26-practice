# Shiny interactivity practice app
# Coren Huff
# 2026-06-04

# load libraries
library(shiny)
library(shinythemes)
library(shinyjs)
library(tidyverse)

#ui
ui <- fluidPage(
  titlePanel("Interactive Greeting Application"), 
  textInput(inputId = "user_input", 
            label = "Enter your greeting:", 
            value = "Hello, World!"), 
  
  textOutput((outputId = 'greeting'))
)

#server
server <- function(input, output) {
  output$greeting <- renderText({
    paste0(input$user_input, " is the greeting you entered")
  })
}

#launch app
shinyApp(ui, server)