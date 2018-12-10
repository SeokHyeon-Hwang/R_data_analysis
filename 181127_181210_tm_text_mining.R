rm(list=ls())

# 라이브러리 불러오기
library(tm)
library(dplyr)

# 텍스트 불러오기
txt<-readLines('C:/Users/ktm/downloads/text_mining.txt')
txt

# 텍스트를 코퍼스로 변환 
docs <- Corpus(VectorSource(txt))
docs

# 사전에 있는 내용과 비교를 위해 소문자로 변경
docs <- tm_map(docs, tolower)

# 숫자 제거
docs <- tm_map(docs, removeNumbers)

# 띄어쓰기와 시제 제거
docs <- tm_map(docs, removeWords, stopwords('english'))

# 구두점 제거
docs <- tm_map(docs, removePunction)

# 어근만 추출
#install.packages('SnowballC')
#library(SnowballC)
#docs <- tm_map(docs, stemDocument)

# 불용어 제거(text, mining, mine)
sword2 <- c(stopwords('en'), 'text', 'mining', 'mine', 'doi', 'isbn')
docs <- tm_map(docs, removeWords, sword2)

# TDM (term document matrix) 만들기
tdm <- TermDocumentMatrix(docs)
m <- as.matrix(tdm)

# TDM 결과를 내림차순 정렬
v <- sort(rowSums(m), decreasing = T)

# 빈도수 확인
d <- data.frame(word = names(v), freq=v)
head(d, 10)
d

# 워드클라우드
#install.packages('wordcloud')
library(wordcloud)
library(RColorBrewer)
wordcloud <- wordcloud(names(v), freq=v, min.freq=8, scale=c(5,1),
                       colors=brewer.pal(5,'Set1'), random.order=F,
                       random.color=T)
