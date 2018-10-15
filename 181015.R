# 효과적인 차트 작성법
## 1. 자료조사
### 권위, 최신자료, 사용허가 받기
## 2. 편집
### 핵심메시지, 걸러내고, 단순화, 핵심
## 3. 구성
### 차트 기본 설정
## 4. 검토
### 이상치는 전문가에게, 독자의 관점

# 1장-기본원칙
## 참조대상 설정(비교 대상 같은 것)
x=c(1,2,3,4,5)
y=c(10,8,9,7,5)
plot(x,y, type='l', ylim=c(0,10))
### 차트에 참조점 만들기

## 1-2 알맞은 신호를 보내라
### 같은 숫자, 다양한 파트, 메시지 의도
price=c(8,10,8,4,2) #매출액
ratio=c(0,25,0,-50,-75) 
df=data.frame(price, ratio)
plot(price, type='l', ylim=c(0, 12), col=3, lwd='5', main='실제 주가 차트') #lwd:선굵기

# 가로 barplot :매출액, 파이차트 : 시장점유율
revenu=c(10,20,50,110)
com=c('D','C','B','A')
ratio=c(55, 25, 10, 10)

df=data.frame(revenu, com)
barplot(revenu, names.arg=com, horiz=T, col='cyan1')
lab<-paste(com, '\n',ratio,'%', sep='' )
pie(ratio, labels=lab, main='시장점유율')

# 3차원 파이 차트
#install.packages('plotrix')
library(plotrix)
pie3D(ratio, labels=lab, explode=0.1, main='시장점유율')

## 1-4 데이터 신뢰성-수치에 맥락 제공
product=c('초콜릿', '초코과자')
a=c(40,60)
lab=paste(product, '\n', a, '&', sep='')
par(mfrow=c(1,2))
pie(a, labels=lab, main='미국', radius=0.8)
pie(a, labels=lab, main='캐나다')


## 1-5
head(iris)
head(round(iris[,-5]))


## 1-6
rev17=c(8,10,12,18,20,32)
rev18=c(8,10,12,18,30,32)
com=c('F','E','D','C','B','A')
par(mfrow=c(1,2))
barplot(rev17, names.arg=com, horiz=T,
        col='cyan1', space=1, main='지난해', las=2)
barplot(rev18, names.arg=com, horiz=T,
        col='cyan3', space=1, main='올해', las=2)

rm(list=ls())
## D3
#install.packages('networkD3')
#install.packages("d3Network")
#install.packages('RCurl')

library(networkD3)
library(d3Network)
library(RCurl)

source = c("철수", "철수", "철수", "수철", "수철", "수철", "기수", "기수")
target = c("영희", "민희", "수철", "수진", "철수", "희수", "영희", "수철")


networkData=data.frame(source, target)



d3SimpleNetwork(networkData, width=400, height=250,   # 그래프가 안뜸. 확인 
              textColour='orange', linkColour='red',
              nodeColour='orange', opacity=0.9)


# 메르스 환자 접촉도 시각화

virus1=read.csv('E:/Bigdata/dataset/rloveyou/meros.csv')
head(virus1)
simpleNetwork(virus1, nodeColour='orange',
              linkColour='red', opacity=0.9,
              zoom=T, fontFamily='serif') # opacity= 불투명

d3SimpleNetwork(virus1, height=300, width=700,
                fontsize=15)

URL <- paste0(
        "https://cdn.rawgit.com/christophergandrud/networkD3/",
        "master/JSONdata//flare.json")
Energy<-jsonlite:fromJSON(URL)

fr1=c('이형민','이형민','이형민', '추준호','추준호' ,'추준호' , '박수인')
fr2=c('추준호','김혜만','이광호', '김택수', '서민성','김진태','추준호' )

nwdt<-data.frame(fr1, fr2)
simpleNetwork(nwdt, nodeColour='orange',
              linkColour='red')



plot(x=1:10, y=rep(5,10), pch=19, cex=3)
points(x=1:10, y=rep(4,10), pch=19, cex=3,
       col=rgb(.25, .5, .3))

colors()
grep('blue', colors(), value=T)

pal1<-heat.colors(5, alpha=1)
pal2<-rainbow(5, alpha=.5)
plot(x=1:10, y=1:10, pch=19, cex=5, col=pal1)

install.packages('RColorBrewer')
library(RColorBrewer)
display.brewer.all()
display.brewer.pal(8, 'Set3')
display.brewer.all()
display.brewer.pal(10, 'Set3')
