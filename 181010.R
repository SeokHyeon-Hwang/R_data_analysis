

# 주성분 분석 함수

data(iris)
df<-iris[, 1:4] # Species를 제외한 데이터 선택
iris.pca<-prcomp(df, scale=T) # 수치간의 표준화 지정
iris.pca

summary(iris.pca)

# PC1 = 0.5210*Sepal.Length - 0.
# PC2 = 
# PC3 = 
# PC4 = 

plot(iris.pca, type='l')
iris.predict<-predict(iris.pca)
iris.predict

biplot(iris.pca)
cor(iris[, -5])

install.packages('HSAUR')
library(HSAUR)

data(heptathlon)
dim(heptathlon)
head(heptathlon)

dat<-heptathlon
dat$hurdles=max(dat$hurdles)-dat$hurdles
dat$run200m=max(dat$run200m)-dat$run200m
dat$run800m=max(dat$run800m)-dat$run800m

hep.data=dat[,-8] # score 변수는 제외
dat.pca<- prcomp(hep.data, scale=T)
names(dat.pca)
dat.pca
summary(dat.pca)
eig.val=dat.pca$sdev^2
eig.val

screeplot(dat.pca, type='lines', pch=19) #pch는 기호
biplot(dat.pca)
