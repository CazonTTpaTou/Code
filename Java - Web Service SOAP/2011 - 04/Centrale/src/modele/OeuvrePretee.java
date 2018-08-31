package modele;

import java.util.Date;

//classe héritant de la classe abstraite Oeuvre
public class OeuvrePretee extends Oeuvre{

	Date dateRetour;
	Date datePret;
	
	// détermine la date de prêt
	public void setDatePret(Date date) {
		this.datePret = date;}
	
	// détermine la date de retour de prêt
	public void setDateRetour(Date date) {
		this.dateRetour = date;}
	
	// renvoie la date de prêt
	public Date getDatePret() {
		return this.datePret;}
	
	// renvoie la date de retour de prêt
	public Date getDateRetour() {
		return this.dateRetour;}
	
}
