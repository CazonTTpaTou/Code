var nombre=0;

//------------- Fonction utilis�e pour v�rifier la validit� des champs du formulaire d'inscription

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

if((f!="")&&(g!="")&&(f!=g)) {z++;h="Vous avez entr� deux mots de passe diff�rents";}

var d="Attention: " +c + " champs non remplis: " + d + "\n"+"Tous les champs doivent �tre compl�t�s !!!";

if (z==0) {alert("Formulaire correctement rempli");return true;}

else {if(h!="") {alert(h);}
      if(c!=0) {alert(d);}
	return false;}
}

//------------- Initialise le formulaire d'identification des profils en mettant le focus sur le premier champs
//------------- et emp�che le remplissage automatique des champs par le navigateur (ne fonctionne qu'avec IE)

function init() {

if (!document.getElementById) {return false;}
var f = document.getElementById('auto_off');
var u = f.elements[0];
f.setAttribute("autocomplete", "off");
u.focus();
} 

//------------- Affiche un message lorsque l'utilisateur cliaque sur le lien de D�connexion

function quit() {

alert("Merci de vous �tre connect� - A bient�t !!!");
}


//------------- Fonction qui envoie en boucle la requ�te asynchrone qui compare le n� du dernier message affich� par le navigateur et le
//------------- et le n� du dernier message ins�r� dans la base de donn�es du chat

function boucle() {
    requete('true');    
    setTimeout("boucle();", 5000);
}

//------------- Fonction qui va envoyer les instances de l'objet XHTLMRequest au serveur

function requete(meth) {

var xhr_object = null; 

//-------- On cr�e une instance de l'objet XMLHttpRequest selon le navigateur utilis� (Microsoft utilisant la technologie ActiveX
if(window.XMLHttpRequest) // Firefox 
   xhr_object = new XMLHttpRequest(); 
else if(window.ActiveXObject) // Internet Explorer 
   xhr_object = new ActiveXObject("Microsoft.XMLHTTP"); 
else { // XMLHttpRequest non support� par le navigateur 
   alert("Votre navigateur ne supporte pas les objets XMLHTTPRequest..."); 
   return; 
	} 

//-------- On ouvre une connexion asynchrone avec le serveur sur lequel on va lancer la requ�te Ajax2.php
//-------- Les param�tres de la requ�te seront transmis � Ajax.php par le biais de la m�thode POST

 
//-------- On attend de recevoir compl�tementla r�ponse � la requ�te au serveur pour exploiter le code renvoy�
//-------- par l'instance de XMLHttpRequest.
//-------- Selon la r�ponse renvoy�e par requete.php, un appel � la fonction javascript requete2 sera lanc�e
 
xhr_object.onreadystatechange = function() { 
  if(xhr_object.readyState == 4) if(xhr_object.status==200) {
					if(xhr_object.responseText==2) {requete2();}}}

//------------- si la  variable meth est � true, c'est que la fonction requete est appel�e depuis la fonction onload
//------------- de la balise body de la page principale Discussion.php. 
//------------- On envoie l'objet l'instance de l'objet XMLHttpRequest par la m�thode GET
//------------- Aucune donn�e ne sera donc envoy�e vers Ajax6.php

if (meth=='true') {xhr_object.open("GET", "Ajax6.php", true);  
		   xhr_object.send();}

//------------- si la  variable meth est � false, c'est que la fonction requete est appel�e depuis la fonction onsubmit
//------------- du formulaire d'envoi du message de la page principale Discussion.php. 
//------------- On envoie l'objet l'instance de l'objet XMLHttpRequest par la m�thode POST
//------------- Les donn�es contenues dans le Text Area du formulaire sont stock�es dans la variable u
//------------- pour �tre envoy�es vers Ajax6.php. 
//------------- Une fois son contenu envoy�, le Text Area du formulaire d'envoi est r�initialis�

if (meth=='false') {xhr_object.open("POST", "Ajax6.php", true); 
		   var f = document.getElementById('msg');
		   var u = f.elements[0];
		
		   request="mess="+escape(u.value);
		 
		   xhr_object.setRequestHeader("Content-type", "application/x-www-form-urlencoded"); 
    		   xhr_object.send(request);
    		   u.value="";
                   return false;}
}

//------------- fonction qui va envoyer une requ�te asynchrone pour r�cup�rer au format XML les messages de chat ins�r�s 
//------------- dans le base de donn�es et que le navigateur client n'a pas encore affich�

function requete2() {

var xhr = initRequete();
xhr.onreadystatechange = function() { 
  			if(xhr.readyState == 4) if(xhr.status==200) {
					//------------- R�cup�re les donn�es renvoy�es par l'instance de l'objet 
					//------------- XMLhttpRequest au format XML
					XMLDoc=xhr.responseXML;
					
					//------------- Appel de la fonction traiteXML qui va exploiter les donn�es XML
					//------------- pour les convertir en donn�es au format Xhtml et les ins�rer
					//------------- par l'entremise du DOM dans la section logique div 
					//------------- dont l'id est intitul�e "insertion"
					traiteXML(XMLDoc,"insertion");}
				  }

		//------------- Envoi de la requ�te asynchrone vers Ajax.php
		xhr.open("GET", "Ajax.php", true);  
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded"); 
		xhr.send();}

//------------- fonction fa�ade qui renvoie le texte contenu dans un �l�ment XML

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

