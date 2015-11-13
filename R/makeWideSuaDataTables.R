makeWideSuaDataTables = function(){
  
  for(i in suaElementTable[, measuredElement]) {
  if(nrow(data[measuredElement == i, ]) != 0) {
    table = dcast.data.table(data[measuredElement == i, ], measuredItemCPC + Item ~ timePointYears, value.var = "Value")
    setkey(table, measuredItemCPC, Item)
    assign(paste(suaElementTable[measuredElement == i, Element], "RowNames", sep =""), table[, measuredItemCPC])
    table[, measuredItemCPC := NULL] 
    assign(paste(suaElementTable[measuredElement == i, Element]), table) 
    
  }else{
    
    table = data.table(cbind(unique(data$Item), matrix(ncol = 25, nrow = length(unique(data$Item)))))
    setnames(table, c("Item" ,paste0( 1989:2013)))
    assign(paste(suaElementTable[measuredElement == i, Element], "RowNames", sep =""), unique(data$measuredItemCPC))
    assign(paste(suaElementTable[measuredElement == i, Element]), table) 
    
  }
  } 
}