package structure;

public class EnsembleListeChainee implements Ensemble {

	protected Class typeDesElements;

	public EnsembleListeChainee(Class c) {
		typeDesElements = c;}
	

	public boolean estVide() {
		return true;}

	public boolean dans(Object x){
		return true;}

	public void ajouter(Object e) throws TypeIncompatibleException {
		if(e.getClass() != typeDesElements) throw new TypeIncompatibleException();}

	public void enlever(Object x) throws ElementAbsentException {}

	public Ensemble union(Ensemble x){
		return x;}

	}
 	