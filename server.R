## server.R
server <- function(input, output, session) { 

  topN <- reactive({
    ## Will go in a reactive 
    ## Will go in a reactive 
    allFLW <- allRec %>% 
      filter(YEAR <= 2015 & YEAR >=1986 & YEAR !=2010) %>% #subset years
      select(YEAR, FLW) %>% #select variables 
      arrange(desc(FLW)) %>% 
      slice(1:10) %>% ##top in will be here
      arrange(YEAR) %>% 
      summarise(sum=sum(FLW))    
    allAL <- allRec %>% 
      filter(YEAR <= 2015 & YEAR >=1986 & YEAR !=2010) %>% #subset years
      select(YEAR, AL) %>% #select variables 
      arrange(desc(AL)) %>% 
      slice(1:10) %>% ##top in will be here
      summarise(sum=sum(AL))  
    
    allMS <- allRec %>% 
      filter(YEAR <= 2015 & YEAR >=1986 & YEAR !=2010) %>% #subset years
      select(YEAR, MS) %>% #select variables 
      arrange(desc(MS)) %>% 
      slice(1:10) %>% ##top in will be here
      summarise(sum=sum(MS)) 
    
    allLA <- allRec %>% 
      filter(YEAR <= 2015 & YEAR >=1986 & YEAR !=2010) %>% #subset years
      select(YEAR, LA) %>% #select variables 
      arrange(desc(LA)) %>% 
      slice(1:10) %>% ##top in will be here
      summarise(sum=sum(LA)) 
    
    topNout <- data.frame(FLW=allFLW, AL=allAL,
                          MS=allMS, LA=allLA,TX=allTX)
    })
  
  output$out32 <- renderTable({
    topN()
  }, hover=TRUE, bordered=TRUE, width="500px")
          
          }


