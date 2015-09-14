
library(shiny)
library(data.table)
library(reshape2)
# Load data

data <- fread("data.csv")

data <- data[, .(geographicAreaM49, geographicArea, measuredItemCPC, Item, measuredElement, Element, timePointYears, 
               Year, Value, Status, Method)]

data <- data[data$timePointYears %in% 1500:3000,]

dataSUA <- data[, .(geographicArea, timePointYears, Item, Element, Value)]

## Create list with SUA Elements Trade Missing!!!
elementsSua <- c("Production [t]", "Seed [t]", "Loss [t]",  "Waste [t]", "Feed [t]", "Processed [t]", "Other Util [t]",
                 "Stocks [#]")

suaLong <- dataSUA[dataSUA$Element %in% elementsSua,]                 


## Convert data into wide format for SUA format: Prod Imp ... . Problem: there are duplicate elements (to examine further)
sua <- dcast.data.table(suaLong, geographicArea + timePointYears + Item ~ Element, value.var="Value")


shinyServer(function(input, output) {

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


})
