library(shiny)
library(tools)
library(vroom)
library(shinyFeedback)

ui <- fluidPage(
  useShinyFeedback(),
  fileInput("file", "", accept = c(".csv", ".tsv")),
  numericInput("n", "Number of Rows", value = 10),
  tableOutput("table")
)

server <- function(input, output, session) {
  data <- reactive({
    req(input$file)
    
    ext <- file_ext(input$file$name)
    feedbackDanger("file", !ext %in% c("csv", "tsv"), "Please select only .csv or .tsv file!")
    req(ext %in% c("csv", "tsv"))
    
    switch (ext,
      "csv" = vroom(input$file$datapath, delim = ","),
      "tsv" = vroom(input$file$datapath, delim = "\t"),
    )
  })
  
  output$table <- renderTable(head(data(), input$n))
}

shinyApp(ui, server)