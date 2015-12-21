# This function saves data if reqested and restores to default data if ordered so
#
observeSaveRestore = function(input, output, session){

observeEvent(input$saveSave , {
  if(!is.null(input$tableProduction)){
    
    data <<- saveToData(input, output, session, individualSUATables)()
    
    saveRDS(saveToData(input, output, session, individualSUATables)(), file = "Data/testData.rda")
  createAlert(session, "restartShiny", "makeEffectiveAllert", title = "Restart",
              content = "You need to restart the FBS compiler to make changes effective.", append = FALSE)}
  
}
)

observeEvent( input$restoreDefault, {
  
  
  data <<- readRDS("Data/backUpTestData.rda")
  
  saveRDS(data, file = "Data/testData.rda")
  createAlert(session, "restartShiny", "makeEffectiveAllert", title = "Restart",
              content = "You need to restart the FBS compiler to make changes effective.", append = FALSE)}
)

}