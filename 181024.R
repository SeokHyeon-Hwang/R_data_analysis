# wordcloud for text mining
library(KoNLP)
library(wordcloud)

text = '텍스트마이닝은 자연어(natural language)로 구성된 비정형 텍스트 데이터에서 
패턴 또는 관계를 추출하여 가치와 의미 있는 정보를 찾아내는 마이닝 기법이다.
(나) 자연어 처리(natural language processing)기술에 기반한 방법이다.
텍스트마이닝은 말 그대로 텍스트 형태의 비정형 데이터에 마이닝 기법을 적용한 것이다. 즉 텍스트에
나타나는 단어를 분해, 정제하고, 특정 단어의 출현빈도 등을 파악하여 단어들 간의 관계를 조사하는
기법이다.
데이터 마이닝은 대규모 DB에 저장된 정형화된 데이터로부터 정보를 찾아내는 기법이라면
텍스트마이닝은 비정형화된 텍스트 문서에서 정보를 찾아내는 기법이라고 할 수 있다.'


useSejongDic()
nouns<-extractNoun(text)

nouns<-nouns[nchar(nouns)>=2]
nouns<-gsub('텍스트마이닝.*', '텍스트마이닝', nouns)
nouns<-gsub('데이터마이닝.*', '데이터마이닝', nouns)
nouns

wordFreq<-table(nouns)
pal<-brewer.pal(6, 'Dark2')

windowsFonts(malgun=windowsFont('맑은 고딕'))

set.seed(1000)
wordcloud(words=names(wordFreq),
          freq=wordFreq,
          colors=pal,
          min.freq=1,
          random.order=F,
          family='malgun')


# excel : 정형
# html : 반정형
# text : 비정형
# 텍스트를 행렬로 만든다
# 뭘 분석? 빈도, 연관성, 감정,
# 요구->텍스트수집->텍스트저장&전처리->텍스트분석->결과시각화->관리및공유
# 지도학습/ 비지도학습 분류문제에 있어서 레이블이 있느냐 없느냐
# 모양이 세가지야:지도학습. 모양은 몰라:비지도학습
# 오픈 API, 크롤링, 스크랩핑, FTP
# 크롤링 : 정기적, 주기적, 자동적
# 스크랩핑 : 한 사이트에서.


