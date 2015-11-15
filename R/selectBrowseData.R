fluidRow(
column(3, 
       selectInput("dataGeographicArea", 
                   "Geographic Area:", 
                   c("All", apply(unique(data[, .(geographicAreaM49, geographicArea)]), 1, paste, collapse= " | ")),
                     multiple = T, selectize = F)
),

column(3, 
       selectInput("dataElement", 
                   "Element:", 
                   c("All", apply(unique(data[, .(measuredElement, Element)]), 1, paste, collapse = " | ")),
                    multiple = T, selectize = F)
),

column(4, 
       selectInput("dataItem", 
                   "Item:", 
                   c("All", apply(unique(data[, .(measuredItemCPC, Item)]), 1, paste, collapse = " | ")), 
                     multiple = T, selectize = F)
),

column(2, 
       selectInput("dataTimePointYears", 
                   "Years:", 
                   c("All", 
                     unique(as.character(data$timePointYears))), multiple=T, selectize=F)
)
)


