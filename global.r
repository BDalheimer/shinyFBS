packagesCran = c("shiny", "data.table", "rhandsontable", "shinyBS")

if (length(setdiff(packagesCran, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packagesCran, rownames(installed.packages())))  
}
lapply(packagesCran, require, character.only = T)

packagesGitHub = data.table(package = "shinysky", path = "AnalytixWare/ShinySky")
if (length(setdiff(packagesGitHub[, package], rownames(installed.packages()))) > 0) {
  devtools::install_github(packagesGitHub[!package  %in% rownames(installed.packages()), path])  
}

lapply(packagesGitHub[, package], require, character.only = T)

#library(shiny)
#library(data.table)
#library(rhandsontable)
#library(shinyBS)
#library(shinysky)

source('R/makeWideSuaDataTables.R')
source('R/selectedBrowseData.R')
source('R/exportBrowseData.R')
source('R/combineBrowseInputs.R')
source('R/selectedSUAData.R')
source('R/renderSUATables.R')
source('R/observeSequentiallyActive.R')

suaElementTable = readRDS("Data/suaElementTable.rda")
## multiple (all) country data
#data = readRDS("Data/data.rda")

## single country data 
data = readRDS("Data/testData.rda")

# only required for multiple country data (oddly)
#setnames(data, "Geographic Area", "geographicArea")
setkey(data, geographicAreaM49, measuredItemCPC, measuredElement, timePointYears)

# standardize data formats
data <- data[, .(geographicAreaM49, geographicArea, measuredItemCPC, Item, 
                 measuredElement, Element, timePointYears, Year, Value, Status, Method)]

data[, c("geographicAreaM49", "geographicArea", "measuredItemCPC", "Item", 
     "measuredElement", "Element", "timePointYears") := lapply(.SD, as.character), 
                   .SDcols = c("geographicAreaM49", "geographicArea", "measuredItemCPC", "Item", 
                              "measuredElement", "Element", "timePointYears")]                  

setkey(data, geographicAreaM49, measuredItemCPC, measuredElement, timePointYears)
# Prepare suas (for read only)
dataSUA <- data[, .(geographicArea, timePointYears, Item, Element, Value)]

## Create list with SUA Elements Trade Missing!!!

suaLong <- dataSUA[Element %in% suaElementTable[, ElementSWSName],]                 

## Convert data into wide format for SUA format
sua <- dcast.data.table(suaLong, geographicArea + timePointYears + Item ~ Element, value.var="Value")

countries = unique(data[, .(geographicAreaM49, geographicArea)])
selectBrowseData = source('R/selectBrowseData.R')
selectizeBrowseData = source('R/selectizeBrowseData.R')
browseSUA  = source('R/browseSUA.R')

