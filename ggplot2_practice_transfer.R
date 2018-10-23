library(readxl)
df<-read_xlsx('E:/Bigdata/dataset/sido/sido_fix.xlsx')
??xlsx

str(df)

colnames(df)<-s_name

df2<-read.csv('E:/Bigdata/dataset/sido/sido_fix2.csv')
str(df2)
View(df2)
#colnames(df2)

df3<-read.csv('E:/Bigdata/dataset/sido/sido_both.csv')
str(df3)
colnames(df3)
rownames(df3)

