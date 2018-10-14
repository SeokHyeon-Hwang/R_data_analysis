rm(list=ls())

#실습과제 1
# 1-1 기본 탐색 및 내용정리
di<-read.csv('D:/bigdata/dataset/diet.csv')
# 다이어트 프로그램 수행 전/후 체중을 기록
# 평균 차이가 유의한지 알아보자.
# 평균 몸무게가 수행 후 낮아졌다면 프로그램은 유의하다고 볼 수 있다.
dim(di)

str(di)
names(di)
di

# 1-3 가설 설정 및 검정
# 귀무가설 : 유의한 차이가 없다
# 대립가설 : 유의한 차이가 있다.

# 평균차도 있지만 우선 차이의 평균을 보자.
dif<-di$Before-di$After
dif
# 이것만 봐도 일단 양수가 많다. 즉 참가후 체중이 줄었음을 알 수 있다.
# 다이어트 전후 차이에 대한 box-plot
boxplot(dif)

# 양측 검정 수행
t.test(di$Before, di$After, alternative=c('two.sided'), paired=T, conf.level=0.95)
# p-value가 0.0068로 0.05보다 작으므로 유효하다.

# 단측 검정 수행
t.test(di$Before, di$After, alternative=c('greater'), paired=T, conf.level=0.95)
# p-value는 0.003432로 0.05보다 작으므로 유효하다.

# t통계량 계산
# 1. 각가의 차에 대한 평균 구하기
(meandif<-mean(dif))
# 2. 표준편차 구하기
(sddif<-sd(dif))
# 3. 검정 통계량 계산 ?? 이 값의 의미는 무엇일까요??
(tstat<-meandif/(sddif/sqrt(length(diff))))

# 양측검정을 하건 단측검정을 하건 p-value가 0.05이하 임을 확인 가능하다.
# 귀무가설을 기각하고 대립가설을 채택할 수 있다.
# 즉, 다이어트 프로그램은 체중감소에 효과가 있었다.

# 실습과제2
# 2-1. 결과를 예측하기 위한 모델 만들기
# 데이터 출처 : http://kkokkilkon.tistory.com/28
# sum_age_mainactors : 주연배우 나이 합계
# avg_slap_face : 회 평균 뺨 맞는 횟수
# genre : 드라마 장르

df<-read.csv('D:/bigdata/dataset/drama_genre.csv')
summary(df)


# 데이터 필터링
df<-subset(df, genre %in% c('막장드라마', '멜로드라마'))
# factor의 레벨을 3개이나 2개로 줄여보자.
# 멜로드라마인지 막장드라마인지 결정.



# 2-2. 평가용 데이터 예측 후, 성능평가
#