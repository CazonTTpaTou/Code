package modele;

import java.util.Date;

//classe h�ritant de la classe abstraite Oeuvre
public class OeuvrePretee extends Oeuvre{

	Date dateRetour;
	Date datePret;
	
	// d�termine la date de pr�t
	public void setDatePret(Date date) {
		this.datePret = date;}
	
	// d�termine la date de retour de pr�t
	public void setDateRetour(Date date) {
		this.dateRetour = date;}
	
	// renvoie la date de pr�t
	public Date getDatePret() {
		return this.datePret;}
	
	// renvoie la date de retour de pr�t
	public Date getDateRetour() {
		return this.dateRetour;}
	
}
