# shiny upload file app

library(shiny)

# define ui for data upload app
ui<-fluidPage(
  
  # app title
  titlePanel('Uploading Files'),


  #sidebar layout with input and output definitions
  sidebarLayout(
    
    #sidebar pannel for inputs
    sidebarPanel(
    
      #input:select a file
      fileInput('file1', 'Choose CSV File',
                multiple = F,
                accept = c('text/csv',
                           'text/comma-separated-values, text/plain',
                           '.csv')),
      
      # horizontal line
      tags$hr(),
      
      # input : checkbox if file has header
      checkboxInput('header', 'Header', T),
      
      # input: select separator
      radioButtons('sep', 'Separator',
                   choices=c(Comma=',',
                             Semicolon=';',
                             Tab='\t'),
                   selected=','),
      
      # input : select quotes
      radioButtons('quote', 'Quote',
                   choices = c(None='',
                               'Double Quote'='"',
                               'Single Quote'="'"),
                   selected='"'),
      
      # horizontal line
      tags$hr(),
      
      # input: select number of rows to display
      radioButtons('disp', 'Display',
                   choices=c(Head='head',
                             All='all'),
                   selected='head')
    ),
    
    # main panel for displaying outputs
    mainPanel(
      
      # output : data file
      tableOutput('contents')
    )
  )
)

# define server logic to read selected file
server<-function(input, output){
  output$contents<-renderTable({
    
    # input$file1 will be Null initially. After the user selects
    # and uploads a file, head of that data file by default,
    # or all rows if selected, will be shown.
    
    req(input$file1)
    
    # when reading semicolon separated files,
    # having a comma separator causes 'read.csv' to error
    tryCatch(
      {
        df<-read.csv(input$file1$datapath,
                     header=input$header,
                     sep=input$sep,
                     quote=input$quote)
        
      },
      
      error=function(e){
        # return a safeError if a parsing error occurs
        stop(safeError(e))
        
      }
    )
    if(input$disp=='head'){
      return(head(df))
    }
    else{
      return(df)
    }
  })
}

# create shiny app
shinyApp(ui, server)