#install.packages('tm', dependencies = T)
#remove.packages('tm')

.libPaths()

library(tm)
dat<-readLines('E:/Bigdata/dataset/moviereview/starwars.txt')
print(dat)

tSource <- VectorSource(dat)
tSource
myCor <- Corpus(tSource)
myCor

#abb<-c('영화', 'ㅋㅋ')
myCor <- tm_map(myCor, removePunctuation)
myCor <- tm_map(myCor, removeNumbers)
#myCor <- tm_map(myCor, stripWhitespace)
#myCor <- tm_map(myCor, removeWords, abb)
myCor<-gsub('영화', '', myCor)
inspect(myCor) # 정보 + 내용

#for (i in seq_along(myCor)){
#  myCor[[i]]<-gsub('영화', '', myCor[[i]])
#}


inspect(myCor) # 정보 + 내용

tdm<-TermDocumentMatrix(myCor, control=list(tokenize='scan', wordLengths=c(2,7)))
tdm_M<-as.matrix(tdm)
tdm_M

frequency<-rowSums(tdm_M)
frequency
barplot(frequency[1:20], las=2)

library(wordcloud)
w1<-names(frequency)
pal<-brewer.pal(8, 'Dark2')
wordcloud(words=w1,
          freq=frequency,
          min.greq=2,
          random.order = F,
          random.color = F,
          colors = pal)
