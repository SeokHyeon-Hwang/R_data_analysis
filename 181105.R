# basic
#install.packages('ggvis')
library(ggvis)

mtcars %>% 
  ggvis(~wt, ~mpg, 
        size := input_slider(10, 100),
        opacity := input_slider(0, 1)
  ) %>% 
  layer_points()

## 지도학습
## 분류 - knn 알고리즘, 의사결정트리
## 회귀 - lm()
## 비지도학습
## 분류 - kmeans
## knn(직관적이고 빠르다) vs kmeans : 전자는 레이블을 주고 나눠라 
## 후자는 레이블 안주고 알아서 레이블 나눠라 

##산점도 시각화 패키지
#install.packages('ggvis', dependencies = T)
library(ggvis)

## KNN 분류를 위한 패키지 설치
#install.packages('class', dependencies = T)
library(class)

## 분류 예측 값 비교 패키지 설치
#install.packages('gmodels', dependencies = T)
library(gmodels)

search()

iris %>%
  ggvis(~iris$Sepal.Length, ~iris$Sepal.Width, fill=~Species) %>%
  layer_points()

iris

iris %>%
  ggvis(~Petal.Length, ~Petal.Width, fill=~Species) %>%
  layer_points()

##04-1 정규화 함수 만들기
normalize <- function(x) {
  num<-x-min(x)
  denom<-max(x)-min(x)
  return(num/denom) # 0과 1사이 값이 됨
}


## 04-2 정규화 시키기 cf:표준화함수:스케일
iris_norm<-as.data.frame(lapply(iris[1:4], normalize))
summary(iris_norm)

## iris$Sepal.Length(꽃받침 길이) 정규화(0~1)

## 05
set.seed(1234)
idx<-sample(1:150, nrow(iris_norm)*0.7, replace=F)
tr<-iris_norm[idx,]
te<-iris_norm[-idx,]

trta<-iris[idx,5] # 타겟(레이블 만들기)
teta<-iris[-idx,5]

## 06. knn 모델 만들기
irispred<-knn(train=tr, test=te, cl=trta, k=3)
irispred

## 07. 확인하기
CrossTable(x=teta, y=irispred, prop.chisq = F)


# ggivs 예제
mtcars %>%
  ggvis(~wt, ~mpg,
        size :=input_slider(10,100),
        opacity :=input_slider(0,1)
         ) %>%
  layer_points


## 점크기와 투명도 조절
mtcars %>%
  ggvis(~wt) %>%
  layer_histograms(width = input_slider(0, 2, step=0.10, label='width'),
                   center=input_slider(0,2, step=0.05, label='center'))

keys_s<-left_right(10,1000,step=50)
mtcars %>% ggvis(~wt, ~mpg, size :=keys_s, opacity :=0.5) %>% layer_points()

## tooltip
mtcars %>% ggvis(~wt, ~mpg) %>%
  layer_points() %>%
  add_tooltip(function(df) df$wt)

## 텍스트 쓰기
df<-data.frame(x=1:3, y=c(1,3,2), label=c('a','b','c'))
df %>% ggvis(~x, ~y, text :=~label) %>% layer_text()
