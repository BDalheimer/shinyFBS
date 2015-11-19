renderSUATables = function(input, output, session,individualSUATables) {
  
  for(x in suaElementTable[, Element]) {local({
    i = x
    output[[paste("table", i, sep="")]] = renderRHandsontable({
      rhandsontable(individualSUATables()[[i]], useTypes = F, rowHeaders = NULL) %>%
        hot_cols(colWidths = 100) %>%
        hot_rows(rowHeights = 20) %>%
        hot_cols(fixedColumnsLeft = 2) %>%
        hot_col("Item", readOnly = TRUE, colWidths = 300)%>%
        hot_col("measuredItemCPC", readOnly = TRUE, colWidths = 70)%>%
        hot_table(highlightCol = TRUE, highlightRow = TRUE)
    })
  })
  }
  
}

  