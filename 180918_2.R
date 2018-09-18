rm(list=ls())

setwd('C:/Users/ktm/Documents/R_STUDIO_EXERCISE')
df<-read.csv()

install.packages('KoNLP')
install.packages('wordcloud')
library('KoNLP')
library('wordcloud')
useSejongDic() # 세종사전 사용(8만 단어)

data1<-readLines('content.txt', encoding='UTF-8')
data1

## 명사 단어 추출
data2<-sapply(data1, extractNoun, USE.NAMES = F)
data_unlist<-unlist(data2)

## 불용어 추출
## 의미가 없는 단어
## gsub(찾을단어, 찾은 후 변경할 단어, 단어리스트)
data_unlist<-gsub('www', '', data_unlist)

wordcount<-table(data_unlist)

headtop<- sort(data_unlist, decreasing=T)
head(data_unlist, 100)

## 정규표현식
data_unlist<-gsub('\\d+', '', data_unlist) #숫자 삭제
data_unlist<-gsub('[ㄱ-ㅎ]', '', data_unlist) #자음 삭제
data_unlist<-gsub('\\"', '', data_unlist) #특수문자" 삭제
data_unlist<-gsub('[(),&|@]', '', data_unlist)
data_unlist<-Filter(function(x) {nchar(x)>=2}, data_unlist)

is(data_unlist)

wordcloud(names(headtop), headtop,
          random.order=F, #빈도수 많은 것 중앙
          random.color=T, #임의 색 지정
          colors=col)


elitxt<-readLines('eliword.txt', encoding = 'UTF-8')
cnt=length(elitxt)

for(i in 1:cnt){
  data_unlist<- gsub(elitxt[i],'', data_unlist )
}
