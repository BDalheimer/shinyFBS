library(shiny)
library(reshape2)
library(data.table)
library(rhandsontable)


## TODO (marcogarieri): There is no need to reload the data
##                      I commented it, and it still runs 

## bernhard: Are you sure? It doesn't work on my end... I don't like it like this either, takes twice as long. I will
##           dig into passing sessions in the server output.

# load the data 
#data <- fread("testData.csv")
#data <- data[, .(geographicAreaM49, geographicArea, measuredItemCPC, Item, measuredElement, Element, timePointYears, 
#             Year, Value, Status, Method)]

#dataSUA <- data[, .(geographicArea, timePointYears, Item, Element, Value)]
## Create list with SUA Elements Trade Missing!!!
#elementsSua <- c("Production [t]", "Seed [t]", "Loss [t]",  "Waste [t]", "Feed [t]", "Processed [t]", "Other Util [t]",
#                 "Stocks [#]")
#suaLong <- dataSUA[dataSUA$Element %in% elementsSua,] 

#sua <- dcast.data.table(suaLong, geographicArea + timePointYears + Item ~ Element, value.var="Value")



# empty data sets for the modules



# Create the interface
shinyUI(
    #fileInput('data')

  #Title  
 navbarPage("Food Balance Sheet Compiler",
    tabPanel(title ="Browse Data",
      
    
    # Browse Data Page: Selection area
    fluidRow(
      column(3, 
             selectInput("dataGeographicArea", 
                         "Geographic Area:", 
                         c("All", 
                           unique(as.character(data$geographicArea))), multiple=T, selectize=F)
      ),
      column(3, 
             selectInput("dataElement", 
                         "Element:", 
                         c("All", 
                           unique(as.character(data$Element))), multiple=T, selectize=F)
      ),
      column(3, 
             selectInput("dataItem", 
                         "Item:", 
                         c("All", 
                           unique(as.character(data$Item))), multiple=T, selectize=F)
      ),
      
    column(3, 
           selectInput("dataTimePointYears", 
                       "Years:", 
                       c("All", 
                         unique(as.character(data$timePointYears))), multiple=T, selectize=F)
    )   
      
      
    ),
    # Table Output.
    fluidRow(
      dataTableOutput(outputId="tableData")
    ) 
  ),
  
  #Page for Visualization of data
  tabPanel(title= "Visualize"),
  
  # Page for SUA tables
  tabPanel(title= "SUA", "Supply and Utilization Accounts",
           fluidRow(
             column(3, 
                    selectInput("SUAgeographicArea", 
                                "Geographic Area:", 
                                c("All", 
                                  unique(as.character(sua$geographicArea))), multiple=T, selectize=F)
             ),
             column(3, 
                    selectInput("SUAItem", 
                                "Item:", 
                                c("All", 
                                  unique(as.character(sua$Item))), multiple=T, selectize=F)
             ),
             
             column(3, 
                    selectInput("SUAtimePointYears", 
                                "Years:", 
                                c("All", 
                                  unique(as.character(sua$timePointYears))), multiple=T, selectize=F)
             )
           ), # Output SUA.
              fluidRow(
              dataTableOutput(outputId="tableSUA")
           )
           
           
           ),
  
  
  #Compiler Page
  tabPanel(title= "Compile SUA and FBS",
           fluidRow(column(width = 3,selectInput("FBSSUAyear", 
                                                 "Year:", 
          c(unique(sua$timePointYears[sua$timePointYears > 2012]), #we'll only create new FBS
          as.character(as.numeric(max(sua$timePointYears[sua$timePointYears > 2012]))+ 1))
           ), widths = c(4,1)), column(width = 9, h1("Data Collection and Estimation for SUA"))), 
           #navlistPanel(widths = c(3,8), 
           tabsetPanel("Production",
                       tabPanel("Production",
                                h3(textOutput("Production")),
                                rHandsontableOutput("tableProduction")
                       ),
                       
                       tabPanel("Trade",
                                h3("Import and Export Data")
                                
                       ),
                       
                       tabPanel("Stocks",
                                h3(textOutput("Stocks")),
                                rHandsontableOutput("tableStocks")
                       ),
                       
                       tabPanel("Food",
                                h3(textOutput("Food Use")),
                                rHandsontableOutput("tableFood Use")
                                
                       ),
                       
                       tabPanel("Feed",
                                h3(textOutput("Feed Use")),
                                rHandsontableOutput("tableFeed Use")
                       ),
                       
                       tabPanel("Seed",
                                h3(textOutput("Seed")),
                                rHandsontableOutput("tableSeed")
                       ),
                       
                       tabPanel("Food Losses & Waste",
                                h3(textOutput("Food Losses & Waste")),
                                rHandsontableOutput("tableFood Losses & Waste")
                       ),
                       
                       tabPanel("Industrial Use",
                                h3(textOutput("Industrial Use")),
                                rHandsontableOutput("tableIndustrial Use")
                       ),
                       
                       tabPanel("Tourist Consumption",
                                h3(textOutput("tableTourist Consumption")),
                                rHandsontableOutput("tableTC")
                       ) )
                      
                       
                       
                       
         
  ),
  
  tabPanel(title= "Help"),
  ## Orangbook here
  
  tabPanel(title= "About")

 )
)

