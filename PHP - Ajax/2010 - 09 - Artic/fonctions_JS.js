var lig=0;
var lig_auteur=0;
var top=1;

//----------- Fonction qui rajoute des lignes produit

function Ajoute() {

var section='Lig_sup'+lig;
var a=encodeURIComponent(document.getElementById(section).value);

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
xhr_object.open("POST", "Ajax8.php", true); 
 
//-------- On attend de recevoir compl�tementla r�ponse � la requ�te au serveur pour exploiter le code renvoy�
//-------- par l'instance de XMLHttpRequest.
//-------- On ins�re par le biais de getElementbyId le code HTML re�u au sein de la balise d'Id Tableau dans le document 
xhr_object.onreadystatechange = function() { 
  if(xhr_object.readyState == 4) {document.getElementById(section).innerHTML=xhr_object.responseText;}} 
     
xhr_object.setRequestHeader("Content-type", "application/x-www-form-urlencoded"); 

//-------- On envoie les param�tres de tri � Ajax2.php (c'est � dire l'Id de l'en t�te de champ sur lequel on a cliqu�

lig++;
var section_f="Lig_sup"+lig;

var data = "Section="+escape(section_f);
xhr_object.send(data); 
//alert(data);
}

//----------- Fonction qui rajoute des lignes Auteur

function Ajoute_auteur() {

var section='Lig_sup'+lig_auteur;
var a=encodeURIComponent(document.getElementById(section).value);

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
xhr_object.open("POST", "Ajax10.php", true); 
 
//-------- On attend de recevoir compl�tementla r�ponse � la requ�te au serveur pour exploiter le code renvoy�
//-------- par l'instance de XMLHttpRequest.
//-------- On ins�re par le biais de getElementbyId le code HTML re�u au sein de la balise d'Id Tableau dans le document 
xhr_object.onreadystatechange = function() { 
  if(xhr_object.readyState == 4) {document.getElementById(section).innerHTML=xhr_object.responseText;}} 
     
xhr_object.setRequestHeader("Content-type", "application/x-www-form-urlencoded"); 

//-------- On envoie les param�tres de tri � Ajax2.php (c'est � dire l'Id de l'en t�te de champ sur lequel on a cliqu�

lig_auteur++;
var section_f="Lig_sup"+lig_auteur;

var data = "Section="+escape(section_f);
xhr_object.send(data); 
//alert(data);
}



function fonc_ISBN() {

var a=encodeURIComponent(document.getElementById("ville_id").value);

if(a.length!=17) {alert("Votre ISBN ne comporte pas 17 caract�res !!!");}
	else{

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
xhr_object.open("POST", "Ajax9.php", true); 
 
//-------- On attend de recevoir compl�tementla r�ponse � la requ�te au serveur pour exploiter le code renvoy�
//-------- par l'instance de XMLHttpRequest.
//-------- On ins�re par le biais de getElementbyId le code HTML re�u au sein de la balise d'Id Tableau dans le document 
xhr_object.onreadystatechange = function() { 
  if(xhr_object.readyState == 4) {if(xhr_object.responseText=='true') {alert("Votre num�ro ISBN est correct - il n\'est pas encore enregistr� dans la BDD !!!");}
				   else {alert("Votre num�ro ISBN n\'est pas unique car il existe d�j� dans la BDD !!! Recommencez !!!");
					 document.getElementById("ville_id").value='';
					 document.getElementById("ville_id").focus();}
				}} 
     
xhr_object.setRequestHeader("Content-type", "application/x-www-form-urlencoded"); 

//-------- On envoie les param�tres de tri � Ajax2.php (c'est � dire l'Id de l'en t�te de champ sur lequel on a cliqu�


var data = "ISBN="+escape(a);
xhr_object.send(data); 
//alert(data);

}}

//--------------------------------------------------------------------------------------------------------------------------
//-------- La fonction tri va nous permettre de trier le tableau sans recharger la page en instanciant la classe XMLHttpRequest

function tri(a) {

var xhr_object = null; 
alert('Tri sur la colonne ' + a);

myDiv = document.getElementById("tableau");

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
xhr_object.open("POST", "Ajax2.php", true); 
 
//-------- On attend de recevoir compl�tementla r�ponse � la requ�te au serveur pour exploiter le code renvoy�
//-------- par l'instance de XMLHttpRequest.
//-------- On ins�re par le biais de getElementbyId le code HTML re�u au sein de la balise d'Id Tableau dans le document 
xhr_object.onreadystatechange = function() { 
  if(xhr_object.readyState == 4) document.getElementById(a).innerHTML=xhr_object.responseText;} 
     
xhr_object.setRequestHeader("Content-type", "application/x-www-form-urlencoded"); 

//-------- On envoie les param�tres de tri � Ajax2.php (c'est � dire l'Id de l'en t�te de champ sur lequel on a cliqu�
var data = "family="+escape(a);
xhr_object.send(data); 
//alert(data);
}

