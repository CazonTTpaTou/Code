package structure;

public class ListeTableauCirculaire implements Liste {

	protected static final int MAXELEM=100;
	protected int lg;
	protected int tete;
	protected int queue;
	protected Object [] elements;
	protected Class typeDesElements;
	public ListeTableauCirculaire(Class c) {this(MAXELEM,c);}
	public ListeTableauCirculaire(int n,Class c) {
		elements = new Object[n];
		typeDesElements = c;
		tete=0;
		queue=0;}

	public int longueur() {
		return lg;}

	public Object ième(int r) throws RangInvalideException {
		if(r<1 || r>lg) throw new RangInvalideException();
		return elements[(tete+r-1) % elements.length];}

	public void supprimer(int r) throws RangInvalideException {
		if (r<1 || r>lg) throw new RangInvalideException();
		if(r==lg) queue = queue==0 ? elements.length-1 : --queue;
			else if (r==1) tete = tete==0 ? elements.length-1 : --tete;
				else {
					for(int i=tete+r;i<lg+tete;i++) elements[(i-1)%elements.length]=elements[i%elements.length];
					queue = queue==0 ? elements.length-1 : --queue;}
		lg--;}
		
	public void ajouter(int r,Object e) throws RangInvalideException,TypeIncompatibleException,ListePleineException {
		if (e.getClass() !=typeDesElements) throw new TypeIncompatibleException();
		if (lg==elements.length) throw new ListePleineException();
		if(r==lg+1) {elements[queue]=e;
			     queue = queue==elements.length-1 ? 0 : ++queue;}

				else if (r==1) {tete = tete==0 ? elements.length-1 : --tete;
					elements[tete]=e;}

					else {
					for(int i=tete+lg;i>=r+tete;i--) elements[i%elements.length]=elements[(i-1)%elements.length];
					elements[tete+r-1]=e;
					queue = queue==elements.length ? 0 : ++queue;}
		lg++;}

public Object elementDeTete() throws RangInvalideException,TypeIncompatibleException,ListePleineException {return ième(1);}
public Object elementDeQueue() throws RangInvalideException,TypeIncompatibleException,ListePleineException {return ième(lg);}
public void ajouterEnTete(Object e) throws RangInvalideException,TypeIncompatibleException,ListePleineException {ajouter(1,e);}
public void ajouterEnQueue(Object e) throws RangInvalideException,TypeIncompatibleException,ListePleineException {ajouter(lg+1,e);}
public void supprimerEnTete() throws RangInvalideException,TypeIncompatibleException,ListePleineException {supprimer(1);}
public void supprimerEnQueue() throws RangInvalideException,TypeIncompatibleException,ListePleineException {supprimer(lg);}


	public Enumeration listeEnumeration() {return new ListeEnumeration();}

private class ListeEnumeration implements Enumeration {

	private int courant,nbEnum;

	private ListeEnumeration() {
		courant=tete;
		nbEnum=0;}

	public boolean finEnumeration() {
		return courant==lg;}

	public Object elementSuivant() throws FinEnumerationException {
		if (courant==lg) throw new FinEnumerationException();
		Object e=elements[courant];
		courant = courant==elements.length-1 ? 0 : ++courant;
		nbEnum++;
		return e;}

	public void parcours(Liste l) throws FinEnumerationException {
		Enumeration énum=l.listeEnumeration();
		while(! énum.finEnumeration()) System.out.println(énum.elementSuivant());}

	}



	}
 	





