library(shiny)
library(shinyFeedback)
library(vroom)

ui <- fluidPage(
  useShinyFeedback(),
  selectInput("dataset", "Datasets", choices = ls("package:datasets")),
  tableOutput("table"),
  downloadButton("download", "Download.csv")
)

server <- function(input, output, session) {
  data <- reactive({
    dataset <- get(input$dataset, "package:datasets")
    
    feedbackDanger("dataset", !is.data.frame(dataset), paste0(input$dataset, " is not a data frame!"))
    req(is.data.frame(dataset))
    
    return(dataset)
  })
  
  output$table <- renderTable(head(data()))
  
  output$download <- downloadHandler(
    filename = function() paste0(input$dataset, ".csv"),
    content = function(file) {
      notify <- showNotification("Downloading File...", duration = NULL, closeButton = NULL)
      vroom_write(data(), file)
      on.exit(removeNotification(notify))
    }
  )
}

shinyApp(ui, server)