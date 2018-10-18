library(wordcloud)
library(KoNLP)

useSejongDic()

# 불러오기
road1 = readLines("C:/Users/ktm/reviews.txt")
road1
str(road1)
# 명사추출
nouns <- sapply(road1, extractNoun, USE.NAMES=F)  # nouns : 리스트
nouns <- unlist(nouns)
nouns
### 쓸데없는 단어 삭제 및 빈도 확인 
nouns <- gsub("\\d+","", nouns)
nouns <- gsub("\t","", nouns)
nouns <- gsub("[a-zA-Z]","", nouns)
nouns <- nouns[nchar(nouns)>=2]
nouns

wordFreq <- table(nouns)
wordFreq <- sort(wordFreq, decreasing=T)
wordFreq

len = length(wordFreq)
if (len >= 500) {
  len = 500
}

wdFreq1 <- wordFreq[1:len] 
#wdFreq50 <- wordFreq[1:30]
write.csv(wdFreq1, file="movie.csv")

barplot(wdFreq1, las=2)


#### 10. 색 지정(brewer.pal(6, "Dark2")
#### 11. 폰트 지정
#### 12. set.seed(1000)
#### 13. wordcloud( )

pal <- brewer.pal(8,"Dark2")

#windowsFonts(malgun=windowsFont("맑은 고딕"))

set.seed(1000)
wordcloud(words=names(wdFreq1),
          freq=wdFreq1,
          colors=pal,
          min.freq=1,
          max.words = 300,
          random.order=F,
          family="malgun")
