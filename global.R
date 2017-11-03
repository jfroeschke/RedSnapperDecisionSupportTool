##global.R
options(digits=7)

## load libraries for app
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
library(formattable)

##load mapped data ###see rasterize.R for details
load("mappedData.RData")
##  Data from : Mandy Karnauskas, John F. Walter III, Matthew D. Campbell, Adam G.
# Pollack, J. Marcus Drymon & Sean Powers (2017) Red Snapper Distribution on Natural Habitats
# and Artificial Structures in the Northern Gulf of Mexico, Marine and Coastal Fisheries, 9:1, 50-67,
# DOI: 10.1080/19425120.2016.1255684
##highchart bar chart data:
Biomass <- data.frame(State=c("TX", "LA", "MS", "AL", "FL"),
                      Biomass=c(.4213, .2028, .0134, .0630, .2994),
                      col=c("#8c510a", "#c7eae5", 
                          "#d8b365", "#5ab4ac",
                          "#01665e"))



biomassChart <- hchart(Biomass, "column", hcaes(State, Biomass, color=col))
  
  


## 
##AllRecreationalLandings.csv: landings-based 1986-2015 tab
## From GOM Red Snapper Recreational Allocation 20171031.xlsx
allRec <- read_csv("AllRecreationalLandings.csv")
allRec[30,2:6] <- NA ##remove 2010 (i.e., oil spill year) 
allRec$star <- c(rep(NA, 29), 1750000,rep(NA,6)) 








## This base plot can be pre-rendered in saved in RData to be
## loaded on page load modified by user interaction.
recLandingsPlot <- highchart() %>% 
  hc_xAxis(categories =allRec$YEAR) %>% 
  # hc_xAxis(categories =allRec$YEAR,
  #          plotBands=list(
  #            list(color= "rgba(100, 0, 0, 0.1)",
  #                 from=allRec$YEAR[29],
  #                 to=allRec$YEAR[30]))) %>% 
  hc_add_series(name = "Florida", data = allRec$FLW, type="line") %>%
  hc_add_series(name = "Alabama", data = allRec$AL, type="line") %>%
  hc_add_series(name = "Mississippi", data = allRec$MS, type="line") %>%
  hc_add_series(name = "Louisiana", data = allRec$LA, type="line") %>%
  hc_add_series(name = "Texas", data = allRec$TX, type="line") %>%
  hc_add_series(name = "Oil spill: data omitted in 2010", type = 'scatter',data=allRec$star,
                marker=list(symbol="cross"),color='black') %>% 
  hc_add_theme(hc_theme_smpl()) %>% 
  hc_yAxis(title = list(text = "Landings (lbs ww)"),
           labels = list(style = list(color = "#000000", fontWeight="bold"))) %>% 
  hc_exporting(enabled = TRUE, url="https://export.highcharts.com",
               filename = "Recreational Landings") %>% 
  hc_title(text = "Recreational red snapper landings")


##import mapped data



           