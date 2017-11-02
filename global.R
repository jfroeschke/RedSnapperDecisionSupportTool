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
allRec[30,2:6] <- NA ##remove 2010 (i.e., oil spill year) 
allRec$star <- c(rep(NA, 29), 1500000,rep(NA,6)) 

recLandingsPlot <- highchart() %>% 
  hc_xAxis(categories =allRec$YEAR) %>% 
  hc_add_series(name = "Florida", data = allRec$FLW, type="line") %>%
  hc_add_series(name = "Alabama", data = allRec$AL, type="line") %>%
  hc_add_series(name = "Mississippi", data = allRec$MS, type="line") %>%
  hc_add_series(name = "Louisiana", data = allRec$LA, type="line") %>%
  hc_add_series(name = "Texas", data = allRec$TX, type="line") %>%
  hc_add_series(name = "Oil spill: data omitted in 2010", type = 'scatter',data=allRec$star,
                marker=list(symbol="cross"),color='black') %>% 
  hc_add_theme(hc_theme_smpl()) 



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