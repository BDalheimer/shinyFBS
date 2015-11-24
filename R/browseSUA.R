# This function provides an ui page to browse SUAs

browseSUA = function(){

  tagList(

  fluidRow(
    
  
  
  # Create selection filters for SUA tables
         column(3,
         selectizeInput("SUAgeographicArea", 
                     "Geographic Area:", 
                      c("", unique(as.character(sua$geographicArea))), multiple=F, selected = NULL)),
         column(2, 
         selectizeInput("SUAtimePointYears", 
                     "Year:", 
                       c("", unique(as.character(sua$timePointYears))), multiple=F, selected = NULL)),
         

         column(3,
         selectizeInput("SUAItem", 
                     "Item:", 
                       c("", unique(as.character(sua$Item))), multiple=F, selected = NULL))
  ),
  
  
  

# Output Sua table
fluidPage(h3("Supply and Utilization Accounts:"), h4(textOutput("suaTitle")),
  fluidRow(tableOutput(outputId="tableSUA")),
  fluidRow(plotOutput("suaPlot"))
)
)


}