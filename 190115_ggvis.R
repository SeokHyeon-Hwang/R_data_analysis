
#install.packages('ggvis')
library(ggvis)

mtcars %>%
  ggvis(~wt, ~mpg,
        size:=input_slider(10, 100),
        opacity := input_slider(0,1)
        ) %>%
  layer_points()

#install.packages('class')
#install.packages('gmodels')

library(class)
library(gmodels)

search()

iris %>%
  ggvis(~iris$Sepal.Length, ~iris$Sepal.Width, fill=~Species) %>%
  layer_points()

iris

iris %>%
  ggvis(~Petal.Length, ~Petal.Width, fill=~Species) %>%
  layer_points()

normalize <- function(x) {
  num<- x-min(x)
  denom<-max(x)-min(x)
  return(num/denom)
}

iris_norm <- as.data.frame(lapply(iris[1:4], normalize))
summary(iris_norm)

set.seed(1234)
idx<-sample(1:150, nrow(iris_norm)*0.7, replace=F)
tr<-iris_norm[idx,]
te<-iris_norm[-idx,]

trta <-iris[idx,5]
teta <-iris[-idx,5]

irispred <-knn(train=tr, test=te, cl=trta, k=3)
irispred

CrossTable(x=teta, y=irispred, prop.chisq =F)

mtcars %>%
  ggvis(~wt, ~mpg,
        size :=input_slider(10,100),
        opacity :=input_slider(0,1)
        ) %>%
  layer_points

keys_s <-left_right(10, 1000, step=50)
mtcars %>% ggvis(~wt, ~mpg, size :=keys_s, opacity :=0.5) %>% layer_points()

mtcars %>% ggvis(~wt, ~mpg) %>%
  layer_points() %>%
  add_tooltip(function(df) df$wt)

df<-data.frame(x=1:3, y=c(1,3,2), label=c('a', 'b', 'c'))
df %>% ggvis(~x, ~y, text :=~label) %>% layer_text()

