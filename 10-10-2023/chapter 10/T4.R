library(shiny)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput("dist", "Distribution", choices = c("normal", "uniform", "exponential")),
      numericInput("n", "Number of samples", 100),
      tabsetPanel(
        id = "tabs",
        type = "hidden",
        tabPanel("normal",
                 numericInput("mean", "Mean", value = 1),
                 numericInput("sd", "Standard Deviation", value = 1, min = 0)
                 ),
        tabPanel("uniform",
                 numericInput("min", "Min", value = 0),
                 numericInput("max", "Max", value = 1)
        ),
        tabPanel("exponential",
                 numericInput("rate", "Rate", value = 1, min = 0),
        )
      )
    ),
    mainPanel(
      plotOutput("plot")
    )
  )
)

server <- function(input, output, session) {
  observeEvent(input$dist, {
    updateTabsetPanel(inputId = "tabs", selected = input$dist)
  })
  
  data <- reactive({
    switch (input$dist,
      normal = rnorm(input$n, input$mean, input$sd),
      uniform = runif(input$n, input$min, input$max),
      exponential = rexp(input$n, input$rate)
    )
  })
  
  output$plot <- renderPlot(hist(data()), res = 96)
}

shinyApp(ui, server)