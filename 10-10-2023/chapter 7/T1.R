library(shiny)

ui <- fluidPage(
  plotOutput("plot", click = "clickPlot"),
  verbatimTextOutput("text"),
)

server <- function(input, output, session) {
  output$plot <- renderPlot({
    plot(mtcars$wt, mtcars$mpg)
  }, res = 96)
  
  output$text <- renderPrint({
    req(input$clickPlot)
    x <- round(input$clickPlot$x, 2)
    y <- round(input$clickPlot$y, 2)
    
    return (cat("[x, y] = [", x, ", ", y, "]", sep = ""))
  })
}

shinyApp(ui, server)