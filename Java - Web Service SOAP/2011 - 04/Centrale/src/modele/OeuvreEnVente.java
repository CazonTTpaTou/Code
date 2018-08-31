package modele;

import service.Search;

// classe héritant de la classe abstraite Oeuvre
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
	
	// version sous chargée de la méthode d'initialisation
	public void init(int numero) {
		this.numeroOeuvre = numero;
		this.etat = false;}
	
	// détermine le statut de réservation à 'réservé'
	public void setReserve() {
		this.etat = true;}
	
	// détermine le statut de réservation à 'disponible'
	public void setLibre() {
		this.etat = false;}
	
	// renvoie le numéro de l'oeuvre
	public int getNumero() {
		return this.numeroOeuvre;}
	
	// renvoie le titre de l'oeuvre
	public String getTitre() {
		return this.titreOeuvre;}
	
	// renvoie le prix de l'oeuvre
	public float getPrix() {
		return this.prixOeuvre;}
	
	// renvoie le numéro d'identifiant du propriétaire
	public int getProprio() {
		return this.refProprio;}
	
	// renvoie l'état de l'oeuvre (statut de réservation)
	public boolean getEtat() {
		return this.etat;}
	
	// méthode créant une requête d'insertion à partir
	// de l'objet OeuvreEn Vente passée en paramètre
	public boolean CRUD_Creation(OeuvreEnVente oeuvre) {
		
		boolean success;
		
		// construction de la requête SQL
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
	    
		// Création d'un objet Search qui est la classe 
		// qui se connecte à la BDD et effectue la requête
		// dans la BDD par le biais du pilote JDBC
		Search CRUD_crea = new Search();
		
		// Invocation de la méthode requete qui exécute
		// la requête passée en paramètre
		// dans la BDD expo
		success = CRUD_crea.requete(requete);
		
		// retourne la valeur du booléen de réussite de la requête
		return success;
	}

	// méthode créant une requête de suppression à partir
	// de l'objet OeuvreEn Vente passée en paramètre
	public boolean CRUD_Suppression(OeuvreEnVente oeuvre) {
		
		boolean success;
		
		// construction de la requête SQL
		String requete ="DELETE FROM OEUVRE WHERE ";
		requete += "num_oeuvre=";
		requete += oeuvre.getNumero();
	    
		// Création d'un objet Search qui est la classe 
		// qui se connecte à la BDD et effectue la requête
		// dans la BDD par le biais du pilote JDBC
		Search CRUD_sup = new Search();
		
		// Invocation de la méthode requete qui exécute
		// la requête passée en paramètre
		// dans la BDD expo
		success = CRUD_sup.requete(requete);
		
		// retourne la valeur du booléen de réussite de la requête
		return success;
	}
	
	// méthode créant une requête de MAJ à partir
	// de l'objet OeuvreEn Vente passée en paramètre
	public boolean CRUD_Modifie(OeuvreEnVente oeuvre) {
	
	boolean success;
	
	// construction de la requête SQL
	String requete ="UPDATE OEUVRE SET statut_oeuvre=";
	
	if(oeuvre.getEtat()) {requete += "'reserve'";}
    else {requete += "'disponible'";}
	
	requete += " where num_oeuvre=";
	requete += String.valueOf(oeuvre.getNumero());
	
	// Création d'un objet Search qui est la classe 
	// qui se connecte à la BDD et effectue la requête
	// dans la BDD par le biais du pilote JDBC
	Search CRUD_modif = new Search();
	
	// Invocation de la méthode requete qui exécute
	// la requête passée en paramètre
	// dans la BDD expo
	success = CRUD_modif.requete(requete);
	
	// retourne la valeur du booléen de réussite de la requête
	return success;
}

	}