//-----------------------------------------------------------------------------------------------------------------------------------------------------------------
//-------- La fonction choix va nous permettre d'afficher les sous menus en instanciant la classe XMLHttpRequest


function choix(a) {

var xhr_object = null; 
var b="";

b=a+"1";
//alert(b);
//alert('Tri sur la colonne ' + a);

myDiv = document.getElementById("tableau");

//-------- On cr�e une instance de l'objet XMLHttpRequest selon le navigateur utilis� (Microsoft utilisant la technologie ActiveX
if(window.XMLHttpRequest) // Firefox 
   xhr_object = new XMLHttpRequest(); 
else if(window.ActiveXObject) // Internet Explorer 
   xhr_object = new ActiveXObject("Microsoft.XMLHTTP"); 
else { // XMLHttpRequest non support� par le navigateur 
   alert("Votre navigateur ne supporte pas les objets XMLHTTPRequest..."); 
   return; 
	} 

//-------- On ouvre une connexion asynchrone avec le serveur sur lequel on va lancer la requ�te Ajax3.php
//-------- Les param�tres de la requ�te seront transmis � Ajax3.php par le biais de la m�thode POST
xhr_object.open("POST", "Ajax3.php", true); 
 
//-------- On attend de recevoir compl�tement la r�ponse � la requ�te au serveur pour exploiter le code renvoy�
//-------- par l'instance de XMLHttpRequest.
//-------- On ins�re par le biais de getElementbyId le code HTML re�u au sein de la balise d'Id Tableau dans le document 
xhr_object.onreadystatechange = function() { 
  if(xhr_object.readyState == 4) document.getElementById("Menu_M").innerHTML=xhr_object.responseText;} 
     
xhr_object.setRequestHeader("Content-type", "application/x-www-form-urlencoded"); 

//-------- On envoie les param�tres de tri � Ajax3.php (c'est � dire l'Id de l'en t�te de champ sur lequel on a cliqu�
var data = "family="+escape(a);
xhr_object.send(data); 
//alert(data);
}

//--------------------------------------------------------------------------------------------------------------------------
//-------- La fonction eff va nous permettre d'effacer le sous menu sans recharger la page en instanciant la classe XMLHttpRequest

function eff(b) {

document.getElementById(b).value="";

}

//--------------------------------------------------------------------------------------------------------------------------
//-------- La fonction client va nous permettre d'afficher des propositions en fonction des param�tres rentr�s 
	
function client(frm) {

var xhr_object = null; 

var a=encodeURIComponent(document.getElementById("champC").value);
var b=encodeURIComponent(document.getElementById("champP").value);
var c=encodeURIComponent(document.getElementById("Departement_id").value);
if(frm) {var d=frm;}
	else {var d='inconnu';}

//var a=frm.elements.length;
//for(var i=0;i<a;i++) {
//	if(frm.elements[i].name=="N_Client") {a=frm.elements[i].value;}
//	if(frm.elements[i].name=="Code_Postal") {b=frm.elements[i].value;}
//	if(frm.elements[i].name=="departement") {c=frm.elements[i].value;}}

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
xhr_object.open("POST", "Ajax4.php", true); 
 
//-------- On attend de recevoir compl�tementla r�ponse � la requ�te au serveur pour exploiter le code renvoy�
//-------- par l'instance de XMLHttpRequest.
//-------- On ins�re par le biais de getElementbyId le code HTML re�u au sein de la balise d'Id Tableau dans le document 
xhr_object.onreadystatechange = function() { 
  if(xhr_object.readyState == 4) document.getElementById("Liste_C").innerHTML=xhr_object.responseText;} 
     
xhr_object.setRequestHeader("Content-type", "application/x-www-form-urlencoded"); 

//-------- On envoie les param�tres de tri � Ajax2.php (c'est � dire l'Id de l'en t�te de champ sur lequel on a cliqu�
var data = "Client="+escape(a)+"&Postal="+escape(b)+"&Departement="+escape(c)+"&Ordre="+escape(d);
xhr_object.send(data); 
if ((d!='') && (d!='inconnu')) {alert('Tri sur la colonne '+d);}

return false;

}

//--------------------------------------------------------------------------------------------------------------------------
//-------- La fonction num_c va nous permettre de v�rifier la viabilit� du num�ro client 
		
function num_c() {

var xhr_object = null; 

var a=encodeURIComponent(document.getElementById("C_client").value);
//alert(a);

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
xhr_object.open("POST", "Ajax5.php", true); 
 
//-------- On attend de recevoir compl�tementla r�ponse � la requ�te au serveur pour exploiter le code renvoy�
//-------- par l'instance de XMLHttpRequest.
//-------- On ins�re par le biais de getElementbyId le code HTML re�u au sein de la balise d'Id Tableau dans le document 
xhr_object.onreadystatechange = function() { 
  if(xhr_object.readyState == 4) alert(xhr_object.responseText);} 
     
xhr_object.setRequestHeader("Content-type", "application/x-www-form-urlencoded"); 

//-------- On envoie les param�tres de tri � Ajax2.php (c'est � dire l'Id de l'en t�te de champ sur lequel on a cliqu�
var data = "Client="+escape(a);
xhr_object.send(data); 
}

