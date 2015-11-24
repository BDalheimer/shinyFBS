# This function subsets the browse SUA data according to input

selectedSUAData = function(input, output, session){

reactive({
  
  validate(
    need(input$SUAgeographicArea != "" |
           input$SUAItem != ""|
           input$SUAtimePointYears != "",
            "Please select Area Year and Item")
  )
  
  suaSmall = sua
  setkey(suaSmall, geographicArea, Item, timePointYears)

  suaSmall = suaSmall[J(input$SUAgeographicArea, input$SUAItem, input$SUAtimePointYears), nomatch = 0L]
  #targetSUA = targetSUA[J("Australia", "2012", "Apples")]
  targetSUA = targetSUA[J(input$SUAgeographicArea, input$SUAtimePointYears, input$SUAItem)]


  if(input$SUAgeographicArea != "" & input$SUAItem != "" & input$SUAtimePointYears != "")
    targetSUA = targetSUA[suaSmall, names(suaSmall) := suaSmall, on = c("geographicArea", "timePointYears", "Item")][, 
                                                         -c("geographicArea", "timePointYears", "Item"), with = F]
})
}