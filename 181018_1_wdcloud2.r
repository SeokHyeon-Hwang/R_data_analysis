getwd()

install.packages("rvest")
library(rvest)

all_reviews <- c()

for (i in 1:200){
  test <- paste0("https://movie.daum.net/moviedb/grade?movieId=93251&type=netizen&page=", i)
  htxt <- read_html(test)
  
  table <- html_nodes(htxt, '.review_info')
  content <- html_nodes(htxt, '.desc_review')
  reviews <- html_text(content)
  
  reviews <- gsub('\n', '', gsub('\t', '', reviews))
  all_reviews <- c(all_reviews, reviews)
}

word <- sapply(all_reviews, extractNoun, USE.NAMES = F)
word <- unlist(word)

word <- gsub("\\d+","", word)
word <- gsub("\t","", word)
word <- gsub("[a-zA-Z]","", word)
word <- word[nchar(word)>=2]
word

wordcount <- table(word)
word_df <- data.frame(wordcount)
head(word_df) 

word_df <- word_df[order(word_df$Freq, decreasing = TRUE), ]

install.packages("wordcloud2")
library(wordcloud2)

wordcloud2(word_df[1:300, ], size = 1.5, 
           color = "random-light",
           backgroundColor = "grey",
           rotateRatio = 0.75)
