rm(list=ls())

# 데이터 불러오기
df <- iris[, c("Sepal.Length", 'Sepal.Width', 'Species')]
df

# 데이터 나누기
## train / valid / test
set.seed(1001)

idx <- sample(x=c('train', 'valid', 'test'),
              size = nrow(df),
              replace =T,
              prob = c(3,1,1))

tr<- df[idx=='train',]
va<- df[idx=='valid',]
te<- df[idx=='test',]

# 데이터 분포 확인
## 색상, 투명도 설정을 위한 scales 패키지.
install.packages('scales')
library(scales)

# train 산점도 그리기
plot(formula = Sepal.Length ~ Sepal.Width,
     data = tr,
     col = alpha(c("black", "blue", "red"), 0.7)[tr$Species],
     main = 'Train - Classification Species')

# vaild 추가하기
points(formula = Sepal.Length~ Sepal.Width,
       data = va,
       pch = 17,
       cex = 1.2,
       col = 'orange')

# test 추가하기
points(formula = Sepal.Length ~ Sepal.Width,
       data = te,
       pch = 15,
       cex = 1.2,
       col = 'cyan')

# 범례 넣기
legend("topright",
       c(levels(df$Species), "valid", "test"),
       pch = c(1,1,1,17,15),
       col = c(alpha(c("black", 'blue', 'red'), 0.7), 'orange', 'cyan'),
       cex = 0.9)

# x와 y로 나누기
## x: Sepal.Length, Sepal.width / y: Species
tr_x <- tr[,-3]
va_x <- va[,-3]
te_x <- te[,-3]

tr_y <- tr[,3]
va_y <- va[,3]
te_y <- te[,3]

# knn 적용하기
## knn 함수 사용을 위해 class 패키지 설치
#install.packages('class')
library(class)

## k=1
set.seed(1000)
knn_1 <- knn(train=tr_x,
             test = va_x,
             cl = tr_y,
             k=1)

# train 산점도 그리기
plot(formula = Sepal.Length ~ Sepal.Width,
     data = tr,
     col = alpha(c('black', 'blue', 'red'), 0.7)[tr$Species],
     main = 'KNN(k=1')

# knn valid 결과 표시
points(formula = Sepal.Length ~ Sepal.Width,
       data = va,
       pch = 17,
       cex = 1.2,
       col = alpha(c('black', 'blue', 'red'),0.7)[knn_1])

# 범례 표시
legend('topright',
       c(paste('train', levels(tr$Species)), paste('valid', levels(va$Species))),
       pch = c(rep(1,3), rep(17,3)),
       col = c(rep(alpha(c('black', 'blue', 'red'),0.7),2)),
       cex = 0.9)

#http://kkokkilkon.tistory.com/15
## k=21