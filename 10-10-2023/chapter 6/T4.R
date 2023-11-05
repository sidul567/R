library(shiny)

ui <- navbarPage(
  id = "tabsetpanel",
  title = "Import Data",
  tabPanel("Import Data",
           fileInput("file", "Data", buttonLabel = "Upload..."),
           textInput("del", "Delimiter (leave blank to guess)"),
           numericInput("rowskip", "Rows to skip", value = 0),
           numericInput("rowsPreview", "Rows to preview", value = 10)
  ),
  tabPanel("Set parameters"),
  tabPanel("Visualise reuslts"),
  navbarMenu("Colors",
             tabPanel("red"),
             tabPanel("orange"),
             tabPanel("blue"))
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)