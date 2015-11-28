# This function provides a second input option for the browse data page

SUAPlot = function(input, output, session, selectedSUAtable){
  
  suaPlotData = cbind(id.var = c("id.var"), selectedSUAtable()) 
  suaPlotMelted = melt(suaPlotData, id.vars = "id.var")
  
  plot = ggplot(suaPlotMelted, aes(x = variable, y = value, fill = variable)) +
    geom_bar(stat = "identity") + 
    theme(legend.position='none') +
    scale_fill_brewer(palette="Set1") +
    xlab("") + ylab("")
  
  print(plot)
  
}