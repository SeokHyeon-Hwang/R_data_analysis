
## Lab04_말뭉치(Corpus) 생성, 전처리

# 01. 텍스트 마이닝 패키지 불러오기(tm) - KoNLP
# 02. 데이터 줄단위 불러오기 - readLines
# 03. 텍스트에서 말뭉치(Corpus)로 변환 - 
# VectorSource(벡터->데이터소스), DirSource(디렉터리->데이터소스)..., 
# 04. corpus 로 변환하여 저장 후, 전처리
# Corpus, VCorpus 
# 05. 전처리가 후, 문서 내용 확인
# tm_map(  tolower ) 
# 
# 06. 불용어 처리 수행
# stopwords('english')

# 07. 단어문서행렬(Term Document Matrix, TDM)
# TermDocumentMatrix (코퍼스를 단어문서행렬)
# DocumentTermMatrix (코퍼스를 단어문서행렬)

rm(list=ls())
# 02. 데이터 줄단위 불러오기 - readLines
library(tm)
dat<-readLines('E:/Bigdata/dataset/moviereview/ratings01_m.txt')
print(dat)


# 03. 텍스트에서 말뭉치(Corpus)로 변환
tSource <- VectorSource(dat)
tSource
myCor <- Corpus(tSource)
myCor

# 05. 전처리가 후, 문서 내용 확인
# tm_map(  tolower ) 
#abb<-c('영화', 'ㅋㅋ')
myCor <- tm_map(myCor, removePunctuation)
myCor <- tm_map(myCor, removeNumbers)
#myCor <- tm_map(myCor, stripWhitespace)
#myCor <- tm_map(myCor, removeWords, abb)


inspect(myCor) # 정보 + 내용
myCor[[3]]$content

# 06. 불용어 처리 수행

#abb<-c('영화', 'ㅋㅋ')
#str(abb)
#for (i in seq_along(myCor)){
#    myCor[[i]]$content <- tm_map(myCor, removeWords, abb)
#}
#myCor<-gsub('영화', '', myCor)

inspect(myCor)

## stopwords : C:\Users\ktm\Documents\R\win-library\3.5\tm\stopwords
## 라이브러리 위치 확인
.libPaths()

# 단어 문서 행렬 만들기(Term Document Matrix, TDM)
# TF(용어의 빈도수)를 구할 수 있음
# TFIDF
tdm<-TermDocumentMatrix(myCor, control=list(tokenize='scan', wordLengths=c(2,7)))
#Encoding(tdm$dimnames$Terms) = 'UTF-8'
inspect(tdm)

tdm_M<-as.matrix(tdm)
tdm_M

## 단어별 빈도수 구하기
frequency<-rowSums(tdm_M)
frequency
barplot(frequency[1:20], las=2)

## 워드 클라우드
library(wordcloud)
w1<-names(frequency)
pal<-brewer.pal(8, 'Dark2')
wordcloud(words=w1,
          freq=frequency,
          min.greq=1,
          random.order = F,
          random.color = F,
          colors = pal)

