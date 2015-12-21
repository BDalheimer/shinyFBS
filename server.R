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

individualSUATables = makeWideSuaDataTables(input, output, session, suaAreaYear)



renderSUATables(input, output, session, individualSUATables)

# save & continue buttons
observeSequentiallyActive(input, output, session)

  
# save data back to database and restore default data
observeSaveRestore(input, output, session)
  

# plots
output$suaPlot = renderPlot({SUAPlot(input, output, session, selectedSUAtable)})

output$testTable = renderTable({ 
  if(!is.null(input$tableProduction)){
    ts = data.table(hot_to_r(input$tableProduction))
  }else{
    ts = individualSUATables()$Production
  }
  #ts = data.table(hot_to_r(input$tableProduction))
  tsData = ts[as.numeric(input$tableProduction_select$select$r), -c("measuredItemCPC", "Item"), with = F]
  #tsDataLong
  #list(tsData[1,])
  tsDataLong = data.table( Year = names(tsData), Production = unlist(list(tsData[1, 1:ncol(tsData), with = F])))
  names(tsDataLong) = c("Year", "Production")
  tsDataLong[, Year := unlist(tstrsplit(Year, "[", fixed = T)[2])]
  tsDataLong[, Year := unlist(tstrsplit(Year, "]", fixed = T))]
  tsDataLong[, Year := as.Date(as.character(Year), format = '%Y')]
  tsDataLong
  #test = data.table(Year = as.Date(as.character(tsDataLong[,1])), Production = tsDataLong[,2])
  #names(tsDataLong) = c("Year", "Production")
  #tsDataLong[, Year := as.Date(as.character(Year), fomrat = '%i')]
  #tsDataLong
  #test
  })

 test = data.table(A = as.Date(as.character(1990:2015), format = '%Y'), B = rnorm(26))
  

 output$productionPlot = renderDygraph({
   if(!is.null(input$tableProduction)){
     ts = data.table(hot_to_r(input$tableProduction))
   }else{
     ts = individualSUATables()$Production
   }
   #ts = data.table(hot_to_r(input$tableProduction))
   itemName = ts[as.numeric(input$tableProduction_select$select$r), Item]
   tsData = ts[as.numeric(input$tableProduction_select$select$r), -c("measuredItemCPC", "Item"), with = F]
   #tsDataLong
   #list(tsData[1,])
   tsDataLong = data.table( Year = names(tsData), Production = unlist(list(tsData[1, 1:ncol(tsData), with = F])))
   names(tsDataLong) = c("Year", "Production")
   tsDataLong[, Year := unlist(tstrsplit(Year, "[", fixed = T)[2])]
   tsDataLong[, Year := unlist(tstrsplit(Year, "]", fixed = T))]
   tsDataLong[, Year := as.Date(as.character(Year), format = '%Y')]
   tsPlot = xts(tsDataLong, order.by = tsDataLong$Year )
   dygraph(tsPlot, main = paste(itemName)) %>%
     dySeries("Production", label = "Production") %>%
     dyOptions(stackedGraph = TRUE) #%>%
# #   tsPlot = xts(ts[as.numeric(input$tableProduction_select$select$r), -c("measuredItemCPC", "Item"), with = F], input$sliderYearRange[1]:input$FBSSUAyear)
# #                dygraph(tsPlot, main = "Cumulative Return") %>%
# #                  dySeries("V1", label = "Portfolio") #%>%
#                  #dyLimit(as.numeric(calc()$Perf$CumulRet[1]), color = "red")
#  dygraph(ts[1,])
#          
})

# Upload Production Data
output$productionUploadTable <- renderTable({
  
  inFile = input$productionUpload
  
  if (is.null(inFile))
    return(NULL)
  
  productionUpload = as.data.table(read.csv(inFile$datapath, header = input$header,
           sep = input$sep, quote = input$quote)
  )
  productionUpload
})

})


