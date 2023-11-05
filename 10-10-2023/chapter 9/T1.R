library(shiny)

ui <- fluidPage(
  fileInput("file", NULL, buttonLabel = "Upload...", multiple = TRUE),
  tableOutput("table")
)

server <- function(input, output, session) {
  output$table <- renderTable(input$file)
}

shinyApp(ui, server)