library(shiny)

ui <- fluidPage(
  tableOutput("table")
)

server <- function(input, output, session) {
  notify <- function(msg, id=NULL){
    return (showNotification(msg, id=id, duration = NULL, closeButton = NULL))
  }
  
  output$table <- renderTable({
    notifyId <- notify("Reading data...")
    on.exit(removeNotification(notifyId))
    Sys.sleep(1)
    
    notify("Fetching data...", notifyId)
    Sys.sleep(1)
    
    notify("Update data...", notifyId)
    Sys.sleep(1)
    
    notify("Delete data...", notifyId)
    Sys.sleep(1)
    
    head(mtcars)
  })
}

shinyApp(ui, server)