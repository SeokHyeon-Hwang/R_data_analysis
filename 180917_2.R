rm(list=ls())
library('dplyr')
library('ggplot2')
library('ggthemes')
DF<-read.csv('E:/Bigdata/dataset/R2_ex/example_population_f.csv')
DF<-DF[,-1]
DF<-mutate(DF,
           SexF = ifelse(SexRatio<1, '여자비율높음',
                         ifelse(SexRatio>1, '남자비율높음', '남자비율같음')))
DF
DF$SexF<-factor(DF$SexF)
DF$SexF<-ordered(DF$SexF, c('여자비율높음', '남여비율같음', '남자비율높음'))
DF$SexF

DF2<-filter(DF, Provinces=='경기도')
DF2

Graph<-ggplot(DF2, aes(x=City, y=(SexRatio-1), fill=SexF))+
  geom_bar(stat='identity', position='identity')+
  theme_wsj()
Graph

DF4<-filter(DF, Provinces=='서울특별시')
DF4
Graph2<-ggplot(DF4, aes(x=City, y=(SexRatio-1), fill=SexF))+
  geom_bar(stat='identity', position='identity')+
  theme_wsj()
Graph2

rm(list = ls())

DF<-read.csv('E:/Bigdata/dataset/R2_ex/example_studentlist.csv')
search()
attach(DF)
DF$height
DF$weight
x=DF$height
z=(x-mean(x, na.rm=T))/sd(x, na.rm=T)
z
DF_hei_scale<-scale(DF$height)
DF_wei_scale<-scale(DF$weight)
comDF<-data.frame(DF$height, DF$weight, DF_hei_scale, DF_wei_scale)
comDF

mean(DF$height)
sd(DF$height)

mean(DF$weight)
sd(DF$weight)

sd(DF$height)/mean(DF$height)
sd(DF$weight)/mean(DF$weight)

par(mfrow=c(1,2))
boxplot(DF$height)
boxplot(DF$weight)

x=DF$height
y=DF$weight

cor(x,y)
cov(x,y)
var(x,y, na.rm=T)
names(DF)
plot(height, weight, type='p')

rm(list=ls())