//--------------------------------------------------------------------------------------------------------------------------
//-------- La fonction num_co va nous permettre de v�rifier la viabilit� du num�ro de commande 
	
function num_co() {

var xhr_object = null; 

var a=encodeURIComponent(document.getElementById("C_commande").value);
//alert(a);
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
xhr_object.open("POST", "Ajax7.php", true); 
 
//-------- On attend de recevoir compl�tementla r�ponse � la requ�te au serveur pour exploiter le code renvoy�
//-------- par l'instance de XMLHttpRequest.
//-------- On ins�re par le biais de getElementbyId le code HTML re�u au sein de la balise d'Id Tableau dans le document 
xhr_object.onreadystatechange = function() { 
  if(xhr_object.readyState == 4) document.getElementById("Liste_C").innerHTML=xhr_object.responseText;} 
     
xhr_object.setRequestHeader("Content-type", "application/x-www-form-urlencoded"); 

//-------- On envoie les param�tres de tri � Ajax2.php (c'est � dire l'Id de l'en t�te de champ sur lequel on a cliqu�
var data = "Client="+escape(a);
xhr_object.send(data); 
}


//--------------------------------------------------------------------------------------------------------------------------
//-------- La fonction commande va nous permettre d'afficher des propositions en fonction des param�tres rentr�s 
	
function commande(frm) {

var xhr_object = null; 

var a=encodeURIComponent(document.getElementById("C_client").value);
var b=encodeURIComponent(document.getElementById("champP").value);
var c=encodeURIComponent(document.getElementById("champD").value);
var e=encodeURIComponent(document.getElementById("champF").value);
var f=encodeURIComponent(document.getElementById("Operateur_id").value);

if(frm) {var d=frm;}
	else {var d='inconnu';}

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
xhr_object.open("POST", "Ajax6.php", true); 
 
//-------- On attend de recevoir compl�tementla r�ponse � la requ�te au serveur pour exploiter le code renvoy�
//-------- par l'instance de XMLHttpRequest.
//-------- On ins�re par le biais de getElementbyId le code HTML re�u au sein de la balise d'Id Tableau dans le document 
xhr_object.onreadystatechange = function() { 
  if(xhr_object.readyState == 4) document.getElementById("Liste_C").innerHTML=xhr_object.responseText;} 
     
xhr_object.setRequestHeader("Content-type", "application/x-www-form-urlencoded"); 

//-------- On envoie les param�tres de tri � Ajax2.php (c'est � dire l'Id de l'en t�te de champ sur lequel on a cliqu�
var data = "Client="+escape(a)+"&Commande="+escape(b)+"&Date_d="+escape(c)+"&Date_f="+escape(e)+"&Operateur="+encodeURI(f)+"&Ordre="+escape(d);
xhr_object.send(data); 
if ((d!='') && (d!='inconnu')) {alert('Tri sur la colonne '+d);}

return false;

}

//--------------------------------------------------------------------------------------------------------------------------
//-------- La fonction auteur va nous permettre d'afficher des propositions en fonction des param�tres rentr�s 
	
function auteur(frm) {

var xhr_object = null; 

var a=encodeURIComponent(document.getElementById("C_client").value);
var b=encodeURIComponent(document.getElementById("champP").value);
var c=encodeURIComponent(document.getElementById("champD").value);
var e=encodeURIComponent(document.getElementById("champF").value);
//var f=encodeURIComponent(document.getElementById("Operateur_id").value);

if(frm) {var d=frm;}
	else {var d='inconnu';}

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
xhr_object.open("POST", "Ajax11.php", true); 
 
//-------- On attend de recevoir compl�tementla r�ponse � la requ�te au serveur pour exploiter le code renvoy�
//-------- par l'instance de XMLHttpRequest.
//-------- On ins�re par le biais de getElementbyId le code HTML re�u au sein de la balise d'Id Tableau dans le document 
xhr_object.onreadystatechange = function() { 
  if(xhr_object.readyState == 4) document.getElementById("Liste_C").innerHTML=xhr_object.responseText;} 
     
xhr_object.setRequestHeader("Content-type", "application/x-www-form-urlencoded"); 

//-------- On envoie les param�tres de tri � Ajax2.php (c'est � dire l'Id de l'en t�te de champ sur lequel on a cliqu�
var data = "Client="+escape(a)+"&Commande="+escape(b)+"&Date_d="+escape(c)+"&Date_f="+escape(e)+"&Ordre="+escape(d);
xhr_object.send(data); 
if ((d!='') && (d!='inconnu')) {alert('Tri sur la colonne '+d);}

return false;

}

