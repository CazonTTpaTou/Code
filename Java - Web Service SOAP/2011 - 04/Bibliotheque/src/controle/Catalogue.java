package controle;

import java.util.ArrayList;
import java.util.List;

import service.*;
import service.CRUD_BiblioStub.Ajouter_Oeuvre;
import service.CRUD_BiblioStub.Ajouter_OeuvreResponse;
import service.CRUD_BiblioStub.ArrayOfString;
import service.CRUD_BiblioStub.Consulter_Oeuvre;
import service.CRUD_BiblioStub.Consulter_OeuvreResponse;
import service.CRUD_BiblioStub.Liste_AdherentResponse;
import service.CRUD_BiblioStub.Liste_OeuvreResponse;
import service.CRUD_BiblioStub.Liste_ProprioResponse;
import service.CRUD_BiblioStub.Reserver_Oeuvre;
import service.CRUD_BiblioStub.Reserver_OeuvreResponse;
import service.CRUD_BiblioStub.Retirer_Oeuvre;
import service.CRUD_BiblioStub.Retirer_OeuvreResponse;


// classe abstraite car elle ne doit pas être instanciée
public abstract class Catalogue {

	// initialisation des ArrayList tampon qui feront office de cache
	static String URL = "http://localhost:8080/Bibliotheque/Controle";
	static boolean init=false;
	static ArrayList<String[]> catalogue = new ArrayList<String[]>();
	static ArrayList<String[]> adherent = new ArrayList<String[]>();
	static ArrayList<String[]> proprietaire = new ArrayList<String[]>();
	
	//constructeur statique de la classe Catalogue
	static{

	ArrayOfString[] result = null;
	boolean success;
	
	try
	
	// création d'une amorce pour invoquer le Web Service
	{CRUD_BiblioStub services = new CRUD_BiblioStub();
	
	// création d'un objet Liste_OeuvreResponse de la classe d'amorce du Web service
	// pour pouvoir invoquer cette méthode à distance par le biais du Web service
	CRUD_BiblioStub.Liste_OeuvreResponse lo = new Liste_OeuvreResponse();
	lo = services.liste_Oeuvre();
	result = lo.get_return();
	// le résultat retourné par la méthode invoquée du web service
	// est stocké dans une ArrayList tampon
	for(int i=0;i<result.length;i++) {
		String[] abc = result[i].getArray();
		catalogue.add(abc);}
	
	// création d'un objet Liste_AdherentResponse de la classe d'amorce du Web service
	// pour pouvoir invoquer cette méthode à distance par le biais du Web service
	CRUD_BiblioStub.Liste_AdherentResponse la = new Liste_AdherentResponse();
	la = services.liste_Adherent();
	result = la.get_return();
	// le résultat retourné par la méthode invoquée du web service
	// est stocké dans une ArrayList tampon
	for(int i=0;i<result.length;i++) {
		String[] abc = result[i].getArray();
		adherent.add(abc);}
	
	// création d'un objet Liste_ProprioResponse de la classe d'amorce du Web service
	// pour pouvoir invoquer cette méthode à distance par le biais du Web service
	CRUD_BiblioStub.Liste_ProprioResponse lp = new Liste_ProprioResponse();
	lp = services.liste_Proprio();
	result = lp.get_return();
	// le résultat retourné par la méthode invoquée du web service
	// est stocké dans une ArrayList tampon
	for(int i=0;i<result.length;i++) {
		String[] abc = result[i].getArray();
		proprietaire.add(abc);}
	
	init=true;}
	
	catch(Exception e) {e.printStackTrace();}
	}
	
