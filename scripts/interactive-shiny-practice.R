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
  radioButtons(
    inputId = "user_input", 
    label = "Choose your greeting:", 
    choices = c("Hello!", "Howdy!", "What's up?"),
    selected = "What's up?"
  ),
  
  textInput(inputId = "name", 
            label = "What is your name?"),
  
  textOutput((outputId = 'greeting'))
)

#server
server <- function(input, output) {
  output$greeting <- renderText({
    paste(input$user_input, input$name)
  })
  
}

#launch app
shinyApp(ui, server)