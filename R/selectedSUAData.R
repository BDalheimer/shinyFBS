selectedSUAData = function(input, output, session){

reactive({
  
if (input$SUAgeographicArea != "All"){
  sua = sua[sua$geographicArea %in% input$SUAgeographicArea,]
}

if (input$SUAItem != "All"){
  sua = sua[sua$Item %in% input$SUAItem,]
}

if (input$SUAtimePointYears != "All"){
  sua = sua[sua$timePointYears %in% input$SUAtimePointYears,]
}


sua
})
}