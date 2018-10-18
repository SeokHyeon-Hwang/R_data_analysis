rm(list=ls())

# clawling & wordcloud2
## 01.clawling
# install.packages('rvest')
library(rvest)

### data road from wed(movie review)
all_reviews<-c()
test<-paste0('https://movie.daum.net/moviedb/grade?movieId=109924&type=netizen&page=', 2)
test

### read html
htxt=read_html(test)
htxt
table=html_nodes(htxt, '.review_info')
table
content=html_nodes(table, '.desc_review')
content
reviews=html_text(content)
reviews

reviews<-gsub('\n', '', reviews)
reviews
reviews<-gsub('\t', '', reviews)
reviews

writeLines(reviews, 'C:/Users/ktm/reviews2.txt')

## 02. clawling with for repeat
all_url<-c()
for (i in 1:20){
### road url
  test<-paste0('https://movie.daum.net/moviedb/grade?movieId=46092&type=netizen&page=',i)
  all_url=c(all_url,test)
}
all_url

all_reviews=c()
for (i in 1:20){
### read html
  htxt=read_html(all_url[i]) #리뷰영역 가져오기
  table=html_nodes(htxt, '.review_info') #리뷰 가져오기
  content=html_nodes(table, '.desc_review')
  reviews=html_text(content)
  
  reviews<-gsub('\n', '', reviews) # 불필요 부호 제거
  reviews<-gsub('\t', '', reviews) # 불필요 부호 제거
  all_reviews<-c(all_reviews, reviews)
}
all_reviews


## wordcloud
### extract noun
nouns<-sapply(all_reviews, extractNoun, USE.NAMES = F)
str(nouns)
nouns<-unlist(nouns)
str(nouns)

### Delete useless noun, confirm frequency
nouns<-gsub('\\d+', '', nouns)
nouns<-gsub('\t', '', nouns)
nouns<-gsub('[a-zA-Z]', '', nouns)
nouns<-nouns[nchar(nouns)>=2]
nouns

wordFreq<-
