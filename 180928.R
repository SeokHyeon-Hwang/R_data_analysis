###01. 회기식


### Boston 교외 506개 지역의 주택가격의 데이터셋
library(MASS)
?MASS
data('Boston')
bo<-Boston
head(Boston)
str(Boston)
dim(Boston)

### 데이터 셋 7:3, 8:2, 9:1, 6:4, 5:5
###caret
idx<-sample(1:nrow(bo), size = nrow(bo)*0.7, replace=F)
idx
bo_tr<-bo[idx,]
bo_te<-bo[-idx,]

dim(bo_tr); dim(bo_te)
names(bo_tr)
### regression 모델 만들기
lm.model<-lm(medv~., data=bo_tr)
lm.model
summary(lm.model)
## medv=-0.09x+...+28
## p-value가 0.05이하이면 대립가설 채택
## p-value가 0.05보다 크면 대립가설이 아니라 귀무가설에 가깝다.
## 회귀모형은 정규분포를 따른다고 가정하고 만드는 것

##02. 분류모델
## 일반적으로 종속변수가 어떤 경우의 예측 문제에 적용
## 지도학습 - 분류모델
## 종류 : 로지스틱 회귀, KNN 분류, SVM, 결정트리, 랜덤포레스트, 배깅, 부스티, 뉴럴 네트워크(인공신경망)
## 로지스틱 회기는 분석하고자 하는 값이 0/1 두가지 일 때 사용.
## 앙상블기법: 두가지 이상의 모델을 섞어 쓰는 방법 : 랜덤포레스트, 배깅, 부스팅

## 지도학습에는 회귀모델, 분류모델이 있다.
rbinom(1000,1,1)
?rbinom
set.seed(1)
x1=rnorm(1000)
x1
x2=rnorm(1000)
z=1+4*x1+3*x2
pr=1/(1+exp(-z))
hist(pr)
plot(pr)
y=rbinom(1000,1,pr)
y

## x1, x2, y
df=data.frame(y=y, x1=x1, x2=x2)
glm1=glm(y~x1+x2, data=df)
glm2=glm(y~x1+x2, data=df, family='binomial')
str(glm1)


## KNN모델은 비선형 문제에 대해 잘 동작한다.
## 로지스틱과 달리 knn은 변수 여러개도 가능하다.
## 데이터가 많아지면 속도가 느려진다.
data(iris)
library(dplyr)
iris
ir<-sample_n(iris, 150)  # 샘플을 섞었다.

##
tr = ir[1:120,]
te = ir[121:150,]

install.packages('caret')
library(caret)

knn_model=knn3(Species~., data=tr, k=3)
pred=predict(knn_model, newdata=te[,-5], type='class')
table(pred, te$Species)
table(pred)



## mtcars
data('mtcars')
library(dplyr)
mtcars
str(mtcars)
mtc<-sample_n(mtcars, 32)
mtc
mtc$am<-as.factor(mtc$am)
str(mtc)
##
trmtc<-mtc[1:22,]
temtc<-mtc[23:32,]

install.packages('caret')
library(caret)
colnames(temtc)
knn_model_mtc=knn3(am~., data=trmtc, k=5)
summary(knn_model_mtc)
pred<-predict(knn_model_mtc, temtc[, -9], type='class')
table(pred, temtc$am)
