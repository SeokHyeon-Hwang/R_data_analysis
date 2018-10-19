

library(igraph)

setwd('E:/Bigdata/dataset')

nodes<-read.csv('./Dataset1-Media-Example-NODES.csv')
links<-read.csv('./Dataset1-Media-Example-EDGES.csv')

str(nodes)
str(links)

View(nodes)
View(links)
dim(nodes); dim(links)

# d: 네트워크 상의 edge
# vertices : node IDs
net=graph_from_data_frame(d=links, vertices=nodes, directed = T)
class(net)

E(net) # edges 확인
V(net) # vertices 확인
E(net)$type
V(net)$media

table(E(net)$type)
table(V(net)$media)

plot(net)

## 무언가를 줄인 형태 : simplify()
net<-simplify(net, remove.multiple = F, remove.loops = T)
plot(net, edge.arrow.size=0.4, vertex.label=NA)

# read data

nodes2<-read.csv('./Dataset2-Media-User-Example-NODES.csv')
links2<-read.csv('Dataset2-Media-User-Example-EDGES.csv')

dim(nodes2);dim(links2)

links2<-as.matrix(links2)
net2<-graph_from_incidence_matrix(links2)
table(V(net2)$type)

plot(net2, vertex.label=NA)

###
plot(net, dege.arrow.size=0.4, edge.curved=0.1)

plot(net, dege.arrow.size=0.4, edge.curved=0,
     vertex.color='orange',
     vertex.label=V(net)$media)

plot(net, dege.arrow.size=0.4, edge.curved=0,
     vertex.color='orange',
     vertex.label=V(net)$media,
     vertex.label.color='black')

plot(net, dege.arrow.size=0.4, edge.curved=0,
     vertex.color='orange',
     vertex.label=V(net)$media,
     vertex.label.color='black',
     vertex.label.cex=0.7)

plot(net, dege.arrow.size=0.4, edge.curved=0,
     vertex.color='orange',
     vertex.frame.color='#555555',
     vertex.label=V(net)$media,
     vertex.label.color='black',
     vertex.label.cex=0.7)


# 각각의 미디어 종류에 따라 색 지정
colors<-c('gray50', 'tomato', 'gold')
V(net)$color<-colors[V(net)$media.type]
V(net)$color

deg<-degree(net, mode='all')
V(net)$size<-deg*3

# 2번째 방법, 데이터의 audience.size를 이용
V(net)$size<-V(net)$audience.size*0.7

# label.color
V(net)$label.color<-'black'
# V(net)$label<-NA : label 없애기

# E(), V()를 통해서 속성을 내장시킬수 있다. 
E(net)$weight<-E(net)$weight/6 # weight:중요도
E(net)$arrow.size<-0.2
E(net)$edge.color<-'gray80'
graph_attr(net, 'layout')<-layout_with_lgl
plot(net)

legend(x=-1.1, y=-1.1, c('Newspaper', 'Television', 'Online News'),
       pch=21, col='#777777', pt.bg=colors, pt.cex=2.5,
       ncol=1)

plot(net,  vertex.label=V(net)$media, 
     vertex.label.font=2, vertex.label.color="gray40",
     vertex.label.cex=.7, edge.color="gray85")
