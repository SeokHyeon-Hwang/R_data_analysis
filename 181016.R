
rm(list=ls())
# 데이터 만들기
runif(10)
rnorm(100)  # 정규분포를 따르는 난수 100개 생성, 평균과 표준편차
## 아무것도 안들어가면 평균 0, 표준편차 1로 생ㅅ
x1 = rnorm(100)

# 하나의 개체에 그래프를 여러개 표시하기
# mar 속성 : 여백(margin)
# mar=c(아래쪽, 왼쪽, 위쪽, 오른쪽)
par(mar=c(0,5,3,3))

x1=rnorm(100)
density(x1) # 확률 밀도 함수 그리기용
plot(density(x1), ylim=c(0,1),
     las=1,
     lwd=4)

# 데이터 값을 4000개, 평균이 100, 표준편차 30인 난수 생성
lxos=rnorm(4000, 100, 30)
hist(lxos)
hist(lxos, xlim=c(0,300), col=rgb(255,0,0, max=255))

hist(lxos, xlim=c(0,300), col=rgb(1,0,0,1))

hist(lxos, xlim=c(0,300), col=rgb(1,0,0,1))

#yaxt, aaxt='n'축 레비블 사라짐
hist(lxos,
     breaks=30,
     xlim=c(0,300),
     col=rgb(1,0,0,0.7)
     yaxt='n'
     )



# 범례: 위치, 글자 크기, 기호, 색, 종류
legend('topright', pt.cex=2, pch=15, legend=c('lxos', 'Primadur'),
       col=c(rgb(1,0,0, 0.5),rgb(0,0,1, 0.5 ))
       )

# create data
# rep: 반복
# c(a,b,c) : 값 연결
names=c(rep('A', 80), rep('B', 50), rep('C',70))
a1=rnorm(80, 10, 9)
a2=rnorm(50,2,15)
a3=rnorm(70,30,10)
value=c(a1,a2,a3)
data=data.frame(names, value)

# Basic boxplot
boxplot(data$value~ data$names, col=terrain.colors(4))

seq(5,14, by=2)
seq(1,100, by=2)
val=seq(1,100, by=2)

# 저수준 함수 중에
# text(x위치, y위치, 글자 및 내용)
text()

sample=sample(1:100, 15, replace=T)

## 회귀분석
##
abline(v=c(4.9, 9.7), col='grey')

## 글자 글자를 붙여준다.
paste('a', 'b', sep='')
paste('a', 'b')
past0('a', 'b')

## 행렬을 만들어 주는 함수
matrix(c(1:6), ncol=2. nrow=3)

# 범주형 변수의 levels
levels(iris$Species)
nlevels(iris$Species)

# http://r-graph-gallery.com

# Distribution
# 수치 변수의 분포를 보여준다.
x1=rnorm(100)
x2=rnorm(100, 2)

par(mfrow=c(2,1))
par(mar=c(0,5,3,3))
plot(density(x1), main='',
     ylim=c(0,1),
     las=1,
     col='slateblue1',
     xaxt='n',
     lwd=4)

par(mar=c(5,5,0,3)) # 아래, 왼, 위, 우
plot(density(x1), main='',
     xlab='변수명',
     ylim=c(1,0),
     las=1,
     col='tomato',
     lwd=4)
# tr, te 비교에 사용 할 수 있다.

# 히스토그램
# (가)하나의 값만 변수값으로 들어옴.
# (나)높이는 데이터 개수를 나타냄
# (다)여러 분포를 비교할 때, violinplots 추가하기도 함.

lxos1=rnorm(4000,100,30)
lxos2=rnorm(4000, 200, 30)

par(mfrow=c(1,2))
hist(lxos1, breaks=30,
     xlim=c(0,300),
     col=rgb(1,0,0, 0.5),
     xlab='높이', ylab='개수', main='')

hist(lxos2, breaks=30,
     xlim=c(0,300),
     col=rgb(0,0,1, 0.5),
     xlab='높이', ylab='개수', main='')

# 그래프 초기화
par(mfrow=c(1,1))
hist(lxos1, breaks=30,
     xlim=c(0,300),
     col=rgb(1,0,0, 0.5),
     xlab='높이', ylab='개수', main='2개의 그래프 표시')

hist(lxos2, breaks=30,
     xlim=c(0,300),
     col=rgb(0,0,1, 0.5),
     xlab='높이', ylab='개수', main='',
     add=T)

legend('topright',
       legend=c('lxos1', 'lxos2'),
       col=c(rgb(1,0,0,.5),
             rgb(0,0,1,.5)),
       pt.cex=2, pch=15) #pt.cex : 글자크기

# 3개 그래프 
set.seed(1)
lxos1=rnorm(4000,100,30)
lxos2=rnorm(4000, 200, 30)
lxos3=rnorm(4000, 300, 30)

par(mfrow=c(1,1))
hist(lxos1, breaks=30,
     xlim=c(0,500),
     col=rgb(1,0,0, 0.5),
     xlab='높이', ylab='개수', main='2개의 그래프 표시')

hist(lxos2, breaks=30,
     xlim=c(0,500),
     col=rgb(0,0,1, 0.5),
     xlab='높이', ylab='개수', main='',
     add=T)

hist(lxos3, breaks=30,
     xlim=c(0,500),
     col=rgb(0,0,1, 0.5),
     xlab='높이', ylab='개수', main='',
     add=T)

# Boxplot
# 상자그림을 그려준다.
# 중앙값, 이상치, 사분위수(25, 50, 75)
# 관측치가 많을 경우, jitter, violinplot

