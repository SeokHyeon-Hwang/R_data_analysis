rm(list=ls())
install.packages('KoNLP')
install.packages('wordcloud')
library('KoNLP')
library('wordcloud')

useSejongDic()

data1<-readLines('pmk.txt', encoding='UTF-8')

extractNoun(data1)
data2<-extractNoun(data1)

data_unlist<-unlist(data2)
is(data_unlist)

wordcount<-table(data_unlist)

sort(wordcount, decreasing=T)

headtop<- sort(wordcount, decreasing=T)
head(headtop, 100)

data2<-sapply(data1, extractNoun, USE.NAMES = F)
data_unlist<-unlist(data2)

data_unlist<-gsub('com', '', data_unlist)
data_unlist<-gsub('카스테라', '', data_unlist)
data_unlist<-gsub('박민규', '', data_unlist)
data_unlist<-gsub('\\d+', '', data_unlist) #숫자 삭제
data_unlist<-gsub('[ㄱ-ㅎ]', '', data_unlist) #자음 삭제
data_unlist<-gsub('\\"', '', data_unlist) #특수문자" 삭제
data_unlist<-gsub('[(),&|@]', '', data_unlist)
data_unlist<-gsub('[A-Za-z]', '', data_unlist)
data_unlist<-Filter(function(x) {nchar(x)>=2}, data_unlist)
data_unlist<-gsub('\\(', '', data_unlist)
data_unlist<-gsub('\\', '', data_unlist)


wordcount<-table(data_unlist)
wordcount

headtop<- sort(wordcount, decreasing=T)
head(headtop, 100)

install.packages('tm')
library('tm')

library(RColorBrewer)
col<-brewer.pal(9, 'Set3')
wordcloud(names(headtop), headtop,
          random.order=F, #빈도수 많은 것 중앙
          random.color=T, #임의 색 지정
          colors=col)