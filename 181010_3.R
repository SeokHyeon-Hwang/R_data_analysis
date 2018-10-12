lm() # ��ġ�� ���� ����
glm() # ������ ���� ����

data(mtcars)
str(mtcars)

model=lm(hp~wt, data=mtcars)  # �� ����
model
data=data.frame(wt=5.0)  # wt=5�� ������ ������
summary(model)
prev=predict(model, newdata=data)
prev

mtcars$hp
mtcars

model=lm(qsec~wt+cyl+drat, data=mtcars)  # �� ����
model
data=data.frame(wt=5.0, cyl=10, drat=10)  # wt=5�� ������ ������
summary(model)
prev=predict(model, newdata=data)
prev

wt1=c(1,2,3)
mpg1=c(10,20,30)
df<-data.frame(wtd=wt1, mpgd=mpg1)
df
model1=lm(mpgd~wtd, data=df)
summary(model1)
predict(model1, newdata=data.frame(wtd=4))


model=glm(vs~., data=mtcars )
summary(model)
predict(model, newdata=data.frame(wt=5.0))

#������ƽ ȸ�ͺм� glm() �� y�� 0�� 1�� ����