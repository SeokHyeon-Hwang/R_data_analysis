
## https://stackclee.github.io/text/nlp-sentiment.html#---gutenberg-gutenberg-tutorial

# https://ropensci.org/tutorials/gutenbergr_tutorial.html
# if (!require("devtools")) install.packages("devtools")
# devtools::install_github("ropenscilabs/gutenbergr")
library(gutenbergr)
library(tidyverse)
library(DT)
library(stringr)
# install.packages("DT")
# install.packages("tidyverse")
# install.packages("devtools")
# install.packages("stringr")
# devtools::install_github("ropenscilabs/gutenbergr")

search()

# 1. 구텐베르크 패키지 사용법
gutenberg_metadata %>% sample_n(100) %>%
  datatable()

gutenberg_metadata %>% count(language, sort=TRUE) %>%
  mutate(percent = n / sum(n),
         cumpcnt = scales::percent(cumsum(percent)))
gutenberg_metadata

# 2.2 다운로드 가능한 도서
gutenberg_works() %>% sample_n(100) %>%
  datatable()

# gutenberg_works(str_detect(author, "Poe"))

gutenberg_works(author == "Poe, Edgar Allan") %>%
  datatable()

## 2.3 에드거 앨런 포 저작물 다운로드
## 전자책마다 고유한 실별자가 붙어있다.
## 예를 들어, 어셔가의 붕괴(The Fall of the House of Usher)는 932, 아몬틸라도의 술통(The Cask of Amontillado)는 1063번으로 고유 ID가 붙어 있다.

usher_house <- gutenberg_download(932)
dim(usher_house)
datatable(usher_house)

## 3.2 책 두권
poe_books <- gutenberg_download(c(932, 1063), meta_fields = "title")
datatable(poe_books)

poe_books %>%
  count(title)

## 3. 감성어 사전
## tidytext 패키지에 감성어 사전(sentiment lexicon)이 3개 포함되어 있다.
## get_sentiments() 함수에 다음 감성어 사전을 인자로 넣어 깔끔한 텍스트 데이터프레임과
## inner_join하여 텍스트에 포함된 감성을 계량화 한다.

## 4. 에드가 앨런 포 감성분석
# install.packages("tidytext")
# install.packages("ggthemes")
# install.packages("extrafont")
# install.packages("tidyr")
library(tidyr) # spread
library(tidytext) # get_sentiments
library(ggthemes)
library(extrafont)
library(dplyr)
library(ggplot2)

loadfonts()
search()

# 2. 깔끔한 텍스트(tidytext) 변환
poe_tidy_books <- poe_books %>%
  group_by(title) %>%
  mutate(linenumber = row_number()) %>%
  unnest_tokens(word, text) %>%
  ungroup()

poe_tidy_books %>%
  count(word, sort = TRUE)

## 4.1 긍정/부정어 활용
## 포우 두 소설에 사용된 긍정어와 부정어를 살펴본다.
## negative, positive로 감성사전이 구성된 "bing"을
## 활용하여 가장 많이 언급된 긍정어를 시각화한다.

# 3. 감성 분석
## 3.1. 긍정/부정 단어
poe_word_counts <- poe_tidy_books %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment)

top_poe_words <- poe_word_counts %>%
  group_by(sentiment) %>%
  top_n(20, n) %>%
  ungroup() %>%
  mutate(word = reorder(word, n))

ggplot(top_poe_words, aes(word, n, fill = sentiment)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~sentiment, scales = "free") +
  coord_flip() +
  labs(x="", y="")

## 4.2 감성 추세
## 감성 변화를 추세로 나타내기 위해서 소설행을 35줄 마다
## 한 단위로 묶고, positive에서 negative를 빼서 감성을
## 한 점수로 만들어 내고, 이를 각 책장마다 붙인 인덱스(index)에
## 맞춰 추세를 시각화한다.

## 3.2 시점별 감성변화
#---------------------------이부분 mutate 부분 에러뜸.
poe_tidy_books %>%
  inner_join(get_sentiments("bing")) %>%
  count(title, index = linenumber %>% 35, sentiment) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment = positive - negative) %>%
  ggplot(aes(index, sentiment, fill = title)) +
  geom_col() +
  facet_wrap(~title, scales = "free_x") +
  theme_bw(base_family = "NanumGothic") +
  theme(legend.position = "none") +
  labs(x="", y="감성점수", fill = "책 제목")
#------------------


## 3.3. 감정을 표현하는데 많이 사용된 단어

poe_tidy_books %>%
  anti_join(data_frame(word = "usher")) %>%
  inner_join(get_sentiments("nrc")) %>%
  count(word, sentiment) %>%
  group_by(sentiment) %>%
  top_n(10, n) %>%
  ungroup() %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n, fill = sentiment)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ sentiment, scales = "free") +
  coord_flip() +
  theme_bw(base_family = "NanumGothic") +
  theme(legend.position = "none") +
  labs(x = "", y = "", fill = "책 제목")

## 4.4. 두 소설 특정 감성에 많이 동원된 단어
## 3.4. 두 소설 비교

poe_tidy_books %>%
  anti_join(data_frame(word = "usher")) %>%
  inner_join(get_sentiments("nrc")) %>%
  filter(sentiment %in% c("negative")) %>%
  count(word, title) %>%
  group_by(title) %>%
  top_n(10, n) %>%
  ungroup() %>%
  mutate(word = reorder(paste(word, title, sep = "__"), n)) %>%
  ggplot(aes(word, n, fill = title)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ title, scales = "free") +
  coord_flip() +
  theme_bw(base_family = "NanumGothic") +
  theme(legend.position = "top") +
  labs(x = "", y = "", fill = "책 제목") +
  scale_x_discrete(labels = function(x) str_replace_all(x, "__.+$", ""))
