rm(list=ls())
# 정규분포를 따른다는 가정하에
# 귀무가설/대립가설
# 데이터 수가 적으면 t분포, 데이터 수가 많으면 정규분포

#로지스틱 회귀(logistic regression)을 사용하여,
#'범주형 변수'의 '확률'을 예측
#로지스틱 회귀 모델은 x의 함수로 p(y=1)을 예측
data("mtcars")
glmmo<-glm(formula=vs~wt+disp,
           data = mtcars, family=binomial)
summary(glmmo)

#결과 확인
# 01. 체중 계수(wt)는 변수는 별로 중요하지 않다.(긍정적영향)
# 02. 변위계수(displacement)가 중요하다.(부정적영향)

#Deviance
#편차는 일반화된 선형 모델의 적합성을 나타내는 척도
#이는 수치가 높을수록 적합도는 낮다는 것을 의미

#R의 두가지 형태의 deviance
# null deviance : 반응변수(Y)가 절편만 포함한 모델에 의해 얼마나 잘 예측되는지를 보여준다.
# residual deviance : 독립변수(wt, disp)를 포함하면
# 29의 자유도에서 21.4ㅇ로 편차가 감소한다.

nd<-data.frame(wt=2.1, disp=180)
prev<-predict(glmmo, nd, type='response')
prev

plot(mtcars$wt, mtcars$vs, pch=16, xlab='Weight(g)',
     ylab='vs')

summary(glmmo)
range(mtcars$wt)
xwei<-seq(0,6,0.01)
vspred<-predict(glmmo, list(wt=xwei), type='response')


#인공신경망

iris
table(iris$Species)

###
library('caret')
set.seed(0)
idx<-createDataPartition(iris$Species,
                         p=0.7, list=F)
#데이터셋 나누기
idx
irtr<-iris[idx,]
irte<-iris[-idx,]

table(irtr$Species)
table(irte$Species)

#install.packages('nnet')
#install.packages('neuralnet')

library(nnet)
library(neuralnet)
irtrsc<-as.data.frame(sapply(irtr[,-5], scale)) 
#scale함수는 문자가 들어가면 안됨
irtesc<-as.data.frame(sapply(irte[,-5], scale))
irtrsc

## 값을 표준화 시킨 후  5번째열 다시 추가
irtrsc$Species=irtr$Species
irtesc$Species=irte$Species

## 모델 만들기 : nnet
nnmo<-nnet(Species~., data=irtrsc, size=8)

nnpre<-predict(nnmo, newdata=irtesc, type='class')

nnpre<-predict(nnmo, newdata=irtesc, type='raw')
nnpre

table(nnpre, irte$Species, dnn=c('pred', 'act'))


rm(list=ls())
###mtcars
data(mtcars)
library(caret)
set.seed(123)
idx2<-createDataPartition(mtcars$vs,
                          p=0.7, list=F)
mtctr<-mtcars[idx2,]
mtcte<-mtcars[-idx2,]
table(mtctr$vs)
table(mtcte$vs)
library(nnet)
library(neuralnet)
colnames(mtctr)
mtctrsc<-as.data.frame(sapply(mtctr[,-8], scale))
mtctesc<-as.data.frame(sapply(mtcte[,-8], scale))
mtctrsc
mtctrsc$vs<-factor(mtctr$vs)
mtctesc$vs<-factor(mtcte$vs)


nnmo2<-nnet(vs~., data=mtctrsc, size=5)
nnpre2<-predict(nnmo2, newdata=mtctesc, type='class')

table(nnpre2, mtctesc$vs, dnn=c('pred', 'real'))






### hospital
hotr<-read.csv('E:/Bigdata/dataset/sh2ndCompetitionData/train.csv', na.strings =c('','-','NA'))
hotr<-read.csv('E:/Bigdata/dataset/sh2ndCompetitionData/train.csv', na.strings =c('','NA'))

hote<-read.csv('E:/Bigdata/dataset/sh2ndCompetitionData/test.csv', na.strings =c('','-', 'NA'))

hotr<-read.csv('E:/Bigdata/dataset/sh2ndCompetitionData/train.csv')
hote<-read.csv('E:/Bigdata/dataset/sh2ndCompetitionData/test.csv')
hotr$employee1<-as.integer(hotr$employee1)

levels(hotr$employee1)
levels(hotr$employee1)
levels(hote$employee1)
levels(hote$employee2)
str(hotr)
grep('[a-zA-Z]', hotr$sga1)
grep('[a-zA-Z]', hotr$sga1, value=T)


missmap(hotr)
missmap(hote)
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
