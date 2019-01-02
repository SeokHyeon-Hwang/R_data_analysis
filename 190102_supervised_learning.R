library(caret)

#idx = sample(1:150, size=100, replace=F)

idx<-createDataPartition(iris$Species, p=0.7, list=F)

iris_train <- iris[idx, ]
iris_test <- iris[-idx, ]
table(iris_test$Species)

### 나이브 베이즈 기법 적용 A:1
library(e1071)
naive.result <- naiveBayes(iris_train, iris_train$Species, laplace=1)
naive.pred <-predict(naive.result, iris_test, type='class')
table(naive.pred, iris_test$Species)
confusionMatrix(naive.pred, iris_test$Species)

# 다항 로지스틱 회귀(0, 1) A:0.9778
library(nnet)
multi.result <- multinom(Species~., iris_train)
multi.pred <- predict(multi.result, iris_test)
table(multi.pred, iris_test$Species)
confusionMatrix(multi.pred, iris_test$Species)

# 의사결정 트리 기법 적용 A:0.9556
library(rpart)
rpart.result <- rpart(Species~., iris_train)
rpart.result
rpart.pred<-predict(rpart.result, iris_test, type="class") #테스트 데이터 이용 평가
table(rpart.pred, iris_test$Species) #분류 결과도출
confusionMatrix(rpart.pred, iris_test$Species)

# 서포트 백터 머신 모델 A:0.9778
library(kernlab)
svm.result<-ksvm(Species~., iris_train, kernel='rbfdot')
svm.pred<-predict(svm.result, iris_test, type='response')
table(svm.pred, iris_test$Species)
confusionMatrix(svm.pred, iris_test$Species)

# 랜덤 포레스트 A:0.9778
library(randomForest)
rand.result<-randomForest(Species~., data=iris_train, ntree=500)
rand.pred<-predict(rand.result, iris_test, type='response')
table(rand.pred, iris_test$Species)
confusionMatrix(rand.pred, iris_test$Species)



idx<-createDataPartition(iris$Species, p=0.8, list=F)

iris_train <- iris[idx, ]
iris_test <- iris[-idx, ]
table(iris_test$Species)

### 나이브 베이즈 기법 적용 7:3,A=1 8:2,A=1
library(e1071)
naive.result <- naiveBayes(iris_train, iris_train$Species, laplace=1)
naive.pred <-predict(naive.result, iris_test, type='class')
table(naive.pred, iris_test$Species)
confusionMatrix(naive.pred, iris_test$Species)

# 다항 로지스틱 회귀(0, 1) A:0.9778 A:0.9667
library(nnet)
multi.result <- multinom(Species~., iris_train)
multi.pred <- predict(multi.result, iris_test)
table(multi.pred, iris_test$Species)
confusionMatrix(multi.pred, iris_test$Species)

# 의사결정 트리 기법 적용 A:0.9556 A:0.9333
library(rpart)
rpart.result <- rpart(Species~., iris_train)
rpart.result
rpart.pred<-predict(rpart.result, iris_test, type="class") #테스트 데이터 이용 평가
table(rpart.pred, iris_test$Species) #분류 결과도출
confusionMatrix(rpart.pred, iris_test$Species)

# 서포트 백터 머신 모델 A:0.9778 A:0.9
library(kernlab)
svm.result<-ksvm(Species~., iris_train, kernel='rbfdot')
svm.pred<-predict(svm.result, iris_test, type='response')
table(svm.pred, iris_test$Species)
confusionMatrix(svm.pred, iris_test$Species)

# 랜덤 포레스트 A:0.9778 A:0.9667
library(randomForest)
rand.result<-randomForest(Species~., data=iris_train, ntree=500)
rand.pred<-predict(rand.result, iris_test, type='response')
table(rand.pred, iris_test$Species)
confusionMatrix(rand.pred, iris_test$Species)


# titanic data
df_tr<-read.csv('E:/Bigdata/dataset/titanic/train.csv')
df_te<-read.csv('E:/Bigdata/dataset/titanic/test.csv')

# 결측치 확인 및 제거
library(Amelia)
missmap(df_tr)
missmap(df_te)
summary(df_te)

library(dplyr)
df_te2<-df_te %>% filter(!is.na(Fare))
missmap(df_te2)

colnames(df_tr)
colnames(df_te)
df_tr2<-df_tr[,-6]
df_te3<-df_te2[,-5]

missmap(df_tr2)
missmap(df_te3)

# 데이터 나누기
colnames(df_tr2)
idx2<-createDataPartition(df_tr2$Survived, p=0.7, list=F)

ti_tr<-df_tr2[idx2,]
ti_te<-df_tr2[-idx2,]
table(ti_te$Survived)

summary(ti_te)
dim(ti_te)
dim(ti_tr)
### 나이브 베이즈 기법 적용 A:1
library(e1071)
naive.result <- naiveBayes(ti_tr, ti_tr$Survived, laplace=1)
naive.pred <-predict(naive.result, ti_te, type='class')
table(naive.pred, ti_te$Survived)
confusionMatrix(naive.pred, ti_te$Survived)

# 다항 로지스틱 회귀(0, 1) A:0.9778
library(nnet)
multi.result <- multinom(Survived~., ti_tr)
multi.pred <- predict(multi.result, ti_te)
table(multi.pred, ti_te$Survived)
confusionMatrix(multi.pred, ti_te$Survived)

# 의사결정 트리 기법 적용 A:0.9556
library(rpart)
rpart.result <- rpart(Survived~., ti_tr)
rpart.result
rpart.pred<-predict(rpart.result, ti_te, type="class") #테스트 데이터 이용 평가
table(rpart.pred, ti_te$Survived) #분류 결과도출
confusionMatrix(rpart.pred, ti_te$Survived)

# 서포트 백터 머신 모델 A:0.9778
library(kernlab)
svm.result<-ksvm(Survived~., ti_tr, kernel='rbfdot')
svm.pred<-predict(svm.result, ti_te, type='response')
table(svm.pred, ti_te$Survived)
confusionMatrix(svm.pred, ti_te$Survived)

# 랜덤 포레스트 A:0.9778
library(randomForest)
rand.result<-randomForest(Survived~., data=ti_tr, ntree=500)
rand.pred<-predict(rand.result, ti_te, type='response')
table(rand.pred, ti_te$Survived)
confusionMatrix(rand.pred, ti_te$Survived)
