
rm(list=ls())
#가설 검정
#data:Cars93 in MASS package
#귀무가설:생산국에 대해 자동차 가격의 평균은 차이가 없다.
#대립가설:생산국에 대해 자동차 가격의 평균은 차이가 있다.

library(MASS)
car<-Cars93

#EDA
str(car)
colnames(car)
car<-car[,c(5,26)]
str(car)
summary(car)

#box plot
boxplot(Price~Origin,
        data=car,
        main='Boxplot of Price by Origin',
        xlab='Origin',
        ylab='Price')

#hist
library(ggplot2)

q<-ggplot(car, aes(x=Price))+
  geom_histogram(binwidth=5)+
  facet_grid(Origin~.)+
  ggtitle('Hist of Price by Origin')
q

# independent two sample t-test
t.test(Price~Origin,
       data=car,
       alternative=c('two.sided'),
       var.equal=F,
       conf.level=0.95)


# p-value : 0.34>0.05 => adopt the null hypothesis(H0).


rm(list=ls())
#2 target:medv(house price)

#2-1 create model
library(MASS)
bos<-Boston

## EDA
str(bos)
summary(bos)
dim(bos)
boxplot(bos$medv, main='House price in Boston')

# look at the data description, we'will see the factor
# but sta() not factor but int
# chas, rad
plot(bos$chas)
plot(bos$rad)
bos$chas<-factor(bos$chas)
bos$rad<-factor(bos$rad)

# divide data set tr:te=7:3
set.seed(123)
idx<-sample(1:nrow(bos), size=nrow(bos)*0.7, replace=F)
bostr<-bos[idx,]
boste<-bos[-idx,]
dim(bostr);dim(boste)

# linear model
boslm<-lm(medv~., data=bos)

# Through step function, get important variables
bosstep<-step(boslm, direction='both')
bosstep$anova

# Through linear model, predict value
bospred=predict(bosstep, newdata=boste, type='response')
head(bospred)

# Performance Evaluation
pe1<-mean((boste$medv-bospred)^2)
pe1

# Ensemble technique
library(randomForest)
bosrf<-randomForest(medv~., data=bostr, mtry=6) # 6 of desctription value
bosrf

plot(bosrf)

# value importance check
importance(bosrf)
# IncNodePurity
# rm: number of room = 9999
# lstat : social, economical status = 9802
varImpPlot(bosrf)

# performance evaluation
rf.yhat<-predict(bosrf, newdata=boste)
pe2<-mean(rf.yhat-boste$medv)
pe2
pe1
# pe1 = 18.18, pe2 = 0.11
# conclusion : bosrf is better than boslm. Because difference in predicted value & actual value is the smaller. In other words, predicted value is close to the actual value.


# 2-2 From model, predict value and evaluate performance
## 2-2-1 MSE
### data: USceral, package 'MASS'
data(UScereal, package='MASS')
dim(UScereal)
idx<-sample(nrow(UScereal)/2)
### make a model
### predict the calories of the cereals that Americans enjoy.
m<-lm(calories~protein+fat+sugars, data=UScereal[idx, -1])
pred<-predict(m, newdata=UScereal[-idx,-1])
### obtain MSE prediction error
error<-pred-UScereal[-idx, 'calories']
error
mean(abs(error))

## 2-2-2 AUC
### data : pima, package 'faraway'
### Predicting diabetes for American Indians
### divide data by train & test
library(faraway)
data(pima, package='faraway')
pima$test<-factor(pima$test)
idx<-sample(nrow(pima)/2)

### make a model and predict a value
m<-glm(test~ pregnant+glucose+bmi, family=binomial, data=pima[idx,])
m

pred<-as.integer(predict(m, newdata=pima[-idx,], type='response')>0.5)
pred

actual<-pima[-idx, 'test']
xt=xtabs(~pred+actual)
xt

prop.table(xt)

###calculation using function
### confusion matrix
#install.packages('caret')
#install.packages('e1071')
library(caret)
pred<-as.factor(pred)
confusionMatrix(pred, actual)

###ROCR
#install.packages('ROCR')
library(ROCR)
pred_prob<-predict(m, newdata=pima[-idx,], type='response')
pred_prob
labels<-pima[-idx, 'test']

pred3<-prediction(pred_prob, labels)
plot(performance(pred3, 'tpr', 'fpr'))
performance(pred3, 'auc')

