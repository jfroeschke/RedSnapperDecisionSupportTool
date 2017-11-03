## server.R
server <- function(input, output, session) { 

  topN <- reactive({
    ## define input from sliders
    ## this reactive allows user to select the range of years 
    ## and the number of top years to be included
    N <- input$topNumber
  
    allRec <-   allRec %>% filter(YEAR <= input$Year[2] &  YEAR >= input$Year[1] & YEAR !=2010)
    
      allFLW <- allRec %>% 
      #filter(YEAR <= 2015 & YEAR >=1986 & YEAR !=2010) %>% #subset years
      dplyr::select(YEAR, FLW) %>% #select variables 
      arrange(desc(FLW)) %>% 
      slice(1:N) %>% ##top in will be here
      arrange(YEAR) %>% 
      summarise(sum=sum(FLW))    
    allAL <- allRec %>% 
      #filter(YEAR <= 2015 & YEAR >=1986 & YEAR !=2010) %>% #subset years
      dplyr::select(YEAR, AL) %>% #select variables 
      arrange(desc(AL)) %>% 
      slice(1:N) %>% ##top in will be here
      summarise(sum=sum(AL))  
    
    allMS <- allRec %>% 
      #filter(YEAR <= 2015 & YEAR >=1986 & YEAR !=2010) %>% #subset years
      dplyr::select(YEAR, MS) %>% #select variables 
      arrange(desc(MS)) %>% 
      slice(1:N) %>% ##top in will be here
      summarise(sum=sum(MS)) 
    
    allLA <- allRec %>% 
      #filter(YEAR <= 2015 & YEAR >=1986 & YEAR !=2010) %>% #subset years
      dplyr::select(YEAR, LA) %>% #select variables 
      arrange(desc(LA)) %>% 
      slice(1:N) %>% ##top in will be here
      summarise(sum=sum(LA)) 
    allTX <- allRec %>% 
      #filter(YEAR <= 2015 & YEAR >=1986 & YEAR !=2010) %>% #subset years
      dplyr::select(YEAR, TX) %>% #select variables 
      arrange(desc(TX)) %>% 
      slice(1:N) %>% ##top in will be here
      summarise(sum=sum(TX)) 
    totalSum <- sum(allFLW, allAL, allMS, allLA, allTX)
    topNout <- data.frame(FLW=(allFLW/totalSum), AL=(allAL/totalSum),
                          MS=(allMS/totalSum), LA=(allLA/totalSum),TX=(allTX/totalSum))
    colnames(topNout) <- c("FLW","AL", "MS", "LA", "TX")
    topNout <- rbind(topNout,rev(Biomass$Biomass) )
    rownames(topNout) <- c("Landings", "Biomass")
    topNout
    })
  
  output$out32 <- renderTable({
    topN()
  }, hover=TRUE, bordered=TRUE, width="500px", rownames=TRUE, digits=5)
  
  ## render landings plot
  
  output$landingsChart <- renderHighchart({recLandingsPlot})
  
  ##render leaflet map
  output$map <- renderLeaflet({
    map <- leaflet() %>%
      #addTiles() %>% 
      addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
               options = providerTileOptions(noWrap = TRUE)) %>%
      addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/Reference/World_Boundaries_and_Places/Mapserver/tile/{z}/{y}/{x}',
               options = providerTileOptions(noWrap = TRUE)) %>%
      addScaleBar(position="bottomright") %>%
      setView(-89.87, 25.15, zoom = 6) %>% 
      addMiniMap() %>%
      addFullscreenControl() %>% 
    ##addMouseCoordinates2(style=("basic")) %>%
      addPolygons(data=Fig7mid, color = ~pal(layer),weight=1,
                  opacity=.6, fillOpacity=0.5, group='biomass') %>% 
      addLegend("bottomleft",pal = pal, 
                values = Fig7mid$layer,title = "Index of biomass - with artificial strucures",
                opacity = 0.5) %>% 
      addPolygons(data=FL, color="#01665e", fillOpacity=0, opacity=1) %>% 
      addPolygons(data=AL, color="#5ab4ac", fillOpacity=0, opacity=1) %>% 
      addPolygons(data=MS, color="#d8b365", fillOpacity=0, opacity=1) %>% 
      addPolygons(data=LA, color="#c7eae5", fillOpacity=0, opacity=1) %>% 
      addPolygons(data=TX, color="#8c510a", fillOpacity=0, opacity=1) 
  })
  ## end render leaflet map
  ##render biomass chart
  output$biomassBar<- renderHighchart({biomassChart})
}
          
          