//--------------------------------------------------------------------------------------------------------------------------
//-------- La fonction livre va nous permettre d'afficher des propositions en fonction des param�tres rentr�s 
	
function livre(frm) {

var xhr_object = null; 

var a=encodeURIComponent(document.getElementById("C_client").value);
var b=encodeURIComponent(document.getElementById("champP").value);
var c=encodeURIComponent(document.getElementById("champD").value);
var e=encodeURIComponent(document.getElementById("champF").value);
var f=encodeURIComponent(document.getElementById("Operateur_id").value);

if(frm) {var d=frm;}
	else {var d='inconnu';}

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
xhr_object.open("POST", "Ajax12.php", true); 
 
//-------- On attend de recevoir compl�tementla r�ponse � la requ�te au serveur pour exploiter le code renvoy�
//-------- par l'instance de XMLHttpRequest.
//-------- On ins�re par le biais de getElementbyId le code HTML re�u au sein de la balise d'Id Tableau dans le document 
xhr_object.onreadystatechange = function() { 
  if(xhr_object.readyState == 4) document.getElementById("Liste_C").innerHTML=xhr_object.responseText;} 
     
xhr_object.setRequestHeader("Content-type", "application/x-www-form-urlencoded"); 

//-------- On envoie les param�tres de tri � Ajax2.php (c'est � dire l'Id de l'en t�te de champ sur lequel on a cliqu�
var data = "Client="+escape(a)+"&Commande="+escape(b)+"&Date_d="+escape(c)+"&Date_f="+escape(e)+"&Operateur="+encodeURI(f)+"&Ordre="+escape(d);
xhr_object.send(data); 
if ((d!='') && (d!='inconnu')) {alert('Tri sur la colonne '+d);}

return false;

}

//------------ Fonction qui v�rifie qu'un signe comparatif a bien �t� rentr�

function signe() {

var a=encodeURIComponent(document.getElementById("champP").value);

if ((a[0]!='>') && (a[0]!='<') && (a[0]!='=')) {alert('Vous devez rentrer un op�rateur de comparaison de type < > = comme premier caract�re');} 

}

//------------ Fonction qui v�rifie le code postal rentr�

function CP(a) {

cp=document.getElementById(a).value;

if (cp.length!=5) {alert("Votre code postal :"+cp+" ne comporte pas 5 chiffres !!!");
	return false;}

	else {return true;}

	}

function filtre(a,b,c) {

var message1="";
var message2="";
var message3="";
var num=0;
var nom=document.getElementById(a).value;
var cp=document.getElementById(b).value;
var ville=document.getElementById(c).value;

if (nom.length==0) {message1="Le nom n'a pas �t� rempli - ";num++;}
if (cp.length!=5) {message2="Votre code postal :"+cp+" ne comporte pas 5 chiffres - ";num++;}
if (ville.length==0) {message3="La ville n'a pas �t� saisie - ";num++;}

if (num!=0) {
	if(num>1) {var s='s'} 
		else {var s='';}
	var message_F="Attention !!! "+num+" anomalie"+s+" : "+message1+message2+message3;
	alert(message_F);
	return false;}

	else{return true;}
}


function filtre_livre(a,b,c) {

var message1="";
var message2="";
var message3="";
var num=0;
var nom=document.getElementById(a).value;
var cp=document.getElementById(b).value;
var ville=document.getElementById(c).value;

if (nom.length==0) {message1="Le titre n'a pas �t� rempli - ";num++;}
if (ville.length!=17) {message2="Votre ISBN :"+cp+" ne comporte pas 17 caract�res- ";num++;}
if (cp.length==0) {message3="Le prix n'a pas �t� saisi - ";num++;}

if (num!=0) {
	if(num>1) {var s='s'} 
		else {var s='';}
	var message_F="Attention !!! "+num+" anomalie"+s+" : "+message1+message2+message3;
	alert(message_F);
	return false;}

	else{return true;}
}

function filtre_auteur(a,b) {

var message1="";
var message2="";
var num=0;
var nom=document.getElementById(a).value;
var cp=document.getElementById(b).value;

if (nom.length==0) {message1="Le nom de l'auteur n'a pas �t� rempli - ";num++;}
if (cp.length==0) {message3="Le pr�nom de l'auteur n'a pas �t� saisi - ";num++;}

if (num!=0) {
	if(num>1) {var s='s'} 
		else {var s='';}
	var message_F="Attention !!! "+num+" anomalie"+s+" : "+message1+message2+message3;
	alert(message_F);
	return false;}

	else{return true;}
}

