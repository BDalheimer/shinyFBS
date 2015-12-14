# This function creates wide data tables for each sua element to be rendered in 
# rhandsontable for sua  data input/output

makeWideSuaDataTables = function(input, output, session, suaAreaYear){
  
reactive({
  
  wideTables = lapply(suaElementTable[, measuredElement], function(i){
  setkey(data, geographicArea, measuredElement, timePointYears)
  suaElementData = data[J(unlist(tstrsplit(input$FBSSUAarea, " | ")[3]), paste(i), 
                          #input$sliderYearRange[1]:input$sliderYearRange[2]
                        as.character(input$sliderYearRange[1]:input$FBSSUAyear)), 
                        nomatch = 0L]
  setkey(suaElementData, measuredItemCPC, timePointYears) 
 
  if (!is.null(input[[paste("table", i, sep ="")]])) {
    wideSuaTable = hot_to_r(input[[paste("table", i, sep ="")]])
  }else{
  
  if(nrow(suaElementData) != 0) {
    # reshape existing data
    suaElementData[, timePointYears := paste("[", timePointYears, "]", sep="")]
    wideSuaTable = dcast.data.table(suaElementData, 
                                    measuredItemCPC + Item ~ timePointYears, value.var = "Value")
     
    
    setkey(wideSuaTable, measuredItemCPC)
   
    
  }else{# For those that do not have data, return empty data
    
    # create empty data table covering the whole time period
    wideSuaTable = data.table(cbind(unique(data[, .(measuredItemCPC, Item)]),
                                    matrix(ncol = length(input$sliderYearRange[1]:input$sliderYearRange[2]), 
                                           nrow = length(unique(data$Item)))))
   
    setnames(wideSuaTable, c("measuredItemCPC", "Item", paste("[", input$sliderYearRange[1]:input$sliderYearRange[2], "]", sep = "")))
    setkey(wideSuaTable, measuredItemCPC)
    wideSuaTable = wideSuaTable[, lapply(.SD, as.numeric), by=.(measuredItemCPC, Item)]
    
  }
  }
  
  if (!paste("[", input$FBSSUAyear, "]", sep ="") %in% names(wideSuaTable)){
    
    wideSuaTable[, paste0("[", input$FBSSUAyear, "]", sep="") := rep(0, length(wideSuaTable[, measuredItemCPC])), with = F] 
  }
  
  
 wideSuaTable
 
  })
  names(wideTables) = paste(suaElementTable[, Element])
  wideTables
  
  })
}



