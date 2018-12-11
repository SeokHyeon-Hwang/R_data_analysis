rm(list=ls())
x <- c(1,2,3)
x
class(x);
is(x);
mode(x)

one <- 89
four <- NA

# 확인
is.na(four)
is.null(x)

c(1,3,3) & c(2,2,2)
c(0,1,1) & c(1,0,1)

levels(iris$Species)
table(iris$Species)
nlevels(iris$Species)

colnames(iris)
names(iris)

nrow(iris)

length(iris)

iris[50:150,]

'setosa' %in% iris$Species

seq(0,20, 5)

3:10

rep(c(1,2,3), 3)


