package structure;

public class ListeTableau implements Liste {

	protected static final int MAXELEM=100;
	protected int lg;
	protected Object [] elements;
	protected Class typeDesElements;
	public ListeTableau(Class c) {this(MAXELEM,c);}
	public ListeTableau(int n,Class c) {
		elements = new Object[n];
		typeDesElements = c;}

	public int longueur() {
		return lg;}

	public Object ième(int r) throws RangInvalideException {
		if(r<1 || r>lg) throw new RangInvalideException();
		return elements[r-1];}

	public void supprimer(int r) throws RangInvalideException {
		if (r<1 || r>lg) throw new RangInvalideException();
		for(int i=r;i<lg;i++) elements[i-1]=elements[i];
		lg--;}
		
	public void ajouter(int r,Object e) throws RangInvalideException,TypeIncompatibleException,ListePleineException {
		if (e.getClass() !=typeDesElements) throw new TypeIncompatibleException();
		if (lg==elements.length) throw new ListePleineException();
		if (r<1 || r>lg+1) throw new RangInvalideException();
		for(int i=lg;i>=r;i--) elements[i]=elements[i-1];
		elements[r-1]=e;
		lg++;}

public Object elementDeTete() throws RangInvalideException,TypeIncompatibleException,ListePleineException {return ième(1);}
public Object elementDeQueue() throws RangInvalideException,TypeIncompatibleException,ListePleineException {return ième(lg);}
public void ajouterEnTete(Object e) throws RangInvalideException,TypeIncompatibleException,ListePleineException {ajouter(1,e);}
public void ajouterEnQueue(Object e) throws RangInvalideException,TypeIncompatibleException,ListePleineException {ajouter(lg+1,e);}
public void supprimerEnTete() throws RangInvalideException,TypeIncompatibleException,ListePleineException {supprimer(1);}
public void supprimerEnQueue() throws RangInvalideException,TypeIncompatibleException,ListePleineException {supprimer(lg);}



	public Enumeration listeEnumeration() {return new ListeEnumeration();}

private class ListeEnumeration implements Enumeration {

	private int courant;

	private ListeEnumeration() {
		courant=0;}

	public boolean finEnumeration() {
		return courant==lg;}

	public Object elementSuivant() throws FinEnumerationException {
		if (courant==lg) throw new FinEnumerationException();
		return elements[courant++];}

	public void parcours(Liste l) throws FinEnumerationException {
		Enumeration énum=l.listeEnumeration();
		while(! énum.finEnumeration()) System.out.println(énum.elementSuivant());}

	}


}
 	





