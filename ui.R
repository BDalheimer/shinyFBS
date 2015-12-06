shinyUI(
    
  #Title
  
 navbarPage("Food Balance Sheet Compiler",
    tabPanel(title ="Browse Data",
    
      fluidPage(
       selectBrowseData()# selection filters
       #selectizeBrowseData() # selection filters
       #browseTableButtons() # output table and buttons
    
    )),
  
  #Page for Visualization of data
  tabPanel(title= "Visualize", h5("Under Construction")),
  
  
  # Page for SUA tables
  tabPanel(title= "SUA", "",
           browseSUA() 
  ),

  #Compiler Pages
  tabPanel(title= "Compile SUA and FBS",
           sequenceSUAFBS()
  ),
  
  tabPanel(title= "Help", h5("Under Construction")),
  ## Orangbook here
  
  tabPanel(title= "About", h5("Under Construction"))

 )
)

