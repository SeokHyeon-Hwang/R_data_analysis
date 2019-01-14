rm(list=ls())

library(ggplot2)

mtcars$cyl <- factor(mtcars$cyl)

ggplot(mtcars, aes(wt, mpg))+
  geom_point(aes(color=cyl))+
  xlab('weight(1,000 lbs')

(p<-ggplot(mtcars, aes(wt, mpg)))
(q<-geom_point())

p+q

p+geom_point(aes(shape=cyl))

p+geom_point(aes(color=cyl))

p+geom_point(aes(size=cyl))

PlantGrowth
table(PlantGrowth$group)

p1 <- ggplot(PlantGrowth, aes(group, weight))

p1 + geom_boxplot()

p1 + coord_flip() + geom_boxplot()

library(MASS)
data(Cars93)
car <- Cars93
head(car)
str(car)

p <-ggplot(Cars93, aes(Price, Horsepower))
p+geom_point()

p+geom_point(aes(col=Origin))

q <- ggplot(car, aes(Origin, Horsepower))
q+geom_boxplot()+geom_jitter(aes(col=Origin))

p<-ggplot(Cars93, aes(Price, Horsepower))
b_plot<-p+geom_point(aes(color=DriveTrain))
b_plot

b_plot+ggtitle('Plot for Cars93')+
  theme(plot.title=element_text(hjust=0.5))

b_plot+ggtitle('Plot for Cars93')+
  theme(plot.title=element_text(hjust=0.5,
                                family='serif'))

b_plot+ggtitle('Plot for Cars93')+
  theme(plot.title=element_text(hjust=0.5,
                                family='serif',
                                size=15,
                                color='darkblue',
                                face='bold'))

