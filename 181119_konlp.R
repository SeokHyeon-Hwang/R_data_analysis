

# 라이브러리
library(KoNLP)

# 텍스트 불러오기
df<-readLines('E:/Bigdata/dataset/public_life_2015/public_life.txt')
head(df)
df

# 세종 사전 불러오기
useSejongDic()

# 간단한 명사 추출
extractNoun(df, autoSpacing=F)

# 형태소 분석하기
MorphAnalyzer(df)

# 품사 달기
SimplePos09(df)

SimplePos22(df)

# 명사 확인하기
library(stringr)
txt=SimplePos09(df)
txt_n<-str_match(txt, '([A-Z가-힣]+)/N') # 명사 확인인
txt_n


rm(list=ls())
## library
library(tm)
library(KoNLP)
search()

# 경로 지정하여 해당 파일 확인
dir('E:/Bigdata/dataset/moviereview/dir_multi')

# corpus 만들기
myCorpus<-VCorpus(DirSource('E:/Bigdata/dataset/moviereview/dir_multi', pattern='txt'))
myCorpus

str(myCorpus[[1]])

# 문서 내용만 확인
content(myCorpus[[1]])

# 문서 전체 확인
lapply(myCorpus, content)

# 문서 메타 정보 추출/추가 함수:meta()
meta(myCorpus[[3]])

meta(myCorpus[[1]], tag='etc') <-'메타정보추가' 
meta(myCorpus[[1]])

# Text 전처리
for (i in seq_along(myCorpus)){
  myCorpus[[i]]$content<-paste(myCorpus[[i]]$content, collapse='')
}
myCorpus[[5]]$content

# 문장부호 제거
myCorpus <- tm_map(myCorpus, removePunctuation) # 특수문자 제거
myCorpus <- tm_map(myCorpus, removeNumbers) # 숫자 제거거
myCorpus <- tm_map(myCorpus, stripWhitespace) # 공백제거
myCorpus[[1]]$content

# 불용어 제거
myCorpus <- tm_map(myCorpus, removeWords, stopwords('english'))
myCorpus[[5]]$content

# 어근 추출(영문)
library(SnowballC)
myCorpus <- tm_map(myCorpus, stemDocument)
myCorpus[[3]]$content

# 불핅요한 단어 삭제
library(stringr)
loc1=str_locate(myCorpus[1]$content, 'label')[2]
loc1
loc2=str_locate(myCorpus[1]$content, 'meta')[1]
loc2

kst<- c('그리고', '아니라는거', '될거가틈', '잘될듯')
rm_words<-paste(kst, collapse='|')
for (i in seq_along(myCorpus)){
  myCorpus[[i]]$content <- str_replace_all(myCorpus[[i]]$content, rm_words, '')
  loc2=str_locate(myCorpus[i]$content, 'meta')[1]
  myCorpus[[i]]$content<-str_sub(myCorpus[[i]]$content, start=1, end=loc2)
}

# myCorpus[[5]]$content
myCorpus[[5]]$content

# 단어 띄어쓰기
library(KoNLP)
library(NIADic)
useNIADic

for (i in seq_along(myCorpus)){
  myCorpus[[i]]$content <- gsub('볼 수록', '볼수록', myCorpus[[i]]$content)
  myCorpus[[i]]$content <- gsub('이쁨터짐', '이쁨 터짐', myCorpus[[i]]$content)
}

myCorpus[[3]]$content


# 새로운 단어 추가
new_word <- c('성룡형님', '초딩')
new_dic <- data.frame(new_word, 'ncn')
buildDictionary(ext_dic=c('sejong', 'woorimalsam', 'insighter'), user_dic=new_dic)

paste(nouns, collapes=' ')

# 분석하기
myCor_tdm <- TermDocumentMatrix(myCorpus, control=list(tokenize='scan', wordLengths=c(2,7)))
inspect(myCor_tdm)

# 문서의 수, 단어수 추출
nTerms(myCor_tdm)
nDocs(myCor_tdm)

# 단어의 길이 2부터 4까지
Terms(myCor_tdm)[nchar(Terms(myCor_tdm)) >= 2 & nchar(Terms(myCor_tdm)) <=4]

# 3번 이상 빈도의 단어들
findFreqTerms(myCor_tdm, lowfreq=3, highfreq=Inf)

# 단어의 연관성 확인
findAssocs(myCor_tdm, c('택시', '중국영화'), c(0.5))


# 워드 클라우드 분석
myCor_tdm <- removeSparseTerms(myCor_tdm, sparse=0.90)
myCor_tdm

wordFreq=slam::row_sums(myCor_tdm)
wordFreq=sort(wordFreq, decreasing=T)
wordFreq

library(wordcloud)
pal <- brewer.pal(8, 'Dark2')
w=names(wordFreq)
w
wordcloud(words=w, freq=wordFreq,
          min.freq=3, random.order=F,
          random.color=T, colors=pal)


rm.idx<-grep('[있습니다|이거|영화|나는|보는|그런|그냥|것을]', names(wordFreq))
wordFreq1<-wordFreq[-rm.idx]
wordFreq1

w1 <- names(wordFreq1)
wordcloud(words=w1, freq=wordFreq,
          min.freq=3, random.order=F,
          random.color=T, colors=pal)

# 군집분석
tds<-myCor_tdm[Terms(myCor_tdm) %in% w1,]
m2<-as.matrix(tds)
colnames(m2)<-gsub(".txt", "", colnames(m2))
distMatrix<-dist(scale(m2))
fit<-hclust(distMatrix, method='ward.D')
plot(fit, xlab='', sub='', main='clustering 키워드')
rect.hclust(fit, k=7)

# 
tds <- myCor_tdm[Terms(myCor_tdm) %in% w1,]
m2<-as.matrix(tds)

tm2<-t(m2)
distMatrix<-dist(scale(tm2))

fit <-hclust(distMatrix, method='ward.D')
plot(fit, xlab='', sub='', main='clustering 키워드')
rect.hclust(fit, k=3)

# 키워드 연관 네트워크
tds1 <- weightTfIdf(myCor_tdm)
M<- t(as.matrix(tds1))
M
