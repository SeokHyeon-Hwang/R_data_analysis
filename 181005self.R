rm(list=ls())
loc<-'http://archive.ics.uci.edu/ml/machine-learning-databases/'
ds<-'breast-cancer-wisconsin/breast-cancer-wisconsin.data'
url<-paste(loc, ds, sep='')
breast<-read.table(url, sep=',', header=F, na.strings='?')
names(breast)<-c('ID', 'clumpThickness', 'sizeUniformity',
                 'shapeUniformity', 'maginalAdhesion',
                 'singleEpithelialCellSize', 'bareNuclei',
                 'blandChromatin', 'normalNucleoli', 'mitosis', 'class')
head(breast)
table(breast$class)
df<-breast[-1]  ## ID 컬럼 불필요해서 삭제

## class 컬럼 범주형으로 변경
df$class<-factor(df$class, levels=c(2,4),
                 labels=c('benign', 'malignant'))
str(df)
set.seed(1234)
idx<-sample(nrow(df), 0.7*nrow(df))
tr<-df[idx,]
te<-df[-idx,]

glmmo<-glm(class~., family=binomial(), data=tr)
summary(glmmo)

prob<-predict(glmmo, te, type='response') # 확률로 표시(0~1)
head(prob,10)
pred<-factor(prob>.5, levels=c(FALSE, TRUE),
             labels=c('benign', 'malignant'))
confm<-table(te$class, pred, dnn=c('Act', 'Pred'))
confm

glmmo2<-glm(class~., data=tr, family=binomial())
glmstp<-step(glmmo2)
glmstp

library(rpart)
set.seed(123)
dtree<-rpart(class~., data=tr, method='class',
             parms=list(split='information'))

dtree$cptable

plotcp(dtree)

# nsplit : n이면 n분기를 가진 나무는 n+1 종착 노드를 가짐
# rel eroor: 나무에 대한 오류
# xerror : 교차 검증 오류
# xstd : 교차 검증 오류의 표준 오차

dtreepr<-prune(dtree, cp=.0125)
#install.packages('rpart.plot')
library(rpart.plot)

#type=2 : 각 노드 밑에 분기 라벨을 그리기
#extra=104 : 각 노드에서의 관측치 비율
#fallen.leaves=T : 바닥의 종착 노드를 보이게 함.

prp(dtreepr, type=2, extra=104,
    fallen.leaves=T, main='Decision Tree')

dtreepred<-predict(dtreepr, te, type='class')
dtreecobfm<-table(te$class, dtreepred,
                  dnn=c('ACT', 'PRED'))
dtreecobfm

# 조건적 추론 나무
# 변수와 분기가 순수성/동질성 척도보다는
# 유의성 검정에 기반하여 선택
# 유의성 검정은 순열검정

install.packages('party')
library(party)
fitctr<-ctree(class~., data=tr)
plot(fitctr, main='Conditional Inference Tree')

ctreepred<-predict(fitctr, te, type='response')
ctreeconfm<-table(te$class, ctreepred,
                  dnn=c('ACT', 'PRED'))
ctreeconfm

#알고리즘
# st1. 각 예측변수와 결과변수 간의 관계에 대한
# p값을 계산
# st2. 가장 낮은 p값을 가진 예측 변수를 선택
# st3. 선택된 예측 변수와 종속변수에서 모든 가능한
# 이항 분기를 탐색(순열검정), 가장 유의미한 분기를 선택
# st4. 데이터를 두 집단으로 나눔. 각 하위 집단에 대해
# 위 프로세스를 계속 진행
# st5. 분기가 더 이상 없을 때 까지 계속 함.