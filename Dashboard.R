#O objetivo desse código é criar uma aplicação web interativa usando Shiny e Shiny Dashboard para visualizar dados
#A aplicação permite:

 #   Carregar e visualizar imagens (como arquivos .jpg, .jpeg, ou .png).
 #   Analisar as imagens carregadas através de uma função de análise (Analyze_Image).
 #   Exibir um mapa interativo centrado em Parintins-AM usando o pacote Leaflet para adicionar camadas de mapa e pop-ups.

# O dashboard tem um menu lateral para navegar entre as abas de "Carregar Imagens" e "Visualizar Mapa", e também apresenta notificações e um título personalizado.

library(shiny)
library(shinydashboard)
library(leaflet)  
library(shinydashboardPlus)
library(bslib)

library(shinythemes)
setwd("C:/Users/Alcilene Santos/Desktop/Rstudio")
source("xxxxxxxxx.R")

target_size <- c(224,224,3)
options(scipen=999) #prevent scientific number formatting

Eco <- dashboardPage(skin = "red", 
                     
                     dashboardHeader(
                       title=tags$h1("xxxxxxxxxxxx",style="font-size: 120%; font-weight: bold; color: white"),
                       titleWidth = 350,
                       tags$li(class = "dropdown"),
                       dropdownMenu(type = "notifications", icon = icon("question-circle", "fa-1x"),
                                    badgeStatus = NULL,
                                    headerText="",
                                    tags$li(a(href = "https://forloopsandpiepkicks.wordpress.com",
                                              target = "_blank",
                                              tagAppendAttributes(icon("icon-circle"), class = "info"),
                                              "Created by")))),
                     
                     
                     dashboardSidebar(
                       
                       width = 350,
                       sidebarMenu(
                         menuItem("Painel de Menu", icon = icon("align-justify")),
                         
                         menuItem("Carregar Banco de Imagens", icon = icon("chalkboard-teacher"), startExpanded = "TRUE",
                                  menuSubItem("Carregar Imagens", tabName = "Im"),
                                  menuSubItem("Vizualizar Mapa", tabName = "Mp")))),
                     
                     
                     dashboardBody(
                       
                       tags$style(".progress-bar
                                  {background-color:red;}"),
                       
                       tabItems(
                         tabItem(
                           tabName = "Im",
                           fluidRow(
                             column(width = 9, offset = 3,
                                    box(title = "--------------------------------------------------------------------------------------",
                                        h4(class = "text-center","Vxxxxxxxxxxxxxxx"),
                                        width = 8,
                                        solidHeader = TRUE,
                                        
                                        column(h4("Imagem:"),imageOutput("output_image"), width=6),
                                        tags$br())),
                             
                             column(width = 10, offset = 0, 
                                    fileInput("input_image", "Carregue uma imagem aqui", accept = c('.jpg','.jpeg', '.png')),
                                    tags$br())),
                           
                           fluidRow(
                             column(offset = 0,
                                    h4("Está é uma:"),tags$br(),textOutput("output_text",), tags$br(),
                                    tags$p(""),tableOutput(""),width=6,
                                    tags$br()))),
                         
                         tabItem(
                           tabName = "Mp",
                           fluidRow(
                             leaflet(width = 1200, height = 700) %>%
                               addTiles() %>%
                               setView(-56.74399241227982, -2.6429737598250873, zoom = 15) %>%
                               addPopups(-56.74399241227982, -2.6429737598250873, '<b>Parintins-AM<b>'))
                         )      
                       )
                     )
)

Forest <- function(input, output, session){
  
  image=reactive({
    
    image_load(input$input_image$datapath, target_size=target_size[1:2])
    
  })#endreactive
  
  output$output_image=renderImage({
    
    req(input$input_image)
    outfile=input$input_image$datapath
    contentType=input$input_image$type
    list(src=outfile, contentType=contentType, width=490)
    
  }, deleteFile=FALSE)#endrenderimage 
  
  output$output_text=renderText({
    
    inputfilename=input$input_image$datapath
    Imagem=readImage(inputfilename)
    Analyze_Image(Imagem)
    
  })#endrenderText 
  
  
}#endfunction

#------------------------------------------------------------------------------


# 3 shinyApp ------------------------------------------------------------------  




shinyApp(Eco, server = Forest)

