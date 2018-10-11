rm(list=ls())

tedf<-read.csv('E:/Bigdata/dataset/2ndCompetitionData/test.csv', stringsAsFactors=F, na.string=c('', '-', 'NA'))
trdf<-read.csv('E:/Bigdata/dataset/2ndCompetitionData/train.csv', stringsAsFactors=F, na.string=c('', '-', 'NA'))

library(dplyr)
library(Amelia)
library(corrplot)

#03. 데이터 프레임 백업하기
tr<-trdf
te<-tedf

table(te$employee1, useNA='always')
table(tr$employee1, useNA='always')


tr$OC<-ifelse(tr$OC=='open', 1, 0)
tr$OC<-as.factor(tr$OC)

# 모델용, 검증용 데이터셋 레벨 맞추기
# sido, instkind

colN = c("busan", "choongbuk", "choongnam", "daegu", "daejeon",
         "gangwon", "gwangju", "gyeongbuk", "gyeonggi", "gyeongnam",
         "incheon", "jeonbuk", "jeonnam", "sejong", "seoul",
         "ulsan", "jeju")

tr$sido<-factor(tr$sido, levels=colN)
str(tr$sido)
te$sido<-factor(te$sido, levels=colN)

levels(tr$sido);levels(te$sido)


coln = c("", "clinic", "dental_clinic", "general_hospital", "hospital" ,
         "nursing_hospital", "traditional_clinic", "traditional_hospital")

tr$instkind<-factor(tr$instkind, levels=coln)
te$instkind<-factor(te$instkind, levels=coln)

levels(tr$instkind); levels(te$instkind)

table(tr$instkind, useNA='always'); table(te$instkind, useNA='always')

missmap(tr)
colnames(tr)
names(tr)
rownames(tr)
dim(tr)
length(tr)
length(rownames(tr))

loc0=which(names(tr)=='openDate')
loc0
tr<-tr[, -loc0]

# ownerChange를 범주형으로
tr$ownerChange<-as.factor(tr$ownerChange)



# 파생변수 추가 emp12nasales
loc1<-which(is.na(tr$employee1) &
              is.na(tr$employee2) &
              tr$salescost1==0
            )
tr[loc1, 'emp12nasales']=1
tr[-loc1, 'emp12nasales']=0
table(tr$emp12nasales)

loc2<-which(is.na(tr$employee1) &
              is.na(tr$employee2) 
              )

tr[loc2, 'emp12na']=1
tr[-loc2, 'emp12na']=0
table(tr$emp12na)

loc1=which(names(tr)=='bedCount')
loc2=which(names(tr)=='employee1')
loc3=which(names(tr)=='employee2')
loc4=which(names(tr)=='ownerChange')
loc5=which(names(tr)=='instkind')

tr<-NAProcess2(tr, loc1, 'SpVal')  
tr<-NAProcess2(tr, loc2, 'SpVal')
tr<-NAProcess2(tr, loc3, 'SpVal')
tr<-NAProcess2(tr, loc4, 'mode')
tr<-NAProcess2(tr, loc5, 'mode')

tr<-tr[!is.na(tr$interest1),]
missmap(tr)


loc0=which(names(te)=='openDate')
loc0
te<-te[, -loc0]

# ownerChange를 범주형으로
tr$ownerChange<-as.factor(tr$ownerChange)

# OC 컬럼명 삭제
loc1=which(names(te)=='OC')
te=te[,-loc1]

# employee1,2, ownerChange 자료형 변경 
str(te)
te$employee1<-as.integer(te$employee1)
te$employee2<-as.integer(te$employee2)
te$ownerChange<-as.factor(te$ownerChange)
missmap(te)

# 파생변수 추가 emp12nasales
loc1<-which(is.na(te$employee1) &
              is.na(te$employee2) &
              te$salescost1==0
)
te[loc1, 'emp12nasales']=1
te[-loc1, 'emp12nasales']=0
table(te$emp12nasales)

loc2<-which(is.na(te$employee1) &
              is.na(te$employee2) 
)

te[loc2, 'emp12na']=1
te[-loc2, 'emp12na']=0
table(te$emp12na)

missmap(te)


loc1=which(names(te)=='bedCount')
loc2=which(names(te)=='employee1')
loc3=which(names(te)=='employee2')
loc4=which(names(te)=='ownerChange')
loc5=which(names(te)=='instkind')

te<-NAProcess2(te, loc1, 'SpVal')
te<-NAProcess2(te, loc2, 'SpVal')
te<-NAProcess2(te, loc3, 'SpVal')
te<-NAProcess2(te, loc4, 'mode')
te<-NAProcess2(te, loc5, 'mode')
missmap(te)

## 06. test결측치 처리 - 나머지 값 결측치 처리
tesub <- te
lenVar = length(tesub)
## 해당되는 변수의 평균값을 구하고 결측치를 평균값으로 넣기
for (i in 1:lenVar) {
  type = class(tesub[[i]])
  nameVar = names(tesub)[i]
  ### int 일때,
  if (type=="integer") {
    
    intVal = median( tesub[[i]] , na.rm=T)
    loc = which(is.na(tesub[[i]]))   # 위치 확인
    # tesub[loc,]
    # tesub[loc,nameVar ] = as.integer(intVal)
    tesub[loc,nameVar ] = 0
    print(tesub[loc,nameVar])
  }
  
  ### Factor 일때, 
  if (type=="factor") {
    Val = getmode(tesub[[i]])
    loc = which(is.na(tesub[[i]]))   # 위치 확인
    tesub[loc,nameVar ] = Val
  }
  
  ### num 일때, 
  if (type=="numeric") {
    meanVal = median( tesub[[i]] , na.rm=T)
    loc = which(is.na(tesub[[i]]))   # 위치 확인
    # test_sub[loc,]
    # test_sub[loc,nameVar ] = meanVal
    tesub[loc,nameVar ] = 0
    print(tesub[loc,nameVar])
  }
}
missmap(tesub)
missmap(te)

str(tr$OC)
### randomForest model 만들기
library(randomForest)
rfmo<-randomForest(OC~., data=tr)

#중요도 확인
importance<-importance(rfmo)
varimp<-data.frame(Var=row.names(importance),
                   Importance=round(importance[, 'MeanDecreaseGini'], 2))
vardat<-varimp[order(-varimp$Importance),]
vardat


# 제출용 파일 불러오기
sub<-read.csv('E:/Bigdata/dataset/2ndCompetitionData/submission_sample.csv')

rfmo1<-randomForest(OC~., data=tr)
prediction<-predict(rfmo1, newdata=tesub)
sub$OC<-prediction
sub

lastresult=list(name='inst_id', inst_id=c())
lastresult$all=sub[sub$OC==0, 'inst_id']
lastresult

rfmo2<-randomForest(OC~ profit1+profit2, data=tr)
prediction2<-predict(rfmo2, newdata=tesub)
sub$OC<-prediction2
sub

lr2=list(name='inst_id', inst_id=c())
lr2$profit12=sub[sub$OC==0, 'inst_id']
lr2

rfmo3<-randomForest(OC~ bedCount, data=tr)
prediction3<-predict(rfmo3, newdata=tesub)
sub$OC<-prediction3
sub

lr3=list(name='inst_id', inst_id=c())
lr3$bedc=sub[sub$OC==0, 'inst_id']
lr3

a<-c('q','w','e')
a<-as.factor(a)
class(tr$instkind)
??dir

di(tr$instkind)






# 제출
write.csv(sub, file='sub1011.csv', row.names=F) #bedc 사용 모델
getwd()
