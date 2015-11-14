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
           
           fluidPage( 
           fluidRow(h1("Data Collection and Estimation for SUA")),
           
           tags$head(tags$script("
                        window.onload = function() {
                                 $('#suaNavlist a:contains(\"Production\")').parent().addClass('disabled');
                                 $('#suaNavlist a:contains(\"Trade\")').parent().addClass('disabled');
                                 $('#suaNavlist a:contains(\"Stocks\")').parent().addClass('disabled');
                                 $('#suaNavlist a:contains(\"Food\")').parent().addClass('disabled');
                                 $('#suaNavlist a:contains(\"Feed\")').parent().addClass('disabled');
                                 $('#suaNavlist a:contains(\"Seed\")').parent().addClass('disabled');
                                 $('#suaNavlist a:contains(\"Food Losses & Waste\")').parent().addClass('disabled');
                                 $('#suaNavlist a:contains(\"Industrial Use\")').parent().addClass('disabled');
                                 $('#suaNavlist a:contains(\"Tourist Consumption\")').parent().addClass('disabled');
                                 $('#suaNavlist a:contains(\"Save All\")').parent().addClass('disabled');
                                 $('#suaNavlist a:contains(\"Clear All\")').parent().addClass('disabled');
                                 };
                                 
                                 Shiny.addCustomMessageHandler('activeNavs', function(nav_label) {
                                 $('#suaNavlist a:contains(\"' + nav_label + '\")').parent().removeClass('disabled');
                                 });
                                 ")),
           tabsetPanel("FBS and SUA", selected = 'Start', id = "suaNavlist",
                       tabPanel("Start",
                                fluidRow(column(width = 10, h3("Please select Country and Year")
                                                ),
                                         column(width = 2, actionButton("startContinue", "Start Compilation!", align = 'center', styleclass = "success")
                                                )
                                         ),
                                tags$style(type='text/css', "#startContinue { width:100%; margin-top: 25px;}"),
                                br(),
                                fluidRow(
                                column(width = 3, selectInput("FBSSUAarea", 
                                                                      "Area:", 
                                                                      unique(sua$geographicArea)) 
                                ),
                                column(width = 3, selectInput("FBSSUAyear", 
                                                                       "Year:", 
                                                                       c(unique(sua$timePointYears[sua$timePointYears > 2012]), #we'll only create new FBS
                                                                         as.character(as.numeric(max(sua$timePointYears[sua$timePointYears > 2012]))+ 1))
                                                                        )
                                )#,
                                #column(width = 3,actionButton("startContinue", "Start Compilation!", align = 'center', styleclass = "success"))
                                )
                                ),
  
                       tabPanel("Production",
                       fluidRow(column(4, h1(textOutput("Production"))),
                                column(2, actionButton("productionEst","Estimate Data ", align = 'center', styleclass="primary", block=T)),
                                column(2, actionButton("productionSave", "Save Production Data", styleclass="primary",block =T)),         
                                column(2, actionButton("visualize", "Visualize", styleclass="primary",block =T)),
                                column(2, actionButton("upload", "Upload File", styleclass="primary",block =T))
                                ),
                       tags$style(type='text/css', "#productionEst { width:100%; margin-top: 25px;}"),
                       tags$style(type='text/css', "#productionSave { width:100%; margin-top: 25px;}"),
                       tags$style(type='text/css', "#visualize { width:100%; margin-top: 25px;}"),
                       tags$style(type='text/css', "#upload { width:100%; margin-top: 25px;}"), br(),
                       rHandsontableOutput("tableProduction")
                       ),
                       
                       tabPanel("Trade",
                                h3("Import and Export Data"), actionButton("tradeSave", "Save and Continue", styleclass = 'success')
                                
                       ),
                       
                       tabPanel("Stocks", 
                       fluidRow(h3(textOutput("Stocks")), actionButton("stocksSave", "Save and Continue", styleclass = 'success')),
                                rHandsontableOutput("tableStocks")
                       ),
                       
                       tabPanel("Food",
                                fluidRow(fluidRow(h3(textOutput("Food Use")), actionButton("foodSave", "Save and Continue", styleclass = 'success'))),
                                rHandsontableOutput("tableFood Use")
                                
                       ),
                       
                       tabPanel("Feed", 
                                fluidRow(h3(textOutput("Feed Use")), actionButton("feedSave", "Save and Continue", styleclass = 'success')),
                                rHandsontableOutput("tableFeed Use")
                       ),
                       
                       tabPanel("Seed", 
                                fluidRow(h3(textOutput("Seed")), actionButton("seedSave", "Save and Continue", styleclass = 'success')),
                                rHandsontableOutput("tableSeed")
                       ),
                       
                       tabPanel("Food Losses & Waste", 
                                fluidRow(h3(textOutput("Food Losses & Waste")), actionButton("flwSave", "Save and Continue", styleclass = 'success')),
                                rHandsontableOutput("tableFood Losses & Waste")
                       ),
                       
                       tabPanel("Industrial Use", 
                                fluidRow(h3(textOutput("Industrial Use")), actionButton("industrialSave", "Save and Continue", styleclass = 'success')),
                                rHandsontableOutput("tableIndustrial Use")
                       ),
                       
                       tabPanel("Tourist Consumption", 
                                fluidRow(h3(textOutput("tableTourist Consumption")), actionButton("touristSave", "Save and Continue", styleclass = 'success')),
                                rHandsontableOutput("tableTC")
                       ),
                       
                       tabPanel("Save All", actionButton("saveSave", "Save and Continue", styleclass = 'success')),
                       tabPanel("Clear All")
                       
                       
                                
                       
                       
                       
                       
                       )
                      
                       
                       
                       
         
  )),
  
  tabPanel(title= "Help"),
  ## Orangbook here
  
  tabPanel(title= "About")

 )
)

