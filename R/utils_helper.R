
# Download Excel (custom) -------------------------------------------------------

#' Custom Write Excel 
#'
#' 
#'
#' @param list_df list of data.frame to write
#' @param file_name A character indicate file name
#'
#' @export
#'
write_custom.xlsx <- function(list_df, file_name){
  
  
  # Create Header Style
  head_style <- openxlsx::createStyle(textDecoration = "bold", 
                                      halign = "center", valign = "center", 
                                      fgFill = "#d9ead3")
  
  wb <- openxlsx::write.xlsx(list_df, file_name, 
                             headerStyle = head_style)
  
  
  openxlsx::saveWorkbook(wb,  file_name, overwrite = T)
  
}
