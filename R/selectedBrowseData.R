selectedBrowseData = function(input, output, session) {
  
  reactive({
  
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
  
  data
  
})
  
}