
guerison <- read.table("E:\\Data\\RawData\\Stats inferentielles\\guerison.txt",header=TRUE)

n_guerison <- dim(guerison)[1]
n_guerison_gueris <- sum(guerison$guerison==1)

p_estim <- n_guerison_gueris/n_guerison

alpha <- 0.05

icinf <- p_estim-qnorm(p=1-alpha/2)*sqrt(p_estim*(1-p_estim)/n_guerison)
print(round(icinf,digits=2))

icsup <- p_estim+qnorm(p=1-alpha/2)*sqrt(p_estim*(1-p_estim)/n_guerison)
print(round(icsup,digits=2))

alpha <- 0.05
prop.test(n_guerison_gueris,n_guerison,conf.level=1-alpha)

alpha <- 0.05
binom.test(n_guerison_gueris,n_guerison,conf.level=1-alpha)

alpha <- 0.10
prop.test(n_guerison_gueris,n_guerison,conf.level=1-alpha)