	// méthode qui invoque la méthode consulter du web service CRUD_Biblio
	// cette méthode retourne le résultat de la requête de jointure
	// entre un numéro d'oeuvre et un numéro de propriétaire dans la BDD
	static public StringBuffer consulter(int numero) {
		StringBuffer liste = new StringBuffer("<div class='formi'><h1><span class='titref'>Détail de l'oeuvre : </span><h1><br/>");
		String[] result;
		
		try
		// création d'une classe d'amorce pour dialoguer avec le WS CRUD_Biblio
		{CRUD_BiblioStub services = new CRUD_BiblioStub();
		
		// création d'un objet qui va permettre d'invoquer à distance la
		// méthode consulter_oeuvre du WS CRUD_Biblio
		CRUD_BiblioStub.Consulter_Oeuvre co = new Consulter_Oeuvre();
		CRUD_BiblioStub.Consulter_OeuvreResponse cor = new Consulter_OeuvreResponse();
		co.setNum(numero);
		cor = services.consulter_Oeuvre(co);
		// on stocke le résultat retourné par le WS CRUD_Biblio
		result = cor.get_return();
		
			// On construit un buffer contenant le code HTML
			// qui va afficher les résultats retournés par le WS CRUD_Biblio
			liste.append("<p>L'oeuvre n° ");
			liste.append(result[0]);
			liste.append(" a les caractéristiques suivantes : </p>");
			liste.append("<span class='detail'>");
			liste.append("<ul><li>Elle a pour titre :");
			liste.append(result[1]);
			liste.append("</li><li>Elle coûte ");
			liste.append(result[2]);
			liste.append(" Euros </li><li>Elle a pour statut :");
			liste.append(result[3]);
			liste.append("</li><li>Elle appartient à ");
			liste.append(result[5]);
			liste.append(" ");
			liste.append(result[4]);
			liste.append("</span>");
			liste.append("</li></ul>");
			liste.append("<br/>");
			liste.append("<a href='");
			liste.append(URL);
			liste.append("?operation=0'>Retour Accueil</a></div>");}
		
		catch(Exception e) {liste.append("<p>Un problème est survenu et empêche la consultation</p></div>");}
			
		// On retourne le code HTML sous forme de buffer
		return liste;
	}

	// méthode qui invoque la méthode ajouter du web service CRUD_Biblio
	// cette méthode retourne le booléen de la requête d'insertion
	// d'une nouvelle oeuvre dans la BDD à partir des paramètres transmis
	static public String ajouter(String titre,float prix,int proprio) {
			String message;
			// on génère le numéro de l'oeuvre à partir du nombre d'occurrence
			// enregistrée dans la liste tampon
			int num=catalogue.size()+1;
			boolean success=false;
			
			try
			// création d'une classe d'amorce pour dialoguer avec le WS CRUD_Biblio
			{CRUD_BiblioStub services = new CRUD_BiblioStub();
			
			// création d'un objet qui va permettre d'invoquer à distance la
			// méthode consulter_oeuvre du WS CRUD_Biblio
			CRUD_BiblioStub.Ajouter_Oeuvre ao = new Ajouter_Oeuvre();
			CRUD_BiblioStub.Ajouter_OeuvreResponse aor = new Ajouter_OeuvreResponse();
			// on rajoute les variables passés en paramètre
			ao.setNumero(num);
			ao.setTitre(titre);
			ao.setPrix(prix);
			ao.setProprio(proprio);
			aor = services.ajouter_Oeuvre(ao);
			// on stocke le résultat retourné par le WS CRUD_Biblio
			success = aor.get_return();
			
			// On construit un buffer contenant le code HTML
			// qui va afficher les résultats retournés par le WS CRUD_Biblio
			if(success) {
					String tampon[]={String.valueOf(num),titre,String.valueOf(prix),"disponible"};
					catalogue.add(tampon);
					message="Félicitations - L'oeuvre ";
					message += titre;
					message +=" a bien été ajoutée au catalogue !!!";}
			else{message="Désolé - L'oeuvre n'a pas pu être ajoutée au catalogue !!!";}}
			
			catch(Exception e) {message="Désolé - L'oeuvre n'a pas pu être ajoutée au catalogue !!!";}
			
			// On retourne le code HTML sous forme de buffer
			return message;}
			
