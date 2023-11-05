library(shiny)
library(readr)

ui <- fluidPage(
  tabsetPanel(id = "tabs")
)

server <- function(input, output, session) {
  observe({
    datf <- read_csv("C:/Users/Moon/Desktop/R/Task/CustomerArrival.csv", col_types =  cols(.default = col_character()))
    colIndicator <- findDateTimeColumnIndex(na.omit(head(datf, 60)))
    if(colIndicator[[2]] != 0 && (colIndicator[[1]] == 0 && colIndicator[[3]] == 0)){
      insertTab(inputId = "tabs", tabPanel("insight", plotOutput("insight")))      
      insertTab(inputId = "tabs", tabPanel("prediction", plotOutput("Prediction")))
    }
  })
  
  observeEvent(input$tabs, {
    print(input$tabs)
    #renderPlot(plot(500:600))    
    if(input$tabs == "insight"){
      output$insight <- renderPlot(plot(1:10))
    }
    else{
      output$Prediction <-renderPlot(plot(50:100))
    }
  })  
}

shinyApp(ui, server)