//--------------------------------------------------------------------------------------------------------
//-------- Fonction qui va v�rifier que tous les champs sont conformes avant la validation d'un formulaire:
//-------- Que chaque champ soit non vide
//-------- Que le champ code postal comporte 5 caract�res
//-------- Que le champ t�l�phone comporte 10 caract�res
//-------- Que le champ date soit conforme � la syntaxe ad�quate

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
	if((frm.elements[i].type=="text" || frm.elements[i].type=="textarea" || frm.elements[i].type=="select-one") && (frm.elements[i].value=="")) {++z;c++;d=d+e+frm.elements[i].name;}
	if(c>=1) {e=" et ";}
	if((frm.elements[i].name=="codepostal") && (frm.elements[i].value.length!=5)) {++z;f="Le code postal doit comporter 5 chiffres";}
	if((frm.elements[i].name=="telephone") && (frm.elements[i].value.length!=10)) {++z;g="Le num�ro de t�l�phone doit comporter 10 chiffres";}
	if((frm.elements[i].name=="date") && (datum(frm.elements[i].value))) {++z;h="La date doit �tre au format aaaa-mm-jj";}}

var d="Attention: " +c + " champs non remplis: " + d + "\n"+"Tous les champs doivent �tre compl�t�s !!!";

if (z==0) {alert("Formulaire correctement rempli");return true;}
else {if(f!="") {alert(f);}
      if(c!=0) {alert(d);}
      if(g!="") {alert(g);}
      if(h!="") {alert(h);}
	return false;}
}


//--------------------------------------------------------------------------------------------------------
//-------- Fonction qui va emp�cher l'utilisateur de rentrer autre chose que des chiffres dans le champ concern�

function numbers(a) {

if (a.which==13 || a.which==8 || a.which==0) {return true;}
else {if (a.which<48 || a.which>57) {alert('Veuillez rentrer uniquement des chiffres');return false;}}

if (a.keycode==13 || a.keycode==8 || a.keycode==0) {return true;}
else {if (a.keycode<48 || a.keycode>57) {alert('Veuillez rentrer uniquement des chiffres');return false;}}

}


//--------------------------------------------------------------------------------------------------------
//-------- Fonction qui va emp�cher l'utilisateur de rentrer autre chose que des chiffres dans le champ concern�
//-------- mais qui autorise la virgule pour pouvoir saisir un nombre d�cimal

function numbers_dec(a) {

if (a.which==13 || a.which==8 || a.which==0 || a.which==46) {return true;}
else {if (a.which<48 || a.which>57) {alert('Veuillez rentrer uniquement des chiffres');return false;}}

if (a.keycode==13 || a.keycode==8 || a.keycode==0 || a.keycode==46) {return true;}
else {if (a.keycode<48 || a.keycode>57) {alert('Veuillez rentrer uniquement des chiffres');return false;}}

}

//--------------------------------------------------------------------------------------------------------
//-------- Fonction qui va emp�cher l'utilisateur de rentrer autre chose que des chiffres dans le champ concern�
//-------- mais qui autorise le tiret pour pouvoir saisir une date au format aaaa-mm-jj

function numbers_dat(a) {

if (a.which==13 || a.which==8 || a.which==0 || a.which==46 || a.which==45) {return true;}
else {if (a.which<48 || a.which>57) {alert('Veuillez rentrer uniquement des chiffres');return false;}}

if (a.keycode==13 || a.keycode==8 || a.keycode==0 || a.keycode==46 || a.keycode==45) {return true;}
else {if (a.keycode<48 || a.keycode>57) {alert('Veuillez rentrer uniquement des chiffres');return false;}}

}

function Datim(a) {

var c=encodeURIComponent(document.getElementById(a).value);
if(c.length!=10) {alert("Votre date doit �tre au format aaaa-mm-jj !!! ");}
datum(c);

}


//--------------------------------------------------------------------------------------------------------
//-------- Fonction qui va v�rifier que l'expression rentr�e dans un champ date respecte bien la syntaxe suivante
//-------- chiffre chiffre chiffre chiffre - chiffre chiffre - chiffre chiffre


function datum(a) {
var exp = new RegExp("^[0-9]{4,4}[-][0-9]{2,2}[-][0-9]{2,2}$");
if (!exp.test(a)) {return true;}
  else{return date_existe(a);}}

//--------------------------------------------------------------------------------------------------------
//-------- Fonction qui va v�rifier que l'expression que les jours, mois et ann�e sont coh�rents. Par exemple,
//-------- qu'un jour rentr� ne soit pas �gal � 60, ou un mois �gal � 0.

function date_existe(a) {
       var annee=a.substring(0,4);
       var mois=a.substring(5,7);
       var jour=a.substring(8,10);
	
	if((annee>2100) || (annee<-2000) || (jour<1) || (jour>31) || (mois<1) || (mois>12)) 
		{alert('La date rentr�e est fantaisiste - Recommencez !!!');return true;}
        else {return date_existe2(a,annee,mois,jour);}}

//--------------------------------------------------------------------------------------------------------
//-------- Fonction qui va v�rifier que la date rentr�e par l'utilisateur existe, en cr�ant une instance date
//-------- � partir des nombres saisis dans le champ. Si l'instance date cr�e est �gale � la date effectivement
//-------- rentr�, c'est que la date est bien dans le calendrier, sinon un message d'erreur est envoy�
//-------- Par exemple, si l'utilisateur rentre 2000-11-31, l'instance date cr��e � partir de 2000, 11 et 31
//-------- va renvoyer la date du 1er d�cembre, qui sera donc diff�rente de la cha�ne saisie initialement,
//-------- ce qui renverra un return false qui emp�chera le formulaire de se valider.

