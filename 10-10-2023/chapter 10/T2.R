library(shiny)
library(vroom)
library(dplyr)

sales <- vroom("sales_data_sample.csv", col_types = list(), na = "")
sales <- sales %>%
  select(TERRITORY, CUSTOMERNAME, ORDERNUMBER, everything()) %>% arrange(ORDERNUMBER)

ui <- fluidPage(
  selectInput("territory", "Territory", choices = unique(sales$TERRITORY)),
  selectInput("customer", "Customer", choices = NULL),
  selectInput("order", "Order Number", choices = NULL),
  tableOutput("data"),
)

server <- function(input, output, session) {
  territory <- reactive({
    req(input$territory)
    filter(sales, input$territory == TERRITORY)
  })
  
  observeEvent(territory(), {
    updateSelectInput(inputId = "customer", choices = unique(territory()$CUSTOMERNAME))
  })
  
  customer <- reactive({
    req(input$customer)
    filter(territory(), input$customer == CUSTOMERNAME)
  })
  
  observeEvent(customer(), {
    updateSelectInput(inputId = "order", choices = unique(customer()$ORDERNUMBER))
  })
  
  output$data <- renderTable({
    req(input$order)
    filter(customer(), input$order == ORDERNUMBER) %>% select(ORDERNUMBER, 0, QUANTITYORDERED, ORDERDATE, STATUS)
  })
}

shinyApp(ui, server)