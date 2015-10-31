library(shiny)
library(data.table)
library(reshape2)
library(rhandsontable)

# Load data

data <- fread("Data/testData.csv")

## TODO (marcogarieri): Is this line of code needed? 
##                      Anyway geographicArea is not present, but Geographic Area.
##                      Do you prefer to modify the data.csv or the code?
## bernhard:            I don't understand the comment.

data <- data[, .(geographicAreaM49, geographicArea, measuredItemCPC, Item, 
                 measuredElement, Element, timePointYears, Year, Value, Status, Method)]


## Same problem as before
dataSUA <- data[, .(geographicArea, timePointYears, Item, Element, Value)]

## Create list with SUA Elements Trade Missing!!!
elementsSua <- c("Production [t]", "Seed [t]", "Loss [t]",  "Waste [t]", "Feed [t]", "Processed [t]", "Other Util [t]",
                 "Stocks [#]")

suaLong <- dataSUA[dataSUA$Element %in% elementsSua,]                 


## Convert data into wide format for SUA format: Prod Imp ... . Problem: there are duplicate elements (to examine further)
## Couldn't find the duplicate elements. Also, the data is incomplete. I started working with a subset of only one country 
sua <- dcast.data.table(suaLong, geographicArea + timePointYears + Item ~ Element, value.var="Value")

suaElementNames <- c("Production", "Import", "Export", "Stocks", "Feed Use", "Food Use", "Seed", "Food Losses & Waste", 
                     "Tourist Consumption", "Industrial Use")

## create empty datasets for each sua element, which will be filled by user or R module
emptyData <- data.frame(Commodity = unique(data$Item), ExpectedValue = rep(0, length(unique(data$Item))),
                        UpperBound = rep(0, length(unique(data$Item))), 
                        LowerBound = rep(0, length(unique(data$Item))),
                        stringsAsFactors = FALSE, row.names = unique(data$measuredItemCPC))


for(i in suaElementNames){
  (assign(paste0(i), emptyData))
  
}

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
