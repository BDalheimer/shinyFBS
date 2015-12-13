shinyServer(function(input, output, session) {

  # selections filters for Browse Data Page
  selectedBrowseTable = selectedBrowseData(input, output, session)
    
  output$tableData = renderDataTable({selectedBrowseTable()})  
                                     
  # Export csv
   output$exportBrowse = exportBrowseData(input, output, session, selectedBrowseTable)

  # Use both inputs for each dimension
   combineBrowseInputs(input, output, session)
   
  
# Selection filter for SUA page
   selectedSUAtable = selectedSUAData(input, output, session)
   
   output$tableSUA = renderTable({selectedSUAtable()})
    

# Just some text output which depends on the chosen year, will be used in headers
# for( x in suaElementTable[, Element]) {local({
#   i = x
#   output[[paste(i)]] = renderText({paste(i ,input$FBSSUAyear)})
# })
# }
   
    
   output$suaTitle = renderText({SUATitle(input, output, session)})
# input/output tables for SUA elements 

individualSUATables = makeWideSuaDataTables(input, output, session)



renderSUATables(input, output, session, individualSUATables)

# save & continue buttons
observeSequentiallyActive(input, output, session)

  
# save data back to database and restore default data
observeSaveRestore(input, output, session)
  

# plots
output$suaPlot = renderPlot({SUAPlot(input, output, session, selectedSUAtable)})
  

output$plotProduction = renderPlot({ 
  plotData = input$tableProduction_select[input$tableProduction_select$select$r, ]
  
  plot(plotData)
  
})

})


