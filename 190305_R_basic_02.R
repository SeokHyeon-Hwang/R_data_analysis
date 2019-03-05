
# 상관분석
## 인과관계 없다.
cor(iris[,1:4])

# 회귀분석의 가정

# 데이터 마이닝
## 회귀분석
## 분류분석
data(mtcars)
str(mtcars)
model1<-lm(mpg~cyl, data=mtcars) # 단순선형
model2<-lm(mpg~cyl+qsec, data=mtcars) # 다중선형
modelall <- lm(mpg~., data=mtcars)

## 단순 선형 회귀 분석, 다중 선형 회귀 분석, 곡선 회귀
## y = ax1 + ax2 + ax3**2

### 변수 선택법
## 후진 제거법
## 전진 선택법
## 단계적 회귀법(stepwise regression)

step(modelall, direction ='backward')
step(modelall, direction ='forward')
step(modelall, direction = 'both')

### 분류
## 로지스틱 회귀 0/1
## 다항 로지스틱 
## 서수 로지스틱 회귀 - 2개 이상의 순서가 있는 범주 예측

## 의사결정트리
## caret - 다양한 classification 모아둔 패키지
## caret - 중요도 산출 (varImp)

library(rpart)
(m <-rpart(Species~., data=iris))
plot(m, compress=TRUE, margin=.2)
text(m, cex=1.5)

### 엔트로피, 분류오류율, 지니계수로 나눠준다.