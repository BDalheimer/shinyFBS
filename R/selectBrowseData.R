# This function provides the input filters for the browse sua table

selectBrowseData = function(){
#ns = NS("selectGeographicArea")
tagList(  
fluidRow(
column(2, 
       selectInput("selectGeographicArea", 
                   "Select Area:", 
                   c("All", apply(unique(data[, .(geographicAreaM49, geographicArea)]), 1, paste, collapse= " | ")),
                     multiple = T, selectize = F)
),

column(3, 
       selectInput("selectElement", 
                   "Select Element:", 
                   c("All", apply(unique(data[, .(measuredElement, Element)]), 1, paste, collapse = " | ")),
                    multiple = T, selectize = F)
),

column(3, 
       selectInput("selectItem", 
                   "Select Item:", 
                   c("All", apply(unique(data[, .(measuredItemCPC, Item)]), 1, paste, collapse = " | ")), 
                     multiple = T, selectize = F)
),

column(2, 
       selectInput("selectTimePointYears", 
                   "Select Years:", 
                   c("All", 
                     unique(as.character(data$timePointYears))), multiple=T, selectize=F)
),

column(2, 
        actionButton("browseLong", "Long Format", styleclass = "primary"),# style = 'font-size:80%'), 
        br(),
        downloadButton("exportBrowse", "Export csv") #, style = 'font-size:80%')
)
# tags$style(type='text/css', "#browseLong { width:100%; margin-top: 25px; margin-bottom: 10px;}")
# #tags$style(type='text/css', "#exportBrowse { width:100%; margin-top: 15px; margin-bottom: 15px;}")

)
)
}