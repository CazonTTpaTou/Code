function message(a) {

var xhr_object = null; 

myDiv = document.getElementById("message");

//-------- On crée une instance de l'objet XMLHttpRequest selon le navigateur utilisé (Microsoft utilisant la technologie ActiveX
if(window.XMLHttpRequest) // Firefox 
   xhr_object = new XMLHttpRequest(); 
else if(window.ActiveXObject) // Internet Explorer 
   xhr_object = new ActiveXObject("Microsoft.XMLHTTP"); 
else { // XMLHttpRequest non supporté par le navigateur 
   alert("Votre navigateur ne supporte pas les objets XMLHTTPRequest..."); 
   return; 
	} 

//-------- On ouvre une connexion asynchrone avec le serveur sur lequel on va lancer la requête Ajax.php
//-------- Les paramètres de la requête seront transmis à Ajax.php par le biais de la méthode POST
xhr_object.open("POST", "Ajax.php", true); 
 
//-------- On attend de recevoir complètementla réponse à la requête au serveur pour exploiter le code renvoyé
//-------- par l'instance de XMLHttpRequest.
//-------- On insère par le biais de getElementbyId le code HTML reçu au sein de la balise d'Id Tableau dans le document 
xhr_object.onreadystatechange = function() { 
  if(xhr_object.readyState == 4) {document.getElementById("message").innerHTML=xhr_object.responseText;}} 
     
xhr_object.setRequestHeader("Content-type", "application/x-www-form-urlencoded"); 

//-------- On envoie les paramètres de tri à Ajax.php (c'est à dire l'Id de l'en tête de champ sur lequel on a cliqué)
var data = "number="+escape(a);
xhr_object.send(data); 
alert("Affichage du message n° "+a);
}
