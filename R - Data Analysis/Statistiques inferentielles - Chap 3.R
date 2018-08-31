library(EnvStats)

essence <- read.table("E:\\Data\\RawData\\Stats inferentielles\\essence.txt",header=TRUE)

n_essence <- dim(essence)[1]
xbar <- mean(essence$conso)
sprime <- sd(essence$conso)

alpha <- 0.05

icinf <- xbar-qt(p=1-alpha/2,df=n_essence-1)*sprime/sqrt(n_essence)
round(icinf,digits=2)

icsup <- xbar+qt(p=1-alpha/2,df=n_essence-1)*sprime/sqrt(n_essence)
round(icsup,digits=2)

alpha <- 0.05
t.test(essence$conso,conf.level=1-alpha)

#######################################################################
#######################################################################

alpha <- 0.05
icinf <- (n_essence-1)*sprime2/qchisq(p=1-alpha/2,df=n_essence-1)
round(icinf,digits=2)


icsup <- (n_essence-1)*sprime2/qchisq(p=alpha/2,df=n_essence-1)
round(icsup,digits=2)

alpha <- 0.05
varTest(essence$conso,conf.level=1-alpha)




