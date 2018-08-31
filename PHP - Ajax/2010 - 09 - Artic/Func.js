var nombre=0;

//------------- Fonction utilisée pour vérifier la validité des champs du formulaire d'inscription

function verif(frm) {

var a=frm.elements.length;
var c=0;
var e=" ";
var d="";
var f="";
var g="";
var h="";
var z=0;


for(var i=0;i<a;i++) {
	if(((frm.elements[i].type=="text") || (frm.elements[i].type=="password")) && (frm.elements[i].value=="")) {z++;c++;d=d+e+frm.elements[i].name;}
	if(c>=1) {e=" et ";}
	if((frm.elements[i].name=="MDP")) {f=frm.elements[i].value;}
	if((frm.elements[i].name=="MDP2")) {g=frm.elements[i].value;}}

if((f!="")&&(g!="")&&(f!=g)) {z++;h="Vous avez entré deux mots de passe différents";}

var d="Attention: " +c + " champs non remplis: " + d + "\n"+"Tous les champs doivent être complétés !!!";

if (z==0) {alert("Formulaire correctement rempli");return true;}

else {if(h!="") {alert(h);}
      if(c!=0) {alert(d);}
	return false;}
}

//------------- Initialise le formulaire d'identification des profils en mettant le focus sur le premier champs
//------------- et empêche le remplissage automatique des champs par le navigateur (ne fonctionne qu'avec IE)

function init() {

if (!document.getElementById) {return false;}
var f = document.getElementById('auto_off');
var u = f.elements[0];
f.setAttribute("autocomplete", "off");
u.focus();
} 

//------------- Affiche un message lorsque l'utilisateur cliaque sur le lien de Déconnexion

function quit() {

alert("Merci de vous être connecté - A bientôt !!!");
}


//------------- Fonction qui envoie en boucle la requête asynchrone qui compare le n° du dernier message affiché par le navigateur et le
//------------- et le n° du dernier message inséré dans la base de données du chat

function boucle() {
    requete('true');    
    setTimeout("boucle();", 5000);
}

//------------- Fonction qui va envoyer les instances de l'objet XHTLMRequest au serveur

function requete(meth) {

var xhr_object = null; 

//-------- On crée une instance de l'objet XMLHttpRequest selon le navigateur utilisé (Microsoft utilisant la technologie ActiveX
if(window.XMLHttpRequest) // Firefox 
   xhr_object = new XMLHttpRequest(); 
else if(window.ActiveXObject) // Internet Explorer 
   xhr_object = new ActiveXObject("Microsoft.XMLHTTP"); 
else { // XMLHttpRequest non supporté par le navigateur 
   alert("Votre navigateur ne supporte pas les objets XMLHTTPRequest..."); 
   return; 
	} 

//-------- On ouvre une connexion asynchrone avec le serveur sur lequel on va lancer la requête Ajax2.php
//-------- Les paramètres de la requête seront transmis à Ajax.php par le biais de la méthode POST

 
//-------- On attend de recevoir complètementla réponse à la requête au serveur pour exploiter le code renvoyé
//-------- par l'instance de XMLHttpRequest.
//-------- Selon la réponse renvoyée par requete.php, un appel à la fonction javascript requete2 sera lancée
 
xhr_object.onreadystatechange = function() { 
  if(xhr_object.readyState == 4) if(xhr_object.status==200) {
					if(xhr_object.responseText==2) {requete2();}}}

//------------- si la  variable meth est à true, c'est que la fonction requete est appelée depuis la fonction onload
//------------- de la balise body de la page principale Discussion.php. 
//------------- On envoie l'objet l'instance de l'objet XMLHttpRequest par la méthode GET
//------------- Aucune donnée ne sera donc envoyée vers Ajax6.php

if (meth=='true') {xhr_object.open("GET", "Ajax6.php", true);  
		   xhr_object.send();}

//------------- si la  variable meth est à false, c'est que la fonction requete est appelée depuis la fonction onsubmit
//------------- du formulaire d'envoi du message de la page principale Discussion.php. 
//------------- On envoie l'objet l'instance de l'objet XMLHttpRequest par la méthode POST
//------------- Les données contenues dans le Text Area du formulaire sont stockées dans la variable u
//------------- pour être envoyées vers Ajax6.php. 
//------------- Une fois son contenu envoyé, le Text Area du formulaire d'envoi est réinitialisé

if (meth=='false') {xhr_object.open("POST", "Ajax6.php", true); 
		   var f = document.getElementById('msg');
		   var u = f.elements[0];
		
		   request="mess="+escape(u.value);
		 
		   xhr_object.setRequestHeader("Content-type", "application/x-www-form-urlencoded"); 
    		   xhr_object.send(request);
    		   u.value="";
                   return false;}
}

