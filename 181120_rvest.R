
# rvest 사용, 다음 영화 댓글 긁어오기
#install.packages('rvest')
#install.packages('curl')

library(rvest)

library(curl)
all_reviews<-c()
htxt<-read_html('https://movie.daum.net/moviedb/grade?movieID=100649&type=netizen&page=1')

#for (i in 1:200){
#  test<-paste0('https://movie.daum.net/moviedb/grade?movieID=100649&type=netizen&page=',i)
#  htxt<-read_html(curl(test, handle=curl::new_handle('useragent'='Mozilla/5.0')))
  
#  table<-html_nodes(htxt, '.review_info')
#  content<-html_nodes(htxt, '.desc_review')
#  reviews<-html_text(content)
  
#  reviews<-gsub('\n', '', gsub('\t', '', reviews))
#  all_reviews<-c(all_reviews, reviews)
  
#}

word<-sapply(all_reviews, extractNoun, USE.NAMES=F)
word<-unlist(word)

word<-gsub('\\d+', '', word)
word<-gsub('\t', '', word)
word<-gsub('[a-zA-Z]', '', word)
word<-word[nchar(word)>=2]
word
wordcount<-table(word)
word_df<-data.frame(wordcount)
head(word_df)

word_df<-word_df[order(word_df$Freq, decreasing=R),]

library(wordcloud2)

wordcloud2(word_df[1:300,], size=10,
           color='random-light',
           backgroundColor='grey',
           rorateRatio=0.75)