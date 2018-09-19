'''
함수명 <- function() {
  실행문1
  실행문2
  return값 <-생략가능
}

함수명 <- function(a,b) {
  실행문1
실행문2
return값 <-생략가능
}


함수명1()
val=함수명1()

val=함수명2(3,5)


'''
rm(list=ls())
sampleFnc<-function(){
  print('execute function')
  return(0)
}
sampleFnc()
val

val=sampleFnc()
print(val)

plusfnc<-function(a,b){
  result=a+b
  return(result)
}

plusfnc(3,4)
r
rm(list=ls())

#0919 더하기 기능 가능
#작성자:$$$
oper<-function(a,b){
  result=a+b
  return(result)
}

val=oper(3,5)
print(val)



oper<-function(a,b,c='+', max=F){
  if (max==T){
    if (a>b) {}
  }
}
??json
??excel



readdata<- function(filename, type='csv'){
  if (type=='csv'){
    df<- read.csv(filename)
    
  } 
  if (type=='txt'){
    df<-read.table(filename)
  }
  if (type=='json'){
    df<-read_json(filename)
  }
  if (type=='xlsx'){
    library(openxlsx)
    df<-read.xlsx(filename)
  }
  return(df)
  
}
data<-readdata('E:/Bigdata/dataset/R2_ex/example_studentlist.xlsx', type='xlsx')
data
