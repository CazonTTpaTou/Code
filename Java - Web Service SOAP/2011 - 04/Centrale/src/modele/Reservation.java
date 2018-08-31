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
	
	// renvoie le num�ro de r�servation
	public int getNumero_reservation() {
		return this.numero_reservation;}
	
	// renvoie le num�ro de l'adh�rent
	public int getNumero_adherent() {
		return this.numero_adherent;
	}
	
	// renvoie le num�ro de l'oeuvre r�serv�e
	public int getNumero_oeuvre() {
		return this.numero_oeuvre;
	}
	
	// renvoie la date de la r�servation
	public String getDate() {
		DateFormat dateFormat = new SimpleDateFormat("dd-MM-yy");
		String date_SQL = dateFormat.format(this.date);
		return date_SQL;
	}
	
	// renvoie la date de r�servation au format SQL (yyyy - mm - jj)
	public String getDateSQL() {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String date_SQL = dateFormat.format(this.date);
		return date_SQL;
	}
	
	// m�thode cr�ant une requ�te d'insertion � partir
	// de l'objet Reservation pass�e en param�tre
	public boolean CRUD_Creation(Reservation reservation) {
		
		boolean success;
		
		// construction de la requ�te SQL
		String requete ="INSERT INTO reservation VALUES(";
		requete += String.valueOf(reservation.getNumero_reservation());
		requete += ",'";
		requete += reservation.getDateSQL();
		requete += "',";
		requete += reservation.getNumero_adherent();
		requete += ",";
		requete += reservation.getNumero_oeuvre();
		requete += ")";
		
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
}
