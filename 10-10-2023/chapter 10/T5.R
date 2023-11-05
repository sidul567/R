library(shiny)

ui <- fluidPage(
  tabsetPanel(
    id = "wizard",
    type = "hidden",
    tabPanel("page1", 
             "Homepage!",
             actionButton("btn12", "next")
             ),
    tabPanel("page2",
             "One page left!",
             actionButton("btn21", "prev"),
             actionButton("btn23", "next")
             ),
    tabPanel("page3", 
             "Complete!",
             actionButton("btn32", "prev")
             )
  )
)

server <- function(input, output, session) {
  switchPage <- function(pageNumber){
    updateTabsetPanel(inputId = "wizard", selected = paste0("page", pageNumber))
  }
  
  observeEvent(input$btn12, switchPage(2))
  observeEvent(input$btn21, switchPage(1))
  observeEvent(input$btn23, switchPage(3))
  observeEvent(input$btn32, switchPage(2))
}

shinyApp(ui, server)