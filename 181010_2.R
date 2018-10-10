rm(list=ls())

#1 Reading data
??xls
??excel
install.packages('gdata')
library(gdata)
df<-read.xls('E:/Bigdata/dataset/beer/beer_pca.xls') # can't read
library(openxlsx) # can't read .xls, .xlm 
df<-read.xlsx('E:/Bigdata/dataset/beer/beer_pca.xls') # can't read .xls, .xlm 

library(readxl) # good!
df<-read_xls('E:/Bigdata/dataset/beer/beer_pca.xls')
#df<-read_excel('E:/Bigdata/dataset/beer/beer_pca.xls')

#2
df.hep<-df[,-7] # taste 제외
df.pca<-prcomp(df.hep, scale=T)
df.pca

#3 PCA
summary(df.pca)

#4
plot(df.pca, type='l')


#5

beerpred<-predict(df.pca)
beerpred[,1:2]

df.pca<-prcomp(df, scale=T)
df.pca



#6
library(corrplot)
df.pca
#df.pcaa<-as.matrix(df.pca)
cor(df.pca)
corrplot(df.pca)

