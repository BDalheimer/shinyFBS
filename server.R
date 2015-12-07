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

# test to save data (still crashing)
#   observeEvent({
#     if(input$productionSave != 0){
#       
#       newData = data.table(hot_to_r(input$tableProduction))
#       newLongData = melt.data.table(newData, id.vars = c("measuredItemCPC", "Item"), 
#                                     variable.name = "timePointYears", value.name = "Value")
#       newLongData[, timePointYears := as.character(timePointYears)]
#       ## This is just for now
#       newLongData[, geographicAreaM49 := as.character(rep("36", length(newLongData[, measuredItemCPC])))]
#       newLongData[, geographicArea := as.character(rep(paste("Australia"), length(newLongData[, measuredItemCPC])))]
#       newLongData[, Element := as.character(rep("Production", length(newLongData[, measuredItemCPC])))]  
#       newLongData[, measuredElement := as.character(rep("5510", length(newLongData[, measuredItemCPC])))]
#       
#       data[newLongData, names(newLongData) := newLongData, on = c("geographicArea", "geographicAreaM49", "measuredItemCPC",
#                                                                   "Item", "measuredElement", "Element", "timePointYears"), with =F]
#       
#       write.csv(data, "test.csv")
# # #     #print(tempfile())
#     }
#   })


# plots
output$suaPlot = renderPlot({SUAPlot(input, output, session, selectedSUAtable)})
  

output$plotProduction = renderPlot({ 
  plotData = input$tableProduction_select[input$tableProduction_select$select$r, ]
  
  plot(plotData)
  
})

})