	// méthode qui invoque la méthode retirer du web service CRUD_Biblio
	// cette méthode retourne le booléen de la requête de suppression
	// d'une nouvelle oeuvre dans la BDD à partir des paramètres transmis	
	static public String retirer(int num) {
		String message;
			boolean success = false;
			
			try
			// création d'une classe d'amorce pour dialoguer avec le WS CRUD_Biblio
			{CRUD_BiblioStub services = new CRUD_BiblioStub();
			
			// création d'un objet qui va permettre d'invoquer à distance la
			// méthode consulter_oeuvre du WS CRUD_Biblio
			CRUD_BiblioStub.Retirer_Oeuvre ro = new Retirer_Oeuvre();
			CRUD_BiblioStub.Retirer_OeuvreResponse ror = new Retirer_OeuvreResponse();
			// on rajoute les variables passés en paramètre
			ro.setNumero(num);
			ror = services.retirer_Oeuvre(ro);
			// on stocke le résultat retourné par le WS CRUD_Biblio
			success = ror.get_return();
			
			// On construit un buffer contenant le code HTML
			// qui va afficher les résultats retournés par le WS CRUD_Biblio
			if(success) {
			catalogue.remove(num-1);
			message="Félicitations - L'oeuvre n° ";
			message += num;
			message +=" a bien été retirée du catalogue !!!";
			}		
			else{message="Désolé - L'oeuvre n'a pas pu être retirée du catalogue !!!";}}
			
			catch(Exception e) {message="Désolé - L'oeuvre n'a pas pu être retirée du catalogue !!!";}
			
			// On retourne le code HTML sous forme de buffer
			return message;}
	
	// méthode qui invoque la méthode réserver du web service CRUD_Biblio
	// cette méthode retourne le booléen de la requête d'insertion
	// d'une nouvelle réservation dans la BDD à partir des paramètres transmis
	static public String reserver(int numo,int numa) {
		String message;
		boolean success=false;
		int nb_reser=0;
		// on calcule le nombre d'ouvrage réservé pour la vente
		// afin de déterminer le numéro de la nouvelle réservation
		for(String[] cat:catalogue)
		{if (cat[3].equals("reserve")) {nb_reser++;}}
		nb_reser++;
		String[] cata = catalogue.get(numo-1);
				
				try {
					
				if(cata[3].equals("disponible")) {
				// création d'une classe d'amorce pour dialoguer avec le WS CRUD_Biblio	
				CRUD_BiblioStub services = new CRUD_BiblioStub();
				
				// création d'un objet qui va permettre d'invoquer à distance la
				// méthode consulter_oeuvre du WS CRUD_Biblio
				CRUD_BiblioStub.Reserver_Oeuvre ro = new Reserver_Oeuvre();
				CRUD_BiblioStub.Reserver_OeuvreResponse ror = new Reserver_OeuvreResponse();
				// on rajoute les variables passés en paramètre
				ro.setNum_adh(numa);
				ro.setNum_res(nb_reser);
				ro.setNumero(numo);
				ror = services.reserver_Oeuvre(ro);
				// on stocke le résultat retourné par le WS CRUD_Biblio
				success = ror.get_return();
				
				// On met à jour le nouveau statut "reservé" de l'oeuvre
				// dans l'ArrayList tampon du catalogue des oeuvres
				String[] tampon = catalogue.get(numo-1);
				tampon[3]="reserve";
				catalogue.set(numo-1, tampon);
				
					// On construit un buffer contenant le code HTML
					// qui va afficher les résultats retournés par le WS CRUD_Biblio
					if(success) {message="Félicitations, la réservation n° ";
							 message+=nb_reser+ " a bien été enregistrée !!!";}
					else {message="Désolé, l'enregistrement de la réservation a échoué !!!";}
				}
				else {message="Attention, l'oeuvre n° ";
				  message+=numo + " est déjà réservée !!!";}
				}
			
				catch(Exception e) {message="Un problème est survenu - la réservation a échoué";}
			
			// On retourne le code HTML sous forme de buffer
			return message;
		}
	
