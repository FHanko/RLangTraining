
library(shiny)
library(ggplot2)

source("DuoQueueFinder.R", local = TRUE)

ui <- fluidPage(
  titlePanel(title=h4("DuoQueueFinder", align="center")),
  sidebarPanel( 
    textInput("sumname", "Summoner Name", "Mango%20MSev"), 
    actionButton("go", "Go!"),
    textOutput("text1")),
  mainPanel(plotOutput("plot2")))

server <- function(input,output){
  val <- reactiveValues()
  val$pro <- Global.Time.Progress
  v <- eventReactive(input$go, {
  })
  output$plot2<-renderPlot({
    if(input$go != 0)
    {
        dist <- isolate(input$sumname)
        PlotDQF(dist)
    }
  })
  
  output$text1<-renderPrint({
    val$pro
  })
  }
shinyApp(ui, server)