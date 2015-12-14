# This function provides the input filters for the browse sua table

selectBrowseData = function(){

tagList(
sidebarLayout(position = c('left', 'right'),
mainPanel(width = 10,             
fluidRow(
column(3, 
       selectInput("selectGeographicArea", 
                   "Select Area:", 
                   c("All", areaCodeName),
                     multiple = T, selectize = F)
),

column(3, 
       selectInput("selectElement", 
                   "Select Element:", 
                   c("All", elementCodeName),
                    multiple = T, selectize = F)
),

column(4, 
       selectInput("selectItem", 
                   "Select Item:", 
                   c("All", itemCodeName), 
                     multiple = T, selectize = F)
),

column(2, 
       selectInput("selectTimePointYears", 
                   "Select Years:", 
                   c("All", 
                     unique(as.character(data$timePointYears))), multiple=T, selectize=F)
)),

fluidRow(
  column(3,
         selectizeInput(
           "selectizeGeographicArea", 
           "Enter Area:", 
           choices = areaCodeName, 
           multiple = T)
  ), 
  
  column(3, 
         selectizeInput(
           "selectizeElement", 
           "Enter Elements:", 
           choices = elementCodeName, 
           multiple = T)
  ),
  column(4, 
         selectizeInput(
           "selectizeItem", 
           "Enter Items:", 
           choices = itemCodeName, 
           multiple = T)
  ),
  column(2, 
         selectizeInput(
           "selectizeTimePointYears", 
           "Enter Years:", 
           choices = unique(data[, timePointYears]), 
           multiple = T)
  )
)),

sidebarPanel(width = 2, 

checkboxInput("showFlags", "Show Flags", TRUE), checkboxInput("showCodes", "Show Codes", TRUE),
       downloadButton("exportBrowse", "Export csv"), br(), actionButton("browseLong", "Long/Wide Format", styleclass = "primary") 
        
)


),
tags$style(type='text/css', "#browseLong {width:100%; margin-top: 4px; margin-bottom: 2px;}"),
tags$style(type='text/css', "#exportBrowse { width:100%; margin-top: -7px; margin-bottom: 5px;}"),

fluidRow(dataTableOutput(outputId = "tableData"))
)

}

