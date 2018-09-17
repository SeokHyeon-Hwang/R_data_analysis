## 회귀분석
## 두 변수간의 상관관계 y=ax+b -> 단순선형, 
## 여러 변수간 상관관계 : 다중선형 회귀
## a, b 는 회귀계수
## 잔차(residuals)가 최소가 되는 회귀계수를 찾는다.
## 종속변수 ~ 독립변수
## 이항형 변수(0,1)를 예측하는 회귀모형 : 로지스틱 회귀모형
## 회귀모형 만드는 함수, 연속형 변수 예측 : Lm = lm(종속변수~독립변수, data=이름)
## summary(Lm) :  상세한 정보 - 변수의 유의한 정도, p-value, f통계량, 잔차의 정도
## F-검정, 결정계수, 예측값의 표준오차
## SSE + SSR = SST
## AIC통계량 : step()
## BIC : regsubsets()
## CP 통계량
## 변수 선택(forward, backward, both)
## Amelia - missmap()
## table(, useNA='always')
## write.csv( , rownames=F) : rowname 삭제
## read.csv( , na.strings=c('NA', ''), stringAsFactor=F, sep='\t') : 공백을 NA로 바꿔준다.

## randomForest() : 예측 변수가 연속형(수치형) 변수면 평균, 아닌 범주형은 많이 뽑힌 것을 뽑는다. 
## 나무 500개에서 배깅, 부트스트랩, 복원추출,
## mode : 최빈값 구하기

## 데이터 준비하기
tr<-read.csv('E:/Bigdata/dataset/bike/train.csv')
head(tr, 30)
te<-read.csv('E:/Bigdata/dataset/bike/test.csv')
head(te, 30)

## Heatmap
trA<-tr[,6:12]
str(tr)
library(corrplot)
trA_cor <- cor(trA)
corrplot(trA_cor, method='color', addCoef.col='black')
str(trA)

## 산점도 : 선형관계인지 확인
plot(trA)

## 상자그림(boxplot)
par(mfrow=c(2,2))
boxplot(trA$temp, trA$atemp, trA$humidity, trA$windspeed)
boxplot(trA$atemp)
## barplot
tbltemp<-table(trA$temp)
barplot(tbltemp)

###phone.csv
df<-read.table('E:/Bigdata/dataset/phone/phone.csv', sep=',')
df

### 어떤 조건에 만족하는 행의 번호를 얻겠다.
### which(조건문) : 조건문이 만족하는 부분을 true가 되는 행의 번호 추출
which(df[,1]==2016)

### 일일 데이터 사용량(V9)가 500BM 이상인 샘플 분류
which(df[,9]>=500)
df[df[,9]>=500, ]

### 데이터 변환
### 분석 목적에 따라 데이터 변환이 효율적인 때가 있다.
### 구간화(binning)
### 군집화(clustering)
names(df)[c(4,5,6,9)]<-c('age', 'height', 'weight', 'useDATA')

### 구간화
cut(df$age, breaks=(1:11)*5)
DegreeOfAge<- table(cut(df$age, breaks=(1:11)*5))
DegreeOfAge
barplot(DegreeOfAge)


### 데이터 변환
### ifelse(조건문, 참일 때 실행값, 거짓일 때 실행값)
df$gen<-ifelse(df$age<30, 'young', 
               ifelse(df$age<69, 'middle',
                    'old')
               )
### 총계(aggregation)
### 두 개 이상의 관측치를 하나의 샘플로 합산
### 군집화
### plot을 찍어본다. 특징이 있는 친구를 모은다.
### k-mean 알고리즘
### 일일 데이터 사용량
km<-kmeans(df[,9], 5)
km
km$centers
km$size
km$iter
km$ifault

a=df[,9]
b=km$cluster
df_cl<-data.frame(value=a, cluster_num=b)
df_cl

### 1번 그룹에 속한 친구들에게 중심값을 치환
km$cluster[km$cluster==1]<-km$centers[1]
km$cluster           

for(i in 1:5){
  km$cluster[km$cluster==i]<-km$centers[i]
}
km$cluster

s_add<-cbind(df, km$cluster)
s_add