# Sensitivity, Specificity
par(mfrow=c(1,2))
plot1<-performance(pred3, 'prec', 'rec')
plot2<-performance(pred3, 'sens', 'spec')

plot(plot1)
plot(plot2)


rm(list=ls()) 
# 실습과제 2 & 3
## 데이터셋 기본 탐색
### 데이터 불러오기
trdf<-read.csv('D:/bigdata/dataset/dacon_hospital/train.csv', na.strings = c('', '-', 'NA'))
tedf<-read.csv('D:/bigdata/dataset/dacon_hospital/test.csv', na.strings = c('', '-', 'NA'))
tr<-trdf
te<-tedf
### dim, str, names 등
dim(tr)
str(tr)
names(tr)
summary(tr)
table(tr$sido); table(te$sido)

### Amelia 패키지의 missmap으로 결측치 확인
library(Amelia)
missmap(tr)

### 데이터 전처리
#### sido, instkind 레벨 맞추기
coln<-c('busan', 'choongbuk', 'choongnam', 'daegu', 'daejeon', 'gangwon', 'gwangju','gyeongbuk', 'gyeonggi', 'gyeongnam','incheon',
        'jeju', 'jeonbuk', 'jeonnam', 'sejong', 'seoul', 'ulsan')
tr$sido<-factor(tr$sido, levels = coln)
te$sido<-factor(te$sido, levels = coln)
table(tr$sido) ; table(te$sido)
table(tr$instkind); table(te$instkind)
summary(tr$instkind); summary(te$instkind)
coln2<-c('clinic', 'dental_clinic', 'general_hospital', 'hospital', 'nursing_hospital', 'traditiona_hospital', 'traditional_clinic')
tr$instkind<-factor(tr$instkind, levels=coln2)
te$instkind<-factor(te$instkind, levels=coln2)

#### 0과 1을 level로 갖는 OC로 변환(factor)
summary(tr$OC);summary(te$OC)
missmap(tr)
tr$OC<-ifelse(tr$OC=='open', 1, 0)
tr$OC<-as.factor(tr$OC)
summary(tr$OC)
levels(tr$OC)
te$OC<-ifelse(te$OC=='open', 1, 0)
te$OC<-as.factor(te$OC)
str(te$OC)

#### tr 데이터 결측치 처리
missmap(tr)

##### 결측치 처리 함수 만들기
###### 최빈값 함수
getmode<-function(v){
  uniqv<-unique(v)
  uniqv[which.max(tabulate(match(v,uniqv)))]
}
###### 결측치 처리 함수
####### wantedval : 'mean', 'median', 'mode'
naprocess<-function(dfna, sel, wantedval='mean'){
  for (i in sel){
    type = class(dfna[[i]])
    
    if (wantedval=='mean'){
      val=mean(dfna[[i]], na.rm=T)
      loc=which(is.na(dfna[[i]]))
    }
    else if (wantedval=='median'){
      val=median(dfna[[i]], na.rm=T)
      loc=which(is.na(dfna[[i]]))
    }
    else if (wantedval=='mode'){
      val=getmode(dfna[[i]])
      loc=which(is.na(dfna[[i]]))
    }
    
    if (type=='numeric'){
      dfna[loc,i]=as.numeric(val)
    }
    else if (type=='integer'){
      dfna[loc,i]=as.integer(val)
    }
    else if (type=='factor'){
      dfna[loc,i]=val
    }
  }
  return(dfna)
}

##### 함수이용 결측치 처리
###### instkind[7]:최빈값, bedCount[6]:중앙값, employee1[56]:중앙값, employee2[57]:중앙값, ownerChange[58]:최빈값 
#colnames(tr)
tr1<-naprocess(tr, sel=c(7,58), 'mode')
missmap(tr1)
tr1<-naprocess(tr1, sel=c(6,56,57), 'median')
missmap(tr1)
###### 결측치 행 삭제
tr1<-tr1[!is.na(tr1$revenue1),]
missmap(tr1)

#### te 데이터 결측치 처리
missmap(te)
##### 함수이용 결측치 처리
###### openDate[5]:중앙값, instkind[7]:최빈값, bedCount[6]:중앙값, employee1[56]:중앙값, employee2[57]:중앙값, ownerChange[58]:최빈값
#names(te)
te$employee1<-as.integer(te$employee1)
te$employee2<-as.integer(te$employee2)
te1<-naprocess(te, sel=c(7,58), 'mode')
te1<-naprocess(te1, sel=c(5,6,56,57),'median')
missmap(te1)

