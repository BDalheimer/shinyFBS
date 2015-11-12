library(shiny)
library(data.table)
library(reshape2)
library(rhandsontable)
library(shinysky)

data <- fread("Data/testData.csv")

data <- data[, .(geographicAreaM49, geographicArea, measuredItemCPC, Item, 
                 measuredElement, Element, timePointYears, Year, Value, Status, Method)]


dataSUA <- data[, .(geographicArea, timePointYears, Item, Element, Value)]

## Create list with SUA Elements Trade Missing!!!
elementsSua <- c("Production [t]", "Seed [t]", "Loss [t]",  "Waste [t]", "Feed [t]", "Processed [t]", "Other Util [t]",
                 "Stocks [#]")

suaLong <- dataSUA[dataSUA$Element %in% elementsSua,]                 


## Convert data into wide format for SUA format: Prod Imp ... . Problem: there are duplicate elements (to examine further)
## Couldn't find the duplicate elements. Also, the data is incomplete. I started working with a subset of only one country 
sua <- dcast.data.table(suaLong, geographicArea + timePointYears + Item ~ Element, value.var="Value")

suaElementNames <- c("Production", "Import", "Export", "Stocks", "Food Use", "Feed Use","Seed", "Food Losses & Waste", 
                     "Tourist Consumption", "Industrial Use", "Residual Other Uses")

suaElementCodes = c(5510, 5610, 5910, 5071, 5141, 5520, 5525, 5015, 5164, 5165, 5166)

suaElementTable = data.table(measuredElement = suaElementCodes, Element = suaElementNames)

# productionElements = c(5510, 55100, 55101, 5515)
# 
# feedElements = c(5520)
# 
# seedElements = c(5520)
# 
# otherElements = c(5153)


## create empty datasets for each sua element, which will be filled by user or R module
emptyData = data.frame(Commodity = unique(data$Item), ExpectedValue = rep(0, length(unique(data$Item))),
                        UpperBound = rep(0, length(unique(data$Item))), 
                        LowerBound = rep(0, length(unique(data$Item))),
                        stringsAsFactors = FALSE, row.names = unique(data$measuredItemCPC))



for(i in suaElementNames){
  (assign(paste0(i), emptyData))
  
}

#for(i in suaElementTable[, suaElementCodes]) {
#  if(nrow(data[measuredElement == i, ]) != 0)
#  assign(paste(suaElementTable[measuredElement == i, Element]), 
#         dcast.data.table(data[measuredElement == i, ], measuredItemCPC + Item ~ timePointYears, value.var = "Value"))
#}
setkey(data)



