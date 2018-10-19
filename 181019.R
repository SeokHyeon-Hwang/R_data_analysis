

## 관계도 그리기
## library(igraph)

library(igraph)

g1<-graph(c(1,2,2,3,2,4,1,4,5,5,3,6,3,3))
plot(g1)

df<-read.csv('E:/Bigdata/dataset/rloveyou/clustering.csv')
str(df)
summary(df)
graph<-data.frame(학생=df$학생, 교수=df$교수)

library(stringr)
df<-graph.data.frame(graph, directed=T)
is(df)
plot(df)

str(df)

#Vertical의 이름
gubun1<-V(df)$name
gubun1

# Vertical의 이름을 출력
gubun<-str_sub(gubun1, start=1, end=1)
gubun
table(gubun)

## 시각화 한 것을 사이즈를 줄여보자.
plot(df, layout=layout.fruchterman.reingold,
     vertex.size=2,  # 노드의 크기
     edge.arrow.size =0.05, # 화살표 크기
     vertex.color='green', #점 색깔
     vertex.label=NA)

## 색깔을 이용해서 T,S를 구분
colors<-c()
for (i in 1:length(gubun)){
  if (gubun[i]=='S'){
    colors<-c(colors, 'red')
  }
  else {
    colors<-c(colors, 'green')
  }
}

plot(df, layout=layout.fruchterman.reingold,
     vertex.size=2,  # 노드의 크기
     edge.arrow.size =0.05, # 화살표 크기
     vertex.color='colors', #점 색깔
     vertex.label=NA)

#################

sizes<-c()
colors<-c()
for (i in 1:length(gubun)){
  if (gubun[i]=='S'){
    sizes<-c(sizes, 2)
    colors<-c(colors, 'green')
  }
  else {
    sizes<-c(sizes, 4)
    colors<-c(colors, 'darkgreen')
  }
}

plot(df, layout=layout.fruchterman.reingold,
     vertex.size=sizes,  # 노드의 크기
     edge.arrow.size =0.03, # 화살표 크기
     vertex.color=colors, #점 색깔
     vertex.label=NA)


##################


sizes<-c()
colors<-c()
for (i in 1:length(gubun)){
  if (gubun[i]=='S'){
    sizes<-c(sizes, 2)
    colors<-c(colors, 'green')
  }
  else {
    sizes<-c(sizes, 4)
    colors<-c(colors, 'darkgreen')
  }
}

plot(df, layout=layout.fruchterman.reingold,
     vertex.size=sizes,  # 노드의 크기
     edge.arrow.size =0.03, # 화살표 크기
     vertex.color=colors, #점 색깔
     ve
)

install.packages('network')
install.packages('sna')
install.packages('visNetwork')
install.packages('threejs')
install.packages('ndtv')

install.packages('png')
install.packages('networkD3')
install.packages('animation')
install.packages('maps')
install.packages('geosphere')




plot(x=1:10, y=rep(5,10), pch=19, cex=5, col='dark red')
points(x=1:10, y=rep(6,10), pch=19, cex=5, col='#557799')
points(x=1:10, y=rep(4,10), pch=19, cex=5, col=rgb(85,119,153, max=255))

# r에는 어떤 컬러를 쓸 수 있을까?
colors()  # 모든 컬러 확인
grep('blue', colors(), value=T)


# 투명도 alpha
plot(x=1:5, y=rep(5,5), pch=19, cex=12, col=rgb(0.25, 0.5, 0.3, alpha=0.5), 
     xlim=c(0,6))


# 배경색 지정
par(bg='black')
search()
col.tr<-grDevices::adjustcolor('#557799', alpha=0.7)
plot(x=1:5, y=rep(5,5), pch=19, cex=20,
     col=col.tr, xlim=c(0,6))

dev.off() # 그래픽 디바이스 초기화

# 색을 넣기
pal1<-heat.colors(5, alpha=1)
pal1
plot(x=1:5, y=rep(5,5), pch=19, cex=10,
     col=pal1)

pal2<-rainbow(7, alpha=0.5)
pal2
plot(x=1:7, y=rep(5,7), pch=19, cex=10,
     col=pal2)

# 컬러셋은 최대 12가지 색이다. 30가지를 쓰려면?
# colorRampPalette(A,B) : A와 B사이 값으로 반환 -> 함수 반환
palf<-colorRampPalette(c('gray70', 'dark red'))
palf
palf(50)
plot(x=10:1, y=rep(1:10), pch=19, cex=10,
     col=palf(10))


#######
col1=rgb(1,1,1,0.2) # rgb비율 & alpha, max=255가 들어가면 비율아니고 값을 넣자
col2=rgb(0.8,0,0, 0.7)

col1255=rgb(255,255,255, 0.2, max=255)
col2255=rgb(0.8,0,0, 0.7)
palf<-colorRampPalette(c(col1, col2), alpha=T)
plot(x=10:1, y=rep(1:10), pch=19, cex=10,
     col=palf(10))


# 외우기 어려움 ColorBrewer 이용
library(RColorBrewer)

display.brewer.all()
brewer.pal.info  # 색깔 확인
col3<-brewer.pal(8,'Set3')
plot(x=1:5, y=rep(5,5), pch=19, cex=10,col=col3)
point


display.brewer.pal(11,'RdGy')


### 패키지 지우기
detach('package:RColorBrewer')
