package structure;

public class ListeChainee implements Liste {

	protected int lg;
	protected Noeud tete;
	protected Class typeDesElements;
	public ListeChainee(Class c) {typeDesElements=c;}
	public int longueur() {return lg;}

	public Object ième(int r) throws RangInvalideException {
		if(r<1 || r>lg) throw new RangInvalideException();
			Noeud n=tete;
		for (int i=1;i<r;i++) n=n.noeudSuivant();
		return n.valeur();}

	public void supprimer(int r) throws RangInvalideException {
		if(r<1 || r>lg) throw new RangInvalideException();
		if(r==1) tete=tete.noeudSuivant();
		else {Noeud p=null;
		      Noeud q=tete;
			for(int i=1;i<r;i++) {p=q;q=q.noeudSuivant();}
		p.suivant(q.suivant());}
	lg--;}

	public void ajouter(int r, Object e) throws RangInvalideException,TypeIncompatibleException {
		if(e.getClass()!=typeDesElements) throw new TypeIncompatibleException();
		if (r<1 || r>lg+1) throw new RangInvalideException();
		Noeud n = new Noeud(e);
		if(r==1) {n.suivant(tete);
			  tete=n;}
		else {
			Noeud p=null;
			Noeud q=tete;
			for(int i =1;i<r;i++) {
				p=q;
				q=q.noeudSuivant();}
			p.suivant(n);
			n.suivant(q);}
		lg++;}

	public Enumeration listeEnumeration() {return new ListeEnumeration();}

private class ListeEnumeration implements Enumeration {

	private Noeud courant;

	private ListeEnumeration() {
		courant=tete;
		}

	public boolean finEnumeration() {
		return courant==null;}

	public Object elementSuivant() throws FinEnumerationException {
		if (courant==null) throw new FinEnumerationException();
		Object e=courant.valeur();
		courant=courant.noeudSuivant();
		return e;}

	public void parcours(Liste l) throws FinEnumerationException {
		Enumeration énum=l.listeEnumeration();
		while(! énum.finEnumeration()) System.out.println(énum.elementSuivant());}

	}


}

