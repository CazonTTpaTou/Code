package modele;

/** 
	* Classe qui sert de structure aux Files qui seront utilisées dans l'application
	* Cette classe hérite de la classe ListeChaineDouble 
	* En effet, une File est une application particulière d'une liste chaînée 
	* Cette classe se construit avec un type d'objet défini en paramètre
	* Plusieurs types d'objet différents ne peuvent pas cohabiter au sein de la File
	*/
public class FileChainee extends ListeChaineeDouble implements File {
	
	public FileChainee(Class c) {super(c);}
	
	/** 
 	* Méthode qui retourne l'état vide ou non de la file 
 	* @return longueur 
 	* longueur de la file soit son nombre de noeud
 	*/
	public boolean estVide() {return longueur()==0;}
	
	/** 
 	* Méthode qui retourne le premier élément de la file
 	* soit le dernier noeud de la liste chaînée
 	* @return elementDeTete 
 	* Elément en tête de la file qui est le premier à être entré
 	*/
	public Object premier() throws FileVideException, RangInvalideException, TypeIncompatibleException {
		if (estVide()) throw new FileVideException();
		return elementDeTete();}
	
	/** 
 	* Méthode qui retourne le dernier élément de la file
 	* soit le premier noeud de la liste chaînée
 	* @return elementDeQueue 
 	* Elément en queue de la file qui est le dernier à être entré
 	*/
	public Object dernier() throws FileVideException, RangInvalideException, TypeIncompatibleException {
		if (estVide()) throw new FileVideException();
		return elementDeQueue(); 
	}
	
	/** 
 	* Méthode qui rajoute un élément à la file
 	* @param e 
 	* Objet à ajouter dans la file 
 	* @throws TypeIncompatibleException
 	* Exception retournée lorsque l'objet ajouté n'est pas du type accepté par la File
 	*/
	public void enfiler(Object e) throws FilePleineException, RangInvalideException, TypeIncompatibleException  {
		ajouterEnTete(e);}

	/** 
 	* Méthode qui enlève un élément à la file
 	* @throws FileVideException
 	* Exception retournée lorsque la file est déjà vide
 	*/
	public void defiler() throws FileVideException, RangInvalideException, TypeIncompatibleException  {
		if (estVide()) throw new FileVideException();
		supprimerEnQueue();}

	/** 
 	* Méthode qui retourne la longueur de la file 
 	* @return taille 
 	* taille de la file qui représente le nombre d'objets contenus dans la File
 	*/
	public int longue() {
		int taille;
		taille =super.longueur();
		return taille;
	}
	
}


		
