

## KoNLP를 이용한 텍스트 마이닝

# 01 패키지 설치
library(KoNLP)

# 02 사전 불러오기
useSejongDic()

# 03 명사 추출
# extractNoun
# Hannanum anlayzer를 사용해서 한국어 문장으로부터 명사를 추출
# java로 개발
sentence<-'우리나라 고유의 문화는 우수하다. 전시회를 재미있게 보았다. 시간이 스르륵 지나갔다.'
# 옵션
extractNoun(sentence, autoSpacing = F) # default
extractNoun(sentence, autoSpacing = T) 

# 04. 사전에 단어 추가 : '스스륵'을 부사로 추가
# mergeUserDic() 함수를 이용해서 sejong 사전에 '스르륵' 단어 '부사'로 추가
mergeUserDic(data.frame(c('스르륵'), c('mag')))
buildDictionary(data.frame(c('스르륵'), c('mag')))

# 05. 형태소 분석하기
# Morpheme :형태소 분석하기
MorphAnalyzer((sentence)) #형태소 분석 결과를 산출

# $고유의
# [1] '고유/ncps+의/
# '의' 관형격

# 06
# SimplePos09 : 09개의 품사 태그를 달아주는 함수
# SimplePos22 : 22개의 품사 태그를 달아주는 함수
SimplePos09(sentence)

SimplePos22(sentence)

# grep을 써서 원하는 품사만 뽑아내서 분석이 가능하다!

#### 실습2
'''
df<-readLines('C:/Users/ktm/Desktop/detachment.txt')
extractNoun(df, autoSpacing = F)

mergeUserDic(data.frame(c('스르륵'), c('mag')))
MorphAnalyzer((df))

SimplePos22(df)

df<-gsub('')

'''

# 07 명사확인
library(stringr)
txt=SimplePos09(sentence)
txt_n=str_match(txt, '[a-zA-Z가-힣]+/N') # 명사확인인
txt_n

# 08 여러줄 텍스트 읽기
wk<-readLines('C:/Users/ktm/Desktop/wiki.txt', encoding = 'utf-8')
wk

### tm 패키지
# install.packages('tm')
# corpus 형태로 변환하여 다룬다.
# tm_map
library(tm)
doc