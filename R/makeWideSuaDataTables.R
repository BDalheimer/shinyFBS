# This function creates wide data tables for each sua element to be rendered in rhandsontable for sua  data input/output

makeWideSuaDataTables = function(i){
  
  # For those that already have data, return table with available data
    #data = data[geographicArea == input$FBSSUAarea, ]
  if(nrow(data[measuredElement == i, ]) != 0) {
    # reshape existing data
    wideSuaTable = dcast.data.table(data[measuredElement == i, ], 
                                    measuredItemCPC + Item ~ timePointYears, value.var = "Value")
    
    setkey(wideSuaTable, Item)
    # save codes for rownmaes
    returnRowNames = wideSuaTable[, measuredItemCPC]
    # remove cpc codes from table
    returnSuaTable = wideSuaTable[ , measuredItemCPC := NULL] 
    
    
  }else{# For those that do not have data, return empty data
    
    # create empty data table covering the whole time period
    wideSuaTable = data.table(cbind(unique(data$Item), 
                                    matrix(ncol = length(min(data[, timePointYears]):max(data[, timePointYears])), 
                                           nrow = length(unique(data$Item)))))
   
    setnames(wideSuaTable, c("Item" ,paste0( min(data[, timePointYears]):max(data[, timePointYears]))))
    # set up cpc codes for rownmaes
    returnRowNames = unique(data$measuredItemCPC)
    # remove cpc codes from table
    returnSuaTable = wideSuaTable[, measuredItemCPC := NULL]   
    returnSuaTable
  }
  # wrap up outputs in list (table and corresponding cpc codes to be used as rownames in rhandsontable)
  returnObjects = list(returnSuaTable = returnSuaTable, returnRowNames = returnRowNames)

  returnObjects
}