function date_existe2(a,annee,mois,jour) {
		var d2=new Date(annee,mois-1,jour);
        		 j2=d2.getDate();
        		 m2=d2.getMonth()+1;
        		 a2=d2.getFullYear();
        		 if (a2<=100) {a2=1900+a2;}
        		 if ( (jour!=j2)||(mois!=m2)||(annee!=a2) ) 
        		    {alert("La date " + a +" n'existe pas !!!");return true;}
				else {return false;}}


function coloriage(cel) {

var cont='';
cont=document.getElementById(cel).value;

if((cont!='') && (cont!='quantit�')) {
	myDiv = document.getElementById(cel);
	myDiv.className = "colorus3";}

if((cont=='') || (cont=='quantit�')) {
	myDiv = document.getElementById(cel);
	myDiv.className = "colorus2";}
}

function Deroule(champ) {

var ligs=lig+1;
var menu ='P_num_id'+ligs;
var is = document.getElementById(champ).value;
//alert(menu);
if(document.getElementById(champ).value!='') {
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
xhr_object.open("POST", "Ajax13.php", true); 
 
//-------- On attend de recevoir compl�tementla r�ponse � la requ�te au serveur pour exploiter le code renvoy�
//-------- par l'instance de XMLHttpRequest.
//-------- On ins�re par le biais de getElementbyId le code HTML re�u au sein de la balise d'Id Tableau dans le document 
xhr_object.onreadystatechange = function() { 
  if(xhr_object.readyState == 4) document.getElementById(menu).innerHTML=xhr_object.responseText;} 
     
xhr_object.setRequestHeader("Content-type", "application/x-www-form-urlencoded"); 

//-------- On envoie les param�tres de tri � Ajax2.php (c'est � dire l'Id de l'en t�te de champ sur lequel on a cliqu�
var data = "isbn="+escape(is)+"&num="+escape(lig);
xhr_object.send(data); }

}
	
//--------------------------------------------------------------------------------------------------------------------------
//-------- La fonction npai va nous permettre d'afficher les noms clients rentr�s correspondant aux n� de NPAI
	
function npai(frm) {

var xhr_object = null; 

var a=document.getElementById(frm).value;

if(frm) {var d=frm;}
	else {var d='inconnu';}

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
xhr_object.open("POST", "Ajax14.php", true); 
 
//-------- On attend de recevoir compl�tementla r�ponse � la requ�te au serveur pour exploiter le code renvoy�
//-------- par l'instance de XMLHttpRequest.
//-------- On ins�re par le biais de getElementbyId le code HTML re�u au sein de la balise d'Id Tableau dans le document 
xhr_object.onreadystatechange = function() { 
  if(xhr_object.readyState == 4) document.getElementById("Liste_C").innerHTML=xhr_object.responseText;} 
     
xhr_object.setRequestHeader("Content-type", "application/x-www-form-urlencoded"); 

//-------- On envoie les param�tres de tri � Ajax2.php (c'est � dire l'Id de l'en t�te de champ sur lequel on a cliqu�
var data = "Client="+escape(a);
xhr_object.send(data); 

return false;

}
	
function clustre(frm) {

	myDiv = document.getElementById(frm);
	myDiv.className = "colorus4";
	window.open(frm);}

//--------------------------------------------------------------------------------------------------------------------------
//-------- La fonction exp�dition va nous permettre d'afficher des propositions en fonction des param�tres rentr�s 
	
function expedition(frm) {

var xhr_object = null; 

var a=encodeURIComponent(document.getElementById("C_commande").value);
var b=encodeURIComponent(document.getElementById("champP").value);
var c=encodeURIComponent(document.getElementById("champD").value);
var e=encodeURIComponent(document.getElementById("champF").value);
var f=encodeURIComponent(document.getElementById("Operateur_id").value);

if(frm) {var d=frm;}
	else {var d='inconnu';}

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
xhr_object.open("POST", "Ajax16.php", true); 
 
//-------- On attend de recevoir compl�tementla r�ponse � la requ�te au serveur pour exploiter le code renvoy�
//-------- par l'instance de XMLHttpRequest.
//-------- On ins�re par le biais de getElementbyId le code HTML re�u au sein de la balise d'Id Tableau dans le document 
xhr_object.onreadystatechange = function() { 
  if(xhr_object.readyState == 4) document.getElementById("Liste_C").innerHTML=xhr_object.responseText;} 
     
xhr_object.setRequestHeader("Content-type", "application/x-www-form-urlencoded"); 

//-------- On envoie les param�tres de tri � Ajax2.php (c'est � dire l'Id de l'en t�te de champ sur lequel on a cliqu�
var data = "Client="+escape(a)+"&Commande="+escape(b)+"&Date_d="+escape(c)+"&Date_f="+escape(e)+"&Operateur="+encodeURI(f)+"&Ordre="+escape(d);
xhr_object.send(data); 
if ((d!='') && (d!='inconnu')) {alert('Tri sur la colonne '+d);}

return false;

}

