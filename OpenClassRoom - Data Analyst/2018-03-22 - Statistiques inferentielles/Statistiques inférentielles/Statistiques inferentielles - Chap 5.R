versi <- iris[iris$Species=="versicolor",]$Petal.Length
virgi <- iris[iris$Species=="virginica",]$Petal.Length

var.test(versi,virgi)

t.test(versi,virgi,var.equal=TRUE)

##################################################################################

n <- c(185,1149,3265,5475,6114,5194,3067,1331,403,105,14,4,0)
p0 <- dbinom(0:12,12,1/3)

#chisq.test(n,p=p0)

n <- c(185,1149,3265,5475,6114,5194,3067,1331,403,105,18)
p0 <- c(dbinom(0:9,12,1/3),sum(dbinom(10:12,12,1/3)))

chisq.test(n,p=p0)

################################################################################

ks.test(essence$conso,"pnorm",mean=mean(essence$conso),sd=sd(essence$conso))

shapiro.test(essence$conso)





