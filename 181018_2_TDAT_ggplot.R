rm(list=ls())
#install.packages('data.table')
library(data.table)
library(ggplot2)
library(dplyr)

df<-read.csv('E:/Bigdata/dataset/tdat/TDAT_train_sample.csv')
str(df)
table(df$is_attributed)

# filter : raw, selelct: col
df_sel<-df %>% select(ip, app, device, os, channel, is_attributed)
head(df_sel, 20)

# 상위 10개 ip확인
ip_is_attr<-df_sel %>% 
  filter(!is.na(is_attributed)) %>% 
  group_by(ip) %>% 
  summarise(sum_is_attr1=sum(is_attributed), cnt=n())
ip_is_attr

# 
top10<-ip_is_attr %>% 
  arrange(desc(cnt)) %>%
  head(10)
top10
top10$ip<-as.factor(top10$ip)

#
#q<-ggplot(top10, aes(x=ip, y=cnt))
#q+geom_boxplot()

p<-ggplot(top10, aes(x=reorder(ip, cnt), y=cnt), fill=ip) +
  geom_bar(stat='identity')
pl1 = p+coord_flip()

p2=ggplot(top10, aes(x=reorder(ip, cnt), y=sum_is_attr1)) +
  geom_bar(stat='identity')
pl2 = p2+coord_flip()

#install.packages('gridExtra')
library(gridExtra)

grid.arrange(pl1, pl2, ncol=2, nrow=1)

