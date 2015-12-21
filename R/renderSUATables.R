# This function renders all individual SUA tables. TO DO: Substitute for loop with apply

renderSUATables = function(input, output, session, individualSUATables) {
  
  for(x in suaElementTable[, Element]) {local({
    i = x
    output[[paste("table", i, sep="")]] = renderRHandsontable({
      
      rhandsontable(individualSUATables()[[i]], useTypes = T, rowHeaders = NULL, Strict = F, columnSorting = TRUE, selectCallback = TRUE) %>%
        hot_cols(colWidths = 100, format = "0") %>%
        hot_rows(rowHeights = 20) %>%
        hot_cols(fixedColumnsLeft = 2) %>%
        hot_col("Item", readOnly = TRUE, colWidths = 300)%>%
        hot_col("measuredItemCPC", readOnly = TRUE, colWidths = 70)%>%
        hot_table(highlightCol = TRUE, highlightRow = TRUE)
    })
  })
    
    
  }
  
}

  