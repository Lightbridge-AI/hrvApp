# Mod: UI - BRS ------------------------------------------------------------


#' read_brs UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_read_brs_ui <- function(id){
  ns <- NS(id)
  
    tabPanel("BeatScope Easy's BRS",
             
             h3("About"),
             tags$blockquote("This application combine BeatScope Easy's BRS Report file(s) — Beats, Waveforms, BRS — from .txt to single Excel file (one row per subject)."),
             
             helpText("For more details click: ",
                      tags$a(href = "https://docs.google.com/document/d/1BxbSswwprWD7XnMw1pWlaaNgB_brRmWAnfAYF0nUkI8/edit?usp=sharing", "Here")),
             
             
             h3("Guides"),
             
             fluidRow(
               column(6,
                      helpText("1. Upload BRS report file in .txt — multiple files allowed, but should be the same type."),
                      helpText(" (e.g., upload multiple Beats' files together)"),
                      
                      fileInput(ns("file_2"), NULL, accept = c(".txt"),buttonLabel = "Upload files",
                                placeholder = "choose BRS Report .txt",multiple = TRUE)
               ),
               
               column(6,
                      helpText("2. Download combined Excel file"),
                      downloadButton(ns("download_2"), "Download BRS Report .xlsx"),
                      helpText("(The uploaded file name will be included in column \"File_name\".)")
                      
               )
               
             ),
             
             h4("Example: BRS Report file"),
             tags$img(src = "www/BRS_rep.png", height = img_size_2[2], width = img_size_2[1]),
             
             
             h3("Combined BRS Report"),
             br(),
             dataTableOutput(ns("table_brs_data")),
             
             h3("Combined BRS Report Metadata"),
             br(),
             dataTableOutput(ns("table_brs_meta"))
             
             #verbatimTextOutput("raw")
    )
 
  
}
    
# Mod: Server - BRS ------------------------------------------------------------

#' read_brs Server Functions
#'
#' @noRd 
mod_read_brs_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    
    ### Actual Data of BRS 
    report_brs_data_df <- reactive({
      
      req(input$file_2)
      read_multi_brs_report_data(file_name = input$file_2$name, 
                                 file_path = input$file_2$datapath) %>% 
       dplyr::bind_rows(.id = "File_name")
      
    })
    
    ### Display Actual Data of BRS 
    output$table_brs_data <- renderDataTable({
      
      report_brs_data_df()
      
    }, options = list(lengthMenu = c(5,10,20,50), pageLength = 5))
    
    
    ### Metadata of BRS
    report_brs_meta_df <- reactive({
      
      req(input$file_2)
      read_multi_brs_report_meta(file_name = input$file_2$name, 
                                 file_path = input$file_2$datapath) %>% 
       dplyr::bind_rows(.id = "File_name")
      
    })
    
    ### Display Metadata of BRS 
    output$table_brs_meta <- renderDataTable({
      
      report_brs_meta_df()
      
    }, options = list(lengthMenu = c(5,10,20,50), pageLength = 5))
    
    output$raw <- renderPrint({  report_brs_meta_df() })
    
    
    ### Download BRS
    output$download_2 <- downloadHandler(
      
      filename = function() {
        paste0("BRS_report",".xlsx") #remove .xxx
      },
      content = function(file) {
        
        
        write_custom.xlsx(list(BRS_Report = report_brs_data_df(),
                               Metadata = report_brs_meta_df()),
                          file_name = file)
      }
    )
    
    
  })
}
    

