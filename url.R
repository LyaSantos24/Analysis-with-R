library(shiny)
runApp(
  list(ui = fluidPage(
    uiOutput("tab")
  ),
  server = function(input, output, session){
    url <- a("Google Homepage", href="https://www.google.com.br/imghp?hl=pt-BR&ogbl")
    output$tab <- renderUI({
      tagList("URL link:", url)
    })
  })
)
