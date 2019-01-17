
library(caret)
train.idx<-create






## 지도학습의 여러 모델
idx <-createDataPartition(iris$Species, p=0.7, list=F)

irtr <-iris[idx,]
irte <-iris[-idx,]

## 모델 만들기
library(e1071)
mo <- naiveBayes(irtr, irtr$Species, laplace=1)
naive.pred <-predict(mo, irte, type='class')
table(naive.pred, irte$Species)

confusionMatrix(naive.pred, irte$Species)

library(nnet)
mo <-multinom(Species ~., data=irtr)

multi.result<-multinom(Species~., irtr)
multi.pred<-predict(multi.result, irte)
table(multi.pred, irte$Species)

library(rpart)
rpart.result<-rpart(Species~., irtr)
rpart.pred<-predict(rpart.result, irte, type='class')
rpart.pred
table(rpart.pred, irte$Species)
