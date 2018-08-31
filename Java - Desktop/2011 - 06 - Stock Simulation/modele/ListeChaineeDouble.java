package modele;

/** 
* Classe qui construit l'architecture globale de la liste cha�n�e
* Et qui servira de mod�le pour la classe FileChainee
*/
public class ListeChaineeDouble implements Liste{
	protected int lg;
	protected Noeud2 tete,queue;
	protected Class typedesElements;

	public ListeChaineeDouble(Class c) {typedesElements=c;}

	public int longueur() {return lg;}

	/** 
 	* M�thode qui retourne le ni�me object de la liste cha�n�e
 	* @param r
 	* num�ro de rang de l'�l�ment que l'on veut extraire de la liste 
 	* @throws RangInvalideException
 	* Lance une exception lorsque le rang indiqu� est en dehors des limites de la liste
 	*/
	public Object i�me(int r) throws RangInvalideException {
		if(r<1 || r>lg) throw new RangInvalideException(); 
		Noeud2 n=tete;
		for(int i=1;i<r;i++) n=n.noeud2Suivant();
		return n.valeur();}

	/** 
 	* M�thode qui supprime le ni�me object de la liste cha�n�e
 	* @param r
 	* num�ro de rang de l'�l�ment que l'on veut supprimer de la liste 
 	* @throws RangInvalideException
 	* Lance une exception lorsque le rang indiqu� est en dehors des limites de la liste
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
 	* M�thode qui ajoute un objet au ni�me rang de la liste cha�n�e
 	* @param r
 	* num�ro de rang de l'�l�ment que l'on veut ajouter dans la liste 
 	* @param e
 	* El�ment de type Objet que l'on veut ajouter dans la liste 
 	* @throws RangInvalideException
 	* Lance une exception lorsque le rang indiqu� est en dehors des limites de la liste
 	* @throws TypeIncompatibleException
 	* Lance une exception lorsque l'objet ins�r� n'est pas du m�me type que les autres �l�ments de la liste
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
 	* M�thode qui retourne l'�l�ment au premier rang de la liste cha�n�e
 	* @return i�me
 	* Retourne l'objet contenu au premier rang de la liste
 	* @throws RangInvalideException
 	* Lance une exception lorsque le rang indiqu� est en dehors des limites de la liste
 	* @throws TypeIncompatibleException
 	* Lance une exception lorsque l'objet ins�r� n'est pas du m�me type que les autres �l�ments de la liste
 	*/
public Object elementDeTete() throws RangInvalideException,TypeIncompatibleException,ListePleineException {
	return i�me(1);}

/** 
	* M�thode qui retourne l'�l�ment au dernier rang de la liste cha�n�e
	* @return i�me
	* Retourne l'objet contenu au dernier rang de la liste
	* @throws RangInvalideException
	* Lance une exception lorsque le rang indiqu� est en dehors des limites de la liste
	* @throws TypeIncompatibleException
	* Lance une exception lorsque l'objet ins�r� n'est pas du m�me type que les autres �l�ments de la liste
	*/
public Object elementDeQueue() throws RangInvalideException,TypeIncompatibleException,ListePleineException {
	return i�me(lg);}

/** 
	* M�thode qui ajoute l'�l�ment au premier rang de la liste cha�n�e
	* @param e
	* Objet � ins�rer au premier rang de la liste
	* @throws RangInvalideException
	* Lance une exception lorsque le rang indiqu� est en dehors des limites de la liste
	* @throws TypeIncompatibleException
	* Lance une exception lorsque l'objet ins�r� n'est pas du m�me type que les autres �l�ments de la liste
	* @throws ListePleineException
	* Lance une exception lorsque l'objet ne peut pas �tre ins�r� car la liste est d�j� pleine
	*/
public void ajouterEnTete(Object e) throws RangInvalideException,TypeIncompatibleException,ListePleineException {
	ajouter(1,e);
	}

/** 
* M�thode qui ajoute l'�l�ment au dernier rang de la liste cha�n�e
* @param e
* Objet � ins�rer au dernier rang de la liste
* @throws RangInvalideException
* Lance une exception lorsque le rang indiqu� est en dehors des limites de la liste
* @throws TypeIncompatibleException
* Lance une exception lorsque l'objet ins�r� n'est pas du m�me type que les autres �l�ments de la liste
* @throws ListePleineException
* Lance une exception lorsque l'objet ne peut pas �tre ins�r� car la liste est d�j� pleine
*/
public void ajouterEnQueue(Object e) throws RangInvalideException,TypeIncompatibleException,ListePleineException {
	ajouter(lg+1,e);}

/** 
* M�thode qui supprime l'�l�ment au premier rang de la liste cha�n�e
* @throws RangInvalideException
* Lance une exception lorsque le rang indiqu� est en dehors des limites de la liste
* @throws TypeIncompatibleException
* Lance une exception lorsque l'objet ins�r� n'est pas du m�me type que les autres �l�ments de la liste
* @throws ListePleineException
* Lance une exception lorsque l'objet ne peut pas �tre ins�r� car la liste est d�j� pleine
*/
public void supprimerEnTete() throws RangInvalideException,TypeIncompatibleException,ListePleineException {
	supprimer(1);}

/** 
* M�thode qui supprime l'�l�ment au dernier rang de la liste cha�n�e
* @throws RangInvalideException
* Lance une exception lorsque le rang indiqu� est en dehors des limites de la liste
* @throws TypeIncompatibleException
* Lance une exception lorsque l'objet ins�r� n'est pas du m�me type que les autres �l�ments de la liste
* @throws ListePleineException
* Lance une exception lorsque l'objet ne peut pas �tre ins�r� car la liste est d�j� pleine
*/
public void supprimerEnQueue() throws RangInvalideException,TypeIncompatibleException,ListePleineException {supprimer(lg);}

/** 
* M�thode qui �num�re tout le contenu de la liste cha�n�e
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
		Enumeration �num=l.listeEnumeration();
		while(! �num.finEnumeration()) System.out.println(�num.elementSuivant());}

	}

}



			
				
		