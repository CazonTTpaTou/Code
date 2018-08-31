package structure;

public interface Graphe {

	public int ordre();
	public boolean arete(Sommet s1,Sommet s2);
	public boolean arc(Sommet s1,Sommet s2);
	public int demiDegreInt(Sommet s);
	public int demiDegreExt(Sommet s);
	public int degre (Sommet s);
	public Sommet ièmeSucc(Sommet s,int i);
	public void ajouterSommet(Sommet s) throws SommetException;
	public void enleverSommet(Sommet s) throws SommetException;
	public void ajouterArc(Sommet s1, Sommet s2) throws ArcException;
	public void supprimerArc(Sommet s1,Sommet s2) throws ArcException;
	public void ajouterArete(Sommet s1,Sommet s2) throws ArcException;
	public void supprimerArete(Sommet s1,Sommet s2) throws ArcException;
	public Enumeration grapheEnumeration();
	public Enumeration sommetsAdjacents(Sommet s);

	public void parcoursProfondeurPrefixe(Operation op);
	public void parcoursProfondeurpostfixe(Operation op);
	public void parcoursLargeur(Operation op);

	}



