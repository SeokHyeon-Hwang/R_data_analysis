rm(list=ls())
data(UScereal, package='MASS')
dim(UScereal)
idx<-sample(1:nrow(UScereal), NROW(UScereal)/2)
tr<-UScereal[idx,]
te<-UScereal[-idx,]
mo<-lm(calories~protein+fat+sugars, data=tr)
pred<-predict(mo, newdata=te[,-1])
mo
er<-pred-te[,'calories']
er

data(pima, package='faraway')
pima$test<-factor(pima$test)
tr_idx<-sample(1:nrow(pima), nrow(pima)/2)

m<-glm(test~ pregnant+glucose+bmi, family=binomial,
    data=pima[tr_idx,])
m
pred<-as.integer(predict(m, newdata=pima[-tr_idx,], type='response')>0.5)
pred

actual<-pima[-tr_idx, 'test']
xt=xtabs(~pred+actual)
xt
prop.table(xt)

library(caret)
pred<-as.factor(pred)
actual<-as.factor(actual)
confusionMatrix(pred, actual)

library(ROCR)
pred_prob<-predict(m, newdata=pima[-tr_idx,], type='response')
pred_prob

labels<-pima[-tr_idx, 'test']

pred3<-prediction(pred_prob, labels)
plot(performance(pred3, 'tpr', 'fpr'))

par(mfrow=c(1,2))
plot1=performance(pred3, 'prec', 'rec')
plot2=performance(pred3, 'sens', 'spec')

plot(plot1)
plot(plot2)
