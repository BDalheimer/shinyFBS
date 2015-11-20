shinyServer(function(input, output, session) {

  # selections filters for Browse Data Page
  selectedBrowseTable = selectedBrowseData(input, output, session)
    
  output$tableData = renderDataTable({selectedBrowseTable()})  
                                     
  # Export csv
   output$exportBrowse = exportBrowseData(input, output, session, selectedBrowseTable)

  # Use both inputs for each dimension
   combineBrowseInputs(input, output, session)
   
  
# Selection filter for SUA page
output$tableSUA = renderDataTable({ selectedSUAData(input, output, session)})
  

# Just some text output which depends on the chosen year, will be used in headers
for( x in suaElementTable[, Element]) {local({
  i = x
  output[[paste(i)]] = renderText({paste(i ,input$FBSSUAyear)})
})
}


# input/output tables for SUA elemnts 

individualSUATables = makeWideSuaDataTables(input, output, session)

renderSUATables(input, output, session, individualSUATables)

# save & continue buttons
observeSequentiallyActive(input, output, session)

output$plotProduction = renderPlot({ 
  plotData = input$tableProduction_select[input$tableProduction_select$select$r, ]
  
  plot(plotData)
  
})

output$range <- renderPrint({ paste0(input$sliderYearRange[1]:input$sliderYearRange[2])  })

})


