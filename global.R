##global.R
options(digits=7)
library(shiny)
library(tidyverse)
library(shinydashboard)
library(sp)
library(leaflet)
library(mapview)
library(sf)
library(htmltools)
library(leaflet.extras)
library(shinyBS)
library(rgdal)
library(rintrojs)

##AllRecreationalLandings.csv: landings-based 1986-2015 tab
## From GOM Red Snapper Recreational Allocation 20171031.xlsx
allRec <- read_csv("AllRecreationalLandings.csv")

## Split into separate series to remove 2010 (i.e., oil spill year)   
recLandingsPre2010 <- allRec %>% filter(YEAR <= 2009 & YEAR >=1986 )  #subset years
recLandingsPost2010 <- allRec %>% filter(YEAR <= 2015 & YEAR >=2011 )  #subset years

recLandingsPlot <- highchart() %>% 
  
  hc_xAxis(categories =1986:2016) %>% 
  hc_add_series(name = "Florida", data = recLandingsPre2010$FLW, type="line") %>%
  hc_add_series(name = "Florida", data = recLandingsPost2010$FLW, type="line")
  
  hc_add_series(name = "Alabama", data = recLandingsPre2010$AL, type="line") %>%
  hc_add_series(name = "Mississippi", data = recLandingsPre2010$MS, type="line") %>%
  hc_add_series(name = "Louisiana", data = recLandingsPre2010$LA, type="line") %>%
  hc_add_series(name = "Texas", data = recLandingsPre2010$TX, type="line") %>%
  
  hc_add_series(name = "Florida", data = recLandingsPost2010$FLW, type="line") %>%
  hc_add_series(name = "Alabama", data = recLandingsPost2010$AL, type="line") %>%
  hc_add_series(name = "Mississippi", data = recLandingsPost2010$MS, type="line") %>%
  hc_add_series(name = "Louisiana", data = recLandingsPost2010$LA, type="line") %>%
  hc_add_series(name = "Texas", data = recLandingsPost2010$TX, type="line") #%>%
  
  
  hc_add_series(name = "Minimum size limit", data = df$SizeLimit, type="line") %>% 
  hc_yAxis(title = list(text = "Size and bag limits"),
           labels = list(style = list(color = "#000000", fontWeight="bold"))) %>% 
  hc_add_theme(hc_theme_economist()) %>% 
  hc_tooltip (enabled=FALSE) %>% 
  
  hc_plotOptions(line=list(marker=list(enabled=FALSE))) %>% 
  hc_exporting(enabled = TRUE, url="https://export.highcharts.com",
               filename = "Landings") %>% 
  hc_title(text = "Recreational red snapper management")
#seasonLength





# ## Will go in a reactive 
# allFLW <- allRec %>% 
#                   filter(YEAR <= 2015 & YEAR >=1986 & YEAR !=2010) %>% #subset years
#                   select(YEAR, FLW) %>% #select variables 
#                   arrange(desc(FLW)) %>% 
#                   slice(1:10) %>% ##top in will be here
#                   arrange(YEAR) %>% 
#                   summarise(sum=sum(FLW))    
# allAL <- allRec %>% 
#   filter(YEAR <= 2015 & YEAR >=1986 & YEAR !=2010) %>% #subset years
#   select(YEAR, AL) %>% #select variables 
#   arrange(desc(AL)) %>% 
#   slice(1:10) %>% ##top in will be here
#   summarise(sum=sum(AL))  
# 
# allMS <- allRec %>% 
#   filter(YEAR <= 2015 & YEAR >=1986 & YEAR !=2010) %>% #subset years
#   select(YEAR, MS) %>% #select variables 
#   arrange(desc(MS)) %>% 
#   slice(1:10) %>% ##top in will be here
#   summarise(sum=sum(MS)) 
# 
# allLA <- allRec %>% 
#   filter(YEAR <= 2015 & YEAR >=1986 & YEAR !=2010) %>% #subset years
#   select(YEAR, LA) %>% #select variables 
#   arrange(desc(LA)) %>% 
#   slice(1:10) %>% ##top in will be here
#   summarise(sum=sum(LA)) 



# ## or define a function
# topX <- function(data, yearMin=1986,
#                  yearMax=2015, N=10){
#   tmp <- data %>%
#   filter(YEAR <= yearMax & YEAR >=yearMin ) %>% #subset years
#    select_(YEAR, state) #%>% #select variables
#   head(tmp)
# }
# # 
# # topX(data=allRec)
#             