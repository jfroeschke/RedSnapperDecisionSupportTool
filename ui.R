## ui.R

dashboardPage(
  #introjsUI(), # must include in UI
 
  
     dashboardHeader(disable=TRUE),
          dashboardSidebar(
               sidebarMenu(id = "tab",
                    menuItem("Allocation tool", tabName = "allocation",selected=FALSE),
                    menuItem("Maps", tabName = "mapz"),
                    tags$head(includeCSS("Style.css")),
                    div(img(src="logo.png"), style="text-align: center;"),
                    div(tags$a(href="mailto: portal@gulfcouncil.org", h4("portal@gulfcouncil.org")), align="center")#,
                   )#,
                    # HTML("<h5 id='title' style='text-align:center;' >Gulf of Mexico <br> Fishery Management Council <br> 2203 North Lois Avenue, Suite 1100 <br>
                    #       Tampa, Florida 33607 USA <br> P: 813-348-1630")
                    #sidebarMenu
              ), #dashboardSidebar
     dashboardBody(
       tabItems(
         tabItem(tabName = "allocation",
            fixedRow(   
                column(width=6,
                  box(
                    tableOutput("out32"),
                    style="background-color: #000a1b")),
                column(width=6,
                  box(highchartOutput("landingsChart"))
                ),#column,
                column(width=6,
                  box(
                    sliderInput("topNumber", "Select number of years to include:", sep="",min = 5, max = 15, value = c(10)),
                    sliderInput("Year", "Select Years:", sep="",min = 1986, max = 2015, value = c(1986,2015))
                      ) #box
                    ) #column
         ) #fixed row
       ), #tabitem
     tabItem(tabName = "mapz",
             ####map code
             HTML("<h3 id='title' style='color: white;' >Red snapper biomass</h3>"),
             leafletOutput('map',height=600),
             highchartOutput("biomassBar",width=400, height=400)
             
             
             #############End map code
             ) #tabItem
  ) #tabItems
))


  


