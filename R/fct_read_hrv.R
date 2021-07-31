### Read HRV wrapper


# Read Multiple HRV for Shiny --------------------------------------------------------------------

#' Read Multiple HRV report for Shiny
#'
#' @param file_name Character vector of file name
#' @param file_path Character vector of file path
#'
#' @return A data.frame
#' @export
#'
read_multi_hrv <- function(file_name, file_path){
  
  df <- tibble::tibble(ext = tools::file_ext(file_name), path = file_path)
  
  read <- function(ext,path){  
    
    switch(ext,
           txt = physiolab::read_HRV_report(path, format_cols = TRUE), 
           validate("Invalid file; Please upload a .txt file")
    )
  }
  
  data_ls <- df %>% purrr::pmap(read)
  
  names(data_ls) <- stringr::str_remove(file_name,"\\.[^\\.]+$") #remove .xxx (content after last dot)
  
  # Bind to Data Frame
  data_ls %>% 
    dplyr::bind_rows(.id = "File_name") %>%
    dplyr::select(-doc_id, -text)
  
}
