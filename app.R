#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

#library(tidyverse)
library("stringr")
library("reshape2")
library("plotly")
library(dplyr, warn.conflicts = FALSE)
#library(tidyr)
#library("readxl")
library("DT")
library(shinyWidgets)
library(shinydashboard)
library(shiny)
library("leaflet")
library("rworldmap")
library("rgeos")
library("cartography")
library(RColorBrewer)
library("ggiraph")
library(leaflet.providers)
library(mapview)
#library(lwgeom)
library(cartography)
library(sp)
library(sf)
library("rgdal")
library(readxl)
library(tidyverse)
library("maptools")
library("rgdal")
library("data.table")
library("dplyr") 
library("tidyr")
#library(ggpubr)




#load("env_test2.RData")
#source("Script_26_05_2020.R")
# Define UI for application that draws a histogram
ui <-dashboardPage(
    skin = "blue",
    title = "RadaR",
    
    # HEADER ------------------------------------------------------------------
    
    dashboardHeader(title =  "Suivi COVID19, ARS BFC" ),
    
    
    
    dashboardSidebar(
        ### Partie menu 
        
        
        sidebarMenu(
            menuItem("INDICATEURS", icon = icon("info-circle"), tabName = "indicateurs",
                     badgeLabel = "new", badgeColor = "green"),
            menuItem("TABLEAU DE BORD", tabName = "tableau_bord", icon = icon("table")),
            
            imageOutput("myImage")
        )
    ),
    dashboardBody(
        
        tabItems(
        tabItem(tabName = "tableau_bord",
                
        #box(
                fluidRow(
                    
                        #sidebarPanel(
                        #selectInput("dept","sélectionner un dep",choices=nom_dept),
                  # selectInput("nom_indicateur","Sélectionner un indicateur",choices=nom_indicateur),
                 #  selectInput("nom_date","Sélectionner une date",choices=nom_date),
                   
                   
                   mainPanel(
                      # leafletOutput("carto_nb_positifs")
                        #mapviewOutput("carto_nb_positifs", width = "100%", height = 400)
                        leafletOutput("mymap")
                   ) ### Fin mainPanel
                   
                        
                    )
          # )
       )## fin tabItems
        
    )### Fin dashboardbody 
)

)

# Define server logic required to draw a histogram
server <- function(input, output) {

  myRenderMapview = function (expr, env = parent.frame(), quoted = FALSE) 
  {
    if (!quoted) 
      expr = substitute(mapview:::mapview2leaflet(expr))
    htmlwidgets::shinyRenderWidget(expr, leafletOutput, env, 
                                   quoted = TRUE)
  }
  
  #output$carto_nb_positifs <- myRenderMapview({
  
  
 # map1
  
  # })
  
  
    #output$carto_nb_positifs <- renderLeaflet({
        
        
        #map1@map
      
   # })
    
  output$mymap <- renderLeaflet({
    
    leaflet(couche_dept_BFC) %>% 
      fitBounds(-8,40,10,50) %>% ### permet de zoomer 
      addTiles()%>%
      addProviderTiles(providers$CartoDB.Positron)
    
  })
    
}

# Run the application 
shinyApp(ui = ui, server = server)