//------------- fonction qui compte le nombre de messages de chat ins�r�s dans la base de donn�es
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

//------------- fonction qui la date d'enregistrement du dernier message de chat ins�r�s dans la base de donn�es
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


//------------- fonction qui va exploiter les donn�es XML pass�es en param�tre pour les convertir en donn�es 
//------------- au format Xhtml et les ins�rer par l'entremise du DOM dans la section logique div 
//------------- dont l'id est �galement pass�e en param�tre

function traiteXML (XMLDoc, id)
{	

	
	//------------- recherche l'ensemble des �l�ments avec un nom donn� (ici "Message") dans le document
	//------------- r�cup�re une NodeList => it�ration sur chacun des �l�ments
	var children = XMLDoc.getElementsByTagName("Message");
	if (children.length > 0) {
		for (var i = 0; i < children.length; i++) {
			var msg = children.item(i);

			//------------- teste si les sous-�l�ments recherch�s sont bien pr�sents dans chaque �l�ment "Message"
			if (msg.hasChildNodes() && msg.getElementsByTagName("Auteur").length == 1 && msg.getElementsByTagName("Texte").length == 1) {

				//------------- cr�e un �l�ment qui va contenir tout le message
				var ligne = document.createElement("div");
				
				//------------- cr�e un �l�ment span
				var numelt = document.createElement("span");
				var numtxt = document.createTextNode(getXMLTextContent(msg.getElementsByTagName("Numero").item(0)));
				//------------- place le noeud texte dans le contenu de l'�l�ment span
				numelt.appendChild(numtxt);
				//------------- cr�e structure XHTML pour l'affichage du num�ro du message
				ligne.appendChild(numelt);
				
				//------------- cr�e un �l�ment span
				var auteurelt = document.createElement("span");
				//------------- cr�e un noeud texte � partir des contenus du document XML (voir fonction getXMLTextContent plus haut)
				var auteurtxt = document.createTextNode(getXMLTextContent(msg.getElementsByTagName("Auteur").item(0)));
				//------------- place le noeud texte dans le contenu de l'�l�ment span
				auteurelt.appendChild(auteurtxt);
				//------------- cr�e la structure XHTML pour l'affichage du pseudo de l'auteur du message
				ligne.appendChild(auteurelt);
				
				//------------- cr�e un �l�ment span
				var heureelt = document.createElement("span");
				//------------- cr�e un noeud texte � partir des contenus du document XML (voir fonction getXMLTextContent plus haut)
				var heuretxt = document.createTextNode(getXMLTextContent(msg.getElementsByTagName("Heure").item(0)));
				//------------- place le noeud texte dans le contenu de l'�l�ment span
				heureelt.appendChild(heuretxt);
				//------------- cr�e la structure XHTML pour l'affichage de l'heure du message
				ligne.appendChild(heureelt);

				//rajoute un s�parateur (pour faire joli)
				//var separateur = document.createTextNode(" : ");
				//ligne.appendChild(separateur);

				
				//------------- cr�e un �l�ment span
				var contenuelt = document.createElement("span");
				//------------- cr�e un noeud texte � partir des contenus du document XML (voir fonction getXMLTextContent plus haut)
				var contenutxt = document.createTextNode(getXMLTextContent(msg.getElementsByTagName("Texte").item(0)));
				//------------- place le noeud texte dans le contenu de l'�l�ment span
				contenuelt.appendChild(contenutxt);
				//------------- cr�e la structure XHTML pour l'affichage du contenu du message
				ligne.appendChild(contenuelt);

				//------------- ajoute des propri�t�s de style � la ligne que l'on va ins�rer
				auteurelt.style.fontWeight = "bold";
				auteurelt.style.color="#8A2BE2";
				heureelt.style.fontWeight = "bold";
				heureelt.style.color="#8A2BE2";	
				numelt.style.fontWeight="bold";		

				//------------- place l'�l�ment qui contient tout le message � un endroit donn� du document, donn� par l'id pass� en param�tre
				
				document.getElementById(id).appendChild(ligne);

				//------------- Met � jour le noeud du nombre de messages post�s

				//combiens();

				//------------- Met � jour le noeud de l'heure du dernier message

				var heur=getXMLTextContent(msg.getElementsByTagName("Heure").item(0));
				var heurs=heur.substring(11,19);
				combien(heurs);

				//------------- Ins�re une ligne de s�paration entre les diff�rents messages post�s

				var ligne2 = document.createElement("div");
				
				var videelt = document.createElement("span");
				var videtxt = document.createTextNode("---------------------------------------------------------------------------");
				videelt.appendChild(videtxt);
				ligne2.appendChild(videelt);

				document.getElementById(id).appendChild(ligne2);

				//------------- Positionne l'acenseur tout en bas de la section d'insertion
				//------------- apr�s chaque nouvel ajout d'un message de chat

				document.getElementById(id).scrollTop = document.getElementById(id).scrollHeight;				
				
			} else {
				//si l'un des �l�ments "Message" n'a pas une structure convenable
				alert("Erreur dans la structure du document XML r�cup�r� : ");
			}
		}
	}
}

//------------- fonction fa�ade qui teste le type de navigateur 
//------------- et renvoie une instance d'un objet XMLHttpRequest capable de se charger de l'envoi de la requ�te.

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

