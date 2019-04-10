ui=shinyUI(fluidPage(
     fileInput('shape', 'Select all files associated with the shapefile (.shp, .dbf,.sbn,.sbx,.shx and .prj)', multiple=TRUE, accept=c('.shp','.dbf','.sbn','.sbx','.shx',".prj")),
     leafletOutput("mymap")
   )
 )
 
 
 server = shinyServer(function(input,output){

   
   data<-reactive({
     req(input$shape)
     shpdf <- input$shape
     tempdirname <- dirname(shpdf$datapath[1])
         for(i in 1:nrow(shpdf)){
         file.rename(shpdf$datapath[i], paste0(tempdirname, "/", shpdf$name[i]))
       }
     data=readOGR(paste(tempdirname, shpdf$name[grep(pattern = "*.shp$", shpdf$name)], sep="/"))
     
   })
  output$mymap <- renderLeaflet({
    
     leaflet() %>%
         addTiles() %>% 
       addPolygons(data = data(), fillColor = "green", fillOpacity = 0.5, color = "black", weight = 2)
 })
 })


  shinyApp(ui, server)
