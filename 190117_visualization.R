
library(ggplot2)
library(MASS)
data(Cars93)
car<-Cars93
dim(car)
names(car)

b_plot <- ggplot(car, aes(x=Price, y=Horsepower))+
  geom_point(aes(color='DriveTrain'))
b_plot

## 타이틀에 대한 글씨체 정렬, 크기
b_plot + ggtitle('Plot for \n Cars93 Dataset') +
  theme(plot.title = element_text(family='serif',
                                  face='bold',
                                  hjust=0.5,
                                  size=15,
                                  color='darkblue'))

## x, y축 타이틀 레이블명 변경
b_plot+ labs(x='최대 최소 가격 평균', y='최대 마력')
ggsave('axis_title.jpg', dpi=300)

## x축 y축 범위 지정
b_plot +lims(x=c(0,40))


## x, y축 레벨 쪼개기
b_plot + scale_x_continuous(breaks=c(10,20,30,40,50,60),
                            labels=paste0('$', c(10,20,30,40,50,60)))+
  scale_y_continuous(breaks=c(50,100,150,200,250,300))

## 축의 눈금 문자열을 90도 돌리기
b_plot + scale_x_continuous(breaks=c(10,20,30,40,50,60),
                            labels=paste0('$', c(10,20,30,40,50,60)))+
  scale_y_continuous(breaks=c(50,100,150,200,250,300))+
  theme(axis.text.x=element_text(angle=90, hjust=1, vjust=0.5))

## 범례 넣기
b_plot+theme(legend.position=c(0.85, 0.2))
b_plot+theme(legend.position=c(0.85, 0.8))


## 글자 쓰기
b_plot+annotate('text', x=52, y=100, label='Price Limit')+
  annotate('text', x=10, y=230, label='Candidate')

## 사각형 그리기
b_plot+annotate('text', x=52, y=100, label='Price Limit')+
  annotate('text', x=10, y=230, label='Candidate')+
  annotate('rect', xmin=0, xmax=40, ymin=0, ymax=250, alpha=.5, fill='skyblue')+
  annotate('segment', x=60, xend=60, y=0, yend=300, color='black', size=1)

## 좌표축 x, y 뒤집기
b_plot +coord_flip()
b_plot+scale_color_grey()
