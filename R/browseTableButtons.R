# This function provides an ui object that provides the browse data table as well as buttons to modify it

browseTableButtons = function(){

tagList(
fluidRow(column(4),
         column(2, checkboxInput("showFlags", "Show flags", TRUE)),
         column(2, checkboxInput("showCodes", "Show Codes", TRUE)),
         column(2, actionButton("browseLong", "Long Format", styleclass = "primary"))#, style = 'font-size:80%')),
         #column(2, downloadButton("exportBrowse", "Export csv"))
         #tags$style(type='text/css', "#browseLong { width:100%; margin-top: 25px; margin-bottom: 10px;}"),
         #tags$style(type='text/css', "#exportBrowse { width:100%; margin-top: 15px; margin-bottom: 15px;}")
),
fluidRow(
  dataTableOutput(outputId = "tableData")
) 
)

}