library(shiny)
library(shinyFeedback)

ui <- fluidPage(
  useShinyFeedback(),
  numericInput("n", "n", 10),
  textOutput("text"),
)

server <- function(input, output, session) {
  half <- reactive({
    even <- input$n %% 2 == 0
    feedbackWarning("n", !even, "Please enter only even number!")
    req(even)
    input$n / 2
  })
  
  output$text <- renderText(half())
}

shinyApp(ui, server)