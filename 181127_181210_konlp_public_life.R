
rm(list=ls())
# 라이브러리
library(KoNLP)
library(data.table)
library(dplyr)
library(RColorBrewer)
library(wordcloud)

# 텍스트 불러오기
text<-readLines('E:/Bigdata/dataset/public_life_2015/public_life.txt')
head(text)

text
is(text)
# 단어 추출 및 데이터 구조 변경
text2<- sapply(text, extractNoun, USE.NAMES = F)
text2
is(text2)

text3<- unlist(text2)
text3
is(text3)

# 두 단어 이하 제외
text3 <- Filter(function(x){nchar(x)>2}, text3)

# 날짜 제외
text3 <- gsub("\\d+", "", text3)

# new line 문자 제거
text3 <- gsub('\\n', '', text3)

# 영문 제거
text3 <- gsub('[A-z]', '', text3)

# 특수문자 제거
text3 <- gsub('[[:cntrl:]]', '', text3)
text3 <- gsub('\\W', '', text3)
text3

# 불용어 제거
text3 <- gsub('문', '', text3)
text3 <- gsub("기타", '', text3)
text3 <- gsub('/', '', text3)
text3 <- gsub('*', '', text3)
#text3 <- gsub('(', '', text3)

# 데이터 테이블로 변형
text4 <- data.table(text3)
text4

# 빈도수 확인
wordcount <- table(text4)
wordcount

# 빈도수 상위 10개 단어 확인
top10<- head(sort(wordcount, decreasing=T), 11)
top10


# 빈도수 내림차순 보기
top <- sort(wordcount, decreasing=T)
# csv로 저장 
## 빈도수 내림차순 내용 저장
write.csv(top, 'public3.csv', row.names = T)

## 단어만 저장
write.csv(text4, 'public.csv', row.names = T)

# 워드 클라우드
wordcloud<-wordcloud(names(wordcount), freq=wordcount, scale=c(5,1), 
                     min.freq=2, rot.per=0.25, colors=brewer.pal(8,'Set2'),
                     random.color=T)
