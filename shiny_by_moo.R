library(shiny)
ui <- fluidPage(
  titlePanel("titlePanel"),
  sidebarLayout(
    sidebarPanel(
      helpText("Test"),
      sliderInput(
        inputId = "col",
        min=1,
        max=5,
        value = 1,
        label = "color"
      ),
      sliderInput(
        inputId = "cex",
        min=1,
        max=20,
        value = 1,
        label = "cex"
      ),
      sliderInput(
        inputId = "bins",
        min=1,
        max=50,
        value = 50,
        label = "Numble of bins"
      ),
      sliderInput(
        inputId = "pch",
        min=1,
        max=20,
        value = 1,
        label = "pch"
      ),
      selectInput("cols1","cols1",choices = c("Murder"="Murder","Assault"="Assault","UrbanPop"="UrbanPop","Rape"="Rape")),
      selectInput("cols2","cols2",choices = c("Murder"="Murder","Assault"="Assault","UrbanPop"="UrbanPop","Rape"="Rape"))
      
    ),
    mainPanel(
      plotOutput("Plot"),
      plotOutput("Plot2"),
      plotOutput("Plot3")
    )
  )
  
)

server <- function(input, output) {
  output$Plot <- renderPlot({
    plot(iris$Sepal.Length, iris$Petal.Length, col=input$col, cex=input$cex )
  })
  output$Plot2 <- renderPlot({
    data = mtcars$mpg
    bins = seq(min(data),max(data), length.out = input$bins +1)
    hist(data, breaks = bins, col = "#75AADB")
  })
  output$Plot3 <- renderPlot({
    plot(USArrests[,input$cols1],USArrests[,input$cols2], pch=input$pch )
  })
  
}

shinyApp(ui, server)
