# ggplot2
library(ggplot2)
library(MASS)
data('Cars93')

p<-ggplot(Cars93, aes(x=Price, y=Horsepower)) +
  geom_jitter(aes(colour=DriveTrain))

p

## 타이틀
## ggtitle()
p1 = p+ggtitle('Jitter Plot for Cars93 Dataset')
p1 + theme(plot.title = element_text(size=15,
                                     color='darkblue',
                                     hjust = 0.5))

p1 = p+ggtitle('Jitter Plot for \n Cars93 Dataset')
p1 + theme(plot.title = element_text(size=15,
                                     color='darkblue',
                                     hjust = 0.5))

# x축, y축 레이블을 한글로 변경
p1 + labs(x='평균', y='최대마력')

# 파일
ggsave('axis_change.jpg', dpi=300)

# x축의 범위를 설정
p1 +labs(x='평균', y='최대마력') + lims(x=c(0,40))

p1 +labs(x='평균', y='최대마력') + lims(x=c(0,60))

# 10, ..., 60
p1 + scale_x_continuous(breaks=c(10,20,30,40,50,60))
ggsave('axis_breaks.jpg', dpi=300)

# 10,20,30...60 앞에 $붙이기
p2 = p1 + scale_x_continuous(breaks=c(10,20,30,40,50,60),
                        labels=paste0('$', c(10,20,30,40,50,60)))


## x축을 위로 올리기
p2 + scale_x_continuous(position='top')

## 범례 위치 바꾸기
p2 + theme(legend.position='top')

p2 + theme(legend.position=c(0.85,0.2))

## 그래프에 글자, 도형, 선 넣기
p2 + annotate('text', x=52, y=100, label='Price Limit\nLine') +
  annotate('rect', xmin=0, xmax=40, ymin=0, ymax=250, alpha=0.2,
           fill='skyblue') +
  annotate('segment', x=60, xend=60, y=0, yend=300, colour='black', size=1)

## price와 horsepower 바꾸기
p2 + coord_flip()

## 흑백 표시
p2 + scale_color_grey()

## geom_jitter
library(ggplot2)
head(midwest)

head(midwest[,c('state', 'poptotal')])

ggplot(midwest, aes(state, percollege)) + geom_point() +
  geom_jitter()

ggplot(midwest, aes(state, percollege)) +
  geom_jitter()

# 높이 넓어짐 : height, 너비 넓어짐 : width
ggplot(midwest, aes(state, percollege)) +
  geom_jitter(height=0.3)

ggplot(midwest, aes(state, percollege)) +
  geom_jitter(height=0.1)

ggplot(midwest, aes(state, percollege)) +
  geom_jitter(height=0.9)

# 색깔 바꾸기
ggplot(midwest, aes(state, percollege)) + 
  geom_jitter(data=midwest, aes(color=inmetro==1))

# 모양도 바꾸기
ggplot(midwest, aes(state, percollege)) + 
  geom_jitter(data=midwest, aes(color=inmetro==1, shape=percprof>mean(percprof)))