//------------- fonction qui va envoyer une requête asynchrone pour récupérer au format XML les messages de chat insérés 
//------------- dans le base de données et que le navigateur client n'a pas encore affiché

function requete2() {

var xhr = initRequete();
xhr.onreadystatechange = function() { 
  			if(xhr.readyState == 4) if(xhr.status==200) {
					//------------- Récupère les données renvoyées par l'instance de l'objet 
					//------------- XMLhttpRequest au format XML
					XMLDoc=xhr.responseXML;
					
					//------------- Appel de la fonction traiteXML qui va exploiter les données XML
					//------------- pour les convertir en données au format Xhtml et les insérer
					//------------- par l'entremise du DOM dans la section logique div 
					//------------- dont l'id est intitulée "insertion"
					traiteXML(XMLDoc,"insertion");}
				  }

		//------------- Envoi de la requête asynchrone vers Ajax.php
		xhr.open("GET", "Ajax.php", true);  
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded"); 
		xhr.send();}

//------------- fonction façade qui renvoie le texte contenu dans un élément XML

function getXMLTextContent(source)
{
	if (source.textContent != null) {
		//Gecko
		return source.textContent;
	} else {
		//IE
		return source.text;
	}
}

//------------- fonction qui compte le nombre de messages de chat insérés dans la base de données
//------------- et qui affiche cette valeur dans le noeud correspondant par l'entremise du DOM

function combiens() {

var asc = document.getElementById("compteur");
	var a = asc.childNodes;
	var b = a.item(0);
	var c = b.nodeValue;
	nombre = Math.max(nombre, c++);
	nombre++;
	b.nodeValue = nombre;
	//alert("Bonjour");
	//alert(c);
	//alert(nombre);
	}

//------------- fonction qui la date d'enregistrement du dernier message de chat insérés dans la base de données
//------------- et qui affiche cette valeur dans le noeud correspondant par l'entremise du DOM

function combien(nombre) {

	var asc = document.getElementById("heure");
	var a = asc.childNodes;
	var b = a.item(0);
	b.nodeValue = nombre;
	//var c = b.nodeValue;
	//nombre = Math.max(nombre, c++);
	//nombre++;
	//b.nodeValue = c++;
	//alert("Bonjour");
	//alert(c);
	//alert(nombre);

	//var newChild = document.createElement("span");
	//var valeur = document.createTextNode(nombre);
	//newChild.appendChild(valeur);
	  
	//newChild.style.fontWeight = "bold";
	//newChild.style.fontFamily="arial,sans-serif";
	//newChild.style.fontSize="larger";
	//b.replaceChild(newChild, b);
	//asc.removeChild(b);
	//asc.appendChild(newChild);
	//asc.className = "norm";
	}


//------------- fonction qui va exploiter les données XML passées en paramètre pour les convertir en données 
//------------- au format Xhtml et les insérer par l'entremise du DOM dans la section logique div 
//------------- dont l'id est également passée en paramètre

