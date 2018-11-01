## 01. 데이터 준비
## 02. 긍, 부정 단어
## 03. 불러온 텍스트 전처리
## 04. 감성 분석을 위한 점수

## 01. 데이터 준비 및 사전 준비
## 세종 dic, KoNLP, 파일 30_AgainCourt.txt
#rm(list=ls())
library(KoNLP)
useSejongDic()

fr<-'E:/Bigdata/dataset/sent/30_AgainCourt.txt'
rd1<-readLines(fr)

setwd('E:/Bigdata/dataset/sent')

## 02. 긍,부정 단어 불러오기
pos.words=scan('positive-words-ko-v2.txt', what='character', comment.char=';')
neg.words=scan('negative-words-ko-v2.txt', what='character', comment.char=';')

pos.words
neg.words

## 03. 의미없는 데이터 제거(특수문자, 제어문자(\n, \r), 숫자 제거) -gsub
require(plyr)
require(stringr)
## require : 잘 불러왔다 아니다, true false if문으로 잘 불러왔는지 선행 확인
## library() 불러온 라이브러리 
## require->library

sentences<-rd1

##
sentences<-gsub('\\d+', '', sentences) # 숫자를 공백으로 변경
sentences<-gsub('[[:cntrl:]]', '', sentences) # \n, \r 같은 제어문자 제거

## 구두점 문자 ! " # $...
sentences<-gsub('[[:punct:]]', '', sentences)

length(sentences)
head(sentences)

## 명사추출
wordlist<- sapply(sentences, extractNoun, USE.NAMES = F)
wordlist2<-lapply(sentences, extractNoun)
wordlist
wordlist2
class(wordlist)
class(wordlist2)

words<-unlist(wordlist)
head(words, 50)
length(words)

## 감성 분석
a<-c('i am student', 'you are a girl')
match(words, c('진짜', '변호사'))
match(words, pos.words) # words에 긍정단어 사전에 있다면 위치, 없다면 NA 뛰움

pos.matches<-match(words, pos.words) # 긍정단어 검색
neg.matches<-match(words, neg.words) # 부정단어 검색

(pos.matches<-!is.na(pos.matches)) # 7000개의 단어를 NA인지 확인
(neg.matches<-!is.na(neg.matches)) 
sum(pos.matches)
sum(neg.matches)
score<-sum(pos.matches)-sum(neg.matches)
score
