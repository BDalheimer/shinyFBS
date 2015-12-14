saveToData = function(input, output, session, individualSUATables){  
  
  reactive({ 
    
    suaInputTables = lapply(suaElementTable[, Element], function(x){
     
      if(!is.null(input[[paste("table", x, sep = "")]])){
    inputSUAHot = data.table(hot_to_r(input[[paste("table", x, sep = "")]]))
    inputSUA = melt.data.table(inputSUAHot, id.vars = c("measuredItemCPC", "Item"), 
                         variable.name = "timePointYears", value.name = "Value")
    inputSUA = as.data.table(inputSUA)
    inputSUA[, timePointYears := unlist(tstrsplit(timePointYears, "[", fixed = T)[2])]
    inputSUA[, timePointYears := unlist(tstrsplit(timePointYears, "]", fixed = T))]
    inputSUA[, timePointYears := as.character(timePointYears)]
    ## The next 2 lines are for nowFor now:
    inputSUA[, geographicAreaM49 := as.character(rep(unlist(tstrsplit(input$FBSSUAarea, " | ")[1]), length(inputSUA[, measuredItemCPC])))]
    inputSUA[, geographicArea := as.character(rep(unlist(tstrsplit(input$FBSSUAarea, " | ")[3]), length(inputSUA[, measuredItemCPC])))]
    inputSUA[, measuredElement := as.character(rep(suaElementTable[Element == x, measuredElement], length(inputSUA[, measuredItemCPC])))]
    inputSUA[, Element := as.character(rep(suaElementTable[Element == x, ElementSWSName], length(inputSUA[, measuredItemCPC])))]
      }else{
        inputSUA = data[J("Australia", paste(x), 
                    #input$sliderYearRange[1]:input$sliderYearRange[2]
                    as.character(input$sliderYearRange[1]:input$sliderYearRange[2])), .(measuredItemCPC, Item, geographicAreaM49, 
                                                geographicArea, timePointYears, Value, measuredElement, Element),
                  nomatch = 0L]
      }
    
    
    setkey(inputSUA, geographicAreaM49, measuredItemCPC, measuredElement, timePointYears)
    
    inputSUA
    })
    names(suaInputTables) = paste("hot", suaElementTable[, Element], sep ="")
    
    newData = data.table()
    
    for (i in suaElementTable[ , Element]){
      newData = rbind(newData, suaInputTables[[paste("hot", i, sep ="")]])
    }
    
    test = copy(data)
    
    test[newData, names(newData) := newData, on = c("geographicAreaM49", "geographicArea", "measuredItemCPC",
                                                    "measuredElement", "Element", "timePointYears"), nomatch = NA]
  
    newData[, Year := timePointYears]
    newData[, Status := as.character(" ")]
    newData[, Method := as.character("UI")]
    setkey(newData, geographicAreaM49, measuredItemCPC, measuredElement, timePointYears)
     notNaNew = newData[!test, on=c("geographicAreaM49", "measuredItemCPC", "measuredElement", "timePointYears")][
       !is.na(Value) & Value != 0]
     
     saveData = rbind(test, notNaNew, fill = T)
     
     saveData[,.(geographicAreaM49, geographicArea, measuredItemCPC, Item, 
             measuredElement, Element, timePointYears, Year, Value, Status, Method)]
     
     saveData[, c("geographicAreaM49", "geographicArea", "measuredItemCPC", "Item", 
              "measuredElement", "Element", "timePointYears") := lapply(.SD, as.character), 
          .SDcols = c("geographicAreaM49", "geographicArea", "measuredItemCPC", "Item", 
                      "measuredElement", "Element", "timePointYears")]                  
     
     setkey(saveData, geographicAreaM49, measuredItemCPC, measuredElement, timePointYears)
     
     saveData
     
  })
  
}