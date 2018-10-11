
loc5=which(names(tr)=='instkind')
v=tr[[loc5]]
class(v)
tabulate((match(v, uniq)))
#최빈값 함수
getmode<-function(v){
  uniq<-unique(v)   # 중복제거
  uniq[which.max(tabulate(match(v, uniq)))] # 가장 많이 나온 항목명
}

getmode(tr[[loc5]])

#결측치 처리 함수
#함수명 naprocess2
#전달정보(매개변수): dfna(데이터세), sel=몇번째열? wantedval='mean', 'max', 's


# 결측치 처리 함수
# df_NA : 데이터 셋
# sel   : 열 벡터
# wantedVal : mean(평균값), median(중앙값), mode(최빈값)

NAProcess <- function(df_NA, sel, wantedVal="mean") {
  # sel = c(1,5)
  len = length(df_NA)
  for (i in sel) {
    type = class(df_NA[[i]])
    
    # mean으로 할지 median으로 할지
    if (wantedVal=='mean') {
      Val = mean( df_NA[[i]] , na.rm=T)
      loc = which(is.na(df_NA[[i]]))   # 위치 확인
    } else if (wantedVal=='median') {
      Val = median( df_NA[[i]] , na.rm=T)
      loc = which(is.na(df_NA[[i]]))   # 위치 확인 
    } else if (wantedVal=='mode') {
      Val = getmode(df_NA[[i]])
      loc = which(is.na(df_NA[[i]]))   # 위치 확인
    }
    
    # 자료형에 따른 값 치환
    if (type=='numeric') {
      df_NA[loc,i ] = as.numeric(Val)
    } else if (type=='integer') {
      df_NA[loc,i ] = as.integer(Val)
    } else if (type=='factor') {
      df_NA[loc,i ] = Val
    }
  }
  return(df_NA)
}

# 결측치 처리 함수
# df_NA : 데이터 셋
# sel   : 열 벡터
# wantedVal : min(최소값으로), max(최대값으로), zero(0으로)

NAProcess2 <- function(df_NA, sel, wantedVal="min") {
  #df_NA =tr_a
  #sel = which(names(df_NA)=="ownerChange")
  #wantedVal = "mode"
  # test_a = NAProcess2(test_a, loc4, 'mode')
  
  # sel = c(1,5)
  i = sel
  len = length(df_NA)
  type = class(df_NA[[i]])
  
  # max, min, 0으로 할지
  # loc = c()
  if (wantedVal=='min') {
    Val = min( df_NA[[i]] , na.rm=T)
    loc = which(is.na(df_NA[[i]]))   # 위치 확인
  } else if (wantedVal=='max') {
    Val = max( df_NA[[i]] , na.rm=T)
    loc = which(is.na(df_NA[[i]]))   # 위치 확인 
  } else if (wantedVal=='zero') {
    Val = 0
    loc = which(is.na(df_NA[[i]]))   # 위치 확인
  } else if (wantedVal=='mode') {
    Val = getmode(df_NA[[i]])
    loc = which(is.na(df_NA[[i]]))   # 위치 확인
  } else if (wantedVal=='SpVal'){
    Val = -99999
    loc = which(is.na(df_NA[[i]]))   # 위치 확인
  } 
  
  # print(Val)
  print(loc)
  strNA = paste( names(df_NA)[i] , "NAVal", sep="")
  locLen = length(loc)
  # 파생변수 생성
  if (locLen >= 0 ) {
    df_NA[loc,strNA] = 1
    df_NA[-loc, strNA] = 0
  }
  
  # 자료형에 따른 값 치환
  if (type=='numeric') {
    df_NA[loc,i ] = as.numeric(Val)
  } else if (type=='integer') {
    df_NA[loc,i ] = as.integer(Val)
  } else if (type=='factor') {
    df_NA[loc,i ] = Val
  }
  
  # 확인 출력
  print(df_NA[loc,sel])
  
  return(df_NA)
}



