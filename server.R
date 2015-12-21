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
    
   
   output$suaTitle = renderText({SUATitle(input, output, session)})
# input/output tables for SUA elements 

individualSUATables = makeWideSuaDataTables(input, output, session, suaAreaYear, productionUploadTable)


renderSUATables(input, output, session, individualSUATables)

# save & continue buttons
observeSequentiallyActive(input, output, session)

  
# save data back to database and restore default data
observeSaveRestore(input, output, session)
  

# plots
output$suaPlot = renderPlot({SUAPlot(input, output, session, selectedSUAtable, productionUploadTable)})

 output$productionPlot = renderDygraph({
   if(!is.null(input$tableProduction)){
     ts = data.table(hot_to_r(input$tableProduction))
   }else{
     ts = individualSUATables()$Production
   }
   itemName = ts[as.numeric(input$tableProduction_select$select$r), Item]
   tsData = ts[as.numeric(input$tableProduction_select$select$r), -c("measuredItemCPC", "Item"), with = F]

   tsDataLong = data.table( Year = names(tsData), Production = unlist(list(tsData[1, 1:ncol(tsData), with = F])))
   names(tsDataLong) = c("Year", "Production")
   tsDataLong[, Year := unlist(tstrsplit(Year, "[", fixed = T)[2])]
   tsDataLong[, Year := unlist(tstrsplit(Year, "]", fixed = T))]
   tsDataLong[, Year := as.Date(as.character(Year), format = '%Y')]
   tsPlot = xts(tsDataLong, order.by = tsDataLong$Year )
   dygraph(tsPlot, main = paste(itemName))
})
 
# Upload Production Data
 
 productionUploadTable = reactive({ 
   inFile = input$productionUpload
   
   if (is.null(inFile))
     return(NULL)
   
   as.data.table(read.csv(inFile$datapath, header = input$header,
                                             sep = input$sep, quote = input$quote)
   )
   
   
   })
 

output$productionUploadTable <- renderTable({
  productionUploadTable()
})


})


