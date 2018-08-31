nH<-399284
nF<-381883
nTot<-nH+nF

# On calcule les proportions
pH <- nH/nTot
pF <- nF/nTot

#La fonction suivante calcule le nombre d'hommes et le nombre de femmes pour un effectif totale donné
repartition <- function ( arg ) { 
  c( arg , round(pH*arg, digits =0 ) , round (pF*arg, digits=0) )
}

#La fonction suivante effectue le teste d'hypothèse 
test <-function( arg1 , arg2 ){
  prop.test( x<-c(arg1,arg2), 
             n<-c(arg1+arg2,arg1+arg2), 
             p = NULL,alternative = "greater",
             conf.level = 0.95, correct = TRUE)
}


# On construit la matrice des données à analyser
donnees <- c(nTot,nH,nF)
mat <- matrix ( c(donnees , repartition(100), repartition (1000), repartition(10000) ) , ncol=3, byrow="TRUE")
colnames(mat)<-c("Total", "Hommes", "Femmes")
rownames(mat)<-c("Cas 0:" ,"Cas 1:" , "Cas 2:" , "Cas 3:")


#On affiche la matrice des données
mat

#On effectue les tests pour 
for(i in 1:4) {
  
  print(test(mat[i,2],mat[i,3]))
}
