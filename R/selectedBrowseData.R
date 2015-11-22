# This function subsets the data according to selected inputs

selectedBrowseData = function(input, output, session) {
  
  reactive({
    validate(
      need(input$selectGeographicArea !="" | 
             input$selectElement != "" | 
             input$selectItem != "" |
             input$selectTimePointYears != "", "Please select Area(s), Element(s) Item(s) and Year(s) to display and Export data"))
              
  if (input$selectGeographicArea != "All" ){
    data = data[data$geographicAreaM49 %in% unlist(tstrsplit(input$selectGeographicArea, " | ")[1]),]
  }
  if (input$selectElement != "All" ){
    data = data[data$measuredElement %in% unlist(tstrsplit(input$selectElement, " | ")[1]),]
  }
  if (input$selectItem != "All"){
    data = data[data$measuredItemCPC %in% unlist(tstrsplit(input$selectItem, " | ")[1]),]
  }
  if (input$selectTimePointYears != "All"){
    data = data[data$timePointYears %in% input$selectTimePointYears,]
  }
  if(input$browseLong %% 2 == 1){
    data = data[, -"timePointYears", with = F]
    data = dcast.data.table(data, geographicArea + geographicAreaM49 + measuredElement + Element +
                              Item + measuredItemCPC ~ Year, value.var=c("Value", "Status", "Method"))
  }
    
  if (input$showCodes == FALSE){
  data = data[, -c("geographicAreaM49", "measuredElement", "measuredItemCPC", "timePointYears"), with = F]
  }
    
  if (input$showFlags == FALSE){
  data = data[, -c(which(like(colnames(data), "^Status"))), with=F]
  data = data[, -c(which(like(colnames(data), "^Method"))), with=F]
  }
    
    
  data
  
  
})

}