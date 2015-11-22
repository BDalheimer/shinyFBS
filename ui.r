shinyUI(
    
  #Title
  
 navbarPage("Food Balance Sheet Compiler",
    tabPanel(title ="Browse Data",
    
    
       selectBrowseData(),# selection filters
       selectizeBrowseData(), # selection filters
       browseTableButtons() # output table and buttons
    
    ),
  
  #Page for Visualization of data
  tabPanel(title= "Visualize"),
  
  # Page for SUA tables
  tabPanel(title= "SUA", "Supply and Utilization Accounts",
           browseSUA() 
  ),

  #Compiler Pages
  tabPanel(title= "Compile SUA and FBS",
           sequenceSUAFBS()
  ),
  
  tabPanel(title= "Help"),
  ## Orangbook here
  
  tabPanel(title= "About")

 )
)

