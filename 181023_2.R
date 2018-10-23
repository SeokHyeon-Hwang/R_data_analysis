library(shiny)
ui<-fluidPage(
  titlePanel('Shiny Text'),
  sidebarLayout(
    sidebarPanel(
      #선택해주는 어떤 입력 패널
      selectInput(inputId = 'datasetId',
                  label='데이터 셋 선택:',
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

## ui에서 변경 후, 이 결과값을 server 처리하고 보여준다
server<-function(input, output){
  ## 처리해주는 게, 요청된 데이터 셋이 반환된다.
  ## reactive는 샤이니 내부 함수
  datasetInput<-reactive({
    switch(input$datasetId,
           'rock'=rock,
           'pressure'=pressure,
           'car'=mtcars)
  })
  output$summary<-renderPrint({
    datasetId<-datasetInput()
    summary(datasetId)
  })
  output$view<-renderTable({
    #r 문법
    head(datasetInput, n=input$obsId)
  })
}

# 앱을 실행시키기
shinyApp(ui, server)


## 실습1. dataset(USArrests, iris, mtcars)를 불러와서 이를
## 확인해보자.
## data(MASS)
## data()


library(shiny)
ui<-fluidPage(
  titlePanel('Shiny Text'),
  sidebarLayout(
    sidebarPanel(
      #선택해주는 어떤 입력 패널
      selectInput(inputId = 'datasetId',
                  label='데이터 셋 선택:',
                  choices=c('USArrests', 'iris','mtcars' ,'sleep')),
      
      #값을 입력하는 어떤 패널
      numericInput(inputId = 'obsId',
                   label='관측치의 수',
                   value=10)
    ),
    mainPanel(
      verbatimTextOutput('summary'),
      tableOutput('view'),
      verbatimTextOutput('str')
      
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
    #r 문법
    head(datasetInput(), n=input$obsId)
  })
  output$str<-renderPrint({
    datasetId<-datasetInput()
    str(datasetId)
  })
}

# 앱을 실행시키기
shinyApp(ui, server)

