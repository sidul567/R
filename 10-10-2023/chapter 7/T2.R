library(shiny)
library(ggplot2)

ui <- fluidPage(
  plotOutput("plot", hover = "clickPlot"),
  tableOutput("table"),
)

server <- function(input, output, session) {
  output$plot <- renderPlot({
    ggplot(mtcars, aes(wt, mpg)) +
      geom_point()
  }, res = 96)
  
  output$table <- renderTable({
    return (nearPoints(mtcars, input$clickPlot))
  })
}

shinyApp(ui, server)