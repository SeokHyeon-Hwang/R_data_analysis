
## 소리 분석

## 01.파일읽기

install.packages('tuneR', dep=T)
# 시간파를 분석, 조작, 편집 및 합성
library(tuneR)

sObj<-readWave('E:/Bigdata/dataset/voice_data/Cartoon_Slip.wav')
play(sObj)

str(sObj)
is(sObj)
sObj@left
sObj@right
summary(sObj)

## 03. sound 그래프 표시
###
range(sObj@left)
range(sObj@right)
timeArray<-(0:(23708-1))/sObj@samp.rate # samp.rate로 재생 기간 구함
range(timeArray)
timeArray


s1<-sObj@left
s1<-s1/2^(sObj@bit-1)

plot(timeArray, s1)

### 고속 푸리에 변환 알고리즘 -fft 함수
### fft는 디지털 신호처리에서 사용
### 위치정보를 갖는 것으로 바꾸어준다?

fft(s1)
head(s1)
head(fft(s1))
# 신호처리에 이용

n<-length(s1) # 길이 구함
p<- fft(s1) # 

sampleLen = 5000
pm <- p[1:sampleLen]
pm <- abs(pm)

# fft함수에 의해 반환된 톤의 푸리에 변환은 크기 정보 및 위상 정보 모두 포함.
# 복소수 표현으로 주어진다.
# 푸리에 변환의 절대값을 취함으로써 주파수 성분의 크기에 대한 정보를 얻는다.
pm <- pm / n
pm <- pm^2

if (n %% 2 > 0){
  pm[2:length(pm)] <- pm[2:length(pm)]*2 # we've got odd number of points fft
} else {
  pm[2: (length(pm) -1)] <- pm[2: (length(pm) -1)]*2 # we've got even number of points fft
}

freqArray <- (0:(sampleLen-1)) * (sObj@samp.rate / n) #  create the frequency array 
plot(freqArray/1000, 10*log10(pm), type='l', 
     col='black', xlab='Frequency (kHz)', ylab='Power (dB)')

## REF
## https://goo.gl/HEJfSk : samcarcagno blog 
## The MathWorks support. Technical notes 1702, available: 
## https://web.archive.org/web/20120615002031/http://www.mathworks.com/support/tech-notes/1700/1702.html


