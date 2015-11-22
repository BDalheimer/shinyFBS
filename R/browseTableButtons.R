# This function provides an ui object that provides the browse data table as well as buttons to modify it

browseTableButtons = function(){

tagList(
  fluidPage(
## The goal heare was to have buttons on top of the table  
# fluidPage(column(3),
#           column(7,
#          column(3, div(type = 'text/css', style =  'margin-top: 2px; margin-bottom: -40px;',downloadButton("exportBrowse", "Export csv"))),         
#          column(3, div(type = 'text/css', style =  'margin-top: 2px; margin-bottom: -40px;',checkboxInput("showFlags", "Show flags", TRUE))),
#          column(3, div(type = 'text/css', style =  'margin-top: 2px; margin-bottom: -40px;', checkboxInput("showCodes", "Show Codes", TRUE))),
#          column(3, div(type = 'text/css', style =  'margin-top: 2px; margin-bottom: -40px; width: 100%', actionButton("browseLong", "Long/Wide Format", styleclass = "primary", style = 'font-size:90%')))),
#          column(2),
#          tags$style(type='text/css', "#showFlags {width:100%; margin-top: 15px; margin-bottom: -82px;}"),
#          tags$style(type='text/css', "#showCodes {width:100%; margin-top: 15px; margin-bottom: -82px;}"),
#          tags$style(type='text/css', "#browseLong {width:100%; margin-top: 15px; margin-bottom: -82px;}"),#, style = 'font-size:80%')),
#          
         
         #column(2, downloadButton("exportBrowse", "Export csv"))
         #tags$style(type='text/css', "#browseLong { width:100%; margin-top: 25px; margin-bottom: 10px;}"),
         #tags$style(type='text/css', "#exportBrowse { width:100%; margin-top: 15px; margin-bottom: 15px;}")
         


dataTableOutput(outputId = "tableData")
 
  
 
)
)
}