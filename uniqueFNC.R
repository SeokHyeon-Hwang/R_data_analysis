name<-c('a','c','a','b','b','c','d')
x<-data.frame(name)
x

# 중복 행을 빼고 보여준다!
y<-unique(x)
y

# 중복 행의 숫자를 알고 싶을 때
nrow(x)
nrow(unique(x))

# unique() : 중복 행 빼고 보여주기
val<-c(1,3,1,2,5,3,4)
x2<-cbind(x,val)
x2
unique(x2)

# 중복된 행 확인 T:중복, F:중복x
duplicated(x2)

# which로 진리값 확인
which(duplicated(x2))

# 해당 행 출력
x2[which(duplicated(x2)),]

# 중복 최초 행 포함을 위해duplicated()를 한 번 더 적용
x2[which(duplicated(x2)|duplicated(x2, fromLast=T)),]
x2

# duplicated()는 1행에서 아래로 내려가며 중복 검사
duplicated(x2)

# fromLast=T 옵션이 주어진 duplicated()는 7행에서 위로 올라온다
duplicated(x2,fromLast=T)

# 둘의 결과를 or('|')를 이용하여 합하면 중복행 표시
x2[which(duplicated(x2)|duplicated(x,fromLast=T)),]
(y<-x2[which(duplicated(x2)|duplicated(x2,fromLast=T)),])

# order렬() 이용하여 원하는 순서로 데이터 정ㄹ
(y<-y[order(y$name),])

# plyr라이브러리 count() 행이 셋 이상 다수 중복-> 중복된 횟수 파악
library(plyr)
count(x2)

# 특정 열의 값만 파악
count(x2, vars=c('name'))

# 중복된 행만 보려면 subset()
subset(count(x2), freq>1)
