
# 말뭉치(corpus) 생성, 전처리

# 01. 텍스트 마이닝 패키지 불러오기
library(tm)

# 02. 데이터 줄단위 불러오기
testText<-readLines('E:/Bigdata/dataset/textmining/data/wikiTextming.txt')

# to solve 'invalid multibyte string 35
# This command converts the 'text' column (multibyte) to utf8 form

testText<-iconv(enc2utf8(testText), sub='byte')

print(testText)

str(testText)

# 03. 텍스트에서 말뭉치(corpus)로 변환 벡터소스->corpus
testText1<-VectorSource(testText)
testText1
print(testText1)
# str(testText1) # str이 의미가 없다.

# 04. corpus 로 변환하여 저장 후, 전처리
corpus<-Corpus(testText1)
corpus
str(corpus)
#corpus$Metadata  # Null

strwrap(corpus[[13]]) # 내용을 확인하려면 strwrap 사용
# corpus[[1]]
# corpus[1]
# print(corpus[[1]])

# 04-2. 문장부호 제거
corpus2<-tm_map(corpus, removePunctuation)

strwrap(corpus2[[13]])

# 04-3. 특정 문자 제거하기(숫자 제거)
corpus3<-tm_map(corpus2, removeNumbers)
strwrap(corpus3[[13]])

# 04-4. 대문자를 소문자로 변환
corpus4<-tm_map(corpus3, tolower)
strwrap(corpus4[[13]])

# 04-5. 불용어 처리(조사, 전치사)
corpus5<-tm_map(corpus4, removeWords, stopwords('english'))
strwrap(corpus5)

# 04-6. 불용어 처리(텍스트, 마이닝)
stopword2<-c('text', 'mining')
corpus6<-tm_map(corpus5, removeWords, stopword2)

# 05. 단어문서 행렬 (Term Document Matrix, TDM)
tdm<-TermDocumentMatrix(corpus6, control=list(tokenize='scan', wordLengths=c(2,14)))
inspect(tdm)

# 05-2
nTerms(tdm)

# 06 문서단어 행렬 변환(Document Term Matrix, DTM)
dtm<-DocumentTermMatrix(corpus6)
dtm
inspect(dtm)
dtm2<-as.matrix(dtm)
dtm2

# 06-2 발생빈도가 높은 상위 5개 출력
frequency<-colSums(dtm2)
frequency2<-sort(frequency, decreasing=T)
print(head(frequency2))

# 07 발생빈도 상위 20개 막대 그래프
barplot(frequency2[1:20], las=3)
search()
