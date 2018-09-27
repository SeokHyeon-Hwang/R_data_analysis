rm(list=ls())

# 00. 데이터 불러오기
trdf<-read.csv('E:/Bigdata/dataset/2ndCompetitionData_copy/train.csv', na.strings=c('',NA))
tedf<-read.csv('E:/Bigdata/dataset/2ndCompetitionData_copy/test.csv', na.strings=c('',NA))
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

plot(tr$OC,tr$revenue1, main='Open/Close별 매출액',
     xlab='op/clo',
     ylab='매출액',
     col='yellow')


#trcor<-tr[,c('inst_id','sgg')]
#cor(tr2)
