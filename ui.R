## ui.R

dashboardPage(
  #introjsUI(), # must include in UI
 
  
     dashboardHeader(disable=TRUE),
          dashboardSidebar(
               sidebarMenu(id = "tab",
                    menuItem(" ", tabName = "map",selected=TRUE),
                    tags$head(includeCSS("Style.css")),
                    div(img(src="logo.png"), style="text-align: center;"),
                    tags$style(type='text/css', ".selectize-input { font-size: 16px; line-height: 18px;} .selectize-dropdown { font-size: 16px; line-height: 18px; }"),
      
                    br(),
                    br(),
                    br(),
                    br(),
                    br(),
                    br(),
                    br(),
                    br(),
                    br(),
                    br(),
                    div(tags$a(href="mailto: portal@gulfcouncil.org", h4("portal@gulfcouncil.org")), align="center"),
                    div(br()),
HTML("<h5 id='title' style='text-align:center;' >Gulf of Mexico <br> Fishery Management Council <br> 2203 North Lois Avenue, Suite 1100 <br>
     Tampa, Florida 33607 USA <br> P: 813-348-1630")
                    
                    )
),
     dashboardBody(
          # tabItems(
          #      tabItem(tabName='map'),
          #       includeCSS('Style.css'),
          #         HTML("<h3 id='title' style='color: white;' >Red Snapper Decision Support Tool</h3>"),
          #      
box(tableOutput("out32"),
    width=4,  style="background-color: #000a1b"))#,

          )
          
          #))


