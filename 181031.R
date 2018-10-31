



#변동계수 구하기(coefficient of variation)
# cv=표준 편차/산술평균
mtcars
cv1=sd(mtcars$mpg/mean(mtcars$mpg))

#함수를 이용한 변동계수 구하기
##
# 함수명 <- function(x){
#   sd(x)/mean(x)
#  }

# 함수적용, 변동계수 구하기
cv<-function(x) {sd(x)/mean(x)}

cv(mtcars$cyl)
cv(mtcars$am)

names(mtcars)

#lapply(데이터셋, 함수)
a<-lapply(mtcars, cv)

b<-sapply(mtcars, cv)
class(a); class(b)


lapply(mtcars, function(x) sd(x)/mean(x))


#패키지 설치 및 버전 확인
a=installed.packages() [, c('Package', 'Version')]
grep('foreign', a, value=T)

#  여러 리스트 형태로 되어 있는 것을 하나의 벡터로 만든다.
lst=list('Moe', NULL, 'Curly', mtcars)
lst
unlist(lst)

library(stringr)
str_count('Moe')


nchar('Moe')

###
library(MASS)
Cars93
# City MPG(miles per US gallon by EPA rating).
# of non-USA or USA company origins(factor).
table(Cars93$MPG.city)
table(Cars93$Origin)

#split(나눌데이터 또는 변수, 나눌 구분(필드))
split(iris$Sepal.Length, iris$Species)
split(Cars93$MPG.city, Cars93$Origin)


# 각각의 리스트 요소에 함수 적용
# sapply : 적용 후 벡터로 반환
# lapply : 적용 후 리스트로 반환

# strings 함수들
# nchar() : 글자수
# 벡터의 길이(요소)를 반환 : length()
# 문자열 결합 : paste(), paste0()
# 문자열 일부를 가져오기:
ss<-c('Moe', 'Larry', 'Curly')
ss[c(1,3)]
substr(ss, 2, 3)

ss<-'I am boy'
substr(ss, 6,8)

## 기준(구분)이 되는 것에 따라 문자를 나눈다.
# strsplit(문자열, '/')
# 맨 마지막에 위치한 파일명만 가져오겠다.
path<-'a/home/mike/data/trials.csv'
b<-strsplit(path, '/')[[1]]



filelen=length(b)
b[filelen]

### mtcars
names(mtcars)
mt<-mtcars[, -c(2,3,4)]
names(tr)

# 문자열의 일부 문자열을 바꾸기
# (이전, 원하는 결과, 문자열)

gsub('영화의', '영화', 문자열)

# 오늘의 날짜를 알아보기
sys.Data()
dat=as.Date('2011-21-31')
class(dat)
dat1<-as.Date('12/31/2017', format='%m/%d/%Y')
dat2<-as.Date('2017/10/31', format='%Y/%d/%d')
dat; dat1 ; dat2

##
Sys.Date()
d=as.character(Sys.Date())
d
substr(d, 1,4) #연도
substr(d, 6, 7) # 월
substr(d, 9, 10) # day

dat=as.Date('2010-12-31')
p=as.POSIXlt(dat)
str(p)

p$mday
p$mon +1 # month(0~11)
p$year +1900 #연도
p$hour # 시간(0~23)
p$wday #0:sun,  1=mon
p$yday #0~365
p$min #분
p$sec  #초
