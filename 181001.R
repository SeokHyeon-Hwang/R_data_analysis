df<-read.csv('E:/Bigdata/dataset/R2_ex/example_studentlist.csv')
getwd()
dim(df)

# 벡터,행렬, 데이터 프레임, 리스트, 데이터 테이블 ##
# 데이터프레임은 컬럼에 따른 행의 갯수가 같아야 형성된다.
# 리스트는 컬럼에 따른 행의 갯수가 달라도 된다.
a<-c(1:20)
s<-c('파스타', '짬뽕','순두부찌개','요거트','커피')
L<-c(T,F,F,T,T,T)
is(a)
is(s)
is(L)
length(a); length(s); length(L)
List<-list(a=a, s=s, L=L, df=df)
List
is(List)
List$a
List$s
List['a']  # 됨
List[1]  # 됨
List[3,1]  # 안됨
List[3,'a']  # 안됨
List[[2]]
is(List[2]) # : 컬럼명도 포함 ex) 표+표 안의 값
is(List[[2]]) # : 컬럼명 빼고 값들만 선택,값들 자체 ex) 표 안의 값
a<-c(80,90,70,90,95,60)
b<-c('pass','pass','fail','pass','pass','fail')

list1<-split(a,b)
list1
is(list1)

sapply(list1, mean)
sapply(list1, sd)
sapply(list1, quantile)

ddd<-extractNoun(text)
unlist

## 다이어트 프로그램 하기전/ 한 후
# 01.가설 설정 - 효과가 없다 : 귀무가설, 효과가 있다 : 대립가설   /t검정과 f 통계량을 통해서.
df<-read.csv('E:/Bigdata/dataset/diet.csv')
df
summary(df)
str(df)
# 02. 유의수준 : 결정 0.05
t.test(df$Before, df$After, alternative = c('two.sided'), paired = T ,conf.level = 1-0.01)  # conf.level=0.95를 default 값으로 가짐
# paried=T 같은 모집단에서. 종속표본에서.

# 동일 모집단에서 데이터는 t분포를 따른다. 그래서 t검정을 한다. 데이터가 작을 경우에 쓴다. t 통계량
# 세 집단 이상에 차이가 있다없다는 f통계량이 검정 통계량이 된다.
# t=3.4868은 검정통계에 의해 구해진 값
# D=Be-Af
diff<-df$Before-df$After
diff
mean_diff<-mean(diff)  # 두 값들의 차의 평균
dim(df)
sd_diff<-sd(diff)  # 두 값들의 차의 표준편차

length(diff)
sqrt_n<-sqrt(length(diff))


(t_stat<-mean_diff/(sd_diff*sqrt_n))

#양측 검정을 했을 때p 값이 0.05보다 작다? -> 대립가설 채택
# 차이가 있다 없다 : 양측검증
# 다이어트가 되었다 ? 단측 검증 greater: 빠진다,

## 단측검증
t.test(df$Before,df$After, alternative=c('greater'), paired = T, conf.level = 0.95)

# p-value 는 극단적 결과가 
# 데이터가 많으면 

# 1종 오류 효과가 없는데 효과가 있다고 하는 것
# 2종 오류 효과가 있는데 효과가 없다고 하는 것


# 독립표본에서
library(MASS)
MAss
head(UScrime)
t.test(Prob~So, data=UScrime)

# 귀무가설 : 남부와 비남부가 같은 투옥 확률을 갖는다.
# 대립가설 : '' 가 같은 투옥 확률을 갖지 않는다.

# 젊은 남성(14~24)의 실업률이
# 장년 남성(35~39)보다 높은가?
# 일자리 수는 정해져 있으므로 두 집단은 독립적이지 않다.

#U1 : 14-24세 지역 남성의 실업률
#U2 : 35-39세 지역 남성의 실업률

us<-UScrime
cor(us$U1, us$U2)

# sapply(_, fun)
# t.test(종속변수~ 독립변수, data)
t.test(us$U1, us$u2, paired=T)


#1970년대 보스턴 주택가격 예측 모델 만들기
df<-read.table('E:/Bigdata/dataset/housing.csv', sep='', header=F, stringsAsFactors = F)
head(df,10)
dim(df)
str(df)

coln<-c('crim','zn','indus','chas','nox','rm','age','dis','rad','tax','ptratio','black','lstat','medv')
colnames(df)<-coln
colnames(df)
str(df)
#df$rm<-as.integer(df$rm)
summary(df$rm)
# 데이터 탐색 - 정규표현식
grep('[a-zA-Z]',df$rm, value=T)
which(df$rm=='miss')
# 27번째 데이터를 결측치로 처리
which(df$rm=='miss')
df[df$rm=='miss',]<-NA
df$rm
plot(df$rm)
hist(df$rm)
df[is.na(df$rm),'rm']<-median(df$rm)
sum(df$rm)
mean(df$rm, na.rm=T)
df$rm=as.numeric(df$rm)

# 실수형 값은 몇개지?
a=grep('[0-9].[0-9]', df$rm, value=T)
a

#df$dis
sum(is.na(df$dis))
grep('[a-zA-Z]', df$dis, value=T)  # value 쓰면 해당 값이 나오고 value= 빼면 인덱스가 나옴
head(df$dis)
