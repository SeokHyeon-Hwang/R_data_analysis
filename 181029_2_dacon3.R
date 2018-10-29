rm(list=ls())
trdf<-read.csv('E:/Bigdata/dataset/dacon3/Auction_master_train.csv')
head(trdf)
tr<-trdf

tr$ratio<-tr$Hammer_price/tr$Claim_price
summary(tr)
plot(tr$ratio)
dim(tr)
plot(tr$Auction_miscarriage_count, tr$ratio)
