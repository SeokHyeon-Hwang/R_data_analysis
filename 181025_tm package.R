
### 01. 패키지 설치 및 불러오기
library(tm)
docs=c('I am boy', 'You are a girl', 'I am a student')
is(docs)
VectorSource(docs)

### 02. 코퍼스 생성(말뭉치)
### 왜? tm 패키지는 기본 자료형으로 코퍼스를 이용
mycor<-Corpus(VectorSource(docs))
mycor

### 03. 불용어 처리
mycor<-tm_map(mycor, removeWords, stopwords('en'))
mycor<-tm_map(mycor, stripWhitespace)

### 실제 코퍼스 내용 보기
inspect(mycor)
# 토지로 단어 상관도 분석하기

tdm<-TermDocumentMatrix(mycor)
tdm
# 보려면 행렬 형태로
m<-as.matrix(tdm)
m

# Docs1 
# Docs2
# Docs3

wordFreq<-sort(rowSums(m), decreasing = T)

# 매트릭스 행의 합은 단어빈도수

# 용어의 빈도를 찾겠다
findFreqTerms(tdm, 2,3) #2: 2번 이상(최소값), 3은 번 이하(최대값)
wordFreq

findFreqTerms(tdm,1) # 한 번 이상 나온 단어를 보여줘
findFreqTerms(tdm,2) # 두 번 이상 나온 단어를 보여줘

findAssocs(tdm, 'girl', 0.2)
# girl과 결과값은 같은 문장안에 있다.
findAssocs(tdm, 'girl', 0.6)
