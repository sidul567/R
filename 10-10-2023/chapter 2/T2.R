library(shiny)
library(reactable)

ui <- fluidPage(
  textOutput("text"),
  verbatimTextOutput("ver"),
  
  tableOutput("table1"),
  dataTableOutput("table2"),
  reactableOutput("table3"),
  
  plotOutput("plot"),
)

server <- function(input, output, session) {
  output$text <- renderText("Hello World!")
  output$ver <- renderPrint(summary(0:10))
  
  output$table1 <- renderTable(head(mtcars))
  output$table2 <- renderDataTable(head(mtcars), options = list(pageLength = 5, searching = FALSE, ordering = FALSE, filtering = FALSE)) 
  output$table3 <- renderReactable(reactable(head(mtcars), searchable = TRUE, minRows = 5))
  
  output$plot <- renderPlot(plot(1:5), res = 96)
}

shinyApp(ui, server)