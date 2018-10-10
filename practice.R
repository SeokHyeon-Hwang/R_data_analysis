rm(list=ls())
# 1-1
### hospital
hotr<-read.csv('E:/Bigdata/dataset/sh2ndCompetitionData/train.csv', na.strings =c('','-','NA')) # missmap에서 NA 최대
#hotr<-read.csv('E:/Bigdata/dataset/sh2ndCompetitionData/train.csv', na.strings =c('','NA'))

hote<-read.csv('E:/Bigdata/dataset/sh2ndCompetitionData/test.csv', na.strings =c('','-', 'NA'))

#hotr<-read.csv('E:/Bigdata/dataset/sh2ndCompetitionData/train.csv', na.strings ='NA') # missmap에서 NA 최소
#hote<-read.csv('E:/Bigdata/dataset/sh2ndCompetitionData/test.csv')
hotr$employee1<-as.integer(hotr$employee1)

library('Amelia')
levels(hotr$employee1)
levels(hotr$employee1)
levels(hote$employee1)
levels(hote$employee2)
str(hotr)
grep('[a-zA-Z]', hotr$sga1)
grep('[a-zA-Z]', hotr$sga1, value=T)
grep('-', hotr$employee2)

missmap(hotr)
missmap(hote)
str(hote)

str(hotr)
str(hotr$OC);table(hotr$OC)
str(hotr$sido);table(hotr$sido)
str(hote$sido);table(hote$sido)
str(hotr$bedCount)


summary(hotr)
table(hotr$instkind); table(hote$instkind)
table(hotr$OC)
table(hote$OC)

library(Amelia)
missmap(hotr)
missmap(hote)

#levels 일치 시키기
table(hotr$sido); table(hote$sido)
str(hotr$sido)
str(hote$sido)

coln<-c('busan', 'choongbuk', 'choongnam', 'daegu', 'daejeon', 'gangwon', 'gwangju',
        'gyeongbuk', 'gyeonggi', 'gyeongnam', 'incheon', 'jeju', 'jeonbuk', 'jeonnam',
        'sejong', 'seoul', 'ulsan')
hotr$sido<-factor(hotr$sido, levels = coln)
hote$sido<-factor(hote$sido, levels = coln)
str(hote$sido)

table(hotr$instkind); table(hote$instkind)
coln2<-c('clinic', 'dental_clinic', 'general_hospital', 'hospital', 'nursing_hospital',
         'traditiona_hospital', 'traditional_clinic')
hotr$instkind<-factor(hotr$instkind, levels = coln2)
hote$instkind<-factor(hote$instkind, levels = coln2)
table(hotr$instkind); table(hote$instkind)

missmap(hotr)
missmap(hote)

#openDate 열 삭제 : hote에서 결측치 있음.
hotr<-hotr[,-5]
hote<-hote[,-5]
colnames(hotr)
colnames(hote)
#결측치 처리(bedCount, ownerChange,  )
