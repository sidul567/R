library(shiny)
library(readr)

ui <- fluidPage(
  tabsetPanel(id = "tabs")
)

server <- function(input, output, session) {
  data <- read_csv("C:/Users/Moon/Desktop/R/Task/TestData.csv")
  columns <- names(data)
  
  observe({
    lapply(columns, function(element){
      insertTab(inputId = "tabs",
                tabPanel(element, plotOutput(element))
                )
    })
  })
  
  observeEvent(input$tabs, {
    output[[input$tabs]] <- renderPlot({
      plot(data[[input$tabs]])
    })
  })
}

shinyApp(ui, server)