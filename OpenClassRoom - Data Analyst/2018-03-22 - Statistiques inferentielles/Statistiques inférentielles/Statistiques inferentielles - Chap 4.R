guerison <- read.table("E:\\Data\\RawData\\Stats inferentielles\\guerison.txt",header=TRUE)

n_guerison <- dim(guerison)[1]
n_guerison_gueris <- sum(guerison$guerison==1)

prop.test(x=167,n=216,p=0.75,alternative="greater")

###############################################################################

essence <- read.table("E:\\Data\\RawData\\Stats inferentielles\\essence.txt",header=TRUE)

alpha <- 0.05
t.test(essence$conso,mu=31,alternative="two.sided")

#################################################################################

library(EnvStats)

alpha <- 0.05
varTest(essence$conso,sigma.squared=4.5,alternative="greater")




