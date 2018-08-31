essence <- read.table("E:\\Data\\RawData\\Stats inferentielles\\essence.txt",header=TRUE)

xbar <- mean(essence$conso)
print(round(xbar,digits=2))

sprime <- sd(essence$conso)
print(round(sprime,digits=2))

sprime2 <- var(essence$conso)
print(round(sprime2,digits=2))

n_essence <- dim(essence)[1]
v <- sprime2*(n_essence-1)/n_essence
round(v,digits=2)

hist(essence$conso,prob=TRUE,xlab="",ylab="",ylim=c(0, 0.25),main="Histogramme")

hist(essence$conso,prob=TRUE,xlab="",ylab="",ylim=c(0, 0.25),main="Histogramme")

abline(v=xbar,col="blue",lwd=3)

mu0 <- 31

hist(essence$conso,prob=TRUE,xlab="",ylab="",ylim=c(0, 0.25),main="Histogramme")
abline(v=xbar,col="blue",lwd=3)
abline(v=mu0,col="red",lwd=3)
legend("topright",legend=c("Moyenne empirique","Seuil testé"),col=c("blue","red"),lty=1,lwd=3)

hist(essence$conso,prob=TRUE,xlab="",ylab="",ylim=c(0, 0.25),main="Histogramme et densité normale")

curve(dnorm(x,mean=xbar,sd=sprime),col="red",lwd=2,add=TRUE,yaxt="n")




