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
    
    // détermine le numéro de l'oeuvre manipulée
    public void setNumero_oeuvre(int num) {
    	this.numero_oeuvre=num;}
    
    // détermine le nom de l'utilisateur
    public void setUtilisateur(String nom) {
    	this.utilisateur=nom;}

    // détermine le libellé de l'opération en cours
    // à partir du numéro de code de l'opération
    public void setOperation(int num) {
    	
    	if(num==0){this.operation="Accueil";}
    	if(num==1){this.operation="Consultation";}
    	if(num==2){this.operation="Réservation";}
    	if(num==3){this.operation="Suppression";}
    	if(num==4){this.operation="Ajout";}
    	if(num==5){this.operation="Consultation";}
    	if(num==6){this.operation="Réservation";}
    	if(num==7){this.operation="Suppression";}
    	if(num==8){this.operation="Ajout";}
    	}
    
    // détermine le code l'opération traitée en cours
    public void setCode(int numero) {
    	this.code=numero;}
    
    // retourne le numéro de l'oeuvre traitée
    public int getNumero_oeuvre() {
    	return this.numero_oeuvre;}
    
    // retourne le nom de l'utilisateur
    public String getUtilisateur() {
    	return this.utilisateur;}
    
    // retourne le libellé de l'opération en cours
    public String getOperation() {
    	return this.operation;}
    
    // retourne le code de l'opération en cours
    public int getCode() {
    	return this.code;}
    
    // constructeur de la servlet
    public Controle() {
        super();
        this.code=0;
        setOperation(getCode());
        }

    // les requêtes transmises par méthode GET sont transmises
    // à la méthode TraitementG
    // en effet, il est conseillé de réduire au maximum le 
    // code dans cette méthode pour ne pas déclencher
    // d'exceptions de type dépassement de timer
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		traitementG(request,response);
		}

	// les requêtes transmises par méthode POST sont transmises
    // à la méthode TraitementP
    // en effet, il est conseillé de réduire au maximum le 
    // code dans cette méthode pour ne pas déclencher
    // d'exceptions de type dépassement de timer
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		traitementP(request,response);
	}

	// cette méthode sélectionne les opérations à effectuer en fonction des
	// paramètres transmises à partir de la méthode GET 
	protected void traitementG(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		StringBuffer form = new StringBuffer();
		
		// on initialise les différentes variables
		// à partir des paramètres reçus par URL
		if(request.getParameter("oeuvre")!=null){setNumero_oeuvre(Integer.parseInt(request.getParameter("oeuvre")));}
		setCode(Integer.parseInt(request.getParameter("operation")));
		setOperation(getCode());
		
		// on stocke le code HTML du formulaire construit
		// par la méthode formulaire(n°) dans un buffer
		form.append(formulaire(getCode()));
		
		// on détermine les attributs de la requête
		// qui va être envoyée à la page JSP
		request.setAttribute("formulaire",form);
		request.setAttribute("libelle",getOperation());
		request.setAttribute("utilisateur",getUtilisateur());
		
		// On dispatche la requête vers le page Acceuil.jsp
		this.getServletContext().getRequestDispatcher("/Accueil.jsp").forward(request,response);
	}
	
	// cette méthode sélectionne les opérations à effectuer en fonction des
	// paramètres transmises à partir de la méthode POST 
	protected void traitementP(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		StringBuffer form = new StringBuffer();
		String[] rep = new String[3];
		
		// on initialise les différentes variables
		// à partir des paramètres reçus par formulaire POST
		setUtilisateur(request.getParameter("nom"));
		// à partir du numéro de formulaire
		// on en déduit le numéro de l'opération à laquelle
		// se réfère le formulaire
		setCode(Integer.parseInt(request.getParameter("numero")));
		setOperation(getCode());
		
		// en fonction du code de l'opération on en déduit
		// l'architecture du formulaire et des différents champs
		// on récupère la valeur de chaque champs
		// pour le stocker dans un tableau tampon qui 
		// sera passé en paramètre
		if(getCode()==6) {rep[0]=request.getParameter("numoeuvre");
						  rep[1]=request.getParameter("nomadherent");}
		
		if(getCode()==7) {rep[0]=request.getParameter("numoeuvre");}

		if(getCode()==8) {rep[0]=request.getParameter("titre");
						  rep[1]=request.getParameter("prix");
						  rep[2]=request.getParameter("nomproprietaire");}
		
		// On récupère le code HTML renvoyé  par la méthode Rformulaire
		// et on l'ajoute dans la variable de type Buffer
		form.append(Rformulaire(getCode(),rep));
		
		// on détermine les attributs de la requête
		// qui va être envoyée à la page JSP
		request.setAttribute("formulaire",form);
		request.setAttribute("libelle",getOperation());
		request.setAttribute("utilisateur",getUtilisateur());
		
		// On dispatche la requête vers le page Acceuil.jsp
		this.getServletContext().getRequestDispatcher("/Accueil.jsp").forward(request,response);
	
	}
	
	// cette méthode construit le code HTML correspondant au numéro
	// de l'opération passée en paramètre
	protected StringBuffer formulaire(int num) {
		StringBuffer consult = new StringBuffer();
		
		// Opération n°0 : message d'accueil
		if(num==0) {consult.append("<h1 class='remarque'>Veuillez choisir une opération SVP</h1>");}
		
		// Opération n°1 : Liste des oeuvres d'art
		if(num==1) {consult = Catalogue.Liste_Oeuvre();}
		
		// Opération n°2 : Formulaire de réservation d'une oeuvre
		if(num==2) {consult.append("<div class='formi'><h1><span class='titref'>Réservation : </span></h1><br/><br/><form method='post' name='reservation' action='Controle?operation=6'>");
		            consult.append("<input type='hidden' name='numero' value='6'><label for='noms'> Choisissez une oeuvre à emprunter : </label>");
					consult.append(Catalogue.Deroule_Oeuvre());
					consult.append("<br/><br/><label for='noms'> Choisissez un adhérent : </label> ");
					consult.append(Catalogue.Liste_Adherent());
					consult.append("<br/><br/><input type='submit' value='Envoyer'><br/></form></div>");}
		
		// Opération n°3: Formulaire de suppression d'une oeuvre
		if(num==3) {consult.append("<div class='formi'><h1><span class='titref'>Suppression : </span></h1><br/><form method='post' name='suppression' action='Controle?operation=7'>");
					consult.append("<input type='hidden' name='numero' value='7'><label for='noms'> Choisissez une oeuvre à supprimer : </label>");
					consult.append(Catalogue.Deroule_Oeuvre());
					consult.append("<br/><br/><input type='submit' value='Envoyer'><br/></form></div>");}
		
		// Opération n°4: Formulaire d'ajout d'une oeuvre d'art
		if(num==4) {consult.append("<div class='formi'><h1><span class='titref'>Enregistrer une nouvelle oeuvre : </span></h1><br/><form method='post' name='ajout' action='Controle?operation=8' onsubmit='return verif();'>");
					consult.append("<input type='hidden' name='numero' value='8'>");
					consult.append("<label for='noms'> Remplir le titre : </label><input type='text'name='titre' id='title'><br/><br/>");
					consult.append("<label for='noms'> Remplir le prix en Euros : </label><input type='text'name='prix' id='price' ");
					consult.append("onKeypress='if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;");
					consult.append(" if(event.which < 45 || event.which > 57) return false;'><br/><br/>");
					consult.append("<label for='noms'> Choisir le propriétaire : </label>");
					consult.append(Catalogue.Liste_Proprio());
					consult.append("<br/><br/><input type='submit' value='Envoyer'><br/></form></div>");}
		
		// Opération n°5: Consultation des caractéristiques d'une oeuvre particulière
		if(num==5) {consult=Catalogue.consulter(getNumero_oeuvre());}   
		
		// retourne la variable buffer contenant le code HTML
		return consult;
		}
	
	// cette méthode construit le code HTML correspondant au traitement 
	// de la réponse au formulaire correspondant au numéro
	// de l'opération passée en paramètre
	protected StringBuffer Rformulaire(int num,String[] answer) {
		StringBuffer consult = new StringBuffer();
		
		// Opération n°0: message de retour à l'accueil
		if(num==0) {consult.append("<h1 class='remarque'>Veuillez choisir une opération SVP</h1>");}
		
		// Opération n°6: message de résultat du traitement du formulaire de réservation
		if(num==6) {consult.append("<div class='formi'><h1 class='message'>");
					consult.append(Catalogue.reserver(Integer.parseInt(answer[0]), Integer.parseInt(answer[1])));
					consult.append("</h1>");
					consult.append("<br/><br/><a href='");
					consult.append(URL);
					consult.append("?operation=0'>Retour Accueil</a></div>");
				}
		
		// Opération n°7: message de résultat du traitement du formulaire de suppression
		if(num==7) {consult.append("<div class='formi'><h1 class='message'>");
					consult.append(Catalogue.retirer(Integer.parseInt(answer[0])));
					consult.append("</h1>");
					consult.append("</h1>");
					consult.append("<br/><br/><a href='");
					consult.append(URL);
					consult.append("?operation=0'>Retour Accueil</a></div>");
				}
		
		// Opération n°8: message de résultat du traitement du formulaire d'enregistrement et d'ajout
		if(num==8) {consult.append("<div class='formi'><h1 class='message'>");
					consult.append(Catalogue.ajouter(answer[0], Float.parseFloat(answer[1]), Integer.parseInt(answer[2])));
					consult.append("</h1>");
					consult.append("</h1>");
					consult.append("<br/><br/><a href='");
					consult.append(URL);
					consult.append("?operation=0'>Retour Accueil</a></div>");
				}
		// retourne la variable buffer contenant le code HTML à afficher
		return consult;
		}	
}