##### 나머지 결측치 처리
#str(te1)
###### 함수 만들고 실행하여 결측치 처리
lenval=length(te1)
for (i in 1:lenval){
  type=class(te1[[i]])
  namevar=names(te1)[i]
  ### type==int
  if (type=='integer'){
    intval=median(te1[[i]], na.rm=T)
    loc=which(is.na(te1[[i]]))
    te1[loc,namevar]=as.integer(intval)
    print(te1[loc,namevar])
  }
  ### type==factor
  if (type=='factor'){
    val=getmode(te1[[i]])
    loc=which(is.na(te1[[i]]))
    te1[loc,namevar]=val
  }
  ### type==numeric
  if (type=='numeric'){
    meanval=median(te1[[i]], na.rm=T)
    loc=which(is.na(te1[[i]]))
    te1[loc,namevar]=meanval
    print(te1[loc,namevar])
  }
}

loc1=which(names(te1)=='OC')
te1=te1[,-loc1]
missmap(te1)

## 유의한 변수 찾기

glmmo<-glm(OC~., data=tr1, family = 'binomial')
summary(glmmo)
step_glmmo<-step(glmmo, direction='both')
### from step(), I get AIC=50,
### OC ~ inst_id + bedCount + instkind + revenue1 +
### receivableS1 + inventoryAsset1 + tanAsset1 +
### netAsset1 + surplus1 + revenue2 + interest2 +
### profit2 + inventoryAsset2 + nonCAsset2 +
### liquidLiabilities2 + surplus2 + employee1 +
### employee2 + ownerChange

## 파생변수 생성

tr1$rev12<-tr1$revenue1-tr1$revenue2
head(tr1$rev12)
tr1$receiv12<-tr1$receivableS1-tr1$receivableS2
head(tr1$rev12)
tr1$invent12<-tr1$inventoryAsset1-tr1$inventoryAsset2
tr1$surp12<-tr1$surplus1-tr1$surplus2

te1$rev12<-te1$revenue1-te1$revenue2
head(te1$rev12)
te1$receiv12<-te1$receivableS1-te1$receivableS2
head(te1$rev12)
te1$invent12<-te1$inventoryAsset1-te1$inventoryAsset2
te1$surp12<-te1$surplus1-te1$surplus2
str(te1$surplus1)
str(te1$surplus2)
str(te1$surp12)





glmmo2<-glm(OC~., data=tr1, family='binomial')
summary(glmmo2)
step_glmmo2<-step(glmmo2, direction='both')




### from step(), I get AIC=50, but it is not useful.
### OC ~ inst_id + bedCount + instkind + revenue1 +
### receivableS1 + inventoryAsset1 + tanAsset1 +
### netAsset1 + surplus1 + revenue2 + interest2 +
### profit2 + inventoryAsset2 + nonCAsset2 +
### liquidLiabilities2 + surplus2 + employee1 +
### employee2 + ownerChange

# predict

pred_glm<-predict(step_glmmo, newdata=te1, type='response')
pred_glm

pred_glm2<-predict(step_glmmo2, newdata=te1, family='binomial', type='response')
pred_glm2

# 3-3

# Divide dataset 7:3
idx<-sample(1:nrow(tr1), size = nrow(tr1)*0.7, replace = F)
tr7<-tr1[idx,]
te3<-tr1[-idx,]

glmmo7<-glm(OC~., data=tr7, family = 'binomial')
summary(glmmo7)
step_glmmo7<-step(glmmo7, direction='both')

#predict
#pred_glm7<-predict(glmmo7, newdata=te3, type='response')
pred_step_glm7<-predict(step_glmmo7, newdata=te3, type='response')
pred_step_glm7

# Divide dataset 6:4
idx2<-sample(1:nrow(tr1), size = nrow(tr1)*0.6, replace=F)
tr6<-tr1[idx,]
te4<-tr1[-idx,]

glmmo6<-glm(OC~., data=tr6, family = 'binomial')
summary(glmmo6)
step_glmmo6<-step(glmmo6, direction='both')

pred_step_glm6<-predict(step_glmmo6, newdata=te4, type='response')
pred_step_glm6


# submission
sub<-read.csv('D:/bigdata/dataset/dacon_hospital/submission_sample.csv')

sub$OC<-pred_step_glm7

write.csv(sub, file='sub1022.csv', row.names=F)


