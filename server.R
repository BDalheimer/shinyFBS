shinyServer(function(input, output, session) {

  
  
  # selections filters for Browse Data Page
  output$tableData <- renderDataTable({ 
    
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
  
  # Use both inputs for each dimension
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
  
  
## Selection filter for SUA page
output$tableSUA = renderDataTable({
  
  if (input$SUAgeographicArea != "All"){
    sua = sua[sua$geographicArea %in% input$SUAgeographicArea,]
  }

  if (input$SUAItem != "All"){
    sua = sua[sua$Item %in% input$SUAItem,]
  }

  if (input$SUAtimePointYears != "All"){
    sua = sua[sua$timePointYears %in% input$SUAtimePointYears,]
  }
  
    
  sua
  
})



# Just some text output which depends on the coosen year, will be used in headers
for( x in suaElementNames) {local({
  i = x
  output[[paste(i)]] = renderText({paste(i ,input$FBSSUAyear)})
})
}


for(i in suaElementTable[, measuredElement]) {
  assign(paste(suaElementTable[measuredElement == i, Element]), makeWideSuaDataTables(i)$returnSuaTable)
  assign(paste(suaElementTable[measuredElement == i, Element], "RowNames", sep =""), makeWideSuaDataTables(i)$returnRowNames)
}


# input/output tables for SUA elemnts 
for(x in suaElementNames) {local({
  i = x
  output[[paste("table",i, sep="")]] = renderRHandsontable({
    rhandsontable(get(i), useTypes = F, rowHeaders = get(paste(i, "RowNames", sep=""))) %>%
      hot_cols(colWidths = 200) %>%
      hot_rows(rowHeights = 20) %>%
      hot_cols(fixedColumnsLeft = 1) %>%
      hot_col("Item", readOnly = TRUE, colWidths = 600)
      
    
  })
})}

observe({
  if (input$startContinue > 0) {
    session$sendCustomMessage('activeNavs', 'Production')
    updateTabsetPanel(session, "suaNavlist", selected = "Production")
  }
})



observe({
  if (input$productionSave > 0) {
    session$sendCustomMessage('activeNavs', 'Trade')
    updateTabsetPanel(session, "suaNavlist", selected = "Trade")
  }
})

observe({
  if (input$tradeSave > 0) {
    session$sendCustomMessage('activeNavs', 'Stocks')
    updateTabsetPanel(session, "suaNavlist", selected = "Stocks")
  }
})

observe({
  if (input$stocksSave > 0) {
    session$sendCustomMessage('activeNavs', 'Food')
    updateTabsetPanel(session, "suaNavlist", selected = "Food")
  }
})

observe({
  if (input$foodSave > 0) {
    session$sendCustomMessage('activeNavs', 'Feed')
    updateTabsetPanel(session, "suaNavlist", selected = "Feed")
  }
})

observe({
  if (input$feedSave > 0) {
    session$sendCustomMessage('activeNavs', 'Seed')
    updateTabsetPanel(session, "suaNavlist", selected = "Seed")
  }
})

observe({
  if (input$seedSave > 0) {
    session$sendCustomMessage('activeNavs', 'Food Losses & Waste')
    updateTabsetPanel(session, "suaNavlist", selected = "Food Losses & Waste")
  }
})

observe({
  if (input$flwSave > 0) {
    session$sendCustomMessage('activeNavs', 'Industrial Use')
    updateTabsetPanel(session, "suaNavlist", selected = "Industrial Use")
  }
})

observe({
  if (input$industrialSave > 0) {
    session$sendCustomMessage('activeNavs', 'Tourist Consumption')
    updateTabsetPanel(session, "suaNavlist", selected = "Tourist Consumption")
  }
})

observe({
  if (input$touristSave > 0) {
    session$sendCustomMessage('activeNavs', 'Residual Other Uses')
    updateTabsetPanel(session, "suaNavlist", selected = "Residual Other Uses")
  }
})

observe({
  if (input$residualSave > 0) {
    session$sendCustomMessage('activeNavs', 'Save All')
    updateTabsetPanel(session, "suaNavlist", selected = "Save All")
  }
})


})
