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


// classe abstraite car elle ne doit pas �tre instanci�e
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
	
	// cr�ation d'une amorce pour invoquer le Web Service
	{CRUD_BiblioStub services = new CRUD_BiblioStub();
	
	// cr�ation d'un objet Liste_OeuvreResponse de la classe d'amorce du Web service
	// pour pouvoir invoquer cette m�thode � distance par le biais du Web service
	CRUD_BiblioStub.Liste_OeuvreResponse lo = new Liste_OeuvreResponse();
	lo = services.liste_Oeuvre();
	result = lo.get_return();
	// le r�sultat retourn� par la m�thode invoqu�e du web service
	// est stock� dans une ArrayList tampon
	for(int i=0;i<result.length;i++) {
		String[] abc = result[i].getArray();
		catalogue.add(abc);}
	
	// cr�ation d'un objet Liste_AdherentResponse de la classe d'amorce du Web service
	// pour pouvoir invoquer cette m�thode � distance par le biais du Web service
	CRUD_BiblioStub.Liste_AdherentResponse la = new Liste_AdherentResponse();
	la = services.liste_Adherent();
	result = la.get_return();
	// le r�sultat retourn� par la m�thode invoqu�e du web service
	// est stock� dans une ArrayList tampon
	for(int i=0;i<result.length;i++) {
		String[] abc = result[i].getArray();
		adherent.add(abc);}
	
	// cr�ation d'un objet Liste_ProprioResponse de la classe d'amorce du Web service
	// pour pouvoir invoquer cette m�thode � distance par le biais du Web service
	CRUD_BiblioStub.Liste_ProprioResponse lp = new Liste_ProprioResponse();
	lp = services.liste_Proprio();
	result = lp.get_return();
	// le r�sultat retourn� par la m�thode invoqu�e du web service
	// est stock� dans une ArrayList tampon
	for(int i=0;i<result.length;i++) {
		String[] abc = result[i].getArray();
		proprietaire.add(abc);}
	
	init=true;}
	
	catch(Exception e) {e.printStackTrace();}
	}
	
	// m�thode qui invoque la m�thode consulter du web service CRUD_Biblio
	// cette m�thode retourne le r�sultat de la requ�te de jointure
	// entre un num�ro d'oeuvre et un num�ro de propri�taire dans la BDD
	static public StringBuffer consulter(int numero) {
		StringBuffer liste = new StringBuffer("<div class='formi'><h1><span class='titref'>D�tail de l'oeuvre : </span><h1><br/>");
		String[] result;
		
		try
		// cr�ation d'une classe d'amorce pour dialoguer avec le WS CRUD_Biblio
		{CRUD_BiblioStub services = new CRUD_BiblioStub();
		
		// cr�ation d'un objet qui va permettre d'invoquer � distance la
		// m�thode consulter_oeuvre du WS CRUD_Biblio
		CRUD_BiblioStub.Consulter_Oeuvre co = new Consulter_Oeuvre();
		CRUD_BiblioStub.Consulter_OeuvreResponse cor = new Consulter_OeuvreResponse();
		co.setNum(numero);
		cor = services.consulter_Oeuvre(co);
		// on stocke le r�sultat retourn� par le WS CRUD_Biblio
		result = cor.get_return();
		
			// On construit un buffer contenant le code HTML
			// qui va afficher les r�sultats retourn�s par le WS CRUD_Biblio
			liste.append("<p>L'oeuvre n� ");
			liste.append(result[0]);
			liste.append(" a les caract�ristiques suivantes : </p>");
			liste.append("<span class='detail'>");
			liste.append("<ul><li>Elle a pour titre :");
			liste.append(result[1]);
			liste.append("</li><li>Elle co�te ");
			liste.append(result[2]);
			liste.append(" Euros </li><li>Elle a pour statut :");
			liste.append(result[3]);
			liste.append("</li><li>Elle appartient � ");
			liste.append(result[5]);
			liste.append(" ");
			liste.append(result[4]);
			liste.append("</span>");
			liste.append("</li></ul>");
			liste.append("<br/>");
			liste.append("<a href='");
			liste.append(URL);
			liste.append("?operation=0'>Retour Accueil</a></div>");}
		
		catch(Exception e) {liste.append("<p>Un probl�me est survenu et emp�che la consultation</p></div>");}
			
		// On retourne le code HTML sous forme de buffer
		return liste;
	}

	// m�thode qui invoque la m�thode ajouter du web service CRUD_Biblio
	// cette m�thode retourne le bool�en de la requ�te d'insertion
	// d'une nouvelle oeuvre dans la BDD � partir des param�tres transmis
	static public String ajouter(String titre,float prix,int proprio) {
			String message;
			// on g�n�re le num�ro de l'oeuvre � partir du nombre d'occurrence
			// enregistr�e dans la liste tampon
			int num=catalogue.size()+1;
			boolean success=false;
			
			try
			// cr�ation d'une classe d'amorce pour dialoguer avec le WS CRUD_Biblio
			{CRUD_BiblioStub services = new CRUD_BiblioStub();
			
			// cr�ation d'un objet qui va permettre d'invoquer � distance la
			// m�thode consulter_oeuvre du WS CRUD_Biblio
			CRUD_BiblioStub.Ajouter_Oeuvre ao = new Ajouter_Oeuvre();
			CRUD_BiblioStub.Ajouter_OeuvreResponse aor = new Ajouter_OeuvreResponse();
			// on rajoute les variables pass�s en param�tre
			ao.setNumero(num);
			ao.setTitre(titre);
			ao.setPrix(prix);
			ao.setProprio(proprio);
			aor = services.ajouter_Oeuvre(ao);
			// on stocke le r�sultat retourn� par le WS CRUD_Biblio
			success = aor.get_return();
			
			// On construit un buffer contenant le code HTML
			// qui va afficher les r�sultats retourn�s par le WS CRUD_Biblio
			if(success) {
					String tampon[]={String.valueOf(num),titre,String.valueOf(prix),"disponible"};
					catalogue.add(tampon);
					message="F�licitations - L'oeuvre ";
					message += titre;
					message +=" a bien �t� ajout�e au catalogue !!!";}
			else{message="D�sol� - L'oeuvre n'a pas pu �tre ajout�e au catalogue !!!";}}
			
			catch(Exception e) {message="D�sol� - L'oeuvre n'a pas pu �tre ajout�e au catalogue !!!";}
			
			// On retourne le code HTML sous forme de buffer
			return message;}
			
	// m�thode qui invoque la m�thode retirer du web service CRUD_Biblio
	// cette m�thode retourne le bool�en de la requ�te de suppression
	// d'une nouvelle oeuvre dans la BDD � partir des param�tres transmis	
	static public String retirer(int num) {
		String message;
			boolean success = false;
			
			try
			// cr�ation d'une classe d'amorce pour dialoguer avec le WS CRUD_Biblio
			{CRUD_BiblioStub services = new CRUD_BiblioStub();
			
			// cr�ation d'un objet qui va permettre d'invoquer � distance la
			// m�thode consulter_oeuvre du WS CRUD_Biblio
			CRUD_BiblioStub.Retirer_Oeuvre ro = new Retirer_Oeuvre();
			CRUD_BiblioStub.Retirer_OeuvreResponse ror = new Retirer_OeuvreResponse();
			// on rajoute les variables pass�s en param�tre
			ro.setNumero(num);
			ror = services.retirer_Oeuvre(ro);
			// on stocke le r�sultat retourn� par le WS CRUD_Biblio
			success = ror.get_return();
			
			// On construit un buffer contenant le code HTML
			// qui va afficher les r�sultats retourn�s par le WS CRUD_Biblio
			if(success) {
			catalogue.remove(num-1);
			message="F�licitations - L'oeuvre n� ";
			message += num;
			message +=" a bien �t� retir�e du catalogue !!!";
			}		
			else{message="D�sol� - L'oeuvre n'a pas pu �tre retir�e du catalogue !!!";}}
			
			catch(Exception e) {message="D�sol� - L'oeuvre n'a pas pu �tre retir�e du catalogue !!!";}
			
			// On retourne le code HTML sous forme de buffer
			return message;}
	
	// m�thode qui invoque la m�thode r�server du web service CRUD_Biblio
	// cette m�thode retourne le bool�en de la requ�te d'insertion
	// d'une nouvelle r�servation dans la BDD � partir des param�tres transmis
	static public String reserver(int numo,int numa) {
		String message;
		boolean success=false;
		int nb_reser=0;
		// on calcule le nombre d'ouvrage r�serv� pour la vente
		// afin de d�terminer le num�ro de la nouvelle r�servation
		for(String[] cat:catalogue)
		{if (cat[3].equals("reserve")) {nb_reser++;}}
		nb_reser++;
		String[] cata = catalogue.get(numo-1);
				
				try {
					
				if(cata[3].equals("disponible")) {
				// cr�ation d'une classe d'amorce pour dialoguer avec le WS CRUD_Biblio	
				CRUD_BiblioStub services = new CRUD_BiblioStub();
				
				// cr�ation d'un objet qui va permettre d'invoquer � distance la
				// m�thode consulter_oeuvre du WS CRUD_Biblio
				CRUD_BiblioStub.Reserver_Oeuvre ro = new Reserver_Oeuvre();
				CRUD_BiblioStub.Reserver_OeuvreResponse ror = new Reserver_OeuvreResponse();
				// on rajoute les variables pass�s en param�tre
				ro.setNum_adh(numa);
				ro.setNum_res(nb_reser);
				ro.setNumero(numo);
				ror = services.reserver_Oeuvre(ro);
				// on stocke le r�sultat retourn� par le WS CRUD_Biblio
				success = ror.get_return();
				
				// On met � jour le nouveau statut "reserv�" de l'oeuvre
				// dans l'ArrayList tampon du catalogue des oeuvres
				String[] tampon = catalogue.get(numo-1);
				tampon[3]="reserve";
				catalogue.set(numo-1, tampon);
				
					// On construit un buffer contenant le code HTML
					// qui va afficher les r�sultats retourn�s par le WS CRUD_Biblio
					if(success) {message="F�licitations, la r�servation n� ";
							 message+=nb_reser+ " a bien �t� enregistr�e !!!";}
					else {message="D�sol�, l'enregistrement de la r�servation a �chou� !!!";}
				}
				else {message="Attention, l'oeuvre n� ";
				  message+=numo + " est d�j� r�serv�e !!!";}
				}
			
				catch(Exception e) {message="Un probl�me est survenu - la r�servation a �chou�";}
			
			// On retourne le code HTML sous forme de buffer
			return message;
		}
	
	// M�thode renvoyant le contenu de l'ArrayList tampon
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
	
	// M�thode renvoyant le contenu de l'ArrayList tampon
	// qui stocke la liste des adh�rents de la biblioth�que
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
	
	// M�thode renvoyant le contenu de l'ArrayList tampon
	// qui stocke le catalogue des oeuvres de la BDD expo
	// sous forme d'une liste d�roulante SELECT
	static public StringBuffer Deroule_Oeuvre() {
		String ch = "<select name='numoeuvre'>";
		StringBuffer liste = new StringBuffer(ch);
		
		// Construction d'un buffer qui va contenir le code HTML
		// d'une liste d�roulante contenant toutes les oeuvres d'art de l'exposition
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
	
	// M�thode renvoyant le contenu de l'ArrayList tampon
	// qui stocke la listes des propri�taires
	// des oeuvres d'art contenues dans la BDD expo
	static public StringBuffer Liste_Proprio() {
		String ch = "<select name='nomproprietaire' id='prop'>";
		StringBuffer liste = new StringBuffer(ch);
		// Construction d'un buffer qui va contenir le code HTML
		// d'une liste d�roulante contenant la liste
		// de tous les propri�taires des oeuvres d'art de l'exposition
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
