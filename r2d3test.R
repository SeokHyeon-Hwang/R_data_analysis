
# D3 variables
#data — The R data converted to JavaScript.
#svg — The svg container for the visualization
#width — The current width of the container
#height — The current height of the container
#options — Additional options provided by the user
#theme — Colors for the current theme

library(r2d3)
#1
r2d3(data=c(0.3, 0.6, 0.8, 0.95, 0.40, 0.20), script = "r2d3test.js")

#2
bars<-c(10,20,30)
r2d3(data=bars, script='r2d3test2.js', options=list(color='orange'))

#3 morley model
r2d3(data = read.csv("E:/Bigdata/dataset/morley/morley.csv"), d3_version = 3, container = "div",
     dependencies = c("E:/Bigdata/dataset/morley/box.js"), script = "E:/Bigdata/dataset/morley/morley.js")

#4 