	// Méthode renvoyant le contenu de l'ArrayList tampon
	// qui stocke le catalogue des oeuvres de la BDD expo
	static public StringBuffer Liste_Oeuvre() {
		
		// Construction d'un buffer qui va contenir le code HTML
		// d'un tableau contenant toutes les oeuvres d'art de l'exposition
		String ch ="<div class='formi'><table id='tableau' border=1px  cellpadding=2px >";
		StringBuffer liste = new StringBuffer(ch);
		liste.append("<tr><th>Numero</th><th>Titre</th><th>Prix</th><th>Statut</th><th>Operation</th></tr>");
		String lien;
		
		for(String[] a:catalogue) {
			lien = URL+"?operation=5&oeuvre="+a[0];
			liste.append("<tr>");
			for(String element: a){
				liste.append("<td>");
				liste.append(element);
				liste.append("</td>");}
			
			liste.append("<td>");
			liste.append("<a href='");
			liste.append(lien);
			liste.append("'>Consulter</a></td>");
			liste.append("</tr>");}
		liste.append("</table/></div>");
		
		// on retourne la buffer contenant le code HTML
		return liste;
	}
	
	// Méthode renvoyant le contenu de l'ArrayList tampon
	// qui stocke la liste des adhérents de la bibliothèque
	static public StringBuffer Liste_Adherent() {
		String ch = "<select name='nomadherent'>";
		StringBuffer liste = new StringBuffer(ch);
		// Construction d'un buffer qui va contenir le code HTML
		// d'un tableau contenant toutes les oeuvres d'art de l'exposition
		for(String[] a:adherent) {
				String libelle=a[0] + " - "+ a[1]+" - " + a[2];
					liste.append("<option value=");
					liste.append(a[0]);
					liste.append(">");
					liste.append(libelle);
					liste.append("</option>");
			}
		liste.append("</select>");
		
		// On retourne le code HTML sous forme de buffer
		return liste;
	}
	
	// Méthode renvoyant le contenu de l'ArrayList tampon
	// qui stocke le catalogue des oeuvres de la BDD expo
	// sous forme d'une liste déroulante SELECT
	static public StringBuffer Deroule_Oeuvre() {
		String ch = "<select name='numoeuvre'>";
		StringBuffer liste = new StringBuffer(ch);
		
		// Construction d'un buffer qui va contenir le code HTML
		// d'une liste déroulante contenant toutes les oeuvres d'art de l'exposition
		for(String[] a:catalogue) {
				String libelle=a[0] + " - "+ a[1]+" - " + a[2] + " Euros";
					liste.append("<option value=");
					liste.append(a[0]);
					liste.append(">");
					liste.append(libelle);
					liste.append("</option>");
			}
		liste.append("</select>");
		
		// On retourne le code HTML sous forme de buffer
		return liste;
	}
	
	// Méthode renvoyant le contenu de l'ArrayList tampon
	// qui stocke la listes des propriétaires
	// des oeuvres d'art contenues dans la BDD expo
	static public StringBuffer Liste_Proprio() {
		String ch = "<select name='nomproprietaire' id='prop'>";
		StringBuffer liste = new StringBuffer(ch);
		// Construction d'un buffer qui va contenir le code HTML
		// d'une liste déroulante contenant la liste
		// de tous les propriétaires des oeuvres d'art de l'exposition
		for(String[] a:proprietaire) {
				String libelle=a[0] + " - "+ a[1]+" - " + a[2];
					liste.append("<option value=");
					liste.append(a[0]);
					liste.append(">");
					liste.append(libelle);
					liste.append("</option>");
			}
		liste.append("</select>");
		
		// On retourne le code HTML sous forme de buffer
		return liste;
	}
	
}
