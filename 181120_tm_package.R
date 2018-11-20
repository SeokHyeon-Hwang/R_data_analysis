
## 라이브러리
library(KoNLP)
library(tm)
# 텍스트 불러오기
df<-readLines('E:/Bigdata/dataset/public_life_2015/public_life.txt')
head(df)
df

# 세종사전 불러오기
useSejongDic()

# 간단한 명사 추출
extractNoun(df, autoSpacing=F)

#형태소 분석하기
MorphAnalyzer(df)

# 품사 달기
SimplePos09(df)

SimplePos22(df)


myCor<-VCorpus(VectorSource(df))
myCor

# 문서 내용만 확인
content(myCor[13])

str(myCor)

#문서 전체 확인
lapply(myCor, content)

meta(myCor)






# 텍스트 마이닝 패키지 불러오기
library(tm)

# 데이터 줄단위 불러오기
text<-readLines('E:/Bigdata/dataset/public_life_2015/public_life.txt')

print(text)

str(text)

# 텍스트에서 말뭉치(corpus)로 변환 벡터소스->corpus
text1<-VectorSource(text)
text1
print(text1)

# corpus로 변환하여 저장 후 전처리
corpus<-Corpus(text1)
corpus
str(corpus)

# 내용 확인시 strwrap 사용
strwrap(corpus[[13]])

# 문장부호 제거
corpus2<-tm_map(corpus, removePunctuation)

strwrap(corpus2[[38]])

# 특정 문자 제거하기(숫자 제거)
corpus3<-tm_map(corpus2, removeNumbers)
strwrap(corpus3[[100]])



# 대소문자를 소문자로 변환
corpus4<-tm_map(corpus3, tolower)
strwrap(corpus4[[100]])

# 불용어 처리
stopword2<-c('않다', '그렇지', '그렇다', '있다', '나는', '어떻게', '보통',
             '이다', '항')
corpus5<-tm_map(corpus4, removeWords, stopword2)

# tdm
tdm<-TermDocumentMatrix(corpus5, control=list(tokenize='scan', wordLengths=c(2,14)))
inspect(tdm)

# dtm
dtm<-DocumentTermMatrix(corpus4)
dtm
dtm2<-as.matrix(dtm)
dtm2

frequency<-colSums(dtm2)
frequency2<-sort(frequency, decreasing=T)

print(head(frequency2))
