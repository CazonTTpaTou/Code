package modele;

public interface File {

	public boolean estVide();
	public Object premier() throws FileVideException, RangInvalideException,TypeIncompatibleException ;
	public void defiler() throws FileVideException, RangInvalideException,TypeIncompatibleException ;
	public void enfiler(Object e) throws FilePleineException, RangInvalideException,TypeIncompatibleException ;

}

