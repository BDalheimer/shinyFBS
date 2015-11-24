#Source functions
sapply(list.files(pattern="[.]R$", path="R/", full.names=TRUE), source)
## Require packages or install if missing
 packageRequirevInstall()


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
#dataSUA <- data[, .(geographicArea, timePointYears, Item, Element, Value)]

## Create list with SUA Elements Trade Missing!!!
suaLong = data[measuredElement %in% suaElementTable[, measuredElement],]                 

## Convert data into wide (SUA) format
sua = dcast.data.table(suaLong, geographicArea + timePointYears + Item ~ Element, value.var="Value")

targetSUA = data.table(cbind(data.table(geographicArea = sua$geographicArea, timePointYears = sua$timePointYears, Item = sua$Item)),
                       matrix(nrow = length(sua$geographicArea), ncol = length(suaElementTable[, Element]),0))

names(targetSUA) = c("geographicArea", "timePointYears", "Item", paste(suaElementTable[, ElementSWSName]))
setkey(targetSUA, geographicArea, timePointYears, Item)                    
