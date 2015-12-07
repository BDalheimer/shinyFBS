# This function checks wether the packages required for the shiny app are installed and apllies either require or 
# install.packages from both Cran and GitHub

packageRequirevInstall = function(){
  
  packagesCran = c("shiny", "data.table", "shinyBS", "devtools", "ggplot2")
  
  if (length(setdiff(packagesCran, rownames(installed.packages()))) > 0) {
    install.packages(setdiff(packagesCran, rownames(installed.packages())))  
  }
  lapply(packagesCran, require, character.only = T)
  
  packagesGitHub = data.table(package = c("shinysky", "rhandsontable"), 
                              path = c("AnalytixWare/ShinySky", "jrowen/rhandsontable"))
  
 # temporary bug fix. there's probably a more elegant way to do this
 # if (length(setdiff(packagesGitHub[, package], rownames(installed.packages()))) > 0) {
    devtools::install_github(packagesGitHub[!package  %in% rownames(installed.packages()), path])  
  #}
  
  lapply(packagesGitHub[, package], require, character.only = T)
}