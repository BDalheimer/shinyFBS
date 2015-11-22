# This function provides an ui page to browse SUAs

browseSUA = function(){

  tagList(
fluidRow(
  
  # Create selection filters for SUA tables
  column(3, 
         selectInput("SUAgeographicArea", 
                     "Geographic Area:", 
                     c("All", 
                       unique(as.character(sua$geographicArea))), multiple=F, selectize=F)
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
                       unique(as.character(sua$timePointYears))), multiple=F, selectize=F)
  )
),
# Output Sua table
fluidRow(
  dataTableOutput(outputId="tableSUA")
)
)
}