names=c(rep('A',80), rep('B',50), rep('C', 70))
a1=rnorm(80,10,9)
a2=rnorm(50,2,15)
a3=rnorm(70,30,10)
value=c(a1, a2, a3) #200개 만들고
data= data.frame(names, value)
dim(data)

#basic boxplot
boxplot(data$value~data$names, col=terrain.colors(4)) #boxplot 200개 데이터

mylevels<-levels(data$names) # A,B,C 값을 저장(mylevels)
levelprop<-summary(data$names)/nrow(data) # 비율을 저장. 80/200, 70/200
levelprop

for (i in 1:length(mylevels)){  #3번 반복
  thislevel=mylevels[i] # A,B,C
  thisvalues = data[data$names==thislevel, 'value'] # 각각의 데이터 확인
  
  ival=rep(i, length(thisvalues)) # i=1이면 A의 개수만큼 반복
  myjitter<-jitter(ival, amount=levelprop[i]/2)
  points(myjitter, thisvalues, pch=20, col=rgb(0,0,0,.2))
}

###
# create data :
sample= paste(rep("sample_",40) , seq(1,40) , sep="")
specie= c(rep("carot" , 10) , 
          rep("cumcumber" , 10) , 
          rep("wheat" , 10) , 
          rep("Potatoe" , 10) )  # 각각 10개씩 있음.

gene1=c( seq(5,14)+rnorm(10 , 4 , 1) , 
         seq(5,14)+rnorm(10 , 4 , 1) , 
         seq(5,14)+rnorm(10 , 4 , 1) , 
         seq(5,14)+rnorm(10 , 4 , 1) )

gene2=c( seq(5,14)+rnorm(10 , 4 , 1) , 
         seq(5,14)+rnorm(10 , 2 , 0.2) , 
         seq(5,14)+rnorm(10 , 4 , 4) , 
         seq(5,14)+rnorm(10 , 4 , 3) )

data=data.frame(sample,specie,gene1,gene2)

# Make the graph
library(lattice)
xyplot(gene1 ~ gene2 | specie , 
       data=data , 
       pch=20 , 
       cex=3 , 
       col=rgb(0.2,0.4,0.8,0.5) )


# Data
name= c("DD","with himself","with DC","with Silur" ,"DC","with himself","with DD","with Silur" ,"Silur","with himself","with DD","with DC" )
average= sample(seq(1,10) , 12 , replace=T)
number= sample(seq(4,39) , 12 , replace=T)
data=data.frame(name,average,number)


###
# Basic Barplot
my_bar=barplot(data$average , 
               border=F , 
               names.arg=data$name , 
               las=2 , 
               col=c(rgb(0.3,0.1,0.4,0.6) , 
                     rgb(0.3,0.5,0.4,0.6) , 
                     rgb(0.3,0.9,0.4,0.6) ,  
                     rgb(0.3,0.9,0.4,0.6)) , 
               ylim=c(0,13) , main="" )

abline(v=c(4.9 , 9.7) , col="grey")

# Add the text 
text(my_bar, data$average+0.4 , paste("n = ",data$number,sep="") ,cex=1) 

#Legende
legend("topleft", legend = c("Alone","with Himself","With other genotype" ) , 
       col = c(rgb(0.3,0.1,0.4,0.6) , 
               rgb(0.3,0.5,0.4,0.6) , 
               rgb(0.3,0.9,0.4,0.6) ,  
               rgb(0.3,0.9,0.4,0.6)) , 
       bty = "y", 
       pch=20 ,       # 범례의 표시 점
       pt.cex = 3,    # 범례의 점의 크기 
       cex = 0.8, 
       horiz = FALSE, 
       inset = c(0.05, 0.05))


# treemap
## 계층 데이터
## 트리의 각 가지에는 사각형이 주어진다.
## 작은 사각형으로 바둑판 식 배열
## treemap은 treemap 라이브러리를 사용

#install.packages('treemap')
library(treemap)

## 데이터 만들기
group=c('g1', 'g2', 'g3')
value=c(13,5,22)
data=data.frame(group, value)

## treemap
treemap(data,
        index='group',
        vSize='value',
        type='index')

#### 상관관계를 표시해주는 그래프
#install.packages('ellipse')
library(ellipse)
library(RColorBrewer)


my_col<-brewer.par(5, 'p[ectral')
data=mtcars
ord<-order(data[1,])
data_ord=data[ord,ord]
plotcorr(data_ord, mar=c(1,1,1,1))

#### Bigcity
install.packages('boot')
library(boot)

data(bigcity)
bct<-bigcity
str(bct)

col<-c('y20', 'y30')
colnames(bct)<-col
bct

bct$index<-c(1:49)
str(bct)

hist(lxos1, breaks=30,
     xlim=c(0,500),
     col=rgb(1,0,0, 0.5),
     xlab='높이', ylab='개수', main='2개의 그래프 표시')

hist(lxos2, breaks=30,
     xlim=c(0,500),
     col=rgb(0,0,1, 0.5),
     xlab='높이', ylab='개수', main='',
     add=T)


barplot(bct$y20,
        col=rgb(1,0,0, 0.3),
        names.arg=bct$index,
        
        xlab='도시번호', ylab='인구수', main='1920/1930 인구 그래프')

barplot(bct$y30,
        col=rgb(0,0,1, 0.3),
        names.arg=bct$index,
        xlab='도시번호', ylab='인구수', main='1920/1930 인구 그래프',
        add=T)
####

boxplot(bct)
