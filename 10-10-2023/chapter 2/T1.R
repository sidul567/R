library(shiny)

animals <- c("cow", "dog", "elephant")

ui <- fluidPage(
  textInput("name", "What's your name?"),
  passwordInput("password", "Password"),
  textAreaInput("message", "Message", rows = "5"),
  
  numericInput("num", "Number", value = 0),
  sliderInput("slider", "Slider", min = 0, max = 100, value = 50),
  sliderInput("slider2", "Slider", min = 0, max = 100, value = c(10, 30)),
  
  dateInput("date", "Date"),
  dateRangeInput("dateRange", "Range Date"),
  
  selectInput("select", "Select state", choices = state.name),
  radioButtons("radio", "Select animals", animals),
  
  radioButtons("radio2","choose reaction", choiceNames = list(
    icon("angry"),
    icon("smile"),
    icon("sad-tear")
  ), choiceValues = list("angry", "happy", "sad")),
  
  selectInput("state2", "Multiple State", choices = state.name, multiple = TRUE),
  
  checkboxGroupInput("animal2", "Animals", choices = animals),
  
  fileInput("file", "Choose File"),
  
  actionButton("btn1", "Click me!"),
  actionButton("btn2", "Click me!", icon = icon("cocktail")),
  actionButton("btn2", "Click me!", class = "btn-danger"),
  actionButton("btn2", "Click me!", class = "btn-success btn-lg btn-block"),
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)