library(shiny)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      textOutput("selectedTabset"),
    ),
    mainPanel(
      tabsetPanel(
        id = "tabsetpanel",
        tabPanel("Import Data",
                 fileInput("file", "Data", buttonLabel = "Upload..."),
                 textInput("del", "Delimiter (leave blank to guess)"),
                 numericInput("rowskip", "Rows to skip", value = 0),
                 numericInput("rowsPreview", "Rows to preview", value = 10)
        ),
        tabPanel("Set parameters"),
        tabPanel("Visualise reuslts")
      )
    )
  )
)

server <- function(input, output, session) {
  output$selectedTabset <- renderText(paste0("Selected Tabset: ", input$tabsetpanel))
}

shinyApp(ui, server)