

library(ggplot2)
library(MASS)
data('Cars93')

car<-Cars93
colnames(car)
head(car)

p<- ggplot(car, aes(x=Price, y=Horsepower))+
  geom_jitter(aes(colour =DriveTrain))
p

## 타이틀
## ggtitle()
p1 = p+ggtitle('Jitter Plot for Cars93 Dataset')
p1+ theme(plot.title = element_text(size=15,
                                    color='darkblue',
                                    hjust=.5))

# x축, y축 레이블을 한글로 변경
p1 + labs(x='평균', y='최대마력')

# 파일
ggsave('axis_change.jpg', dpi=300)

# x축 범위를 설정
p1+labs(x='평균', y='최대마력') + lims(x=c(0,40))

p1 + labs(x='평균', y='최대마력')+ lims(x=c(0,60))

# 10, ..., 60
p1 + scale_x_continuous(breaks=c(10,20,30,40,50,60))
ggsave('axis_breaks.jpg', dpi=300)

# 10, 20, 30, ..., 60 앞에 $ 붙이기
p2 = p1+scale_x_continuous(breaks=c(10, 20,30,40,50,60),
                           labels=paste0('$', c(10,20,30,40,50,60)))
p2

# x축을 위로 올리기
p2 +scale_x_continuous(position='top')

# 범례 위치 바꾸기
p2 +theme(legend.position=c(.85, .2))

# 그래프에 글자, 도형, 선 넣기
p2 + annotate('text', x=52, y=100, label='Price Limit\nLine')+
  annotate('rect', xmin=0, xmax=40, ymin=0, ymax=250, alpha=.2,
           fill='skyblue')+
  annotate('segment', x=60, xend=60, y=0, yend=300, colour='black', size=1)

# price와 horsepower 바꾸기
p2 + coord_flip()

# 흑백 표시
p2 + scale_color_grey()

# geom_jitter
library(ggplot2)
head(midwest)

head(midwest[, c('state', 'poptotal')])

ggplot(midwest, aes(state, percollege))+geom_point()+
  geom_jitter()

ggplot(midwest, aes(state, percollege)) +
  geom_jitter()

# 높이 넓어짐: height, 너비 넓어짐 : width
ggplot(midwest, aes(state, percollege))+
  geom_jitter(height=.3)

ggplot(midwest, aes(state, percollege))+
  geom_jitter(height=.1)

ggplot(midwest, aes(state, percollege))+
  geom_jitter(height=.9)

# 색깔 바꾸기
ggplot(midwest, aes(state, percollege))+
  geom_jitter(data=midwest, aes(color=inmetro==1))

# 모양 바꾸기
ggplot(midwest, aes(state, percollege))+
  geom_jitter(data=midwest, aes(color=inmetro==1, shape=percprof>mean(percprof)))


# 02

library(ggplot2)
library(ggmap)
library(MASS)
data(Cars93)
car<-Cars93
str(car)
summary(car)
p1<-ggplot(data=car, aes(x=Manufacturer, y=Horsepower))
p1<-p1+geom_point()
p1

p1<-p1+ggtitle('Plot of Manufacturer vs Horsepower')
p1

# 03
rm(list=ls())
install.packages('data.table')
library(data.table)
library(ggplot2)
library(dplyr)

df<-read.csv('C:/Users/ktm/Downloads/train_1000m.csv')
str(df)
table(df$is_attributed)

# filter : raw, select: col
df_sel <- df %>% select(ip, app, device, os, channel, is_attributed)
head(df_sel, 20)

# 상위 10개 ip확인
ip_is_attr<-df_sel %>%
  filter(!is.na(is_attributed)) %>%
  group_by(ip) %>%
  summarise(sum_is_attr1=sum(is_attributed), cnt=n())
ip_is_attr

#
top10 <- ip_is_attr %>%
  arrange(desc(cnt)) %>%
  head(10)
top10
top10$ip <- as.factor(top10$ip)

#
q<-ggplot(top10, aes(x=ip, y=cnt))
q+geom_boxplot()

p<-ggplot(top10, aes(x=reorder(ip, cnt), y=cnt), fill=ip)+
  geom_bar(stat='identity')
pl1 = p+coord_flip()
pl1

p2=ggplot(top10, aes(x=reorder(ip, cnt), y=sum_is_attr1))+
  geom_bar(stat='identity')
pl2 = p2+coord_flip()
pl2

install.packages('gridExtra')
library(gridExtra)

grid.arrange(pl1, pl2, ncol=2, nrow=1)

# 04

#관계도 그리기
library(igraph)

g1<-graph(c(1,2,2,3,2,4,1,4,5,5,3,6,3,3))
plot(g1)

df<-read.csv('C:/Users/ktm/Downloads//clustering.csv')
str(df)
summary(df)
graph<-data.frame(학생=df$학생, 교수=df$교수)

library(stringr)
df<-graph.data.frame(graph, directed=T)
is(df)
plot(df)

str(df)

# Vertical의 이름
gubun1<-V(df)$name
gubun1

# 시각화 한 것을 사이즈를 줄여보자.
plot(df, layout=layout.fruchterman.reingold,
     vertex.size=2, # 노드의 크기
     edge.arrow.size=.05, # 화살표의 크기
     vertex.color='green', #점 색깔
     vertex.label=NA)

# 색깔을 이용해서 T,S 를 구분
colors<-c()
for (i in 1:length(gubun1)){
  if (gubun1[i]=='S'){
    colors<-c(colors, 'red')
  }
  else {
    colors<-c(colors, 'green')
  }
}

plot(df, layout=layout.fruchterman.reingold,
     vertex.size=2, # 노드의 크기
     edge.arrow.size =.05, # 화살표의 크기
     vertex.color = 'colors', # 점 색깔
     vertex.label=NA)

#

sizes<-c()
colors<-c()
for (i in 1:length(gubun1)){
  if (gubun1[i]=='S'){
    sizes<-c(sizes, 2)
    colors<-c(colors, 'green')
  }
  else{
    sizes<-c(sizes, 4)
    colors<-c(colors, 'darkgreen')
  }
}

plot(df, layout=layout.fruchterman.reingold,
     vertex.size=sizes, # 노드의 크기
     edge.arrow.size = .03, # 화살표 크기
     vertex.color=colors, # 점 색깔
     vertex.label=NA)

install.packages('network')
install.packages('sna')
install.packages('visNetwork')
install.packages('threejs')
install.packages('ndtv')