library(shiny)

ui <- fluidPage(
  actionButton("btn", "Cilck me!"),
  tableOutput("table")
)

server <- function(input, output, session) {
  observeEvent(input$btn, {
    showNotification("Notification 1...")
    Sys.sleep(1)
    showNotification("Notification 2...", type = "message")
    Sys.sleep(1)
    showNotification("Notification 3...", type = "error")
    Sys.sleep(1)
    showNotification("Notification 4...", type = "warning")
    Sys.sleep(1)
    showNotification("Notification 5...", type = "default")
    Sys.sleep(1)
    id <- showNotification("Reading data...", duration = NULL, closeButton = NULL)
    Sys.sleep(5)
    on.exit(removeNotification(id))
  })
}

shinyApp(ui, server)