
rm(list=ls())

# iris 시각화
# 목적 : iris 데이터 시각화를 통해 종류별 특징을 관찰한다.

data(iris)
df<-iris

# EDA
head(df, n=20)
colnames(df)

# Visualization

plot(iris)

library(ggplot2)

## volcano plot(violet plot)

vol <- ggplot(data=iris, aes(x=Sepal.Length))
vol + stat_density(aes(ymax = ..density.., ymin = -..density..,
                       fill = Species, color = Species),
                   geom = 'ribbon', position = 'identity') +
  facet_grid(. ~Species) + coord_flip() + xlab('Sepal Length') + 
  ggtitle('Density - Sepal Length') + 
  theme(plot.title = element_text(family = 'serif',
                                  face='bold',
                                  hjust=.5,
                                  size=18,
                                  color='black'))

vol2 <- ggplot(data=iris, aes(x=Sepal.Width))
vol2 + stat_density(aes(ymax = ..density.., ymin = -..density..,
                       fill = Species, color = Species),
                   geom = 'ribbon', position = 'identity') +
  facet_grid(. ~Species) + coord_flip() + xlab('Sepal Width') +
  ggtitle('Density - Sepal Width') + 
  theme(plot.title = element_text(family = 'serif',
                                  face='bold',
                                  hjust=.5,
                                  size=18,
                                  color='black'))


vol3 <- ggplot(data=iris, aes(x=Petal.Length))
vol3 + stat_density(aes(ymax = ..density.., ymin = -..density..,
                       fill = Species, color = Species),
                   geom = 'ribbon', position = 'identity') +
  facet_grid(. ~Species) + coord_flip() + xlab('Petal Length') + 
  ggtitle('Density - Petal Length') + 
  theme(plot.title = element_text(family = 'serif',
                                  face='bold',
                                  hjust=.5,
                                  size=18,
                                  color='black'))

vol4 <- ggplot(data=iris, aes(x=Petal.Width))
vol4 + stat_density(aes(ymax = ..density.., ymin = -..density..,
                        fill = Species, color = Species),
                    geom = 'ribbon', position = 'identity') +
  facet_grid(. ~Species) + coord_flip() + xlab('Petal Width') + 
  ggtitle('Density - Petal Width') + 
  theme(plot.title = element_text(family = 'serif',
                                  face='bold',
                                  hjust=.5,
                                  size=18,
                                  color='black'))

## boxplot

box <- ggplot(data=iris, aes(x=Species, y=Sepal.Length))
box + geom_boxplot(aes(fill=Species)) + 
  ylab("Sepal Length") +
  stat_summary(fun.y=mean, geom="point", shape=5, size=4)+
  ggtitle('Petal Width') + 
  theme(plot.title = element_text(family = 'serif',
                                  face='bold',
                                  hjust=.5,
                                  size=18,
                                  color='black'))

box2 <- ggplot(data=iris, aes(x=Species, y=Sepal.Width))
box2 + geom_boxplot(aes(fill=Species)) + 
  ylab("Sepal Width") +
  stat_summary(fun.y=mean, geom="point", shape=5, size=4)+
  ggtitle('Sepal Width') + 
  theme(plot.title = element_text(family = 'serif',
                                  face='bold',
                                  hjust=.5,
                                  size=18,
                                  color='black'))


box3 <- ggplot(data=iris, aes(x=Species, y=Petal.Length))
box3 + geom_boxplot(aes(fill=Species)) + 
  ylab("Petal Length") +
  stat_summary(fun.y=mean, geom="point", shape=5, size=4)+
  ggtitle('Petal Length') + 
  theme(plot.title = element_text(family = 'serif',
                                  face='bold',
                                  hjust=.5,
                                  size=18,
                                  color='black'))

box4 <- ggplot(data=iris, aes(x=Species, y=Petal.Width))
box4 + geom_boxplot(aes(fill=Species)) + 
  ylab("Petal Width") +
  stat_summary(fun.y=mean, geom="point", shape=5, size=4)+
  ggtitle('Petal Width') + 
  theme(plot.title = element_text(family = 'serif',
                                  face='bold',
                                  hjust=.5,
                                  size=18,
                                  color='black'))

## scatter plot

p <- ggplot(data=df, aes(x= Sepal.Length, y=Sepal.Width))
p + geom_point(aes(color=Species, shape=Species)) +
  xlab('꽃받침 길이') + ylab('꽃받침 너비') + 
  ggtitle('붓꽃의 꽃받침 길이와 너비') + 
  theme(plot.title = element_text(family = 'serif',
                                  face='bold',
                                  hjust=.5,
                                  size=18,
                                  color='black'))

q <- ggplot(data=df, aes(x= Petal.Length, y=Petal.Width))
q + geom_point(aes(color=Species, shape=Species)) +
  xlab('꽃잎 길이') + ylab('꽃잎 너비') + 
  ggtitle('붓꽃의 꽃잎의 길이와 너비') + 
  theme(plot.title = element_text(family = 'serif',
                                  face='bold',
                                  hjust=.5,
                                  size=18,
                                  color='black'))




## shiny app (start with if cord)
library(shiny)
if interactive() {
  shinyApp(
    ui = pageWithSidebar(
      headerPanel('Iris k-means clustering'),
      sidebarPanel(
        selectInput('xcol', 'X Variable', names(iris)),
        selectInput('ycol', 'Y Variable', names(iris),
                    selected=names(iris)[[2]]),
        numericInput('clusters', 'Cluster count', 3,
                     min = 1, max = 9)
      ),
      mainPanel(
        plotOutput('plot1')
      )
    ),
    server = function(input, output, session) {
      
      # Combine the selected variables into a new data frame
      selectedData <- reactive({
        iris[, c(input$xcol, input$ycol)]
      })
      
      clusters <- reactive({
        kmeans(selectedData(), input$clusters)
      })
      
      output$plot1 <- renderPlot({
        palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
                  "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))
        
        par(mar = c(5.1, 4.1, 0, 1))
        plot(selectedData(),
             col = clusters()$cluster,
             pch = 20, cex = 3)
        points(clusters()$centers, pch = 4, cex = 4, lwd = 4)
      })
      
    }
  )
  
}

## shiny app (start with below cord)

ui = pageWithSidebar(
  headerPanel('Iris k-means clustering'),
  sidebarPanel(
    selectInput('xcol', 'X Variable', names(iris)),
    selectInput('ycol', 'Y Variable', names(iris),
                selected=names(iris)[[2]]),
    numericInput('clusters', 'Cluster count', 3,
                 min = 1, max = 9)
  ),
  mainPanel(
    plotOutput('plot1')
  )
)

server = function(input, output, session) {
  
  # Combine the selected variables into a new data frame
  selectedData <- reactive({
    iris[, c(input$xcol, input$ycol)]
  })
  
  clusters <- reactive({
    kmeans(selectedData(), input$clusters)
  })
  
  output$plot1 <- renderPlot({
    palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
              "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))
    
    par(mar = c(5.1, 4.1, 0, 1))
    plot(selectedData(),
         col = clusters()$cluster,
         pch = 20, cex = 3)
    points(clusters()$centers, pch = 4, cex = 4, lwd = 4)
  })
  
}

shinyApp(ui,server)
