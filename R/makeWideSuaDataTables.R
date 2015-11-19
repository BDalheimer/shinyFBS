# This function creates wide data tables for each sua element to be rendered in 
# rhandsontable for sua  data input/output

makeWideSuaDataTables = function(input, output, session){
  
reactive({
  
  #for (i in suaElementTable[, measuredElement]){
  wideTables = lapply(suaElementTable[, measuredElement], function(i){
  setkey(data, geographicArea, measuredElement)

  suaElementDataOne = data[geographicArea %in% input$FBSSUAarea,]
  suaElementData = suaElementDataOne[measuredElement %in% paste(i), ]
  suaElementData = data[J(input$FBSSUAarea, paste(i)), nomatch = 0L]
  setkey(suaElementData, measuredItemCPC, timePointYears) 
 
  if(nrow(suaElementData) != 0) {
    # reshape existing data
    wideSuaTable = dcast.data.table(suaElementData, 
                                    measuredItemCPC + Item ~ timePointYears, value.var = "Value")
    
    setkey(wideSuaTable, measuredItemCPC)
   
    
  }else{# For those that do not have data, return empty data
    
    # create empty data table covering the whole time period
    wideSuaTable = data.table(cbind(unique(data[, .(measuredItemCPC, Item)]),
                                    matrix(ncol = length(min(data[, timePointYears]):max(data[, timePointYears])), 
                                           nrow = length(unique(data$Item)))))
   
    setnames(wideSuaTable, c("measuredItemCPC", "Item" ,paste0( min(data[, timePointYears]):max(data[, timePointYears]))))
    setkey(wideSuaTable, measuredItemCPC)
    
  }
  # wrap up outputs in list (table and corresponding cpc codes to be used as rownames in rhandsontable)
  
 wideSuaTable
 
 

  })
  names(wideTables) = paste(suaElementTable[, Element])
  wideTables
  
  })
}



