# sample()
# 데이터에서 무작위로 샘플을 추출해주는 함수
sample(x=1:10, 5)

df<-c(1:10)
set.seed(123)
sample(df,5)

# default값이 비복원 추출로 되어있다.
# replace=F 인 것.
# 비복원추출은 추출 갯수가 모집단 데이터 수보다 작아야 함.
# 복원추출 하고 싶다면 replace=T


df<-c(1:10)
sample(df, 10, replace=T)
