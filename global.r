library(shiny)
library(data.table)
library(reshape2)
library(rhandsontable)
library(shinysky)
source('R/makeWideSuaDataTables.R')

data <- fread("Data/testData.csv")
data[, measuredItemCPC := as.character(measuredItemCPC)]
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


setkey(data)
selectBrowseData = source('R/selectBrowseData.R')
selectizeBrowseData = source('R/selectizeBrowseData.R')
browseSUA  = source('R/browseSUA.R')
