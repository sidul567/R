library(shiny)
library(vroom)
library(janitor)

uiUpload <- sidebarLayout(
  sidebarPanel(
    fileInput("data", "Data"),
    textInput("delim", "Delimiter (leave blank to guess)"),
    numericInput("skip", "Rows to skip", 0),
    numericInput("rows", "Rows to preview", 10),
  ),
  mainPanel(
    h3("Raw data"),
    tableOutput("table1")
  )
)

uiCleaner <- sidebarLayout(
  sidebarPanel(
    checkboxInput("snake", "Rename columns to snake case?"),
    checkboxInput("constant", "Remove constant columns?"),
    checkboxInput("empty", "Remove empty cols?")
  ),
  mainPanel(
    h3("Cleaner Data"),
    tableOutput("table2")
  )
)

uiDownload <- fluidRow(
  column(12,
         downloadButton("download", class = "btn-block btn-info")
         )
)
ui <- fluidPage(
  uiUpload,
  uiCleaner,
  uiDownload
)

server <- function(input, output, session) {
  # Upload
  rawData<- reactive({
    req(input$data)
    delim <- if(input$delim  == "") NULL else input$delim
    vroom(input$data$datapath, delim = delim, skip = input$skip)
  })
  output$table1 <- renderTable(head(rawData(), input$rows))
  
  # Clean
  clean <- reactive({
    outputData <- rawData()
    if(input$snake){
      names(outputData) <- make_clean_names(names(outputData))
    }
    if(input$empty){
      outputData <- remove_empty(outputData, "cols")
    }
    if(input$constant){
      outputData <- remove_constant(outputData)
    }
    
    return(outputData)
  })
  
  output$table2 <- renderTable(head(clean(), input$rows))
  
  # download
  output$download <- downloadHandler(
    filename = function() paste0(file_path_sans_ext(input$data$name), ".csv"),
    content = function(file) vroom_write(clean(), file, delim = ",")
  )
}

shinyApp(ui, server)