//--------------------------------------------------------------------------------------------------------------------------
//-------- La fonction exp�dition va nous permettre d'afficher des propositions en fonction des param�tres rentr�s 
	
function expedition_r(frm) {

var xhr_object = null; 

var a=encodeURIComponent(document.getElementById("C_commande").value);
var b=encodeURIComponent(document.getElementById("champP").value);
var c=encodeURIComponent(document.getElementById("champD").value);
var e=encodeURIComponent(document.getElementById("champF").value);
var f=encodeURIComponent(document.getElementById("Operateur_id").value);

var g=encodeURIComponent(document.getElementById("N_client").value);
var h=encodeURIComponent(document.getElementById("CP_client").value);
var i=encodeURIComponent(document.getElementById("C_client").value);
//var j=encodeURIComponent(document.getElementById("C_commande").value);

if(frm) {var d=frm;}
	else {var d='inconnu';}

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
xhr_object.open("POST", "Ajax17.php", true); 
 
//-------- On attend de recevoir compl�tementla r�ponse � la requ�te au serveur pour exploiter le code renvoy�
//-------- par l'instance de XMLHttpRequest.
//-------- On ins�re par le biais de getElementbyId le code HTML re�u au sein de la balise d'Id Tableau dans le document 
xhr_object.onreadystatechange = function() { 
  if(xhr_object.readyState == 4) document.getElementById("Liste_C").innerHTML=xhr_object.responseText;} 
     
xhr_object.setRequestHeader("Content-type", "application/x-www-form-urlencoded"); 

//-------- On envoie les param�tres de tri � Ajax2.php (c'est � dire l'Id de l'en t�te de champ sur lequel on a cliqu�
var data = "Client="+escape(a)+"&Commande="+escape(b)+"&Date_d="+escape(c)+"&Date_f="+escape(e)+"&Operateur="+encodeURI(f)+"&Ordre="+escape(d)+"&Nom="+escape(g)+"&CP="+escape(h)+"&Code_C="+escape(i);
xhr_object.send(data); 
if ((d!='') && (d!='inconnu')) {alert('Tri sur la colonne '+d);}

return false;

}

//--------------------------------------------------------------------------------------------------------------------------
//-------- La fonction datest va nous permettre de reconstituer une date compl�te
	
function datest(frm) {

var xhr_object = null; 

var aa="Jour"+frm;
var bb="Mois"+frm;
var cc="Annee"+frm;

var a=encodeURIComponent(document.getElementById(aa).value);
var b=encodeURIComponent(document.getElementById(bb).value);
var c=encodeURIComponent(document.getElementById(cc).value);

//alert("date"+a+b+c);

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
xhr_object.open("POST", "Ajax18.php", true); 
 
//-------- On attend de recevoir compl�tementla r�ponse � la requ�te au serveur pour exploiter le code renvoy�
//-------- par l'instance de XMLHttpRequest.
//-------- On ins�re par le biais de getElementbyId le code HTML re�u au sein de la balise d'Id Tableau dans le document 
xhr_object.onreadystatechange = function() { 
  if(xhr_object.readyState == 4) {document.getElementById(frm).value=xhr_object.responseText;}} 
     
xhr_object.setRequestHeader("Content-type", "application/x-www-form-urlencoded"); 

//-------- On envoie les param�tres de tri � Ajax2.php (c'est � dire l'Id de l'en t�te de champ sur lequel on a cliqu�
var data = "Jour="+escape(a)+"&Mois="+escape(b)+"&Annee="+escape(c);
xhr_object.send(data); 

return false;

}

// Fonction qui va proposer un choix des commentaires

function Deroules(champ) {

//var ligs=lig+1;
var menu ='P_num_id'+champ;
var lig=champ;
var is = document.getElementById(champ).value;
//alert(menu);
if(document.getElementById(champ).value!='') {
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
xhr_object.open("POST", "Ajax20.php", true); 
 
//-------- On attend de recevoir compl�tementla r�ponse � la requ�te au serveur pour exploiter le code renvoy�
//-------- par l'instance de XMLHttpRequest.
//-------- On ins�re par le biais de getElementbyId le code HTML re�u au sein de la balise d'Id Tableau dans le document 
xhr_object.onreadystatechange = function() { 
  if(xhr_object.readyState == 4) document.getElementById(menu).innerHTML=xhr_object.responseText;} 
     
xhr_object.setRequestHeader("Content-type", "application/x-www-form-urlencoded"); 

//-------- On envoie les param�tres de tri � Ajax2.php (c'est � dire l'Id de l'en t�te de champ sur lequel on a cliqu�
var data = "isbn="+escape(is)+"&num="+escape(lig);
xhr_object.send(data); }

}
	
