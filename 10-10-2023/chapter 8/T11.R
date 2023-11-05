library(shiny)

modal <- modalDialog(
  title ="Deleting Files",
  "Are you sure want to delete?",
  footer = tagList(
    actionButton("yes", "YES", class="btn btn-danger"),
    actionButton("no", "NO")
  )
)

ui <- fluidPage(
  actionButton("delete", "Delete Files"),
)

server <- function(input, output, session) {
  observeEvent(input$delete, {
    showModal(modal)
  })
  
  observeEvent(input$yes, {
    showNotification("File deleted successfully!", type = "message")
    removeModal()
  })
  
  observeEvent(input$no, removeModal())
}

shinyApp(ui, server)