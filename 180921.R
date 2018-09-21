rm(list=ls())
trdf<-read.csv('E:/Bigdata/dataset/sh2ndCompetitionData/train.csv')
tedf<-read.csv('E:/Bigdata/dataset/sh2ndCompetitionData/test.csv')
str(tr_a)
library(dplyr)
str(trdf)
tr_a<-trdf
te_a<-tedf
getmode<-function(v){
  uniqv<-unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}
# df_NA : 결측 처리할 데이터
# sel : 몇번째 컬럼인가?
# wantedVal : 'mean', 'median', 'mode'
NAProcess<-function(df_NA, sel, wantedVal='mean'){
  for (i in sel){
    type=class(df_NA[[i]])
    
    if (wantedVal=='mean'){
      ## 평균값을 구하고, 그 값으로 위치 찾고, 값 치환
      Val=mean(df_NA[[i]], na.rm=T)
      loc=which(is.na(df_NA[[i]]))
    }
    else if (wantedVal=='median'){
      Val=median(df_NA[[i]], na.rm=T)
      loc=which(is.na(df_NA[[i]]))
    }
    else if (wantedVal=='mode'){
      Val=getmode(df_NA[[i]])
      loc=which(is.na(df_NA[[i]]))  # 위치확인
    }
    
    # 자료형에 따른 값 치환
    if (type=='numeric'){
      df_NA[loc,i]=as.numeric(Val)
    }
    else if (type=='integer'){
      df_NA[loc,i]=as.integer(Val)
    }
    else if (type=='factor'){
      df_NA[loc,i]=Val
    }
  }
  return(df_NA)
}
summary(tr_a)
names(tr_a)
library(Amelia)
missmap(tr_a)

#tr_a[[2]]

tr_a$employee1<-as.integer(tr_a$employee1)
tr_a$employee2<-as.integer(tr_a$employee2)

# 6:bedCount, 56:employee1, 57:employee2
tr_a<-NAProcess(tr_a, sel=c(6,56,57),'median')
missmap(tr_a)

colN=c('busan', 'choongbuk', 'choongam', 'daegu', 'daejeon',
       'gangwon', 'gwangju', 'gyeongbuk', 'gyeonggi', 'gyeongnam',
       'incheon', 'jeonbuk', 'jeonnam', 'sejong', 'seoul',
       'ulsan', 'jeju')

tr_a$sido=factor(tr_a$sido, levels=colN)
te_a$sido=factor(te_a$sido, levels=colN)

colN2=c('', 'clinic', 'dental_clinic', 'general_hospital', 'hospital',
        '')

