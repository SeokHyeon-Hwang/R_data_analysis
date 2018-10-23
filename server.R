library(shiny)

shinyServer(
  function(input, output){
    output$myplot<-renderPlot({
      ### 실행되는 R코드
      if(input$x=='a'){
        i=1
      }
      if(input$x=='b'){
        i=2
      }
      if(input$x=='c'){
        i=3
      }
      if(input$x=='d'){
        i=4
      }
      if(input$y=='e'){
        j=1
      }
      if(input$y=='f'){
        j=2
      }
      if(input$y=='g'){
        j=3
      }
      if(input$y=='h'){
        j=4
      }
      s<-iris[,i]
      k<-iris[,j]
      plot(s,k)
    })
  }
)
