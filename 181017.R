
library(ggplot2)
mtcars$cyl<-factor(mtcars$cyl)

# 데이터셋, x,y변수 지정
# 색깔구분 : z변수로 지정
# xlab : x축 label
ggplot(mtcars, aes(wt,mpg))+
         geom_point(aes(color=cyl))+
         xlab('weight(1,000 lbs)')

(p<-ggplot(mtcars, aes(wt,mpg)))       
(q<-geom_point())

## 점으로 표현
p+q

## 점으로 표현& 색 넣기
p+geom_point(aes(color=cyl))

## 모양을 이용해서 표현해 보겠다.
p+geom_point(aes(shape=cyl))

## 크기로 표현
p+geom_point(aes(size=cyl))

PlantGrowth
table(PlantGrowth$group)

## boxplot은 x축을 범주형으로 사용
p1<-ggplot(PlantGrowth, aes(group, weight))
p1+geom_boxplot()

## 방향
p1+coord_flip()+geom_boxplot()



library(MASS)
data(Cars93) 
#### x:Price, y:Horsepower
####01 산점도 그리기
####02 색 넣기
####03 geom_? jitter plot
car<-Cars93
head(car)
str(car)

#01
p<-ggplot(Cars93, aes(Price, Horsepower))
p+geom_point()

#02
p+geom_point(aes(col=Origin))

#03
q<-ggplot(car, aes(Origin, Horsepower))
q+geom_boxplot()+geom_jitter(aes(col=Origin))


### 타이틀 달기
p<-ggplot(Cars93, aes(Price, Horsepower))
B_plot<-p+geom_point(aes(color=DriveTrain))

# 가운데 정렬, 글자크기, 글씨체, 색상, 진하기
B_plot+ggtitle('Plot for Cars93')+
  theme(plot.title=element_text(hjust=0.5)) # hjust=0.5 : 가운데 정렬

B_plot+ggtitle('Plot for Cars93')+
  theme(plot.title=element_text(hjust=0.5,
                                family='serif')) # family= : 글씨체

B_plot+ggtitle('Plot for Cars93')+
  theme(plot.title=element_text(hjust=0.5,
                                family='serif',
                                size=15,
                                color='darkblue',
                                face='bold'))   # face= : 진하기 

B_plot+ggtitle('Plot for Cars93 \n with Drive Train')+   #제목 줄바꿈
  theme(plot.title=element_text(hjust=0.5,
                                family='serif',
                                size=15,
                                color='darkblue',
                                face='bold'))   

## 축 타이틀 바꾸기
## y: Horesepower
## x: Price
## 입력함수 :labs()

B_plot+labs(x='최대 최소 가격 평균', y='최대마력')+
  ggtitle('Plot for Cars93 \n with Drive Train')+   #제목 줄바꿈
  theme(plot.title=element_text(hjust=0.5,
                                family='serif',
                                size=15,
                                color='darkblue',
                                face='bold'))   

## 그림 저장하기
getwd()
ggsave('cars93.jpg', dpi=300)

B_plot+labs(x='최대 최소 가격 평균', y='최대마력')+
  ggtitle('Plot for Cars93 \n with Drive Train')+   #제목 줄바꿈
  theme(plot.title=element_text(hjust=0.5,
                                family='serif',
                                size=15,
                                color='darkblue',
                                face='bold')) # +
  #ggsave('C:/Users/ktm/Documents/R_STUDIO_EXERCISE/cars93_2.jpg', dpi=300)

B_plot+lims(x=c(0,40)) # x축 원하는 범위로.

xlal =seq(0,80,by=10) 
xlal
B_plot+scale_x_continuous(breaks=xlal)

B_plot+scale_x_continuous(breaks=c(0,10,20,30,40,50,60,70))


ylal=seq(0,320, by=50)
B_plot+scale_y_continuous(breaks=ylal)
ylal


## 실습2
md<-read.csv('E:/Bigdata/dataset/microdust.csv')

str(md)
head(md)
summary(md)
col<-c('date', 'density', 'result')
colnames(md)<-col