function traiteXML (XMLDoc, id)
{	

	
	//------------- recherche l'ensemble des éléments avec un nom donné (ici "Message") dans le document
	//------------- récupère une NodeList => itération sur chacun des éléments
	var children = XMLDoc.getElementsByTagName("Message");
	if (children.length > 0) {
		for (var i = 0; i < children.length; i++) {
			var msg = children.item(i);

			//------------- teste si les sous-éléments recherchés sont bien présents dans chaque élément "Message"
			if (msg.hasChildNodes() && msg.getElementsByTagName("Auteur").length == 1 && msg.getElementsByTagName("Texte").length == 1) {

				//------------- crée un élément qui va contenir tout le message
				var ligne = document.createElement("div");
				
				//------------- crée un élément span
				var numelt = document.createElement("span");
				var numtxt = document.createTextNode(getXMLTextContent(msg.getElementsByTagName("Numero").item(0)));
				//------------- place le noeud texte dans le contenu de l'élément span
				numelt.appendChild(numtxt);
				//------------- crée structure XHTML pour l'affichage du numéro du message
				ligne.appendChild(numelt);
				
				//------------- crée un élément span
				var auteurelt = document.createElement("span");
				//------------- crée un noeud texte à partir des contenus du document XML (voir fonction getXMLTextContent plus haut)
				var auteurtxt = document.createTextNode(getXMLTextContent(msg.getElementsByTagName("Auteur").item(0)));
				//------------- place le noeud texte dans le contenu de l'élément span
				auteurelt.appendChild(auteurtxt);
				//------------- crée la structure XHTML pour l'affichage du pseudo de l'auteur du message
				ligne.appendChild(auteurelt);
				
				//------------- crée un élément span
				var heureelt = document.createElement("span");
				//------------- crée un noeud texte à partir des contenus du document XML (voir fonction getXMLTextContent plus haut)
				var heuretxt = document.createTextNode(getXMLTextContent(msg.getElementsByTagName("Heure").item(0)));
				//------------- place le noeud texte dans le contenu de l'élément span
				heureelt.appendChild(heuretxt);
				//------------- crée la structure XHTML pour l'affichage de l'heure du message
				ligne.appendChild(heureelt);

				//rajoute un séparateur (pour faire joli)
				//var separateur = document.createTextNode(" : ");
				//ligne.appendChild(separateur);

				
				//------------- crée un élément span
				var contenuelt = document.createElement("span");
				//------------- crée un noeud texte à partir des contenus du document XML (voir fonction getXMLTextContent plus haut)
				var contenutxt = document.createTextNode(getXMLTextContent(msg.getElementsByTagName("Texte").item(0)));
				//------------- place le noeud texte dans le contenu de l'élément span
				contenuelt.appendChild(contenutxt);
				//------------- crée la structure XHTML pour l'affichage du contenu du message
				ligne.appendChild(contenuelt);

				//------------- ajoute des propriétés de style à la ligne que l'on va insérer
				auteurelt.style.fontWeight = "bold";
				auteurelt.style.color="#8A2BE2";
				heureelt.style.fontWeight = "bold";
				heureelt.style.color="#8A2BE2";	
				numelt.style.fontWeight="bold";		

				//------------- place l'élément qui contient tout le message à un endroit donné du document, donné par l'id passé en paramètre
				
				document.getElementById(id).appendChild(ligne);

				//------------- Met à jour le noeud du nombre de messages postés

				//combiens();

				//------------- Met à jour le noeud de l'heure du dernier message

				var heur=getXMLTextContent(msg.getElementsByTagName("Heure").item(0));
				var heurs=heur.substring(11,19);
				combien(heurs);

				//------------- Insère une ligne de séparation entre les différents messages postés

				var ligne2 = document.createElement("div");
				
				var videelt = document.createElement("span");
				var videtxt = document.createTextNode("---------------------------------------------------------------------------");
				videelt.appendChild(videtxt);
				ligne2.appendChild(videelt);

				document.getElementById(id).appendChild(ligne2);

				//------------- Positionne l'acenseur tout en bas de la section d'insertion
				//------------- après chaque nouvel ajout d'un message de chat

				document.getElementById(id).scrollTop = document.getElementById(id).scrollHeight;				
				
			} else {
				//si l'un des éléments "Message" n'a pas une structure convenable
				alert("Erreur dans la structure du document XML récupéré : ");
			}
		}
	}
}

//------------- fonction façade qui teste le type de navigateur 
//------------- et renvoie une instance d'un objet XMLHttpRequest capable de se charger de l'envoi de la requête.

function initRequete()
{
    var xhr = null;
    if (window.XMLHttpRequest) { 
        xhr = new XMLHttpRequest();
    }
    else if (window.ActiveXObject) 
    {
        xhr = new ActiveXObject("Microsoft.XMLHTTP");
    }
	return xhr;
}

