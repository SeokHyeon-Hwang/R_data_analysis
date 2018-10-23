
install.packages('Synth')
install.packages('seewave')

library(seewave)
library(tuneR)
data(tico)
play(tico)
summary(tico)

plot(tico@left[0:length(tico)], 
     main='Sound tico',
     ylab='Frequency', xlab='Time')
#푸리에 변환으로 프리퀀시로 바꿀 수 있다.

spectro(tico,
        f=22000,
        ovlp=30,
        collevels=seq(-40,0,0.5),
        osc=T)

spectro(tico,
        f=22000,
        ovlp=10,
        collevels=seq(-40,0,0.5),
        osc=T)

spectro(tico,
        f=22000,
        ovlp=90,
        collevels=seq(-90,0,0.5),
        osc=T)

###

tico
data(peewit) # 댕기물떼새
play(peewit)
is(temp.colors)

##
spectro(peewit, f=22000,
        palette=temp.colors,
        collevels=seq(-100,0,1))

dev.off()

### 데이터를 3차원 시각화
data(tico)
play(tico)

### 3D spectrogram(graph)
wf(tico,
   f=22050,
   ovlp=50,
   hoff=2,
   voff=9,
   border='#00000075')

wf(tico,
   f=22050,
   ovlp=90,
   hoff=0.5,
   voff=9,
   border='#00000075')

# sound root : http://freesound.org