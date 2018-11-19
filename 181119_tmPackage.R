
library(tm)
docs<-c('I am boy', 'You are a girl', 'I am a student')
is(docs)
VectorSource(docs)

##
print(Corpus(VectorSource(docs)))
myCorpus<- Corpus(VectorSource(docs))
is(myCorpus)

##
print(myCorpus[1:3])
print(myCorpus[[1]])
print(myCorpus[[2]])
print(myCorpus[[3]])

## Corpus
inspect(myCorpus[1:3])

##
textMining = readLines('E:/Bigdata/dataset/anb_jarena_lee.txt')
is(textMining)
print(textMining)

## tm_map
myCorpus=Corpus(VectorSource(textMining))
myCorpus<-tm_map(myCorpus, stripWhitespace)
myCorpus<-tm_map(myCorpus, tolower)
myCorpus<-tm_map(myCorpus, removePuctuation)
myCorpus<-tm_map(myCorpus, removeNumbers)
myCorpus<-tm_map(myCorpus, removeWords, stopwords('english'))

##
stopword2<-c(stopwords('en'), 'amd', 'but', 'not')
myCorpus<-tm_map(myCorpus, removeWords, stopword2)

## Term-Document Matrix
str(myCorpus)

tdm<-TermDocumentMatrix(myCorpus)
tdm

stopword2 <-c(stopwords('en'), 'new', 'among', 'ennui')
myCorpus<-tm_map(myCorpus, removeWords, stopword2)
tdm2<-TermDocumentMatrix(myCorpus)
tdm2

##
m2<-as.matrix(tdm2)
m2

##
library(RColorBrewer)
wordFreq<-sort(rowSums(m2), decreasing=T)
head(wordFreq, 20)

##
wordFreq2 <- sort(colSums(m2), decreasing=T)
wordFreq2

##
findFreqTerms(tdm2, lowfreq=2, highfreq=Inf)

##
findAssocs(tdm2, 'jersey', 0.2)

##
library(RColorBrewer)
library(wordcloud)
search()

##
names(wordFreq)

##
set.seed(1234)
wordF=findFreqTerms(tdm2, lowfreq=1,highfreq=Inf)
pal=brewer.pal(8,'Dark2')

wordcloud(words=names(wordFreq),
          freq=wordFreq,
          scale=c(4,1),
          min.freq=2, colors=pal, random.order=F, random.color=T)
legend(0.3, 1, 'tm Package Test', cex=1, fill=NA, border=NA, bg='white', text.col='red')
