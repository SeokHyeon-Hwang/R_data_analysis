library(ggplot2)

library(ggmap)
library(MASS)
data(Cars93)
str(Cars93)
summary(Cars93)
p1<-ggplot(data=Cars93, aes(x=Manufacturer, y=Horsepower))
p1<-p1+geom_point()

p1<-p1+ggtitle('Plot of Manufacturer vs Horsepower')
p1
