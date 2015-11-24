# This function creates SUA titles

SUATitle = function(input, output, session){
  
  if(input$SUAgeographicArea != "" & input$SUAItem != "" & input$SUAtimePointYears !=""){
    paste(input$SUAgeographicArea, input$SUAItem, input$SUAtimePointYears, sep = ", ")
  }else{""}
  
}