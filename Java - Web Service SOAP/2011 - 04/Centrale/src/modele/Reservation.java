package modele;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import service.Search;

public class Reservation {

	private int numero_reservation;
	private Date date;
	private int numero_adherent;
	private int numero_oeuvre;
	
	// initialise les variables de classe
	public void init(int numr,int numa,int numo){
		this.numero_reservation=numr;
		this.numero_adherent=numa;
		this.numero_oeuvre=numo;
		this.date = new Date();	
	}
	
	// renvoie le numéro de réservation
	public int getNumero_reservation() {
		return this.numero_reservation;}
	
	// renvoie le numéro de l'adhérent
	public int getNumero_adherent() {
		return this.numero_adherent;
	}
	
	// renvoie le numéro de l'oeuvre réservée
	public int getNumero_oeuvre() {
		return this.numero_oeuvre;
	}
	
	// renvoie la date de la réservation
	public String getDate() {
		DateFormat dateFormat = new SimpleDateFormat("dd-MM-yy");
		String date_SQL = dateFormat.format(this.date);
		return date_SQL;
	}
	
	// renvoie la date de réservation au format SQL (yyyy - mm - jj)
	public String getDateSQL() {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String date_SQL = dateFormat.format(this.date);
		return date_SQL;
	}
	
	// méthode créant une requête d'insertion à partir
	// de l'objet Reservation passée en paramètre
	public boolean CRUD_Creation(Reservation reservation) {
		
		boolean success;
		
		// construction de la requête SQL
		String requete ="INSERT INTO reservation VALUES(";
		requete += String.valueOf(reservation.getNumero_reservation());
		requete += ",'";
		requete += reservation.getDateSQL();
		requete += "',";
		requete += reservation.getNumero_adherent();
		requete += ",";
		requete += reservation.getNumero_oeuvre();
		requete += ")";
		
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
}
