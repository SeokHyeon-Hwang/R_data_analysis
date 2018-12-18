
#install.packages('RODBC')
library(RODBC)

# 기본 db에 연결
my <- odbcConnect('mysql', uid='root', pwd='qwer1234');
text <- sqlQuery(my, 'SELECT * FROM user');
text

# 원하는 db로 바꾸기
sqlQuery(my, 'use mydatabase')
text <- sqlQuery(my, 'SELECT * FROM Bike');
text

