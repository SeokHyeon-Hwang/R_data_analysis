rm(list=ls())
#install.packages('faraway')
data(pima, package='faraway')
head(pima)
str(pima)
?pima
str(pima)
# test: 종속변수
pima$test<-factor(pima$test)
idx<-sample(nrow(pima)/2)
tr<-pima[idx,]
te<-pima[-idx,]
str(te)

(glmmo<-glm(tr$test~., data=tr, family='binomial' ))
summary(glmmo)

(act<-te[,'test'])  # 실제값
#예측
(pred<-predict(glmmo,newdata=te, type='response'))
(pred<-ifelse(pred>=0.5, 1, 0))
table(pred, act)

pred=as.factor(pred)
act=as.factor(act)

#install.packages('e1071')
#library(e1071)
library(caret)
confusionMatrix(pred,act)

install.packages('ROCR')
library(ROCR)
pred1=predict(glmmo, newdata=te, type='response')
pred3=prediction(pred1, act)

str(pred3)
performance(pred3, 'auc')
performance(pred3, 'tpr')
performance(pred3, 'fpr')
performance(pred3, 'prec')
plot(performance(pred3, 'tpr', 'fpr'))


## mtcars
#01
data(mtcars, package='datasets')
str(mtcars)

#02 mpg, am, vs
colnames(mtcars)
coln<-c('mpg','am','vs')
mtsb<-mtcars[, coln]
mtsb$vs<-as.factor(mtsb$vs)
idx2<-sample(nrow(mtsb)*0.7)
mtr<-mtsb[idx2,]
mte<-mtsb[-idx2,]
str(mtsb)

#03&04 glm
(glmmo2<-glm(mtr$vs~., data=mtr, family='binomial'))
summary(glmmo2)

act2<-mte[,'vs']

(pred1<-predict(glmmo2, newdata=mte, type='response'))
(pred1<-ifelse(pred1>=0.5,1,0))
table(pred1,act2)

pred1<-as.factor(pred1)
act2<-as.factor(act2)
library(caret)
confusionMatrix(pred1,act2)

#05 ROCR
library(ROCR)
(pred3<-prediction(pred1,act2))
str(pred3)
performance(pred3, 'auc')
performance(pred3, 'tpr')
performance(pred3, 'fpr')
performance(pred3, 'prec')
plot(performance(pred3,'tpr','fpr'))
 