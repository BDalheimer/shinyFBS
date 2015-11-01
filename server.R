shinyServer(function(input, output, session) {

  
  
  # selections filters for Browse Data Page
  output$tableData <- renderDataTable({ 
    
    if (input$dataGeographicArea != "All"){
      data <- data[data$geographicArea %in% input$dataGeographicArea,]
    }
    if (input$dataElement != "All"){
      data <- data[data$Element %in% input$dataElement,]
    }
    if (input$dataItem != "All"){
      data <- data[data$Item %in% input$dataItem,]
    }
    if (input$dataTimePointYears != "All"){
      data <- data[data$timePointYears %in% input$dataTimePointYears,]
    }
    
    data
  })
  
## Selection filter for SUA page
output$tableSUA <- renderDataTable({
  
  if (input$SUAgeographicArea != "All"){
    sua <- sua[sua$geographicArea %in% input$SUAgeographicArea,]
  }

  if (input$SUAItem != "All"){
    sua <- sua[sua$Item %in% input$SUAItem,]
  }

  if (input$SUAtimePointYears != "All"){
    sua <- sua[sua$timePointYears %in% input$SUAtimePointYears,]
  }
  
    
  sua
  
})



# Just some text output which depends on the coosen year, will be used in headers
for( x in suaElementNames) {local({
  i <- x
  output[[paste(i)]] <- renderText({paste(i ,input$FBSSUAyear)})
})
}


# input/output tables for SUA elemnts 
for(x in suaElementNames) {local({
  i <- x
  output[[paste("table",i, sep="")]] <- renderRHandsontable({
    rhandsontable(get(i)) %>%
      hot_cols(colWidths = 200) %>%
      hot_rows(rowHeights = 20) %>%
      hot_col("Commodity", readOnly = TRUE, colWidths = 600)
    
  })
})}

})
