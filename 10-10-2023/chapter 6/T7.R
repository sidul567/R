library(shiny)

ui <- fluidPage(
  HTML(r"(
       <h1>This is a heading</h1>
       <p>Lorem Ipsum</p>
       <ul>
        <li>First</li>
        <li>Second</li>
       </ul>
       <br>
       <br>
       <br>
  )"),
  
  tags$h1("This is a heading"),
  tags$p("Lorem Ipsum"),
  tags$ul(
    tags$li("First"),
    tags$li("Second"),
  )
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)