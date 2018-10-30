rm(list=ls())
library('caret')
set.seed(1712)

inTrain<-createDataPartition(y=iris$Species,
                             p=0.7, list=F)
training <- iris[inTrain,]
testing <- iris[-inTrain,]
training
testing

training.data <- scale(training[-5])
summary(training.data)

iris.kmeans <- kmeans(training.data[,-5], centers = 3, iter.max = 10000)
iris.kmeans$centers

training$cluster <- as.factor(iris.kmeans$cluster)
qplot(Petal.Width, Petal.Length, colour = cluster, data = training)
table(training$Species, training$cluster)

install.packages("NbClust")
library(NbClust)

nc <- NbClust(training.data, min.nc = 2, max.nc = 15, method = "kmeans")

par(mfrow=c(1,1))
barplot(table(nc$Best.n[1,]),
        xlab="Numer of Clusters", ylab="Number of Criteria",
        main="Number of Clusters Chosen")

wssplot <- function(data, nc = 15, seed = 1234) {
  wss <- (nrow(data) - 1) * sum(apply(data, 2, var))
  for (i in 2:nc) {
    set.seed(seed)
    wss[i] <- sum(kmeans(data, centers=i)$withinss)}
  plot(1:nc, wss, type="b", xlab = "Number of Clusters",
       ylab = "Within groups sum of squares")}

wssplot(training.data)

install.packages("e1071")
library(e1071)
training.data <- as.data.frame(training.data)
modFit <- train(x = training.data[,-5], 
                y = training$cluster,
                method = "rpart")
testing.data <- as.data.frame(scale(testing[-5]))
testClusterPred <- predict(modFit, testing.data) 
table(testClusterPred ,testing$Species)
