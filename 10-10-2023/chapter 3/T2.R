library(shiny)
library(ggplot2)

freqpoly <- function(x1, x2, binwidth = 0.1, xlim = c(-3, 3)) {
  df <- data.frame(
    x = c(x1, x2),
    g = c(rep("x1", length(x1)), rep("x2", length(x2)))
  )
  
  ggplot(df, aes(x, colour = g)) +
    geom_freqpoly(binwidth = binwidth, size = 1) +
    coord_cartesian(xlim = xlim)
}

t_test <- function(x1, x2) {
  test <- t.test(x1, x2)
  
  # use sprintf() to format t.test() results compactly
  sprintf(
    "p value: %0.3f\n[%0.2f, %0.2f]",
    test$p.value, test$conf.int[1], test$conf.int[2]
  )
}

ui <- fluidPage(
  fluidRow(
    column(4,
           "Distribution 1",
           numericInput("n1", "n", value = 10, min = 1),
           numericInput("m1", "µ", value = 0, step = 0.1),
           numericInput("sd1", "σ", value = 0.5, min = 0.1, step = 0.1),
           ),
    column(4,
           "Distribution 2",
           numericInput("n2", "n", value = 10, min = 1),
           numericInput("m2", "µ", value = 0, step = 0.1),
           numericInput("sd2", "σ", value = 0.5, min = 0.1, step = 0.1),
        ),
    column(4,
           "Frequency polygon",
           numericInput("bin", "Bin width", value = 0.1, step = 0.1),
           sliderInput("xlim", "range", value = c(-2, 2), min = -5, max = 5),
           actionButton("simulate", "Simulate"),
    )
 ), 
 
 fluidRow(
   column(9,
          plotOutput("plot"),
          ),
   column(3,
          verbatimTextOutput("text"),
          )
 )
)

server <- function(input, output, session) {
  # timer <- reactiveTimer(500)
  
  # x1 <- reactive({
  #   timer()
  #   rnorm(input$n1, input$m1, input$sd1)
  # })
  # 
  # x2 <- reactive({
  #   timer()
  #   rnorm(input$n2, input$m2, input$sd2)
  #   })

  values <- reactiveValues(x1 = rnorm(10, 0, 0.5), x2 = rnorm(10, 0, 0.5),bin = 0.1, xlim =  c(-2, 2))

  output$plot <- renderPlot({
    freqpoly(values$x1, values$x2, values$bin, values$xlim)
  })

  output$text <- renderText({
      t_test(values$x1, values$x2)
  })
  
  observeEvent(input$simulate, {
    values$x1 <- rnorm(input$n1, input$m1, input$sd1)
    values$x2 <- rnorm(input$n2, input$m2, input$sd2)
    values$bin <- input$bin
    values$xlim <- input$xlim
  })
}

shinyApp(ui, server)