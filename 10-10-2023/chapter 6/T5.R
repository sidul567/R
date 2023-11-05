library(shiny)

ui <- fluidPage(
  # theme = bslib::bs_theme(bootswatch = "darkly"),
  # theme = bslib::bs_theme(bootswatch = "flatly"),
  # theme = bslib::bs_theme(bootswatch = "sandstone"),
  # theme = bslib::bs_theme(bootswatch = "united"),
  bslib::bs_theme_preview(theme),
  sidebarLayout(
    sidebarPanel(
      textInput("text", "Text input:", "text here"),
      sliderInput("slider", "Slider input:", min = 1, max = 100, value = 30)
    ),
    mainPanel(
      h1("Theme: darkly"),
      h2("Header 2"),
      p("Some text")
    )
  )
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)