a<-ggplot(md, aes(result, density ))
a+geom_boxplot(aes(color=result))+
  labs(x='Result', y='Value')+
  ggtitle('Density Of \n MicroDust')+
  theme(plot.title=element_text(hjust=0.5,
                                family='serif',
                                size=15,
                                color='darkblue',
                                face='bold'))+
  geom_jitter()

  
#mdta<-table(md$result) # I want to draw a barplot but i didn't.
b<-ggplot(md, aes(x=result))
b+geom_bar(aes(color=result))+
  labs(x='Result', y='Value')+
  ggtitle('Density Of \n MicroDust')+
  theme(plot.title=element_text(hjust=0.5,
                                family='serif',
                                size=15,
                                color='darkblue',
                                face='bold'))


### with scatter plot
b<-ggplot(md, aes(x=result, y=density))
b+geom_point()+geom_jitter(aes(color=result))+
  coord_flip()
  labs(x='Result', y='Value')+
  ggtitle('Density Of \n MicroDust')+
  theme(plot.title=element_text(hjust=0.5,
                                family='serif',
                                size=15,
                                color='darkblue',
                                face='bold'))
### 축 라벨 바꾸기
xlbl=seq(0,60, by=5)
labels=paste('$', xlbl, sep='')
labels
B_plot+scale_x_continuous(breaks=xlbl,
                          labels=labels)+# $ 붙이기
  theme(axis.text.x= element_text(angle=90))


### x 축을 위로 옮기기
B_plot+scale_x_continuous(position='top')

### 범례 위치 바꾸기
B_plot+theme(legend.position = 'top')

### 범례 위치를 그래프 안으로 들이기
B_plot+theme(legend.position = c(0.85,0.2))

### 그래프 안에 글자 넣기
### annotate() : 표시하다 , 주석달기
### annotate() : 
B_plot+annotate('text', x=60, y=200, label='abante')+
  annotate('text', x=50, y=260, label='sonata')

B_plot+annotate('text', x=60, y=200, label='abante')+
  annotate('rect', xmin=0, xmax=40, ymin=100, ymax=260,
           fill='skyblue', alpha=0.2)+
  annotate('text', x=20, y=240, label='*** inportant')

B_plot+annotate('text', x=60, y=200, label='abante')+
  annotate('rect', xmin=0, xmax=40, ymin=100, ymax=260,
           fill='skyblue', alpha=0.2)+
  annotate('text', x=20, y=240, label='*** inportant')+
  annotate('segment', x=10, xend=40, y=100, yend=250,
           color='black', size=1)

# x축, y축
B_plot+coord_flip()


# 흑백 점 : grey scale
B_plot+scale_color_grey()

## 특정 색 세트 사용
B_plot+scale_color_brewer(palette='Dark2')

B_plot+scale_color_brewer(palette='Set2')

## 직접 색깔 지정
B_plot+scale_color_manual(values=c('dodgerblue4', 'darkorchid3', 'goldenrod1'))

## 테마 적용
## ggthemes : theme_economist() theme
library(ggthemes)
B_plot+theme_economist()+scale_color_economist()
B_plot+theme_hc(bgcolor = 'darkunica')+scale_color_hc('darkunica')
B_plot+theme_excel()+scale_color_excel()
B_plot+theme_fivethirtyeight()+scale_color_fivethirtyeight()


rm(list=ls())
### 실습 3 
### 도로형태 : roadtype, 차종:spe, 발생건수:NoO, 사망자수:NoD,
### 부상자수 : NoI, 중상 : heavy, 경상:light, 부상신고:dec
carac<-read.csv('E:/Bigdata/dataset/2017_car_accident/car_species.csv')
head(carac)
coln2<-c('roadtype', 'spe', 'NoO', 'NoD', 'NoI', 'heavy', 'light', 'dec')
colnames(carac)<-coln2
colnames(carac)
#(carac_tu<-carac[1:12,])
#carac_tu
c<-ggplot(carac, aes(x=spe, y=NoO))
c+geom_boxplot()+coord_flip()      
