
#Question 1
arg<-399284
n<-399284+381883
p0<-0.5
prop.test(x=arg,n=n,p=p0,alternative='two.sided')

#Question 3 & 4
alpha<-0.05
n1<-100
arg1<-n1*399284/(399284+381883)
prop.test(x=arg1,n=n1,p=p0,alternative='two.sided',conf.level=1-alpha)

n2<-1000
arg2<-n2*399284/(399284+381883)
prop.test(x=arg2,n=n2,p=p0,alternative='two.sided',conf.level=1-alpha)

n3<-10000
arg3<-n3*399284/(399284+381883)
prop.test(x=arg3,n=n3,p=p0,alternative='two.sided',conf.level=1-alpha)

