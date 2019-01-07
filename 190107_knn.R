iris2<-iris[, 1:4]

k<-c()
km.out.withness<-c()
km.out.between<-c()
for (i in 2:25){
  set.seed(1)
  km.out<-kmeans(iris2, centers=i)
  k[i-1]<-i
  km.out.withness[i-1]<-km.out$tot.withinss
  km.out.between[i-1]<-km.out$betweenss
}
df =data.frame(k, km.out.withness, km.out.between)
df

par(mfrow=c(2,2))

plot(df$k, df$km.out.withness, type='ol', 
     xlab='군집의 개수 k',
     ylab = '그룹 내 제곱합')


plot(df$k, df$km.out.between, type='ol', 
     xlab='군집의 개수 k',
     ylab = '그룹 내 제곱합')

k3 <- kmeans(iris2, centers=3)
k3$centers
k3$cluster # 1~4열까지 -> 군집 번호
k3$size # 각 군집의 개수

table(k3$cluster, iris$Species)

plot(iris2[, 1:4],
     col=k3$cluster,
     pch=ifelse(k3$cluster==1, 16,
                ifelse(k3$cluster==2, 17, 18)),
     cex=2)

##
train <- read.csv('E:/Bigdata/dataset/titanic/train.csv', na.strings = c('', 'NA'))

