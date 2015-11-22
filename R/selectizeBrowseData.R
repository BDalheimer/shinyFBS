# This function provides a second input option for the browse data page

selectizeBrowseData = function(){

  tagList(
#   fluidRow(
#   column(2, 
#         selectizeInput(
#           "selectizeGeographicArea", 
#           "Enter Area:", 
#           choices = apply(unique(data[, .(geographicAreaM49, geographicArea)]), 1, paste, collapse= " | "), 
#           multiple = T)
# ), 
# 
# column(3, 
#        selectizeInput(
#          "selectizeElement", 
#          "Enter Elements:", 
#          choices = apply(unique(data[, .(measuredElement, Element)]), 1, paste, collapse= " | "), 
#          multiple = T)
# ),
# column(3, 
#        selectizeInput(
#          "selectizeItem", 
#          "Enter Items:", 
#          choices = apply(unique(data[, .(measuredItemCPC, Item)]), 1, paste, collapse= " | "), 
#          multiple = T)
# ),
# column(2, 
#        selectizeInput(
#          "selectizeTimePointYears", 
#          "Enter Years:", 
#          choices = unique(data[, timePointYears]), 
#          multiple = T)
# )
# )
)
}