rm(list=ls())

# 00. 데이터 불러오기
trdf<-read.csv('D:/bigdata/dataset/Mouda_data/train.csv', na.strings=c('',NA))
tedf<-read.csv('D:/bigdata/dataset/Mouda_data/test.csv', na.strings=c('',NA))
tr<-trdf
te<-tedf
# 01. 탐색&요약정리
str(tr)
str(te)
summary(tr)

# 02. EDA
trta_sido<-table(tr$sido)
trta_instkind<-table(te$instkind)
rm(mfrow)
par(mfrow=c(2,1))
plot(trta_sido, main='시도별 병원 현황',
     xlab = '시도',
     ylab = '개수',
     col='blue',
     las=2)

plot(trta_instkind, main='종류별 병원 현황',
     xlab = '종류',
     ylab = '개수',
     col='blue',
     las=1)


#tr$OC에서 ' close'를 'close'로 변경
table(tr$OC)
library(dplyr)
filter(tr, tr$OC==' close') 
tr[tr$OC==' close', 'OC'] <- 'close'
colN=c('close', 'open')
tr$OC=factor(tr$OC, levels=colN)
str(tr$OC)

#숫자 지수표기 숫자표기로 변경
options('scipen'=100)


plot(tr$OC,tr$revenue1, main='Open/Close별 매출액',
     xlab='op/clo',
     ylab='매출액',
     col='yellow')

plot(tr$OC, tr$surplus1, main='OP/CL별 이익잉여금',
     xlab='op/clo',
     ylab='이익잉여금',
     col='yellow')

str(tr)
plot(tr$sido, tr$OC, main='시도별 op/cl 현황',
     xlab='시도',
     ylab='op/cl',
     las=2)

plot(tr$instkind, tr$OC, main='병원 종류별 op/cl 현황',
     xlab='병원 종류',
     ylab='op/cl')

plot(tr$OC, tr$bedCount, main='op/cl별 침대수 현황',
     xlab='op/cl',
     ylab='침대수',
     col='yellow')

library(ggplot2)
ggplot(data=tr, aes(x=OC, y=revenue1), fill='yellow')+geom_boxplot()
ggplot(data=tr, aes(x=instkind, y=OC))+geom_bar(stat='identity')
ggplot(data=tr, aes(x=OC, y=bedCount))+geom_point()
ggplot(data=tr, aes(x=sido, y=OC))+geom_bar(stat='identity')


#trcor<-tr[,c('inst_id','sgg')]
#cor(tr2)

# 03. summary()
summary(tr)


# 04. bedCount와 다른 변수간의 heatmap & 상관관계 분석
str(tr)
trcor<-tr[,c('bedCount','revenue1', 'revenue2', 'profit1','profit2',
             'surplus1', 'surplus2')]
str(trcor)
cor(trcor, use='complete.obs')
library(corrplot)
trcor_corr<-cor(trcor, use='complete.obs')
corrplot(trcor_corr, addCoef.col='red')
