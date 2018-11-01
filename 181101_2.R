

###
library(tm)
## 01.문서수집
docs<-c(D1='The sky is blue.',
        D2='The sun is bright.',
        D3='The sun in the sky is bright.')

## 02.전처리(불용어 빼기, 문서)
dd<-Corpus(VectorSource(docs))
dd<-tm_map(dd, removePunctuation)
dd<-tm_map(dd, removeWords, stopwords('english'))

### 내용확인 방법 1, 2
strwrap(dd)
inspect(dd)

## 03. 단어문서행렬, 문서단어행렬
dtm<-DocumentTermMatrix(dd, control=list(weightTfIdf))
#dtm<-DocumentTermMatrix(dd, control=list(weighting))
dtm
as.matrix(dtm)

## 실습
docs2<-c(doc1<-'파스타 먹방, 강남 파스타 데이트',
         doc2<-'강남 버스 파스타 맛집',
         doc3<-'강남 버스, 강남 파스타, 강남 맛집')

dd2<-Corpus(VectorSource(docs2))
dd2<-tm_map(dd2, removePunctuation)

inspect(dd2)

dtm2<-DocumentTermMatrix(dd2, control=list(weightTfIdf))
dtm2                         
as.matrix(dtm2)

docs3<-c(doc01<-'In the face of our common dangers, in this winter of our hardship, let us remember these timeless words.',
         doc02<-'With hope and virtue, let us brave on-ce more the icy currents, and endure what storms may come.',
         doc03<-"Let it be said by our children's children that when we were tested we refused to let this journey end, that we did not turn back nor did we falter; and with eyes fixed on the horizon and God's grace upon us, we carried forth that great gift of freedom and delivered it safely to future generations.")

dd3<-Corpus(VectorSource(docs3))
dd3<-tm_map(dd3, removePunctuation)
dd3<-tm_map(dd3, removeWords, stopwords('english'))

inspect(dd3)

dtm3<-DocumentTermMatrix(dd3, control=list(weightTfIdf))
dtm3
as.matrix(dtm3)
