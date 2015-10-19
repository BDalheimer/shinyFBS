library(shiny)
library(reshape2)
library(data.table)



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

suaElementNames <- c("Production", "Import", "Export", "Stocks", "Feed", "Food", "Seed", "FLW", "TC", "Industrial Use")

# empty data sets for the modules

emptyData <- data.frame(Commodity = unique(data$Item), ExpectedValue = rep(0, length(unique(data$Item))),
                        UpperBound = rep(0, length(unique(data$Item))), 
                        LowerBound = rep(0, length(unique(data$Item))),
                        stringsAsFactors = FALSE, row.names = unique(data$measuredItemCPC))


for(i in suaElementNames){
    assign(paste0(i), emptyData)
    
}

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
  
  
  #Compiler Page
  tabPanel(title= "Compile SUA and FBS",
           shinyUI(fluidPage(
                 navlistPanel("",
                       tabPanel("Production",
                            h3("Production Data & Estimation"),
                            
                            rhandsontable(Production) %>%
                              hot_cols(colWidths = 100) %>%
                              hot_rows(rowHeights = 20) %>%
                              hot_col("Commodity", readOnly = TRUE, colWidths = 400)# %>%
                              #hot_col(row.names, colWidths = 80)
                              #hot_context_menu(allowRowEdit = FALSE, allowColEdit = FALSE)
                            
                            
                       ),
                       
                       tabPanel("Trade",
                            h3("Import and Export Data"),
                            rhandsontable(Production) %>%
                              hot_cols(colWidths = 100) %>%
                              hot_rows(rowHeights = 20) %>%
                              hot_col("Commodity", readOnly = TRUE, colWidths = 400)
                              #hot_context_menu(allowRowEdit = FALSE, allowColEdit = FALSE)
                       ),
                       
                       tabPanel("Stocks",
                            h3("Stocks Data & Estimation"),
                            rhandsontable(Stocks) %>%
                              hot_cols(colWidths = 100) %>%
                              hot_rows(rowHeights = 20) %>%
                              hot_col("Commodity", readOnly = TRUE, colWidths = 400)
                              #hot_context_menu(allowRowEdit = FALSE, allowColEdit = FALSE)
                       ),
                       
                       tabPanel("Food",
                                h3("Food Data & Estimation"),
                                rhandsontable(Food) %>%
                                  hot_cols(colWidths = 100) %>%
                                  hot_rows(rowHeights = 20) %>%
                                  hot_col("Commodity", readOnly = TRUE, colWidths = 400)
                                  #hot_context_menu(allowRowEdit = FALSE, allowColEdit = FALSE)
                                
                       ),
                       
                       tabPanel("Feed",
                                h3("Feed Data & Estimation"),
                                rhandsontable(Feed) %>%
                                  hot_cols(colWidths = 100) %>%
                                  hot_rows(rowHeights = 20) %>%
                                  hot_col("Commodity", readOnly = TRUE, colWidths = 400)
                                  #hot_context_menu(allowRowEdit = FALSE, allowColEdit = FALSE)
                       ),
                       
                       tabPanel("Seed",
                                h3("Seed Data & Estimation"),
                                rhandsontable(Seed) %>%
                                  hot_cols(colWidths = 100) %>%
                                  hot_rows(rowHeights = 20) %>%
                                  hot_col("Commodity", readOnly = TRUE, colWidths = 400)
                                  #hot_context_menu(allowRowEdit = FALSE, allowColEdit = FALSE)
                       ),
                       
                       tabPanel("Food Losses and Waste",
                                h3("Food Losses and Waste Data & Estimation"),
                                rhandsontable(FLW) %>%
                                  hot_cols(colWidths = 100) %>%
                                  hot_rows(rowHeights = 20) %>%
                                  hot_col("Commodity", readOnly = TRUE, colWidths = 400)
                                  #hot_context_menu(allowRowEdit = FALSE, allowColEdit = FALSE)
                       ),
                       
                       tabPanel("Industrial Use",
                                h3("Industrial Use & Estimation"),
                                rhandsontable(`Industrial Use`) %>%
                                  hot_cols(colWidths = 100) %>%
                                  hot_rows(rowHeights = 20) %>%
                                  hot_col("Commodity", readOnly = TRUE, colWidths = 400)
                                  #hot_context_menu(allowRowEdit = FALSE, allowColEdit = FALSE)
                       ),
                       
                       tabPanel("Tourist Consumption",
                                h3("Tourist Consumption & Estimation"),
                                rhandsontable(TC) %>%
                                  hot_cols(colWidths = 100) %>%
                                  hot_rows(rowHeights = 20) %>%
                                  hot_col("Commodity", readOnly = TRUE, colWidths = 400)
                                  #hot_context_menu(allowRowEdit = FALSE, allowColEdit = FALSE)
                       )
                       
                       
                )
            )     )
  ),
  
  tabPanel(title= "Help"),
  
  tabPanel(title= "About")

 )
)

