library(shiny)

ui <- fluidPage(
  sidebarPanel(
    selectInput("show", "Show", choices = paste0("panel", 1:3))
  ),
  mainPanel(
    tabsetPanel(
      id = "panel",
      type = "hidden",
      tabPanel("panel1", "Panel 1 content"),
      tabPanel("panel2", "Panel 2 content"),
      tabPanel("panel3", "Panel 3 content"),
    )
  )
)

server <- function(input, output, session) {
  observeEvent(input$show, {
    updateTabsetPanel(inputId = "panel", selected = input$show)
  })
}

shinyApp(ui, server)