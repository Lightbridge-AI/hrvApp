
img_size <- (c(1480, 400)/2 )

img_size_2 <- (c(1836, 626)/2.5)

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
    navbarPage("Combine HRV & BRS Report file", 
                     
                     tabPanel("LabChart's HRV",
                              h3("About"),
                              tags$blockquote("This application combine LabChart's HRV Report file(s) from .txt to single Excel table (one row per subject)."),
                              
                              helpText("For more details click: ",
                                       tags$a(href = "https://docs.google.com/document/d/1BxbSswwprWD7XnMw1pWlaaNgB_brRmWAnfAYF0nUkI8/edit?usp=sharing", "Here")),
                              
                              
                              br(),
                              h3("Guides"),
                              
                              fluidRow(
                                column(6,
                                       helpText("1. Upload HRV report file in .txt (multiple files allowed)"),
                                       fileInput(ns("file"), NULL, accept = c(".txt"),buttonLabel = "Upload files",
                                                 placeholder = "choose HRV report .txt",multiple = TRUE)
                                ),
                                
                                column(6,
                                       helpText("2. Download combined Excel file"),
                                       downloadButton(ns("download"), "Download HRV Report .xlsx"),
                                       helpText("(The uploaded file name will be included in column \"File_name\".)")
                                       
                                )
                                
                              ),
                              
                              
                              
                              
                              h4("Example: HRV Report file"),
                              tags$img(src = "www/HRV_rep.png", height = img_size[2], width = img_size[1]),
                              
                              
                              hr(),
                              h3("Combined HRV Report"),
                              dataTableOutput(ns("table")),
                              
                              
                     )
                     
                     
    )
  )
}
    
#' read_hrv Server Functions
#'
#' @noRd 
mod_read_hrv_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    # Server - HRV ------------------------------------------------------------
    
    
    report_df <- reactive({

      req(input$file)
      read_multi_hrv(file_name = input$file$name, file_path = input$file$datapath)

    })

    
    output$download <- downloadHandler(
      
      filename = function() {
        paste0("HRV_report",".xlsx") #remove .xxx
      },
      content = function(file) {
        
        
        write_custom.xlsx(list(Report = report_df(),
                               Descriptions = physiolab::HRV_report_vars
                               ),
                          file_name = file)
      }
    )
    
    output$table <- renderDataTable({
      
      report_df()
      
    }, options = list(lengthMenu = c(5,10,20,50), pageLength = 5))
    
    
    
 
  })
}

