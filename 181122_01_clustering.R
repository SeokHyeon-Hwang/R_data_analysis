### ~~~ Hubert 지수는 클러스터 수를 결정하는 그래픽 방식입니다.
## Hubert 지수의 플롯에서 우리는 a에 해당하는 유의 한 무릎을 찾습니다.
## 측정 값의 유의한 증가, 즉 Hubert의 유의한 피크
## 색인 두 번째 차이점 플롯.

par(mfrow=c(1,1))
barplot(table(nc$best.n[1,]),
        xlab="Numer of Clusters", ylab="Number of Criteria",
        main="Number of Clusters Chosen")
# NbClust 함수는 3개의 군집이 적당하다고 함.

# 3.6 이번에는 some of square means
wssplot <- function(data, nc = 15, seed = 1234) {
  wss<-(nrow(data) - 1) * sum(apply(data, 2, var))
  for (i in 2:nc) {
    set.seed(seed)
    wss[i] <-sum(kmeans(data, centers=i)$withinss)}
  plot(1:nc, wss, type="b", xlab= "Number of Clusters",
       ylab = "Within groups sum of squeares")}

wssplot(training.data)

# 3.7
install.pacjages("e1071")
library(e1071)
training.data <- as.data.frame(training.data)
modFit <- train(x = training.data[,-5],
                y = training$cluster,
                method = "rpart")

testing.data <- as.data.frame(scale(testing[-5]))
testClusterPred <- predict(modFit, testing.data)
table(testClusterPred, testing$Species)

            