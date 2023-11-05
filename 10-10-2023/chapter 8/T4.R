library(shiny)

ui <- fluidPage(
  numericInput("x", "X", 0),
  selectInput("transformation", "Transformation", choices = c("square", "log", "square-root")),
  textOutput("result")
)

server <- function(input, output, session) {
  output$result <- renderText({
    if(input$x < 0 && input$transformation %in% c("log", "square-root")){
      validate(paste0("x can't be negative for ", input$transformation, " operation!"))
    }
    
    switch (input$transformation,
      "square" = input$x ^ 2,
      "log" = log(input$x),
      "square-root" = sqrt(input$x)
    )
  })
}

shinyApp(ui, server)