#Source functions
# sapply(list.files(pattern="[.]R$", path="R/", full.names=TRUE), source)
# ## Require packages or install if missing
# packageRequirevInstall()

#source functions
source('R/makeWideSuaDataTables.R')
source('R/selectedBrowseData.R')
source('R/exportBrowseData.R')
source('R/combineBrowseInputs.R')
source('R/selectedSUAData.R')
source('R/renderSUATables.R')
source('R/observeSequentiallyActive.R')
source('R/selectBrowseData.R')
source('R/selectizeBrowseData.R')
source('R/browseTableButtons.R')
source('R/browseSUA.R')
source('R/sequenceSUAFBS.R')

# Read data
# Option 1: Single country
suaElementTable = readRDS("Data/suaElementTable.rda")

# Option 2: multiple (all) country data
#data = readRDS("Data/data.rda")

## single country data 
data = readRDS("Data/testData.rda")

# only required for multiple country data (oddly)
#setnames(data, "Geographic Area", "geographicArea")

#setkeys (for both types of data)
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

## Convert data into wide (SUA) format
sua <- dcast.data.table(suaLong, geographicArea + timePointYears + Item ~ Element, value.var="Value")

countries = unique(data[, .(geographicAreaM49, geographicArea)])
#selectBrowseData = source('R/selectBrowseData.R')
#selectizeBrowseData = source('R/selectizeBrowseData.R')
#browseSUA  = source('R/browseSUA.R')

