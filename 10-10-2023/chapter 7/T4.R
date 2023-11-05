library(shiny)

df <- data.frame(x = rnorm(100), y = rnorm(100))

ui <- fluidPage(
  plotOutput("plot", click = "clickPlot")
)

server <- function(input, output, session) {
  distance <- reactiveVal(rep(100, nrow(df)))
  
  observeEvent(input$clickPlot, {
    distance(nearPoints(df, input$clickPlot, allRows = TRUE, addDist = TRUE)$dist_)
  })
  
  output$plot <- renderPlot({
    df$distance <- distance()
    ggplot(df, aes(x, y, size = distance)) + 
      geom_point() + 
      scale_size_area(limits = c(0, 1000), max_size = 10, guide = NULL)
  })
}

shinyApp(ui, server)