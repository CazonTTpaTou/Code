package structure;

public interface Liste {

	public int longueur();
	public Object i�me(int r) throws RangInvalideException;
	public void supprimer(int r) throws RangInvalideException;
	public void ajouter(int r,Object e) throws RangInvalideException,TypeIncompatibleException,ListePleineException;
	public Enumeration listeEnumeration();
	}

	