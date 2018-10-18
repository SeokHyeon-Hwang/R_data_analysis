install.packages('rvest')
rm(list=ls())
library(rvest)
all.reviews<-c()

test<-paste0('https://movie.daum.net/moviedb/grade?movieId=100294&type=netizen&page=',1)
test

### read html
htxt=read_html(test)
htxt
table=html_nodes(htxt, '.review_info')
table
content=html_nodes(table, '.desc_review')  # 코드도 가져옴
content
reviews=html_text(content)  ## 문장만 가져옴
reviews

reviews<-gsub('\n', '', reviews)
reviews<-gsub('\t','', reviews)
reviews

### 실습1

library(rvest)
all.reviews<-c()
test2<-paste0('https://movie.daum.net/moviedb/grade?movieId=109924&type=netizen&page=',2)
test2

### read html
htxt2=read_html(test2)
htxt2
table2=html_nodes(htxt2, '.review_info')
table2
content2=html_nodes(table2, '.desc_review')
content2
reviews2=html_text(content2)
reviews2

reviews2<-gsub('\n', '', reviews2)
reviews2<-gsub('\t', '', reviews2)
reviews2

### for 

url_all=c()
for (i in 1:7){
    test<-paste0('https://movie.daum.net/moviedb/grade?movieId=109924&type=netizen&page=',i)
    url_all=c(url_all, test)
}
url_all

all_reviews=c() 
for (i in 1:7){
### read html
    htxt=read_html(url_all[i])


    table=html_nodes(htxt, '.review_info') #리뷰영역 가져오기
    
    content=html_nodes(table, '.desc_review') #리뷰 가져오기
    
    reviews=html_text(content) # html 코드 제거, 텍스트만
    

    reviews<-gsub('\n', '', reviews) # 불필요 부호 제거
    reviews<-gsub('\t', '', reviews) # 불필요 부호 제거
    all_reviews<-c(all_reviews, reviews)
}
all_reviews
str(all_reviews)
### write txt
writeLines(all_reviews, 'C:/Users/ktm/reviews.txt')

### wordcloud2
#install.packages('wordcloud2')
library(wordcloud2)
  wordcloud2(all_reviews)

  
### 연관성 분석