package modele;

/** 
* Classe qui construit l'architecture globale de la liste chaînée
* Et qui servira de modèle pour la classe FileChainee
*/
public class ListeChaineeDouble implements Liste{
	protected int lg;
	protected Noeud2 tete,queue;
	protected Class typedesElements;

	public ListeChaineeDouble(Class c) {typedesElements=c;}

	public int longueur() {return lg;}

	/** 
 	* Méthode qui retourne le nième object de la liste chaînée
 	* @param r
 	* numéro de rang de l'élément que l'on veut extraire de la liste 
 	* @throws RangInvalideException
 	* Lance une exception lorsque le rang indiqué est en dehors des limites de la liste
 	*/
	public Object ième(int r) throws RangInvalideException {
		if(r<1 || r>lg) throw new RangInvalideException(); 
		Noeud2 n=tete;
		for(int i=1;i<r;i++) n=n.noeud2Suivant();
		return n.valeur();}

	/** 
 	* Méthode qui supprime le nième object de la liste chaînée
 	* @param r
 	* numéro de rang de l'élément que l'on veut supprimer de la liste 
 	* @throws RangInvalideException
 	* Lance une exception lorsque le rang indiqué est en dehors des limites de la liste
 	*/
	public void supprimer(int r) throws RangInvalideException {
		if(r<1 || r>lg) throw new RangInvalideException();
		if(lg==1) tete = queue = null;
		else if(r==1) tete=tete.noeud2Suivant();
			else if(r==lg) {
				queue=queue.noeud2Precedent();
				queue.suivant(null);}
					else {  Noeud2 q=tete, p=null;
						for(int i=1;i<r;i++) {p=q;q=q.noeud2Suivant();}
						q.noeud2Suivant().precedent(p);
						p.suivant(q.suivant());}
		lg--;}
	
	/** 
 	* Méthode qui ajoute un objet au nième rang de la liste chaînée
 	* @param r
 	* numéro de rang de l'élément que l'on veut ajouter dans la liste 
 	* @param e
 	* Elément de type Objet que l'on veut ajouter dans la liste 
 	* @throws RangInvalideException
 	* Lance une exception lorsque le rang indiqué est en dehors des limites de la liste
 	* @throws TypeIncompatibleException
 	* Lance une exception lorsque l'objet inséré n'est pas du même type que les autres éléments de la liste
 	*/
	public void ajouter(int r,Object e) throws RangInvalideException,TypeIncompatibleException {
		if(e.getClass()!=typedesElements) throw new TypeIncompatibleException();
		if(r<1 || r>lg+1) throw new RangInvalideException();
		Noeud2 n = new Noeud2(e);
		if(lg==0) tete=queue=n;
		else if(r==1) {tete.precedent=n;
				n.suivant(tete);
				tete=n;}
			else if(r==lg+1) {
				queue.suivant(n);
				n.precedent(queue);
				queue=n;}
				else {Noeud2 p=null, q=tete;
					for(int i=1;i<r;i++) {p=q;
							      q=q.noeud2Suivant();}
					p.suivant(n);
					n.precedent(p);
					n.suivant(q);
					q.precedent(n);}
			lg++;}

	/** 
 	* Méthode qui retourne l'élément au premier rang de la liste chaînée
 	* @return ième
 	* Retourne l'objet contenu au premier rang de la liste
 	* @throws RangInvalideException
 	* Lance une exception lorsque le rang indiqué est en dehors des limites de la liste
 	* @throws TypeIncompatibleException
 	* Lance une exception lorsque l'objet inséré n'est pas du même type que les autres éléments de la liste
 	*/
public Object elementDeTete() throws RangInvalideException,TypeIncompatibleException,ListePleineException {
	return ième(1);}

/** 
	* Méthode qui retourne l'élément au dernier rang de la liste chaînée
	* @return ième
	* Retourne l'objet contenu au dernier rang de la liste
	* @throws RangInvalideException
	* Lance une exception lorsque le rang indiqué est en dehors des limites de la liste
	* @throws TypeIncompatibleException
	* Lance une exception lorsque l'objet inséré n'est pas du même type que les autres éléments de la liste
	*/
public Object elementDeQueue() throws RangInvalideException,TypeIncompatibleException,ListePleineException {
	return ième(lg);}

/** 
	* Méthode qui ajoute l'élément au premier rang de la liste chaînée
	* @param e
	* Objet à insérer au premier rang de la liste
	* @throws RangInvalideException
	* Lance une exception lorsque le rang indiqué est en dehors des limites de la liste
	* @throws TypeIncompatibleException
	* Lance une exception lorsque l'objet inséré n'est pas du même type que les autres éléments de la liste
	* @throws ListePleineException
	* Lance une exception lorsque l'objet ne peut pas être inséré car la liste est déjà pleine
	*/
public void ajouterEnTete(Object e) throws RangInvalideException,TypeIncompatibleException,ListePleineException {
	ajouter(1,e);
	}

/** 
* Méthode qui ajoute l'élément au dernier rang de la liste chaînée
* @param e
* Objet à insérer au dernier rang de la liste
* @throws RangInvalideException
* Lance une exception lorsque le rang indiqué est en dehors des limites de la liste
* @throws TypeIncompatibleException
* Lance une exception lorsque l'objet inséré n'est pas du même type que les autres éléments de la liste
* @throws ListePleineException
* Lance une exception lorsque l'objet ne peut pas être inséré car la liste est déjà pleine
*/
public void ajouterEnQueue(Object e) throws RangInvalideException,TypeIncompatibleException,ListePleineException {
	ajouter(lg+1,e);}

/** 
* Méthode qui supprime l'élément au premier rang de la liste chaînée
* @throws RangInvalideException
* Lance une exception lorsque le rang indiqué est en dehors des limites de la liste
* @throws TypeIncompatibleException
* Lance une exception lorsque l'objet inséré n'est pas du même type que les autres éléments de la liste
* @throws ListePleineException
* Lance une exception lorsque l'objet ne peut pas être inséré car la liste est déjà pleine
*/
public void supprimerEnTete() throws RangInvalideException,TypeIncompatibleException,ListePleineException {
	supprimer(1);}

/** 
* Méthode qui supprime l'élément au dernier rang de la liste chaînée
* @throws RangInvalideException
* Lance une exception lorsque le rang indiqué est en dehors des limites de la liste
* @throws TypeIncompatibleException
* Lance une exception lorsque l'objet inséré n'est pas du même type que les autres éléments de la liste
* @throws ListePleineException
* Lance une exception lorsque l'objet ne peut pas être inséré car la liste est déjà pleine
*/
public void supprimerEnQueue() throws RangInvalideException,TypeIncompatibleException,ListePleineException {supprimer(lg);}

/** 
* Méthode qui énumère tout le contenu de la liste chaînée
* @return ListeEnumeraion()
* Objet de type classe ListeEnumeration qui renvoie la liste des objets contenue dans la liste 
*/
	public Enumeration listeEnumeration() {return new ListeEnumeration();}

private class ListeEnumeration implements Enumeration {

	private Noeud2 courant;

	private ListeEnumeration() {
		courant=tete;
		}

	public boolean finEnumeration() {
		return courant==null;}

	public Object elementSuivant() throws FinEnumerationException {
		if (courant==null) throw new FinEnumerationException();
		Object e=courant.valeur();
		courant=courant.noeud2Suivant();
		return e;}

	public void parcours(Liste l) throws FinEnumerationException {
		Enumeration énum=l.listeEnumeration();
		while(! énum.finEnumeration()) System.out.println(énum.elementSuivant());}

	}

}



			
				
		