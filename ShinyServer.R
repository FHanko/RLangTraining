rm(list = ls())
library(shiny)
library(ggplot2)

source("DuoQueueFinder.R", local = TRUE)

ui <- fluidPage(
  titlePanel(title=h4("DuoQueueFinder", align="center")),
  sidebarPanel( 
    textInput("sumname", "Summoner Name", "Mango%20MSev"), 
    actionButton("go", "Go!")),
  mainPanel(plotOutput("plot2")))

server <- function(input,output){
  v <- reactiveValues(doPlot = FALSE)
  observeEvent(input$go, {
    # 0 will be coerced to FALSE
    # 1+ will be coerced to TRUE
    v$doPlot <- input$go
  })
  output$plot2<-renderPlot({
    if(v$doPlot == FALSE) return()
    print(input$sumname)
    dist <- isolate(input$sumname)
    PlotDQF(dist)
  })
  }
shinyApp(ui, server)