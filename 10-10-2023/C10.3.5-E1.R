library(shiny)

parameter_tabs <- tabsetPanel(
  id = "params",
  type = "hidden",
  tabPanel("slider",
        sliderInput("n", "n", value = 0, min = 0, max = 100)
  ),
  tabPanel("numeric", 
        numericInput("n", "n", value = 0, min = 0, max = 100)
  ),
)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput("type", "type", c("slider", "numeric")),
      parameter_tabs,
    ),
    mainPanel(
      
    )
  )
)

server <- function(input, output, session) {
  observeEvent(input$type, {
    updateTabsetPanel(inputId = "params", selected = input$type)
  }) 
}

shinyApp(ui, server)