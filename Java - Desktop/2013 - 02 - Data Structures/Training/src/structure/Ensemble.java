package structure;

public interface Ensemble {

	public boolean estVide();
	public boolean dans(Object x);
	public void ajouter(Object x) throws TypeIncompatibleException;
	public void enlever(Object x) throws ElementAbsentException;
	public Ensemble union(Ensemble x);}

	