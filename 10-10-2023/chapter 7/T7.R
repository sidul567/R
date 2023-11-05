library(shiny)

puppies <- tibble::tribble(
  ~breed, ~ id, ~author, 
  "corgi", "eoqnr8ikwFE","alvannee",
  "labrador", "KCdYn0xu2fU", "shaneguymon",
  "spaniel", "TzjMd7i5WQI", "_redo_"
)


ui <- fluidPage(
  selectInput("breed", "Pick a breed", choices = setNames(puppies$id, puppies$breed)),
  htmlOutput("link"),
  imageOutput("img"),
)

server <- function(input, output, session) {
  output$img <- renderImage({
    list(
      src = file.path("images", paste0(input$breed, ".jpg")),
      contentType = "image/jpg",
      width = 500,
      height = 650
    )
  })
  
  output$link <- renderUI({
    puppy <- puppies[puppies$id == input$breed, , drop = FALSE]
    
    HTML(glue::glue("
    <p>
        <a href = 'https://unsplash.com/photos/{puppy$id}'>Original</a> by
        <a href = 'https://unsplash.com/@{puppy$author}'>{puppy$author}</a>
      </p>
    "))
  })
}

shinyApp(ui, server)