function Commentaires(champ) {

//var ligs=lig+1;
var menu ='1000_'+champ;
var ligs='Meni'+champ;
var lig=champ;
var is = document.getElementById(ligs).value;
alert("ligs="+ligs+"is="+is);
//alert(menu);
if(document.getElementById(champ).value!='') {
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
xhr_object.open("POST", "Ajax19.php", true); 
 
//-------- On attend de recevoir compl�tementla r�ponse � la requ�te au serveur pour exploiter le code renvoy�
//-------- par l'instance de XMLHttpRequest.
//-------- On ins�re par le biais de getElementbyId le code HTML re�u au sein de la balise d'Id Tableau dans le document 
xhr_object.onreadystatechange = function() { 
  if(xhr_object.readyState == 4) {alert(xhr_object.responseText);document.getElementById(menu).innerHTML=xhr_object.responseText;}}
     
xhr_object.setRequestHeader("Content-type", "application/x-www-form-urlencoded"); 

//-------- On envoie les param�tres de tri � Ajax2.php (c'est � dire l'Id de l'en t�te de champ sur lequel on a cliqu�
var data = "isbn="+escape(is)+"&num="+escape(lig);
xhr_object.send(data); }

}

function Commentaires_R(champ) {

//var ligs=lig+1;
var lig=champ.substring(4);
var menu ="1000_"+lig;
var ligs='Meni'+lig;

var is = document.getElementById(ligs).value;
//alert("lig="+lig+" ligs="+ligs+" isbn="+is);
//alert(menu);

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
xhr_object.open("POST", "Ajax19.php", true); 
 
//-------- On attend de recevoir compl�tementla r�ponse � la requ�te au serveur pour exploiter le code renvoy�
//-------- par l'instance de XMLHttpRequest.
//-------- On ins�re par le biais de getElementbyId le code HTML re�u au sein de la balise d'Id Tableau dans le document 
xhr_object.onreadystatechange = function() { 
  if(xhr_object.readyState == 4) {document.getElementById(menu).innerHTML=xhr_object.responseText;}} 
     
xhr_object.setRequestHeader("Content-type", "application/x-www-form-urlencoded"); 

//-------- On envoie les param�tres de tri � Ajax2.php (c'est � dire l'Id de l'en t�te de champ sur lequel on a cliqu�
var data = "isbn="+escape(is)+"&num="+escape(lig);
//alert(data);
xhr_object.send(data); 

}
	
function aperco(champ) {

//var ligs=lig+1;
var lig=champ.substring(4);
var menu ='Meni'+lig;
var ligs='Menu'+lig;

var isb=document.getElementById(menu).value;
var is = document.getElementById(ligs).value;
//alert("is="+is);
//alert(menu);
if(document.getElementById(champ).value!='') {
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
xhr_object.open("POST", "Ajax21.php", true); 
 
//-------- On attend de recevoir compl�tementla r�ponse � la requ�te au serveur pour exploiter le code renvoy�
//-------- par l'instance de XMLHttpRequest.
//-------- On ins�re par le biais de getElementbyId le code HTML re�u au sein de la balise d'Id Tableau dans le document 
xhr_object.onreadystatechange = function() { 
  if(xhr_object.readyState == 4) alert(xhr_object.responseText);} 
     
xhr_object.setRequestHeader("Content-type", "application/x-www-form-urlencoded"); 

//-------- On envoie les param�tres de tri � Ajax2.php (c'est � dire l'Id de l'en t�te de champ sur lequel on a cliqu�
var data = "isbn="+escape(isb)+"&num="+escape(is);
xhr_object.send(data); }

}
	
//--------------------------------------------------------------------------------------------------------------------------
//-------- La fonction top va nous permettre de trier le tableau sans recharger la page en instanciant la classe XMLHttpRequest

function topi(a) {

var xhr_object = null; 

top++;

alert('Tri sur la colonne ' + a );

c = document.getElementById("tableaux");

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
xhr_object.open("POST", "Ajax22.php", true); 
 
//-------- On attend de recevoir compl�tementla r�ponse � la requ�te au serveur pour exploiter le code renvoy�
//-------- par l'instance de XMLHttpRequest.
//-------- On ins�re par le biais de getElementbyId le code HTML re�u au sein de la balise d'Id Tableau dans le document 
xhr_object.onreadystatechange = function() { 
  if(xhr_object.readyState == 4) {document.getElementById("tableaux").innerHTML=xhr_object.responseText;}}
     
xhr_object.setRequestHeader("Content-type", "application/x-www-form-urlencoded"); 

//-------- On envoie les param�tres de tri � Ajax2.php (c'est � dire l'Id de l'en t�te de champ sur lequel on a cliqu�
var data = "family="+escape(a)+"&sens="+escape(top);
xhr_object.send(data); 
//alert(data);
}
