### 01. EDA
df=table(df$...)
barplot(df)  #빈도를 볼 때

Boxplot(, main='',
        xlab='',
        ylab='',
        xlim=c(0,30),
        ylim=c(0,40),
        col='')  #상자그림

?hist
hist(, breaks=)  #밀도(X축은 반드시 수치형 연속형 변수이어야 한다.)
ScatterPlot() #산점도

### 02. 종속변수, 독립변수
종속변수 : 영향을 받는 변수이다.
독립변수 : 영향을 미치는 변수이다.

### 03. 고수준 함수, 저수준 함수
고수준함수 : barplot(), Boxplot(), hist(), scatter()
저수준함수 : title(), line(), abline(), legend(), point()

### 04. 파일을 읽어올 때 함수
read.csv(data, sep='\t', header=TRUE, stringAsFactors=TRUE, na.strings=c('',NA))
read.spss() #foreign, haven
read_xlsx()
read.json()
read.table(sep=',')

### 05. 파일을 쓸 때
write.csv(, row.names=FALSE)

### 06. 데이터 탐색
str()
dim()
View()
names()
head()
tail()
is()
summary()

### 07. 범주형 또는 이산형 변수의 빈도 확인
table(, useNA='always')

### 08.dplyr패키지(plyr)
df<-rename(data, name1=원래이름,
           name1=원래이름,
           name1=원래이름,
           name1=원래이름) : 컬럼명 변경

filter() 조건에 따른 행 선택
mutate() 파생변수 선택
arrange() 정렬
group_by() 그룹화
summarise() 요약결과 보기

### 09.
install.packages('패키지명')
library(패키지명)

search()
attach()

detach()

### 10. 결측치 확인
library(Amelia)
missmap(,)

### 11. 파생변수
mutate
df$새로운컬럼명<-...

### 12.
cbind()
rbind()
names()
colnames()
rownames()

### 13. 변수
factor()  # levels, orderd를 넣을 때는 이걸 써야
data.frame()
matrix()
as.factor()

### 14. 표준화
#평균을 0으로 옮기곻, 이를 각각의 자신의 표준편차로 나누어 준 값
scale()

### 15. 정규화 : 0~1사이의 값으로 만들어준다
norm()

### 16. 회귀분석, 랜덤포레스트
lm() : 타깃이 수치형일 때
randomForest() : 분류(classification)알고리즘에 최적화, 수치형에도 가능
glm() : 0,1

Lm=lm()

## p-val, 결정계수, f-통계량, 유의한 변수
summary(Lm)

# 잔차 등 확인
plot(Lm)

### cp통계량, AIC, BIC 
### 값 낮을수록 좋다. 선택법이 다양하다. 
### AIC : step()함수
### BIC : regsubsets()



