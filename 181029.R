
#KoNLP
library(KoNLP)
search()

useSejongDic()

## KoNLP
## 명사 추출 함수 : extractNoun

sentence <- "우리나라 고유의 문화들을 멋진그래픽으로 잘 표현했다. 재미있게 봤다. 스르륵 시간이 지나갔다."
sentence2 <- "님은 갔습니다. 아아, 사랑하는 나의 님은 갔습니다.
푸른 산빛을 깨치고 단풍나무 숲을 향하여 난 작은 길을 걸어서 차마 떨치고 갔습니다.
황금의 꽃같이 굳고 빛나던 옛 맹세는 차디찬 티끌이 되어서 한숨의 미풍에 날아갔습니다.
날카로운 첫 키스의 추억은 나의 운명의 지침을 돌려 놓고 뒷걸음쳐서 사라졌습니다.
나는 향기로운 님의 말소리에 귀먹고 꽃다운 님의 얼굴에 눈멀었습니다."

extractNoun(sentence)
extractNoun(sentence2)

## 스르륵 : 부사
mergeUserDic(data.frame(c('스르륵'), c('mag')))
extractNoun(sentence)

### 형태소 분석하기
### MorphAnalyzer(sentence)
MorphAnalyzer(sentence)


### 품사 달기
### SimplePos09 : 상위분류의 9개 기준으로 분류 수행
### SimplePos22 : 22개의 분류 기준으로 분류 수행

SimplePos09(sentence)
SimplePos22(sentence)

### tm package
### MeCAB
#install.packages('MeCAB')

### tmPackage 
### MeCAB
### slam
library(tm)
docs <- c("I am boy", "You are a girl", "I am a student")
is(docs)

print(Corpus(VectorSource(docs)))
## doc1 : "I am boy"
## doc2 : "You are a girl"
## doc3 : "I am a student"
myCorpus = Corpus(VectorSource(docs))
inspect(myCorpus)

# 데이터 전처리 
stopwords("english")

myCorpus <- tm_map(myCorpus, stripWhitespace)   ## 공백제거 
myCorpus <- tm_map(myCorpus, tolower)           ## 소문자로 만들기
myCorpus <- tm_map(myCorpus, removePunctuation) ## 특수문자 제거
myCorpus <- tm_map(myCorpus, removeNumbers)     ## 숫자 제거 
myCorpus <- tm_map(myCorpus, removeWords, stopwords("english"))

tdm <- TermDocumentMatrix(myCorpus)
tdm

m2 <- as.matrix(tdm)
m2

##
wordFreq <- sort(rowSums(m2), decreasing=TRUE)
head(wordFreq, 20)

## 빈도확인
findFreqTerms(tdm, lowfreq = 1, highfreq = Inf)

findAssocs(tdm, 'you', 0.2)



####

rm(list=ls())

####
## 벡터소스 말고 디렉토리를 불러온다.

library(tm)
mycor<-VCorpus(DirSource('E:/Bigdata/dataset/moviereview', pattern = 'txt'))
mycor

## 구조보기(content, meta)로 구성
str(mycor[1])

## 문서 내용보기
content(mycor[1])
content(mycor[[1]])

## 리스트로 만들어서 보여주겠다.
lapply(mycor, content)
## 콘텐츠가 5개이니 리스트도 5개

## 메타 정보 보기
meta(mycor[[3]])

## 메타 정보 추가
meta(mycor[[3]], tag='etc')<-'메타정보추가'
meta(mycor[[1]], tag='etc')<-'메타타'
str(mycor[1])

str(mycor[1])

#a<-c('A', 'B', 'C')
#b<-c('D', 'E', 'F')
#paste(a, collapse = ' ')
#paste(a, sep=',')
#paste(a)

mycor[[1]]$content[1:3]
## 문서 내용들의 행을 이어붙이겠다
#paste(mycor[[1]]$content, collapse=' ')



# 여러개의 문서(5)의 content(내용)이 들어가 있는 부분을
# 한 줄 리뷰로 만들겠다.
for (i in seq_along(mycor)){
  mycor[[i]]$content<-paste(mycor[[i]]$content, collapse = ' ')
}

length(mycor[[1]]$content)
length(mycor[[2]]$content)
length(mycor[[3]]$content)
length(mycor[[4]]$content)
length(mycor[[5]]$content)

  

mycor <- tm_map(mycor, stripWhitespace)   ## 공백제거 
#mycor <- tm_map(mycor, tolower)           ## 소문자로 만들기
mycor <- tm_map(mycor, removePunctuation) ## 특수문자 제거
mycor <- tm_map(mycor, removeNumbers)     ## 숫자 제거 
mycor <- tm_map(mycor, removeWords, stopwords("english"))
mycor

str(mycor$content)
str(mycor$meta)

library(KoNLP)
library(NIADic)
useNIADic()


# removeword<-c('영화', 'ㅋ', '아무런', '있는', '여러', '바보', '더욱', '엉뚱하면서도')
for (i in seq_along(mycor)){
  mycor[[i]]$content<-gsub('영화', '', mycor[[i]]$content)
  mycor[[i]]$content<-gsub('ㅋ', '', mycor[[i]]$content)
  mycor[[i]]$content<-gsub('아무런', '', mycor[[i]]$content)
  mycor[[i]]$content<-gsub('있는', '', mycor[[i]]$content)
  mycor[[i]]$content<-gsub('바보', '', mycor[[i]]$content)
  mycor[[i]]$content<-gsub('더욱', '', mycor[[i]]$content)
  mycor[[i]]$content<-gsub('엉뚱하면서도', '', mycor[[i]]$content)
}
mycor[[1]]$content

## 불용어 처리 : stopwords
abb<-c('싶음', '인듯', '있어', '와', '어릴때')
str(abb)
mycor[[1]]$content <- tm_map(mycor, removeWords, 'abb')
mycor[[1]]$content
mycor[[2]]$content
