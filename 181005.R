rm(list=ls())

loc <- "http://archive.ics.uci.edu/ml/machine-learning-databases/"
ds  <- "breast-cancer-wisconsin/breast-cancer-wisconsin.data"
url <- paste(loc, ds, sep="")

breast <- read.table(url, sep=",", header=FALSE, na.strings="?")
names(breast) <- c("ID", "clumpThickness", "sizeUniformity",
                   "shapeUniformity", "maginalAdhesion", 
                   "singleEpithelialCellSize", "bareNuclei", 
                   "blandChromatin", "normalNucleoli", "mitosis", "class")
# 의사결정트리 모델로 악성, 양성 예측 모델 생성

head(breast)
View(breast)
table(breast$class)

df<-breast[,-1]
str(df)
df$class<-factor(df$class, levels=c(2,4),
                 labels=c('benign', 'malignant'))
str(df)
#tr/te 7:3
idx<-sample(nrow(df),nrow(df)*0.7)
tr<-df[idx,]
te<-df[-idx,]
tr
str(tr)
str(te)

#로지스틱
glmmo<-glm(tr$class~., family = 'binomial', data=tr )
glmmo
summary(glmmo)

prob<-predict(glmmo, newdata=te, type='response')
head(prob,10)

pred<-factor(prob>.5, levels=c(FALSE, TRUE), 
             labels=c('benign', 'malignant'))
pred
act<-te$class
table(pred,act,
      dnn=c('prediction','act'))
# 정확도(맞춘것/테이블 전체 합)

(logit_step<-step(glmmo))

# rpart 패키지의 rpart(), prune()
#install.packages('rpart')
library(rpart)
set.seed(1234)
dtree<-rpart(class~., data=tr,
             method='class',
             parms=list(split='information'))

dtree$cptable
plotcp(dtree)

dtree.pruned<-prune(dtree, cp=0.01000000)
#install.packages('rpart.plot')
library(rpart.plot)

prp(dtree.pruned, type=2,
    extra=104, #각 노드에서의 관측치
    fallen.leaves=TRUE, #맨 마지막 노드를 보여주겠다.
    main='Decision Tree') # 트리의 이름을 정한다

dtree.pred<-predict(dtree.pruned, te, type='class')
dtree.pref<-table(act, dtree.pred,
                  dnn=c('act','pred'))
