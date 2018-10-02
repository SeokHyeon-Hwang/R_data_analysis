rm(list=ls())
# 비료투입량과 수확량 간의 상관계수 구하기
x<-c(25,20,18,15,14,8)
y<-c(45,38,32,24,22,10)

plot(y~x)
cor.test(x,y)


#02. EuStockMarkets
data('EuStockMarkets')
dim(EuStockMarkets)
head(EuStockMarkets)
help(EuStockMarkets)
#독일, 스웨덴, 프랑스, 영국 주가지표

# 03. 통계 확인
var(EuStockMarkets[,'DAX'])
sd(EuStockMarkets[,'DAX'])

var(EuStockMarkets[,'SMI'])
sd(EuStockMarkets[,'SMI'])

var(EuStockMarkets[,'CAC'])
sd(EuStockMarkets[,'CAC'])

var(EuStockMarkets[,'FTSE'])
sd(EuStockMarkets[,'FTSE'])

# 분포의 비대칭성
# 왜도와 첨도
install.packages('fBasics')
library(fBasics)
#왜도
skewness(EuStockMarkets[,'DAX'])
#첨도
kurtosis(EuStockMarkets[,'DAX'])

# 상관계수, heatmap - 상관계수 확인, heapmap 그리기
# hist(나라별) - par(mfrow=c(2,2))
# plot()국가별 주가 시계열

esm<-cor(EuStockMarkets)
library(corrplot)
corrplot(esm, addCoef.col = 'red')
corrplot(esm, method='ellipse')

par(mfrow=c(2,2))
hist(EuStockMarkets[,'DAX'])
hist(EuStockMarkets[,'SMI'])
hist(EuStockMarkets[,'CAC'])
hist(EuStockMarkets[,'FTSE'])

str(EuStockMarkets)
DAX_ts<-ts(EuStockMarkets[,'DAX'])
SMI_ts<-ts(EuStockMarkets[,'SMI'])
CAC_ts<-ts(EuStockMarkets[,'CAC'])
FTSE_ts<-ts(EuStockMarkets[,'FTSE'])

plot.ts(DAX_ts)
plot.ts(SMI_ts)
plot.ts(CAC_ts)
plot.ts(FTSE_ts)



# house_price
df<-read.table('E:/Bigdata/dataset/housing.csv', sep='', stringsAsFactors = F)
coln<-c('crim', 'zn', 'indus','chas','nox','rm','age','dis','rad','tax','ptratio','black','lstat','medv')
colnames(df)<-coln
str(df)
summary(df)
grep('[a-zA-Z]',df$rm)
grep('[a-zA-Z]', df$rm, value=T)
df[grep('[a-zA-Z]', df$rm),'rm']<-NA
grep('[a-zA-Z]',df$dis)
df[grep('[a-zA-Z]', df$dis), 'dis']<-NA
df$dis
df[,'rm']<-as.numeric(df[,'rm'])
df[,'dis']<-as.numeric(df[,'dis'])


sapply(df, is.numeric)  # 자료형 중에 numeric만 확인
sapply(df, is.character)
sapply(df, function(x) {sum(is.na(x))})  # 무명함수, na의 수 확
sapply(df, function(x) {grep('[a-zA-Z]', x)})  #문자가 들어간 행 확인



a<-function(x){
  sum(is.na(x))
}


# df$medv가 상관계수가 가장 높은 것 3가지
# cor.test() 가설 검정 확인
# medv 외에 서로 상관계수가 높은게 있는지.

cor_df<-cor(df)
cor_df
corrplot(cor_df, addCoef.col = 'red')


####
Girl<-c('low','low','low','low','low','low','low',
     'low','low','low','low', 'high','high',
     'high','high','high','high','high')
Boy<-c('low','low','low','low','low','low'
       ,'low','low','low','low','low','low'
       ,'low','low','low','low','low','high',
       'high','high','high','high')
dff<-data.frame()
Girl

g<-c(11,7)
b<-c(17,5)

dff<-read.csv('E:/Bigdata/dataset/kai.csv')
dff

# Empty dataframe
expDat <- data.frame()

# Loop that makes i = 1, then i = 2, then i = 3
for (i in 1:3){
  # Makes row i and column 1 into the expected value
  expDat[i,1] <- (sum(data[i,]) * sum(data[,1])) / sum(data)
  # Makes row i and column 1 into the expected value
  expDat[i,2] <- (sum(data[i,]) * sum(data[,2])) / sum(data)
  #Add a line that calculates the third column values
  expDat[i,3] <- 
}

# Print expected values
expDat