library(shiny)

ui <- fluidPage(
  textAreaInput("msg", "", placeholder = "Write Something...", rows = 5),
  actionButton("send", "SEND")
)

runLater <- function(action, seconds = 3){
  observeEvent(
               invalidateLater(seconds * 1000), 
               action,
               autoDestroy = FALSE,
               ignoreInit = TRUE,
               ignoreNULL = FALSE,
               once = TRUE
  )
}

server <- function(input, output, session) {
  waiting <- NULL
  lastMessage <- NULL
  
  observeEvent(input$send, {
    notification <- glue::glue("Send '{input$msg}'")
    lastMessage <<- input$msg
    updateTextAreaInput(inputId = "msg", value = "")
    
    showNotification(
      notification,
      action = actionButton("undo", "Undo?"),
      duration = NULL,
      closeButton = FALSE,
      id = "notify",
      type = "warning"
    )
    
    waiting <<- runLater({
      cat("Message Send successfully!")
      removeNotification("notify")
    })
    
  })
  
  observeEvent(input$undo, {
    waiting$destroy()
    showNotification("Undoing Message...", id = "notify")
    updateTextInput(inputId = "msg", value = lastMessage)
  })
}

shinyApp(ui, server)