# Shiny practice app
# Coren Huff
# 2026-06-04

# load libraries
library(shiny)
library(shinythemes)
library(shinyjs)
library(tidyverse)

# three parts : user interfaces, a server (tells how application generates outputs), and a call 

# UI: layout and inputs/outputs go here
ui <- fluidPage(
  titlePanel("Exploring the normal distribution"),
  plotOutput(outputId = 'normal_plot'),
  textOutput(outputId = 'context_discussion'), 
  titlePanel("Exploring the normal distribution"),
  plotOutput(outputId = 'normal_plot2')
  #add ui code here
)

# Server: logic and reactivity go here
server <- function(input, output) {
  #add server code 
 output$normal_plot <- renderPlot({
   #create normal vector
   set.seed(seed=7)
   samples <- rnorm(1000, mean=0, sd=1)
   
   #make a histogram
   hist(samples, 
        breaks=30,
        col='tomato',
        name='Histogram of Coren\'s normal samples', 
        xlab='Value')
 })
 
 output$normal_plot2 <- renderPlot({
   #create normal vector
   set.seed(seed=7)
   samples <- rnorm(1000, mean=0, sd=1)
   
   #make a histogram
   hist(samples, 
        breaks=30,
        col='violet',
        name='Histogram of Coren\'s normal samples', 
        xlab='Value')
 })
 
 #add context
 output$context_discussion <- renderText({'Histogram shows 1,000 values randomly drawn from a standard normal distribution.'})
 
}
  
# launch the app
shinyApp(ui, server)