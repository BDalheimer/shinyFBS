shinyServer(function(input, output, session) {

  
  
  # selections filters for Browse Data Page
  output$tableData <- renderDataTable({ 
    
    if (input$dataGeographicArea != "All"){
      data = data[data$geographicArea %in% input$dataGeographicArea,]
    }
    if (input$dataElement != "All"){
      data = data[data$Element %in% input$dataElement,]
    }
    if (input$dataItem != "All"){
      data = data[data$Item %in% input$dataItem,]
    }
    if (input$dataTimePointYears != "All"){
      data = data[data$timePointYears %in% input$dataTimePointYears,]
    }
    
    data
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
