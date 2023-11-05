library(shiny)

ui <- fluidPage(
  titlePanel("Central limit theorem"),
  sidebarLayout(
    mainPanel(
      plotOutput("plot")
    ),
    sidebarPanel(
      numericInput("samples", "Number of samples:", value = 2),
    )
  )
)

server <- function(input, output, session) {
  output$plot <- renderPlot({
    means <- replicate(1e4, mean(runif(input$samples)))
    hist(means, breaks=10)
  }, res = 96)
}

shinyApp(ui, server)