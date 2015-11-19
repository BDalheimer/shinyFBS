shinyServer(function(input, output, session) {

  # selections filters for Browse Data Page
  selectedBrowseTable = selectedBrowseData(input, output, session)
    
  output$tableData = renderDataTable({ selectedBrowseTable() })

  # Export csv
   output$exportBrowse = exportBrowseData(input, output, session, selectedBrowseTable)

  # Use both inputs for each dimension
   combineBrowseInputs(input, output, session)
   
  
## Selection filter for SUA page
output$tableSUA = renderDataTable({ selectedSUAData(input, output, session)})
  

# Just some text output which depends on the coosen year, will be used in headers
for( x in suaElementTable[, Element]) {local({
  i = x
  output[[paste(i)]] = renderText({paste(i ,input$FBSSUAyear)})
})
}



# for(i in suaElementTable[, measuredElement]) {
#  # i = x
#   assign(paste(suaElementTable[measuredElement == i, Element]), 
#          makeWideSuaDataTables(input, output, session, i))
#   
#   }

individualSUATables = makeWideSuaDataTables(input, output, session)

# input/output tables for SUA elemnts 
for(x in suaElementTable[, Element]) {local({
  i = x
  output[[paste("table", i, sep="")]] = renderRHandsontable({
    rhandsontable(individualSUATables()[[i]], useTypes = F, rowHeaders = NULL) %>%
      hot_cols(colWidths = 100) %>%
      hot_rows(rowHeights = 20) %>%
      hot_cols(fixedColumnsLeft = 2) %>%
      hot_col("Item", readOnly = TRUE, colWidths = 300)%>%
      hot_col("measuredItemCPC", readOnly = TRUE, colWidths = 70)%>%
      hot_table(highlightCol = TRUE, highlightRow = TRUE)
  })
})
}#)
#}

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
