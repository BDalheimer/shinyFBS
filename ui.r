shinyUI(
    
  #Title
  
 navbarPage("Food Balance Sheet Compiler",
    tabPanel(title ="Browse Data",
    
    # Browse Data Page: Selection area
    selectBrowseData$value,
    
    selectizeBrowseData$value, 
    
    fluidRow(column(4),
             column(2, checkboxInput("showFlags", "Show flags", TRUE)),
             column(2, checkboxInput("showCodes", "Show Codes", TRUE)),
             column(2, actionButton("browseLong", "Long Format", styleclass = "primary"))#, style = 'font-size:80%')),
             #column(2, downloadButton("exportBrowse", "Export csv"))
    #tags$style(type='text/css', "#browseLong { width:100%; margin-top: 25px; margin-bottom: 10px;}"),
    #tags$style(type='text/css', "#exportBrowse { width:100%; margin-top: 15px; margin-bottom: 15px;}")
    ),
   
    
    
    
    
    
    # Table Output.
    fluidRow(
      dataTableOutput(outputId = "tableData")
    ) 
  ),
  
  #Page for Visualization of data
  tabPanel(title= "Visualize"),
  
  # Page for SUA tables
  tabPanel(title= "SUA", "Supply and Utilization Accounts",
           browseSUA$value, 
           
           # Output SUA.
              fluidRow(
              dataTableOutput(outputId="tableSUA")
              )
  ),
  
  
  #Compiler Page
  tabPanel(title= "Compile SUA and FBS",
           
           fluidPage( 
           #fluidRow(h1("Data Collection and Estimation for SUA")),
           
           tags$head(tags$script(includeCSS("www/sequentiallyActiveTabs.css"))),
           
           tabsetPanel("FBS and SUA", selected = 'Start', id = "suaNavlist",
                       tabPanel("Start",
                                fluidRow(column(width = 10, h3("Please select Country and Year")
                                                ),
                                         column(width = 2, actionButton("startContinue", "Start Compilation!", align = 'center', styleclass = "success")
                                                )
                                         ),
                                tags$style(type='text/css', "#startContinue { width:100%; margin-top: 15px; margin-bottom: 15px;}"),
                                br(),
                                fluidRow(
                                column(width = 3, selectInput("FBSSUAarea", 
                                                                      "Area:", 
                                                                      unique(data$geographicArea), selected = unique(data$geographicArea)[1]) 
                                ),
                                column(width = 3, selectInput("FBSSUAyear", 
                                                                       "Year:", 
                                                                       c(unique(sua$timePointYears[sua$timePointYears > 2012]), #we'll only create new FBS
                                                                         as.character(as.numeric(max(sua$timePointYears[sua$timePointYears > 2012]))+ 1))
                                                                        )
                                ) )
                                ),
                       
                       tabPanel("Production",
                       fluidRow(column(4, h3(textOutput("Production"))),
                                column(2, actionButton("productionEst","Estimate Data ", align = 'center', styleclass="primary", block=T)),
                                column(2, actionButton("upload", "Upload File", styleclass="warning",block =T)),       
                                column(2, actionButton("visualize", "Visualize", styleclass="danger",block =T)),
                                column(2, actionButton("productionSave", "Save Production Data", styleclass="success",block =T)) 
                                ),
                       tags$style(type='text/css', "#productionEst { width:100%; margin-top: 15px; margin-bottom: 15px;}"),
                       tags$style(type='text/css', "#upload { width:100%; margin-top: 15px; margin-bottom: 15px;}"),
                       tags$style(type='text/css', "#visualize { width:100%; margin-top: 15px; margin-bottom: 15px;}"),
                       tags$style(type='text/css', "#productionSave { width:100%; margin-top: 15px; margin-bottom: 15px;}"),
                       rHandsontableOutput("tableProduction")
                       ),
                       
                       tabPanel("Trade",
                                fluidRow(column(width = 10, h3("Import and Export Data")), 
                                         column(width = 2, actionButton("tradeSave", "Save and Continue", styleclass = 'success'))
                                ), tags$style(type='text/css', "#tradeSave { width:100%; margin-top: 15px; margin-bottom: 15px;}")
                                
                       ),
                       
                       tabPanel("Stocks", 
                                fluidRow(column(width = 10, h3(textOutput("Stocks"))), 
                                         column(width = 2, actionButton("stocksSave", "Save and Continue", styleclass = 'success'))
                                         ), tags$style(type='text/css', "#stocksSave { width:100%; margin-top: 15px; margin-bottom: 15px}"),
                                  
                                rHandsontableOutput("tableStocks")
                       ),
                       
                       tabPanel("Food",
                                fluidRow(column(width = 10, h3(textOutput("Food Use"))), 
                                         column(width = 2,actionButton("foodSave", "Save and Continue", styleclass = 'success'))
                                         ), tags$style(type='text/css', "#foodSave { width:100%; margin-top: 15px; margin-bottom: 15px}"),
                                rHandsontableOutput("tableFood Use")
                                
                       ),
                       
                       tabPanel("Feed", 
                                fluidRow(column(width = 10, h3(textOutput("Feed Use"))), 
                                         column(width = 2, actionButton("feedSave", "Save and Continue", styleclass = 'success'))
                                         ), tags$style(type='text/css', "#feedSave { width:100%; margin-top: 15px; margin-bottom: 15px}"),
                                rHandsontableOutput("tableFeed Use")
                       ),
                       
                       tabPanel("Seed", 
                                fluidRow(column(width = 10, h3(textOutput("Seed"))), 
                                         column(width = 2, actionButton("seedSave", "Save and Continue", styleclass = 'success'))
                                         ), tags$style(type='text/css', "#seedSave { width:100%; margin-top: 15px; margin-bottom: 15px}"),
                                rHandsontableOutput("tableSeed")
                       ),
                       
                       tabPanel("Food Losses & Waste", 
                                fluidRow(column(width = 10, h3(textOutput("Food Losses & Waste"))), 
                                         column(width = 2, actionButton("flwSave", "Save and Continue", styleclass = 'success'))
                                         ), tags$style(type='text/css', "#flwSave { width:100%; margin-top: 15px; margin-bottom: 15px}"),
                                rHandsontableOutput("tableFood Losses & Waste")
                       ),
                       
                       tabPanel("Industrial Use", 
                                fluidRow(column(width = 10, h3(textOutput("Industrial Use"))), 
                                         column(width = 2, actionButton("industrialSave", "Save and Continue", styleclass = 'success'))
                                         ), tags$style(type='text/css', "#industrialSave { width:100%; margin-top: 15px; margin-bottom: 15px}"),
                                rHandsontableOutput("tableIndustrial Use")
                       ),
                       
                       tabPanel("Tourist Consumption", 
                                fluidRow(column(width = 10, h3("Tourist Consumption")), 
                                         column(width = 2, actionButton("touristSave", "Save and Continue", styleclass = 'success'))
                                         ), tags$style(type='text/css', "#touristSave { width:100%; margin-top: 15px; margin-bottom: 15px;}"),
                                rHandsontableOutput("tableTourist Consumption")
                       ),
                       
                       tabPanel("Residual Other Uses",
                                fluidRow(column(width = 10, h3("Residual Other Uses")), 
                                         column(width = 2, actionButton("residualSave", "Save and Continue", styleclass = 'success'))
                                ), tags$style(type='text/css', "#residualSave { width:100%; margin-top: 15px; margin-bottom: 15px;}"),
                                rHandsontableOutput("tableResidual Other Uses")
                                ),
                       
                       tabPanel("Save All", actionButton("saveSave", "Save and Continue", styleclass = 'success'))
                      
                       
                       
                                
                       
                       
                       
                       
                       )
                      
                       
                       
                       
         
  )),
  
  tabPanel(title= "Help"),
  ## Orangbook here
  
  tabPanel(title= "About")

 )
)

