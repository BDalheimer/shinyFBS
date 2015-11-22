# This function observes both inputs on the browse data page and updates the input accordingly

combineBrowseInputs = function(input, output, session){
  
  observeEvent(input$selectizeGeographicArea, {
    if(!is.null(input$selectizeGeographicArea)){
      updateSelectInput(session, "selectGeographicArea", 
                        selected = c(input$selectGeographicArea, input$selectizeGeographicArea))
    }
  })
  
  observeEvent(input$selectizeElement, {
    if(!is.null(input$selectizeElement)){
      updateSelectInput(session, "selectElement", 
                        selected = c(input$selectElement, input$selectizeElement))
    }
  })
  
  observeEvent(input$selectizeItem, {
    if(!is.null(input$selectizeItem)){
      updateSelectInput(session, "selectItem", 
                        selected = c(input$selectItem, input$selectizeItem))
    }
  })
  observeEvent(input$selectizeTimePointYears, {
    if(!is.null(input$selectizeTimePointYears)){
      updateSelectInput(session, "selectTimePointYears", 
                        selected = c(input$selectTimePointYears, input$selectizeTimePointYears))
    }
  }) 
  
  
  
}