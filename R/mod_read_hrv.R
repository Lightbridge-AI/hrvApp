#' read_hrv UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_read_hrv_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' read_hrv Server Functions
#'
#' @noRd 
mod_read_hrv_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_read_hrv_ui("read_hrv_ui_1")
    
## To be copied in the server
# mod_read_hrv_server("read_hrv_ui_1")
