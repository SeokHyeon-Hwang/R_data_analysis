
#install.packages('dplyr')
#install.packages('tm')
#install.packages('stringr')
#install.packages('data.table')
library(KoNLP)
library(tm)
library(stringr)
library(data.table)

txt<-readLines('C:/users/ktm/downloads/public_life.txt')

head(txt)
class(txt)

txt1 <- extractNoun(txt)
txt1
txt2 <- unlist(txt1)
txt2

class(txt1)
class(txt2)

txt2 <- gsub('\\d+', '', txt2)
txt2 <- gsub('\\n', '', txt2)
txt2 <- gsub('[A-z]', '', txt2)
txt2 <- gsub('[[:cntrl:]]', '', txt2)
txt2 <- Filter(function(x){nchar(x)>2}, txt2)
txt2 <- gsub('(', '', txt2)

txt3 <- data.table(txt2)
wordcount<-table(txt3)
wordcount

#install.packages('RColorBrewer')
#install.packages('wordcloud')
library(RColorBrewer)
library(wordcloud)

ccolor <- brewer.pal(6, 'Dark2')
wordCloud<-wordcloud(names(wordcount), 
                     wordcount, 
                     min.freq=2,
                     colors=ccolor,
                     random.color=T)

wordCloud<-wordcloud::
??wordcloud
