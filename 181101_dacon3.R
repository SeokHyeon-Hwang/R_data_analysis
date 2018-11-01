rm(list=ls())
trdf<-read.csv('E:/Bigdata/dataset/dacon3/Auction_master_train.csv')
tedf<-read.csv('E:/Bigdata/dataset/dacon3/Auction_master_test.csv')
head(trdf)
tr<-trdf
te<-tedf

# EDA
str(tr)
summary(tr)
dim(tr)
plot(tr$Auction_miscarriage_count, tr$ratio)

#전처리
## 컬럼 추가 
tr$ratio<-tr$Hammer_price/tr$Claim_price
plot(tr$ratio)
te$ratio<-te$Hammer_price/te$Claim_price


## 컬럼 삭제 
### 삭제 컬럼 : Auction_key[1], Appraisal_date[6]
### Auction_miscarriage_count[8], First_auction_date[16], 
### Final_auction_date[17], Final_result[18],
### addr_li[23],addr_bunji1[25], addr_bunji2[26], 
### addr_etc[27],Preserve_regist_date[29], Specific[32]
### road_name[34], road_bunji1[35], road_bunji2[36],
### Close_date[37], Close_result[38], 
### Total_land_real_area[10], Total_building_area[12],
### point.y[39], point.x[40]
colnames(tr)
delcol<-c(1, 6, 8, 10, 12, 16, 17, 18, 23, 25,
          26, 27, 29, 32, 34, 35, 36, 37, 38, 39, 40)
tr1<-tr[,-delcol ]
te1<-te[,-delcol]

## 결측치 확인
library(Amelia)
missmap(tr1)

str(tr1)
# ratio 행이 inf 로 나와서 
loc<-which(tr1$Claim_price==0)
tr1<-tr1[-loc,]


# factor인 컬럼 삭제 후 lm 실행
colnames(tr1)
delcol2<-c(1, 2, 4, 11, 12,13,14,15,16,19)
tr2<-tr1[,-delcol2]
te2<-te1[,-delcol2]

#for (i in 1:ncol(tr1)){
#  locwhich(class(tr1[,i]) != 'factor')
#}


#for (i in 1:ncol(tr1)) {
#  if (class(tr1[,i]) != 'factor'){
#    print(which(class(tr1[,i]) != 'factor'))
#    tr2<-tr1[,-i]
#    }
#}


# 7:3 샘플링
set.seed(1007)
idx<-sample(1:nrow(tr1), nrow(tr1)*0.7)
tr7<-tr2[idx,]
tr3<-tr2[-idx,]


str(tr7)

## 상관도 그리기
library(corrplot)
tr7cor<-cor(tr7)
corrplot(tr7cor)




# lm 모델 만들기
tr7lm<-lm(Hammer_price~Total_appraisal_price+
            Minimum_sales_price, data=tr7)
summary(tr7lm)
tr7lmst<-step(tr7lm, direction='both')

# 테스트 데이터 예측 후 실제값과 비교
preval<-predict(tr7lm, newdata=te2)
preval

dim(preval)

sub<-read.csv('E:/Bigdata/dataset/dacon3/Auction_submission.csv')
sub$Hammer_price<-preval
write.csv(sub, file='E:/Bigdata/dataset/dacon3/sub/sub181101_01.csv', row.names=F)
