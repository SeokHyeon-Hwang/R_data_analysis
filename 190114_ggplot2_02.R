library(ggplot2)

mtcars$cyl <- factor(mtcars$cyl)

ggplot(mtcars, aes(wt, mpg))+
  geom_point(aes(color=cyl))+
  xlab('weight(1,000 lbs')

p<-ggplot(mtcars, aes(wt,mpg))
q<-geom_point()

p+q

p+geom_point(aes(color=cyl))

p+geom_point(aes(shape=cyl))

p+geom_point(aes(size=cyl))

PlantGrowth
table(PlantGrowth$group)

p1 <-ggplot(PlantGrowth, aes(group, weight))
p1+geom_boxplot()

p1+coord_flip() + geom_boxplot()

library(MASS)
data(Cars93)

car<-Cars93
head(car)
str(car)

#01
p<-ggplot(car, aes(Price, Horsepower))
p+geom_point()

#02
p+geom_point(aes(col=Origin))

#03
q<-ggplot(car, aes(Origin, Horsepower))
q+geom_boxplot()+geom_jitter(aes(col=Origin))

# title
p<- ggplot(car, aes(Price, Horsepower))
b_plot <-p+geom_point(aes(color=DriveTrain))

# hjust=0.5
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

b_plot+ggtitle('Plot for Cars93 \n with Drive Train')+
  theme(plot.title=element_text(hjust=0.5,
                                family='serif',
                                size=15,
                                color = 'darkblue',
                                face='bold'))

b_plot+labs(x='최대 최소 가격 평균', y='최대마력')+
  ggtitle('Plot for Cars93 \n with Drive Train')+
  theme(plot.title=element_text(hjust=0.5,
                                family='serif',
                                size=15,
                                color='darkblue',
                                face='bold'))
getwd()
ggsave('cars93.jpg', dpi=300)

b_plot+labs(x='최대 최소 가격 평균', y='최대마력')+
  ggtitle('Plot for Cars93 \n with Drive Train')+
  theme(plot.title=element_text(hjust=0.5,
                                family='serif',
                                size=15,
                                color='darkblue',
                                face='bold'))+
  ggsave('C:/users/ktm/documents/cars93_2.jpg', dpi=300)

b_plot+lims(x=c(0,40))

xlal=seq(0, 80, by=10)
xlal
b_plot+scale_x_continuous(breaks=xlal)
b_plot+scale_x_continuous(breaks=c(0, 10, 20, 30, 40, 50, 60, 70))

ylal = seq(0, 320, by=50)
b_plot+scale_y_continuous(breaks=ylal)
ylal

md<-read.csv('C:/Users/ktm/Downloads/dust.csv')

str(md)
head(md)
summary(md)
col<-c('date', 'density', 'result')
colnames(md)<-col
str(md)
a<-ggplot(md, aes(result, density))
a+geom_boxplot(aes(color=result))+
  labs(x='Result', y='Value')+
  ggtitle('Density Of \n MicroDust')+
  theme(plot.title=element_text(hjust=0.5,
                                family='serif',
                                size=15,
                                color='darkblue',
                                face='bold'))+
  geom_jitter()

b<-ggplot(md, aes(x=result, y=density))
b+geom_point()+geom_jitter(aes(color=result))+
  coord_flip()+
  labs(x='Result', y='Value')+
  ggtitle('Density of \n Microdust')+
  theme(plot.title=element_text(hjust=0.5,
                                family='serif',
                                size=15,
                                color='darkblue',
                                face='bold'))

# change label
xlbl=seq(0, 60, by=5)
labels=paste('$', xlbl, sep='')
labels
b_plot+scale_x_continuous(breaks=xlbl,
                          labels=labels)+
  theme(axis.text.x=element_text(angle=90))


# up x label
b_plot+scale_x_continuous(position='top')

# change lagend
b_plot+theme(legend.position = 'top')
b_plot+theme(legend.position = c(0.85, 0.2))

b_plot+annotate('text', x=60, y=200, label='abante')+
  annotate('text', x=50, y=260, label='sonata')

b_plot+annotate('text', x=60, y=200, label='abante')+
  annotate('rect', xmin=0, xmax=40, ymin=100, ymax=260,
           fill='skyblue', alpha=0.2)+
  annotate('text', x=20, y=240, label='***important')

b_plot+annotate('text', x=60, y=200, label='abante')+
  annotate('rect', xmin=0, xmax=40, ymin=100, ymax=260,
           fill='skyblue', alpha=0.2)+
  annotate('text', x=20, y=240, label='*** important')+
  annotate('segment', x=10, xend=40, y=100, yend=250,
           color='black', size=1)

b_plot+coord_flip()

b_plot+scale_color_brewer(palette='Dark2')

b_plot+scale_color_brewer(palette='Set2')

b_plot+scale_color_manual(values=c('dodgerblue4', 'darkorchid3', 'goldenrod1'))

# theme
#install.packages('ggthemes')
library(ggthemes)
b_plot+theme_economist()+scale_color_economist()
b_plot+theme_hc(bgcolor='darkunica')+scale_color_hc('darkunica')
b_plot+theme_excel()+scale_color_excel()
b_plot+theme_fivethirtyeight()+scale_color_fivethirtyeight()

