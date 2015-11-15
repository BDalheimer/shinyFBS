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
)