
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
  v <- eventReactive(input$go, {
  })
  output$plot2<-renderPlot({
    if(input$go != 0)
    {
    dist <- isolate(input$sumname)
    PlotDQF(dist)
    }
  })
  }
shinyApp(ui, server)