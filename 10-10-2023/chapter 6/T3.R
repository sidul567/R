library(shiny)

ui <- fluidPage(
  navlistPanel(
    id = "tabsetpanel",
    "Import Data",
    tabPanel("Import Data",
             fileInput("file", "Data", buttonLabel = "Upload..."),
             textInput("del", "Delimiter (leave blank to guess)"),
             numericInput("rowskip", "Rows to skip", value = 0),
             numericInput("rowsPreview", "Rows to preview", value = 10)
    ),
    "Set Parameters",
    tabPanel("Set parameters"),
    tabPanel("Visualise reuslts")
  )
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)