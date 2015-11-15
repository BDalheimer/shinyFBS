fluidRow(
  column(3, 
        selectizeInput(
          "M49GeographicArea", 
          "Enter Area:", 
          choices = apply(unique(data[, .(geographicAreaM49, geographicArea)]), 1, paste, collapse= " | "), 
          multiple = TRUE)
), 

column(3, 
       selectizeInput(
         "codeElment", 
         "Enter Elements:", 
         choices = apply(unique(data[, .(measuredElement, Element)]), 1, paste, collapse= " | "), 
         multiple = TRUE)
),
column(4, 
       selectizeInput(
         "CPCItem", 
         "Enter Items:", 
         choices = apply(unique(data[, .(measuredItemCPC, Item)]), 1, paste, collapse= " | "), 
         multiple = TRUE)
),
column(2, 
       selectizeInput(
         "codeYear", 
         "Enter Years:", 
         choices = unique(data[, timePointYears]), 
         multiple = TRUE)
)
)