package structure;

public class ListeChaineeDouble implements Liste{
	protected int lg;
	protected Noeud2 tete,queue;
	protected Class typedesElements;

	public ListeChaineeDouble(Class c) {typedesElements=c;}

	public int longueur() {return lg;}

	public Object ième(int r) throws RangInvalideException {
		if(r<1 || r>lg) throw new RangInvalideException(); 
		Noeud2 n=tete;
		for(int i=1;i<r;i++) n=n.noeud2Suivant();
		return n.valeur();}

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

public Object elementDeTete() throws RangInvalideException,TypeIncompatibleException,ListePleineException {return ième(1);}
public Object elementDeQueue() throws RangInvalideException,TypeIncompatibleException,ListePleineException {return ième(lg);}
public void ajouterEnTete(Object e) throws RangInvalideException,TypeIncompatibleException,ListePleineException {ajouter(1,e);}
public void ajouterEnQueue(Object e) throws RangInvalideException,TypeIncompatibleException,ListePleineException {ajouter(lg+1,e);}
public void supprimerEnTete() throws RangInvalideException,TypeIncompatibleException,ListePleineException {supprimer(1);}
public void supprimerEnQueue() throws RangInvalideException,TypeIncompatibleException,ListePleineException {supprimer(lg);}


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



			
				
		