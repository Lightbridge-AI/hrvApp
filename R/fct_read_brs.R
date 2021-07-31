### Function BRS

# Read multi-BRS ----------------------------------------------------------


read_multi_brs_report_data <- function(file_name,file_path){
  
  df <- tibble::tibble(ext = tools::file_ext(file_name), path = file_path)
  
  read <- function(ext,path){  
    
    switch(ext,
           txt = read_BRS_report_data(path),
           validate("Invalid file; Please upload a .txt file")
    )
  }
  
  data_ls <- df %>% purrr::pmap(read)
  
  names(data_ls) <- stringr::str_remove(file_name,"\\.[^\\.]+$") #remove .xxx (content after last dot)
  
  data_ls
  
}



read_multi_brs_report_meta <- function(file_name,file_path){
  
  df <- tibble::tibble(ext = tools::file_ext(file_name), path = file_path)
  
  read <- function(ext,path){  
    
    switch(ext,
           txt = read_BRS_report_meta(path),
           validate("Invalid file; Please upload a .txt file")
    )
  }
  
  data_ls <- df %>% purrr::pmap(read)
  
  names(data_ls) <- stringr::str_remove(file_name,"\\.[^\\.]+$") #remove .xxx (content after last dot)
  
  data_ls
  
}

# Read BRS Actual Report Data --------------------------------------------------------

read_BRS_report_data <- function(path) {
  
  readr::read_csv2(path, skip = 8)
  
}

# Read BRS Metadata  ----------------------------------------------------------


read_BRS_report_meta <- function(path) {
  
  
  raw_txt <- readtext::readtext(path, encoding = "UTF-8") %>% dplyr::pull(text) 
  
  ## Extract Program name
  prog_nm <- stringr::str_extract(raw_txt, "^BeatScope Easy.+")
  
  ## Extract Reconstructed pressure lv
  p_lv <- stringr::str_extract(raw_txt, "(?<=Reconstructed pressure level: \\n).+")
  
  ## Read Demographic data in line 3
  demo_df <- readr::read_csv2(path, skip = 2, n_max = 1)
  
  tibble::tibble(Program = prog_nm, 
                 Pressure_lv_recon = p_lv) %>% 
    dplyr::bind_cols(demo_df)
  
  
}


