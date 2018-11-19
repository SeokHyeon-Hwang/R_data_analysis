
# KoNLP
# 단어사전 구축 _ 여러줄
# 여러줄 파일 자연어 처리

# install.packages('KoNLP')
# install.packages('wordcloud')

# 라이브러리 불러오기
library(KoNLP)
library(wordcloud)

# 세종딕 불러오기
useSejongDic()

# 파일 불러오기


##
install.packages('rvest')
library(rvest)

all_reviews<-c()

for (i in 1:200){
  test<-paste0('https://movie.daum.net/moviedb/grade?movieId=100649&type=netizen&page=', i)
  htxt<-read_html(test)
  
  table<-html_nodes(htxt, '.review_info')
  content<-html_nodes(htxt, '.desc_review')
  reviews<-html_text(content)
  
  reviews<-gsub('\n', '', gsub('\t','', reviews))
  all_reviews<-c(all_reviews, reviews)
  
}

word<-sapply(all_reviews, extractNoun, USE.NAMES = F)
word<-unlist(word)

word<-gsub('\\d+', '', word)
word<-gsub('\t', '', word)
word<-gsub('[a-zA-Z]', '', word)
word<-wrod[nchar(word)>=2]
word

wordcount<-table(word)
word_df<-data.frame(wordcount)
head(word_df)

word_df<-word_df[order(word_df$Freq, decreasing=T),]

install.packages('wordcloud2')
library(wordcloud2)

wordcloud2(word_df[1:300, ], size=10,
           color='random-light', 
           backgroundColor='grey',
           rotateRatio=0.75)
