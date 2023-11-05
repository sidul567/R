library(shiny)
library(waiter)

options(shiny.host = "0.0.0.0")
options(shiny.port = 5000)

ui <- fluidPage(
  useWaiter(),
  actionButton("btn", "RUN"),
  # textOutput("result"),
  plotOutput("plot"),
)

server <- function(input, output, session) {
  data <- eventReactive(input$btn, {
    # waiter <- Waiter$new()
    # waiter$show()
    # on.exit(waiter$hide())
    # 
    # number <- sample(5, 1)
    # 
    # Sys.sleep(number)
    # number
    
    Waiter$new(id = "plot")$show()
    
    Sys.sleep(1)
    
    data.frame(x = rnorm(20), y = rnorm(20))
  })
  
  output$result <- renderText(round(data(), 2))
  
  output$plot <- renderPlot(plot(data()), res = 96)
}

shinyApp(ui, server)