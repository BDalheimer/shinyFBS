library(shiny)
library(reshape2)
library(data.table)



## TODO (marcogarieri): There is no need to reload the data
##                      I commented it, and it still runs 

# load the data 
#data <- fread("data.csv")
#data <- data[, .(geographicAreaM49, geographicArea, measuredItemCPC, Item, measuredElement, Element, timePointYears, 
#               Year, Value, Status, Method)]
## apparently there is some mess in the years. This command should not be necessary
#data <- data[data$timePointYears %in% 1500:3000,]
#dataSUA <- data[, .(geographicArea, timePointYears, Item, Element, Value)]
## Create list with SUA Elements Trade Missing!!!
#elementsSua <- c("Production [t]", "Seed [t]", "Loss [t]",  "Waste [t]", "Feed [t]", "Processed [t]", "Other Util [t]",
#                 "Stocks [#]")
#suaLong <- dataSUA[dataSUA$Element %in% elementsSua,]                 
#sua <- dcast(suaLong, geographicArea + timePointYears + Item ~ Element, value.var="Value")

# Create the interface
shinyUI(


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
  
  
  #FBS page
  tabPanel(title= "FBS")
  
 )
)

