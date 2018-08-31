package modele;

import service.Search;

// classe h�ritant de la classe abstraite Oeuvre
public class OeuvreEnVente extends Oeuvre{

	Boolean etat;
	float prixOeuvre;
	
	// initialise les variables de classe
	public void init(int numero,String nom,float prix,int proprio) {
		this.numeroOeuvre = numero;
		this.titreOeuvre = nom;
		this.prixOeuvre = prix;
		this.refProprio = proprio;
		this.etat = false;}
	
	// version sous charg�e de la m�thode d'initialisation
	public void init(int numero) {
		this.numeroOeuvre = numero;
		this.etat = false;}
	
	// d�termine le statut de r�servation � 'r�serv�'
	public void setReserve() {
		this.etat = true;}
	
	// d�termine le statut de r�servation � 'disponible'
	public void setLibre() {
		this.etat = false;}
	
	// renvoie le num�ro de l'oeuvre
	public int getNumero() {
		return this.numeroOeuvre;}
	
	// renvoie le titre de l'oeuvre
	public String getTitre() {
		return this.titreOeuvre;}
	
	// renvoie le prix de l'oeuvre
	public float getPrix() {
		return this.prixOeuvre;}
	
	// renvoie le num�ro d'identifiant du propri�taire
	public int getProprio() {
		return this.refProprio;}
	
	// renvoie l'�tat de l'oeuvre (statut de r�servation)
	public boolean getEtat() {
		return this.etat;}
	
	// m�thode cr�ant une requ�te d'insertion � partir
	// de l'objet OeuvreEn Vente pass�e en param�tre
	public boolean CRUD_Creation(OeuvreEnVente oeuvre) {
		
		boolean success;
		
		// construction de la requ�te SQL
		String requete ="INSERT INTO OEUVRE VALUES(";
		requete += String.valueOf(oeuvre.getNumero());
		requete += ",'";
		requete += oeuvre.getTitre();
		requete += "',";
		requete += String.valueOf(oeuvre.getPrix());
		requete += ",";
		requete += String.valueOf(oeuvre.getProprio());
		requete += ",";
		if(oeuvre.getEtat()) {requete += "'reserve')";}
	    else {requete += "'disponible')";}
	    
		// Cr�ation d'un objet Search qui est la classe 
		// qui se connecte � la BDD et effectue la requ�te
		// dans la BDD par le biais du pilote JDBC
		Search CRUD_crea = new Search();
		
		// Invocation de la m�thode requete qui ex�cute
		// la requ�te pass�e en param�tre
		// dans la BDD expo
		success = CRUD_crea.requete(requete);
		
		// retourne la valeur du bool�en de r�ussite de la requ�te
		return success;
	}

	// m�thode cr�ant une requ�te de suppression � partir
	// de l'objet OeuvreEn Vente pass�e en param�tre
	public boolean CRUD_Suppression(OeuvreEnVente oeuvre) {
		
		boolean success;
		
		// construction de la requ�te SQL
		String requete ="DELETE FROM OEUVRE WHERE ";
		requete += "num_oeuvre=";
		requete += oeuvre.getNumero();
	    
		// Cr�ation d'un objet Search qui est la classe 
		// qui se connecte � la BDD et effectue la requ�te
		// dans la BDD par le biais du pilote JDBC
		Search CRUD_sup = new Search();
		
		// Invocation de la m�thode requete qui ex�cute
		// la requ�te pass�e en param�tre
		// dans la BDD expo
		success = CRUD_sup.requete(requete);
		
		// retourne la valeur du bool�en de r�ussite de la requ�te
		return success;
	}
	
	// m�thode cr�ant une requ�te de MAJ � partir
	// de l'objet OeuvreEn Vente pass�e en param�tre
	public boolean CRUD_Modifie(OeuvreEnVente oeuvre) {
	
	boolean success;
	
	// construction de la requ�te SQL
	String requete ="UPDATE OEUVRE SET statut_oeuvre=";
	
	if(oeuvre.getEtat()) {requete += "'reserve'";}
    else {requete += "'disponible'";}
	
	requete += " where num_oeuvre=";
	requete += String.valueOf(oeuvre.getNumero());
	
	// Cr�ation d'un objet Search qui est la classe 
	// qui se connecte � la BDD et effectue la requ�te
	// dans la BDD par le biais du pilote JDBC
	Search CRUD_modif = new Search();
	
	// Invocation de la m�thode requete qui ex�cute
	// la requ�te pass�e en param�tre
	// dans la BDD expo
	success = CRUD_modif.requete(requete);
	
	// retourne la valeur du bool�en de r�ussite de la requ�te
	return success;
}

	}
