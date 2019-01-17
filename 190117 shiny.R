library(shiny)
ui <-fluidPage(
  titlePanel('Shiny Text'),
  sidebarLayout(
    sidebarPanel(
      #선택해주는 어떤 입력 패널
      selectInput(inputId = 'datasetId',
                  label = '데이터 셋 선택:',
                  choices=c('rock', 'pressure', 'cars')),
      
      #값을 입력하는 어떤 패널
      numericInput(inputId = 'obsId',
                   label='관측치의 수',
                   value=10)
      
    ),
    mainPanel(
      verbatimTextOutput('summary'),
      table('view')
    )
  )
)

## ui에서 변경 후, 이 결과값을 server 처리하고 보여준다.
server<-function(input, output){
  ## 처리해주는 게, 요청된 데이터 셋이 반환된다.
  ## reactive는 샤이니 내부 함수
  datasetInput<-reactive({
    switch(input$datasetId,
           'rock'=rock,
           'pressure'=pressure,
           'cars'=mtcars)
  })
  output$summary<-renderPrint({
    datasetId<-datasetInput()
    summary(datasetId)
  })
  output$view<-renderTable({
    # r문법
    head(datasetInput, n=input$obsId)
  })
}

shinyApp(ui, server)

##
library(shiny)
ui <-fluidPage(
  titlePanel('Shiny mtcars'),
  sidebarLayout(
    sidebarPanel(
      #데이터 선택 해주는 어떤 입력 패널
      selectInput(inputId = 'datasetId',
                  label='데이터 셋 선택:',
                  choices=c('USArrests', 'iris', 'mtcars', 'sleep')),
      
      # head() 값을 입력하는 어떤 패널
      numericInput(inputId = 'obsId',
                   label = '관측치의 수',
                   value=5),
      
    ),
    mainPanel(
      verbatimTextOutput('summary'),
      tableOutput('view'),
      verbatimTextOutput('str'),
      plotOutput('plot')
    )
  )
)

## ui에서 변경 후, 이 결과값을 server 처리하고 보여준다
server<-function(input, output){
  ## 처리해주는 게, 요청된 데이터 셋이 반환된다.
  ## reactive는 샤이니 내부 함수
  datasetInput<-reactive({
    switch(input$datasetId,
           'USArrests'=USArrests,
           'iris'=iris,
           'mtcars'=mtcars,
           'sleep'=sleep)
  })
  output$summary<-renderPrint({
    datasetId<-datasetInput()
    summary(datasetId)
  })
  output$view<-renderTable({
    # r문법
    head(datasetInput(), n=input$obsId)
  })
  output$str<-renderPrint({
    # str()
    datasetId<-datasetInput()
    str(datasetId)
  })
  output$plot<-renderPlot({
    datasetId<-datasetInput()
    plot(datasetId[,1], datasetId[,2])
  })
}

# 앱을 실행시키기
shinyApp(ui, server)

# 02
library(shiny)

ui <- basicPage(
  plotOutput('plot', click = 'plot_click'),
  verbatimTextOutput('info')
)

server <- function(input, output) {
  output$plot <- renderPlot({
    plot(mtcars$wt, mtcars$mpg)
  })
  
  output$info <- renderText({
    paste0('x=', input$plot_click$x, '\ny=', input$plot_click$y)
  })
  
}

shinyApp(ui, server)


# 03
library(shiny)

ui <- basicPage(
  plotOutput('plot',
             click = 'plot_click',
             dbclick = 'plot_dblclick',
             hover = 'plot_hover',
             brush = 'plot_brush'
             ),
  verbatimTextOutput('info')
)

server <- function(input, output){
  
  output$plot <- renderPlot({
    plot(mtcars$wt, mtcars$mpg)
  })
  
  output$info <- renderText({
    xy_str <- function(e) {
      if(is.null(e)) return('NULL\n')
      paste0('x=', round(e$x, 1), ' y=', round(e$y, 1), '\n')
         
    }
    xy_range_str <- function(e) {
      if(is.null(e)) return('NULL\n')
      paste0('xmin=', round(e$xmin, 1), ' xmax=', round(e$xmax, 1),
             ' ymin=', round(e$ymin, 1), ' ymax=', round(e$ymax, 1))
    }
    
    paste0(
      'click: ', xy_str(input$plot_click),
      'dbclick: ', xy_str(input$plot_dbclick),
      'hover: ', xy_str(input$plot_hover),
      'brush: ', xy_range_str(input$plot_brush)
    )
  })
}

shinyApp(ui, server)


# 04

## only run these examples in interactive R sessions
if (interactive()) {
  ## A basic shiny app with a plotOutput
  shinyApp(
    ui = fluidPage(
      sidebarLayout(
        sidebarPanel(
          actionButton('newplot',  'New plot')
        ),
        mainPanel(
          plotOutput('plot')
        )
      )
    ),
    server = function(input, output){
      output$plot <- renderPlot({
        input$newplot
        # Add a little noise to the cars data
        cars2 <- cars + rnorm(nrow(cars))
        plot(cars2)
        
      })
    }
  )
  
  
}

## only run these examples in interactive R sessions
if (interactive()) {

# A demonstration of clicking, hovering, and brushing
shinyApp(
  ui =basicPage(
    fluidRow(
      column(width=4,
             plotOutput('plot_click', # Equiv, to click=clickOpts(id='plot_click')
                        hover = hoverOpts(id = 'plot_hover', delayType = 'throttle'),
                        brush = brushOpts(id = 'plot_brush')
                        ),
             h4('Clicked points'),
             tableOutput('plot_clickedpoints'),
             h4('Brushed points'),
             tableOutput('plot_brushedpoints')
             ),
      column(width = 4,
             verbatimTextOutput('plot_clickinfo'),
             verbatimTextOutput('plot_hoverinfo')
             ),
      column(width = 4,
             wellPanel(actionButton('newplot', 'New plot')),
             verbatimTextOutput('plot_brushinfo')
             )
      
      
    )
  ),
  server = function(input, output, session){
    data <- reactive({
      input$newplot
      # Add a little noise to the cars data so the points move
      cars + rnorm(nrow(cars))
    })
    output$plot <- renderPlot({
      d<- data()
      plot(d$speed, d$dist)
    })
    output$plot_clickinfo <- renderPrint({
      cat('Click:\n')
      str(input$plot_click)
    })
    output$plot_hoverinfo <- renderPrint({
      cat('Hover (throttled):\n')
      str(input$plot_hover)
    })
    output$plot_brushinfo <- renderPrint({
      cat('Brush (debounced):\n')
      str(input$plot_brush)
    })
    output$plot_clickpoints <- renderTable({
      # For base graphics, we need to specify column, though for ggplot2,
      # it's usually not necessary.
      res <- nearPoints(data(), input$plot_click, 'speed', 'dist')
      if (nrow(res) == 0)
        return()
      res
    })
    output$plot_brushedpoints <- renderTable({
      res <- brushedPoints(data(), input$plot_brush, 'speed', 'dist')
      if (nrow(res) ==0)
        return()
      res
    })
    
  }
  
)
  
}
