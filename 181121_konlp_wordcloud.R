## 라이브러리
library(KoNLP)
library(tm)
#install.packages('data.table')
library(data.table)
# 텍스트 불러오기
df<-readLines('E:/Bigdata/dataset/public_life_2015/public_life.txt')
head(df)
df
# 세종사전 불러오기
useSejongDic()
# 단어 추출 및 데이터 구조 변경
df2<-sapply(df, extractNoun, USE.NAMES = F)
df2

df3<-unlist(df2)
df3

# 불용어 제외
df3<-gsub('\\d+', '', df3)
df3<-gsub('\\n', '', df3)
df3<-gsub('[A-z]', '', df3)
df3<-gsub('[[:cntrl:]]', '', df3)


# 두 단어 이하 제외
df4<-Filter(function(x){nchar(x)>2}, df3)
df4

# 데이터를 테이블로 변형
df5<-data.table(df4)
df5

# 빈도수 확인
wordcount<-table(df5)
wordcount

# 워드클라우드 색지정
library(RColorBrewer)
ccolor<-brewer.pal(5,'Dark2')

# 워드클라우드
library(wordcloud)
wordcloud(df5, )