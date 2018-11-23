

install.packages("rvest")
library(rvest)

all.reviews <- c()

#url_o <- 'https://movie.daum.net/moviedb/grade?movieId=100294&type=netizen&page='

# 완벽한 타인
url_o <- 'https://movie.daum.net/moviedb/grade?movieId=117910&type=netizen&page='

url <- c()
for (n in 1:50){
  tempurl <- paste(url_o, n, sep="")
  url <- c(url, tempurl)
}

url

for (page in 1:50) {
  urll <- url[page]
  htxt <- read_html(urll)
  table <- html_nodes(htxt, '.review_info')
  content <- html_nodes(table, '.desc_review')
  reviews <- html_text(content)
  if (length(reviews) == 0) {break}
  all.reviews <- c(all.reviews, reviews)
  print(page)
}

all.reviews2 <- c()

url <- c()
for (n in 51:100){
  tempurl <- paste(url_o, n, sep="")
  url <- c(url, tempurl)
}

url

for (page in 1:50) {
  urll <- url[page]
  htxt <- read_html(urll)
  table <- html_nodes(htxt, '.review_info')
  content <- html_nodes(table, '.desc_review')
  reviews <- html_text(content)
  if (length(reviews) == 0) {break}
  all.reviews2 <- c(all.reviews2, reviews)
  print(page)
}


all.reviews3 <- c()

url <- c()
for (n in 101:150){
  tempurl <- paste(url_o, n, sep="")
  url <- c(url, tempurl)
}

url

for (page in 1:50) {
  urll <- url[page]
  htxt <- read_html(urll)
  table <- html_nodes(htxt, '.review_info')
  content <- html_nodes(table, '.desc_review')
  reviews <- html_text(content)
  if (length(reviews) == 0) {break}
  all.reviews3 <- c(all.reviews3, reviews)
  print(page)
}


all.reviews
write.table(all.reviews, 'intimate_stranger.txt')
class(all.reviews)
is(all.reviews)