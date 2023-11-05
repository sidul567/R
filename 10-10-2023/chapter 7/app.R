library(shiny)
library(ggplot2)
options(shiny.host = "0.0.0.0")
options(shiny.port = 5000)

ui <- fluidPage(
  plotOutput("plot", brush="brushPlot", dblclick = "dblClickPlot")
)

server <- function(input, output, session) {
  selected <- reactiveVal(rep(FALSE, nrow(mtcars)))
  
  observeEvent(input$brushPlot, {
    selected(brushedPoints(mtcars, input$brushPlot, allRows = TRUE)$selected_ | selected())
  })
  
  observeEvent(input$dblClickPlot, {
    selected(rep(FALSE, nrow(mtcars)))
  })
  
  output$plot <- renderPlot({
    mtcars$selected <- selected()
    ggplot(mtcars, aes(wt, mpg, color = selected)) +
      geom_point()+
      scale_color_discrete(limits = c("TRUE", "FALSE"))
  })
}

shinyApp(ui, server)