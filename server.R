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

individualSUATables = makeWideSuaDataTables(input, output, session, suaAreaYear)



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

output$productionUploadTable <- renderTable({
  # input$file1 will be NULL initially. After the user selects
  # and uploads a file, it will be a data frame with 'name',
  # 'size', 'type', and 'datapath' columns. The 'datapath'
  # column will contain the local filenames where the data can
  # be found.
  
  inFile <- input$productionUpload
  
  if (is.null(inFile))
    return(NULL)
  as.data.table(
  read.csv(inFile$datapath, header = input$header,
           sep = input$sep, quote = input$quote, row.names = F)
  )
})

})


