#Norway PA to leaflet map
require(sf)
getwd()
NorwayPA <- read_sf("C:/Users/matthew.grainger/OneDrive - NINA/Projects_in_development/EviAtlas/AddPolygons_leaflet/WDPA_Apr2019_NOR-shapefile/WDPA_Apr2019_NOR-shapefile-polygons.shp")
NorwayPA
leaflet() %>%
    addTiles() %>% 
  addPolygons(data = NorwayPA, fillColor = "green", fillOpacity = 0.5, color = "black", weight = 2)

##I cant get the read_sf part to work through Rshiny - something to do with the path?
# ui=shinyUI(fluidPage(
#     fileInput('shape', 'Choose shapefile', multiple=FALSE, accept=c('.shp','.dbf','.sbn','.sbx','.shx',".prj")),
#     leafletOutput("mymap")
#   )
# )
# 
# 
# server = shinyServer(function(input,output){
#  
#  inShp = reactive({
#    req(input$shape)
#   sf::read_sf(input$shape$datafile)
#   })
#   
#  output$mymap <- renderLeaflet({
#       leaflet() %>%
#      addTiles() %>% 
#       addPolygons(data=inShp(), weight = 2, fillColor = "yellow")
#     })
# })
# shinyApp(ui, server)
