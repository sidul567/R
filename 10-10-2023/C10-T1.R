library(shiny)

ui <- fluidPage(
  textInput("label", "label"),
  selectInput("type", "type", c("slider", "numeric")),
  uiOutput("numeric")
)

server <- function(input, output, session) {
  output$numeric <- renderUI({
    value <- if (is.null(input$dynamic)) 0 else isolate(input$dynamic)
    if (input$type == "slider") {
      sliderInput("dynamic", input$label, value = value, min = 0, max = 10)
    } else {
      numericInput("dynamic", input$label, value = value, min = 0, max = 10)
    }
  })
}

shinyApp(ui, server)