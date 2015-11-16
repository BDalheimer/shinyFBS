fluidRow(
  column(3, 
        selectizeInput(
          "selectizeGeographicArea", 
          "Enter Area:", 
          choices = apply(unique(data[, .(geographicAreaM49, geographicArea)]), 1, paste, collapse= " | "), 
          multiple = TRUE)
), 

column(3, 
       selectizeInput(
         "selectizeElement", 
         "Enter Elements:", 
         choices = apply(unique(data[, .(measuredElement, Element)]), 1, paste, collapse= " | "), 
         multiple = TRUE)
),
column(4, 
       selectizeInput(
         "selectizeItem", 
         "Enter Items:", 
         choices = apply(unique(data[, .(measuredItemCPC, Item)]), 1, paste, collapse= " | "), 
         multiple = TRUE)
),
column(2, 
       selectizeInput(
         "selectizeTimePointYears", 
         "Enter Years:", 
         choices = unique(data[, timePointYears]), 
         multiple = TRUE)
)
)