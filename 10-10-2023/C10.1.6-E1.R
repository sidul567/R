library(shiny)

ui <- fluidPage(
  numericInput("year", "year", value = 2020),
  dateInput("date", "date"),
  uiOutput("aa")
)

server <- function(input, output, session) {
  # observeEvent(input$year, {
  #   updateDateInput(inputId = "date", min = as.Date(paste0(input$year, "-01-01")), max = as.Date(paste0(input$year, "-12-31")))
  # })
  
  x <- reactive({
    message("changes from reactive...")
    input$year
  })
  
  output$aa <- renderUI({
    message("changes from renderUI...")
    input$year
  })
}

shinyApp(ui, server)