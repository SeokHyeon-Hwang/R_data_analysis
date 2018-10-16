# Bigcity
## data inform(https://stat.ethz.ch/R-manual/R-devel/library/boot/html/bigcity.html)
## barplot 2 in 1
install.packages('boot')
library(boot)

data(bigcity)
bct<-bigcity
str(bct)

col<-c('y20', 'y30')
colnames(bct)<-col
bct

bct$index<-c(1:49)
str(bct)

barplot(bct$y20,
        col=rgb(1,0,0, 0.3),
        names.arg=bct$index,
        
        xlab='city number', ylab='population', main='1920/1930 population')

barplot(bct$y30,
        col=rgb(0,0,1, 0.3),
        names.arg=bct$index,
        xlab='city number', ylab='population', main='1920/1930 population',
        add=T)
####

boxplot(bct)