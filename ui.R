library(shiny)

shinyUI(
  fluidPage(
    titlePanel('My Shiny App'),
    sidebarLayout(
      sidebarPanel(
        radioButtons('x', 'select X-axis:',
                     list('Sepal.Length'='a',
                          'Sepal.Width'='b',
                          'Petal.Length'='c',
                          'Petal.Width'='d')),
        radioButtons('y', 'select Y-axis:',
                     list('Sepal.Length'='e',
                          'Sepal.Width'='f',
                          'Petal.Length'='g',
                          'Petal.Width'='h'))
        
      ),
      mainPanel(
        plotOutput('myplot')
      )
    )
  )
)
