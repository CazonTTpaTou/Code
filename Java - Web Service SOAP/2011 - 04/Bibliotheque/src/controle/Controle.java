package controle;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class Controle extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	static String URL = "http://localhost:8080/Bibliotheque/Controle";
    
	private String utilisateur="User";
    private String operation;
    private int code;
    private int numero_oeuvre;
    
    // d�termine le num�ro de l'oeuvre manipul�e
    public void setNumero_oeuvre(int num) {
    	this.numero_oeuvre=num;}
    
    // d�termine le nom de l'utilisateur
    public void setUtilisateur(String nom) {
    	this.utilisateur=nom;}

    // d�termine le libell� de l'op�ration en cours
    // � partir du num�ro de code de l'op�ration
    public void setOperation(int num) {
    	
    	if(num==0){this.operation="Accueil";}
    	if(num==1){this.operation="Consultation";}
    	if(num==2){this.operation="R�servation";}
    	if(num==3){this.operation="Suppression";}
    	if(num==4){this.operation="Ajout";}
    	if(num==5){this.operation="Consultation";}
    	if(num==6){this.operation="R�servation";}
    	if(num==7){this.operation="Suppression";}
    	if(num==8){this.operation="Ajout";}
    	}
    
    // d�termine le code l'op�ration trait�e en cours
    public void setCode(int numero) {
    	this.code=numero;}
    
    // retourne le num�ro de l'oeuvre trait�e
    public int getNumero_oeuvre() {
    	return this.numero_oeuvre;}
    
    // retourne le nom de l'utilisateur
    public String getUtilisateur() {
    	return this.utilisateur;}
    
    // retourne le libell� de l'op�ration en cours
    public String getOperation() {
    	return this.operation;}
    
    // retourne le code de l'op�ration en cours
    public int getCode() {
    	return this.code;}
    
    // constructeur de la servlet
    public Controle() {
        super();
        this.code=0;
        setOperation(getCode());
        }

    // les requ�tes transmises par m�thode GET sont transmises
    // � la m�thode TraitementG
    // en effet, il est conseill� de r�duire au maximum le 
    // code dans cette m�thode pour ne pas d�clencher
    // d'exceptions de type d�passement de timer
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		traitementG(request,response);
		}

	// les requ�tes transmises par m�thode POST sont transmises
    // � la m�thode TraitementP
    // en effet, il est conseill� de r�duire au maximum le 
    // code dans cette m�thode pour ne pas d�clencher
    // d'exceptions de type d�passement de timer
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		traitementP(request,response);
	}

	// cette m�thode s�lectionne les op�rations � effectuer en fonction des
	// param�tres transmises � partir de la m�thode GET 
	protected void traitementG(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		StringBuffer form = new StringBuffer();
		
		// on initialise les diff�rentes variables
		// � partir des param�tres re�us par URL
		if(request.getParameter("oeuvre")!=null){setNumero_oeuvre(Integer.parseInt(request.getParameter("oeuvre")));}
		setCode(Integer.parseInt(request.getParameter("operation")));
		setOperation(getCode());
		
		// on stocke le code HTML du formulaire construit
		// par la m�thode formulaire(n�) dans un buffer
		form.append(formulaire(getCode()));
		
		// on d�termine les attributs de la requ�te
		// qui va �tre envoy�e � la page JSP
		request.setAttribute("formulaire",form);
		request.setAttribute("libelle",getOperation());
		request.setAttribute("utilisateur",getUtilisateur());
		
		// On dispatche la requ�te vers le page Acceuil.jsp
		this.getServletContext().getRequestDispatcher("/Accueil.jsp").forward(request,response);
	}
	
	// cette m�thode s�lectionne les op�rations � effectuer en fonction des
	// param�tres transmises � partir de la m�thode POST 
	protected void traitementP(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		StringBuffer form = new StringBuffer();
		String[] rep = new String[3];
		
		// on initialise les diff�rentes variables
		// � partir des param�tres re�us par formulaire POST
		setUtilisateur(request.getParameter("nom"));
		// � partir du num�ro de formulaire
		// on en d�duit le num�ro de l'op�ration � laquelle
		// se r�f�re le formulaire
		setCode(Integer.parseInt(request.getParameter("numero")));
		setOperation(getCode());
		
		// en fonction du code de l'op�ration on en d�duit
		// l'architecture du formulaire et des diff�rents champs
		// on r�cup�re la valeur de chaque champs
		// pour le stocker dans un tableau tampon qui 
		// sera pass� en param�tre
		if(getCode()==6) {rep[0]=request.getParameter("numoeuvre");
						  rep[1]=request.getParameter("nomadherent");}
		
		if(getCode()==7) {rep[0]=request.getParameter("numoeuvre");}

		if(getCode()==8) {rep[0]=request.getParameter("titre");
						  rep[1]=request.getParameter("prix");
						  rep[2]=request.getParameter("nomproprietaire");}
		
		// On r�cup�re le code HTML renvoy�  par la m�thode Rformulaire
		// et on l'ajoute dans la variable de type Buffer
		form.append(Rformulaire(getCode(),rep));
		
		// on d�termine les attributs de la requ�te
		// qui va �tre envoy�e � la page JSP
		request.setAttribute("formulaire",form);
		request.setAttribute("libelle",getOperation());
		request.setAttribute("utilisateur",getUtilisateur());
		
		// On dispatche la requ�te vers le page Acceuil.jsp
		this.getServletContext().getRequestDispatcher("/Accueil.jsp").forward(request,response);
	
	}
	
	// cette m�thode construit le code HTML correspondant au num�ro
	// de l'op�ration pass�e en param�tre
	protected StringBuffer formulaire(int num) {
		StringBuffer consult = new StringBuffer();
		
		// Op�ration n�0 : message d'accueil
		if(num==0) {consult.append("<h1 class='remarque'>Veuillez choisir une op�ration SVP</h1>");}
		
		// Op�ration n�1 : Liste des oeuvres d'art
		if(num==1) {consult = Catalogue.Liste_Oeuvre();}
		
		// Op�ration n�2 : Formulaire de r�servation d'une oeuvre
		if(num==2) {consult.append("<div class='formi'><h1><span class='titref'>R�servation : </span></h1><br/><br/><form method='post' name='reservation' action='Controle?operation=6'>");
		            consult.append("<input type='hidden' name='numero' value='6'><label for='noms'> Choisissez une oeuvre � emprunter : </label>");
					consult.append(Catalogue.Deroule_Oeuvre());
					consult.append("<br/><br/><label for='noms'> Choisissez un adh�rent : </label> ");
					consult.append(Catalogue.Liste_Adherent());
					consult.append("<br/><br/><input type='submit' value='Envoyer'><br/></form></div>");}
		
		// Op�ration n�3: Formulaire de suppression d'une oeuvre
		if(num==3) {consult.append("<div class='formi'><h1><span class='titref'>Suppression : </span></h1><br/><form method='post' name='suppression' action='Controle?operation=7'>");
					consult.append("<input type='hidden' name='numero' value='7'><label for='noms'> Choisissez une oeuvre � supprimer : </label>");
					consult.append(Catalogue.Deroule_Oeuvre());
					consult.append("<br/><br/><input type='submit' value='Envoyer'><br/></form></div>");}
		
		// Op�ration n�4: Formulaire d'ajout d'une oeuvre d'art
		if(num==4) {consult.append("<div class='formi'><h1><span class='titref'>Enregistrer une nouvelle oeuvre : </span></h1><br/><form method='post' name='ajout' action='Controle?operation=8' onsubmit='return verif();'>");
					consult.append("<input type='hidden' name='numero' value='8'>");
					consult.append("<label for='noms'> Remplir le titre : </label><input type='text'name='titre' id='title'><br/><br/>");
					consult.append("<label for='noms'> Remplir le prix en Euros : </label><input type='text'name='prix' id='price' ");
					consult.append("onKeypress='if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;");
					consult.append(" if(event.which < 45 || event.which > 57) return false;'><br/><br/>");
					consult.append("<label for='noms'> Choisir le propri�taire : </label>");
					consult.append(Catalogue.Liste_Proprio());
					consult.append("<br/><br/><input type='submit' value='Envoyer'><br/></form></div>");}
		
		// Op�ration n�5: Consultation des caract�ristiques d'une oeuvre particuli�re
		if(num==5) {consult=Catalogue.consulter(getNumero_oeuvre());}   
		
		// retourne la variable buffer contenant le code HTML
		return consult;
		}
	
	// cette m�thode construit le code HTML correspondant au traitement 
	// de la r�ponse au formulaire correspondant au num�ro
	// de l'op�ration pass�e en param�tre
	protected StringBuffer Rformulaire(int num,String[] answer) {
		StringBuffer consult = new StringBuffer();
		
		// Op�ration n�0: message de retour � l'accueil
		if(num==0) {consult.append("<h1 class='remarque'>Veuillez choisir une op�ration SVP</h1>");}
		
		// Op�ration n�6: message de r�sultat du traitement du formulaire de r�servation
		if(num==6) {consult.append("<div class='formi'><h1 class='message'>");
					consult.append(Catalogue.reserver(Integer.parseInt(answer[0]), Integer.parseInt(answer[1])));
					consult.append("</h1>");
					consult.append("<br/><br/><a href='");
					consult.append(URL);
					consult.append("?operation=0'>Retour Accueil</a></div>");
				}
		
		// Op�ration n�7: message de r�sultat du traitement du formulaire de suppression
		if(num==7) {consult.append("<div class='formi'><h1 class='message'>");
					consult.append(Catalogue.retirer(Integer.parseInt(answer[0])));
					consult.append("</h1>");
					consult.append("</h1>");
					consult.append("<br/><br/><a href='");
					consult.append(URL);
					consult.append("?operation=0'>Retour Accueil</a></div>");
				}
		
		// Op�ration n�8: message de r�sultat du traitement du formulaire d'enregistrement et d'ajout
		if(num==8) {consult.append("<div class='formi'><h1 class='message'>");
					consult.append(Catalogue.ajouter(answer[0], Float.parseFloat(answer[1]), Integer.parseInt(answer[2])));
					consult.append("</h1>");
					consult.append("</h1>");
					consult.append("<br/><br/><a href='");
					consult.append(URL);
					consult.append("?operation=0'>Retour Accueil</a></div>");
				}
		// retourne la variable buffer contenant le code HTML � afficher
		return consult;
		}	
}
