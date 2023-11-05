library(shiny)
options(shiny.host = "0.0.0.0")
options(shiny.port = 5000)

ui <- fluidPage(
  selectInput("dataset", "Datasets", choices = c("pressure", "cars")),
  selectInput("column", "Columns", choices = NULL),
  verbatimTextOutput("text")
)

server <- function(input, output, session) {
  data <- reactive(get(input$dataset, "package:datasets"))
  
  observeEvent(input$dataset, {
    freezeReactiveValue(input, "column")
    updateSelectInput(inputId = "column", choices = names(data()))
  })
  
  output$text <- renderPrint(summary(data()[[input$column]]))
}

shinyApp(ui, server)