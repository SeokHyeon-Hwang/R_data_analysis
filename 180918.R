

setwd('C:/Users/ktm/Documents/R_STUDIO_EXERCISE')
df<-read.csv()

install.packages('KoNLP')
install.packages('wordcloud')
library('KoNLP')
library('wordcloud')

useSejongDic() # 세종사전 사용(8만 단어)

data1<-readLines('content.txt', encoding='UTF-8')
data1

##시각화(wordcloud)
word<-c('사과', '바나나', '복숭아', '포도', '키위', '망고')
fre<-c(50,20,10,10,3,1)
wordcloud(word,fre)

##명사추출 - extractNoun
?extractNoun
extractNoun(data1)
data2<-extractNoun(data1)
is(data2)

data_unlist<-unlist(data2)
is(data_unlist)
#wordcloud(data_unlist)
length(data_unlist)

###빈도분석
wordcount<-table(data_unlist)

### 정렬
sort(wordcount, decreasing=T)

headtop<- sort(wordcount, decreasing=T)
head(headtop, 100)

install.packages('tm')
library('tm')

##wordcloud(단어, 빈도)
wordcloud(names(headtop), headtop)

##
wordcloud(names(headtop), headtop,
          random.order = F,
          colors=c('blue', 'green', 'red'))

## RColorBrewer
library(RColorBrewer)
col<-brewer.pal(9, 'Set3')

wordcloud(names(headtop), headtop,
          random.order=F, #빈도수 많은 것 중앙
          random.color=T, #임의 색 지정
          colors=col)
