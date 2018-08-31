package modele;

/** 
	* Classe qui sert de structure aux Files qui seront utilis�es dans l'application
	* Cette classe h�rite de la classe ListeChaineDouble 
	* En effet, une File est une application particuli�re d'une liste cha�n�e 
	* Cette classe se construit avec un type d'objet d�fini en param�tre
	* Plusieurs types d'objet diff�rents ne peuvent pas cohabiter au sein de la File
	*/
public class FileChainee extends ListeChaineeDouble implements File {
	
	public FileChainee(Class c) {super(c);}
	
	/** 
 	* M�thode qui retourne l'�tat vide ou non de la file 
 	* @return longueur 
 	* longueur de la file soit son nombre de noeud
 	*/
	public boolean estVide() {return longueur()==0;}
	
	/** 
 	* M�thode qui retourne le premier �l�ment de la file
 	* soit le dernier noeud de la liste cha�n�e
 	* @return elementDeTete 
 	* El�ment en t�te de la file qui est le premier � �tre entr�
 	*/
	public Object premier() throws FileVideException, RangInvalideException, TypeIncompatibleException {
		if (estVide()) throw new FileVideException();
		return elementDeTete();}
	
	/** 
 	* M�thode qui retourne le dernier �l�ment de la file
 	* soit le premier noeud de la liste cha�n�e
 	* @return elementDeQueue 
 	* El�ment en queue de la file qui est le dernier � �tre entr�
 	*/
	public Object dernier() throws FileVideException, RangInvalideException, TypeIncompatibleException {
		if (estVide()) throw new FileVideException();
		return elementDeQueue(); 
	}
	
	/** 
 	* M�thode qui rajoute un �l�ment � la file
 	* @param e 
 	* Objet � ajouter dans la file 
 	* @throws TypeIncompatibleException
 	* Exception retourn�e lorsque l'objet ajout� n'est pas du type accept� par la File
 	*/
	public void enfiler(Object e) throws FilePleineException, RangInvalideException, TypeIncompatibleException  {
		ajouterEnTete(e);}

	/** 
 	* M�thode qui enl�ve un �l�ment � la file
 	* @throws FileVideException
 	* Exception retourn�e lorsque la file est d�j� vide
 	*/
	public void defiler() throws FileVideException, RangInvalideException, TypeIncompatibleException  {
		if (estVide()) throw new FileVideException();
		supprimerEnQueue();}

	/** 
 	* M�thode qui retourne la longueur de la file 
 	* @return taille 
 	* taille de la file qui repr�sente le nombre d'objets contenus dans la File
 	*/
	public int longue() {
		int taille;
		taille =super.longueur();
		return taille;
	}
	
}


		
