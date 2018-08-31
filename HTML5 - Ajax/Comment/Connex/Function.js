function message(a) {

var xhr_object = null; 

myDiv = document.getElementById("message");

//-------- On cr�e une instance de l'objet XMLHttpRequest selon le navigateur utilis� (Microsoft utilisant la technologie ActiveX
if(window.XMLHttpRequest) // Firefox 
   xhr_object = new XMLHttpRequest(); 
else if(window.ActiveXObject) // Internet Explorer 
   xhr_object = new ActiveXObject("Microsoft.XMLHTTP"); 
else { // XMLHttpRequest non support� par le navigateur 
   alert("Votre navigateur ne supporte pas les objets XMLHTTPRequest..."); 
   return; 
	} 

//-------- On ouvre une connexion asynchrone avec le serveur sur lequel on va lancer la requ�te Ajax.php
//-------- Les param�tres de la requ�te seront transmis � Ajax.php par le biais de la m�thode POST
xhr_object.open("POST", "Ajax.php", true); 
 
//-------- On attend de recevoir compl�tementla r�ponse � la requ�te au serveur pour exploiter le code renvoy�
//-------- par l'instance de XMLHttpRequest.
//-------- On ins�re par le biais de getElementbyId le code HTML re�u au sein de la balise d'Id Tableau dans le document 
xhr_object.onreadystatechange = function() { 
  if(xhr_object.readyState == 4) {document.getElementById("message").innerHTML=xhr_object.responseText;}} 
     
xhr_object.setRequestHeader("Content-type", "application/x-www-form-urlencoded"); 

//-------- On envoie les param�tres de tri � Ajax.php (c'est � dire l'Id de l'en t�te de champ sur lequel on a cliqu�)
var data = "number="+escape(a);
xhr_object.send(data); 
alert("Affichage du message n� "+a);
}
