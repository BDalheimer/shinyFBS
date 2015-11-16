library(shiny)
library(data.table)
library(reshape2)
library(rhandsontable)
library(shinysky)
source('R/makeWideSuaDataTables.R')

suaELementTable = readRDS("Data/suaElementTable.rda")
data = readRDS("Data/testData.rda")
data[, measuredItemCPC := as.character(measuredItemCPC)]

data <- data[, .(geographicAreaM49, geographicArea, measuredItemCPC, Item, 
                 measuredElement, Element, timePointYears, Year, Value, Status, Method)]


dataSUA <- data[, .(geographicArea, timePointYears, Item, Element, Value)]

## Create list with SUA Elements Trade Missing!!!

suaLong <- dataSUA[dataSUA$Element %in% elementsSua,]                 

## Convert data into wide format for SUA format: Prod Imp ... . Problem: there are duplicate elements (to examine further)
## Couldn't find the duplicate elements. Also, the data is incomplete. I started working with a subset of only one country 
sua <- dcast.data.table(suaLong, geographicArea + timePointYears + Item ~ Element, value.var="Value")

setkey(data)
selectBrowseData = source('R/selectBrowseData.R')
selectizeBrowseData = source('R/selectizeBrowseData.R')
browseSUA  = source('R/browseSUA.R')
