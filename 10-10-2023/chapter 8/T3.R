library(shiny)
library(shinyFeedback)

ui <- fluidPage(
  useShinyFeedback(),
  textInput("dataset", "Dataset Name"),
  tableOutput("table"),
)

server <- function(input, output, session) {
  data <- reactive({
    req(input$dataset)

    exist <- exists(input$dataset, "package:datasets")

    feedbackDanger("dataset", !exist, "Invalid dataset name!")

    req(exist, cancelOutput = TRUE)

    get(input$dataset, "package:datasets")
  })
  
  
  output$table <- renderTable(data())
}

shinyApp(ui, server)