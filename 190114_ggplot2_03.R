
rm(list=ls())
#install.packages('igraph')
library(igraph)

g1<-graph(c(1,2,2,3,2,4,1,4,5,5,3,6,3,3))
plot(g1)

df<-read.csv('C:/Users/ktm/Downloads/clustering.csv')
str(df)
summary(df)
graph<-data.frame(학생=df$학생, 교수=df$교수)

graph
library(stringr)
df<-graph.data.frame(graph, directed=T)
is(df)
plot(df)


str(df)

gubun1 <- V(df)$name
gubun1

gubun <- str_sub(gubun1, start=1, end=1)
gubun
table(gubun)

plot(df, layout=layout.fruchterman.reingold,
     vertex.size=2,
     edge.arrow.size = 0.05,
     vertex.color='green',
     vertex.label=NA)

