package service;

import modele.OeuvreEnVente;
import modele.Reservation;

// classe qui sert � cr�er le web service CRUD_Biblio
public class CRUD_Biblio {

	// renvoie la liste de toutes les oeuvres d'art
	// pr�sents dans la table de la BDD expo
	// avec tous leurs champs
	public String[][] Liste_Oeuvre() {
		
		Search essai = new Search();
		String[][] result;
		
		result = essai.getListe();
		
		// renvoie le tableau de String obtenu
		return result;
	}
	
	// renvoie la liste de tous les adh�rents
	// pr�sents dans la table de la BDD expo
	// avec tous leurs champs
	public String[][] Liste_Adherent() {
		
		String[][] result;
		Search essai = new Search();
		result=essai.getListeAdh();
		
		// renvoie le tableau de String obtenu
		return result;
	}
	
	// renvoie la liste de tous les propri�taires
	// pr�sents dans la table de la BDD expo
	// avec tous leurs champs
	public String[][] Liste_Proprio() {
		
		String[][] result;
		Search essai = new Search();
		result=essai.getListeProprio();
		
		// renvoie le tableau de String obtenu
		return result;
	}
	
	// renvoie le r�sultat de la requ�te de jointure
	// entre un num�ro d'oeuvre et un num�ro
	// de propri�taire dans la BDD expo
	public String[] Consulter_Oeuvre(int num) {
		
		String[] result = null;
		Search essai = new Search();
		result=essai.getOeuvre(num);
		
		// renvoie le tableau de String obtenu
		return result;
	}
	
	// renvoie le r�sultat bool�en d'une requ�te
	// d'insertion d'une nouvelle oeuvre dans la
	// BDD expo � partir des attributs pass�s en
	// param�tres de la m�thode
	public boolean Ajouter_Oeuvre(int numero,String titre,Float prix,int proprio) {
		
		boolean success;
		
		OeuvreEnVente oeuvre = new OeuvreEnVente();
		oeuvre.init(numero,titre,prix,proprio);
		success = oeuvre.CRUD_Creation(oeuvre);
		
		// renvoie le bool�en de r�sultat de la requ�te
		return success;
	}
	
	// renvoie le r�sultat bool�en d'une requ�te
	// de suppression d'une oeuvre dans la
	// BDD expo � partir des attributs pass�s en
	// param�tres de la m�thode
	public boolean Retirer_Oeuvre(int numero) {
		
		boolean success;
		
		OeuvreEnVente oeuvre = new OeuvreEnVente();
		oeuvre.init(numero);
		success = oeuvre.CRUD_Suppression(oeuvre);
		
		// renvoie le bool�en de r�sultat de la requ�te
		return success;
	}
	
	// renvoie le r�sultat bool�en d'une requ�te
	// d'insertion d'une nouvelle r�servation 
	// d'oeuvre d'art dans la table Reservation de la
	// BDD expo � partir des attributs pass�s en
	// param�tres de la m�thode
	public boolean Reserver_Oeuvre(int num_res,int num_adh,int numero) {
		
		boolean success;
		
		OeuvreEnVente oeuvre = new OeuvreEnVente();
		oeuvre.init(numero);
		oeuvre.setReserve();
		success = oeuvre.CRUD_Modifie(oeuvre);
		
		Reservation reserv = new Reservation();
		reserv.init(num_res, num_adh, numero);
		success = reserv.CRUD_Creation(reserv);
		
		// renvoie le bool�en de r�sultat de la requ�te
		return success;
	}
	
}
