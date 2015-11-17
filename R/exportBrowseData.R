exportBrowseData = function(input, output, session, selectedBrowseTable){

downloadHandler(
  filename = function() {paste('shinyFBS', Sys.Date(), '.csv', sep='') },
  content = function(file) {
    
    write.csv(selectedBrowseTable(), file, row.names = F)
    
  })
}