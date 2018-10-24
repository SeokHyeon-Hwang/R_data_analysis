# memmo crawling
rm(list=ls())
mm<-readLines('E:/Bigdata/dataset/memo1351.txt')
head(mm)
str(mm)
tail(mm)

library(wordcloud)
library(RColorBrewer)
library(KoNLP)

useSejongDic()

# sapply is return value as list
mm<-sapply(mm, extractNoun, USE.NAMES=F)

mm_v<-unlist(mm)
head(mm_v)
str(mm_v)

wc<-table(mm_v)
