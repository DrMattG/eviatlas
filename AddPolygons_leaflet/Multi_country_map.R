library(raster)
library(leaflet)
library(shiny)

#allows you to select more than 1 country 
ui <- fluidPage(
  selectInput(inputId = "ISO", 
              label = "Select ISO", 
              choices = getData('ISO3')$ISO,
              multiple=TRUE,
              selected = "GBR"),
  selectInput(inputId = "Level", 
              label = "Select map level", 
              choices = c(0,1,2,3),
              multiple=FALSE,
              selected = 1),
  leafletOutput("mymap")
)

server <- function(input, output, session) {
  new_dat<-reactive({
    if(length(input$ISO)==1){
      new_dat = getData('GADM', country=input$ISO, level=input$Level)#single country
    } else {
      dat = list()
      dat$countries = c(input$ISO)
      new_dat = do.call("bind", lapply(dat$countries,function(x) getData('GADM', country=x, level=input$Level)))
    }
  })#more than one country
  mainPanel(
    textOutput("textOutput")
  ) 
  
  output$mymap <- renderLeaflet({
    leaflet() %>%
      addTiles() %>% 
      addPolygons(data=new_dat(), weight = 2, fillColor = "yellow")
  })
}

shinyApp(ui, server)


