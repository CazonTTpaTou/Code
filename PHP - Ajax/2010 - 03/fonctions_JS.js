//--------------------------------------------------------------------------------------------------------------------------
//-------- La fonction tri va nous permettre de trier le tableau sans recharger la page en instanciant la classe XMLHttpRequest

function tri(a) {

var xhr_object = null; 
alert('Tri sur la colonne ' + a);

myDiv = document.getElementById("tableau");

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
xhr_object.open("POST", "Ajax2.php", true); 
 
//-------- On attend de recevoir complètementla réponse à la requête au serveur pour exploiter le code renvoyé
//-------- par l'instance de XMLHttpRequest.
//-------- On insère par le biais de getElementbyId le code HTML reçu au sein de la balise d'Id Tableau dans le document 
xhr_object.onreadystatechange = function() { 
  if(xhr_object.readyState == 4) document.getElementById("tableau").innerHTML=xhr_object.responseText;} 
     
xhr_object.setRequestHeader("Content-type", "application/x-www-form-urlencoded"); 

//-------- On envoie les paramètres de tri à Ajax2.php (c'est à dire l'Id de l'en tête de champ sur lequel on a cliqué
var data = "family="+escape(a);
xhr_object.send(data); 
//alert(data);
}

//--------------------------------------------------------------------------------------------------------
//-------- Fonction qui va vérifier que tous les champs sont conformes avant la validation d'un formulaire:
//-------- Que chaque champ soit non vide
//-------- Que le champ code postal comporte 5 caractères
//-------- Que le champ téléphone comporte 10 caractères
//-------- Que le champ date soit conforme à la syntaxe adéquate

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
	if((frm.elements[i].name=="telephone") && (frm.elements[i].value.length!=10)) {++z;g="Le numéro de téléphone doit comporter 10 chiffres";}
	if((frm.elements[i].name=="date") && (datum(frm.elements[i].value))) {++z;h="La date doit être au format aaaa-mm-jj";}}

var d="Attention: " +c + " champs non remplis: " + d + "\n"+"Tous les champs doivent être complétés !!!";

if (z==0) {alert("Formulaire correctement rempli");return true;}
else {if(f!="") {alert(f);}
      if(c!=0) {alert(d);}
      if(g!="") {alert(g);}
      if(h!="") {alert(h);}
	return false;}
}


//--------------------------------------------------------------------------------------------------------
//-------- Fonction qui va empêcher l'utilisateur de rentrer autre chose que des chiffres dans le champ concerné

function numbers(a) {

if (a.which==13 || a.which==8 || a.which==0) {return true;}
else {if (a.which<48 || a.which>57) {alert('Veuillez rentrer uniquement des chiffres');return false;}}

if (a.keycode==13 || a.keycode==8 || a.keycode==0) {return true;}
else {if (a.keycode<48 || a.keycode>57) {alert('Veuillez rentrer uniquement des chiffres');return false;}}

}


//--------------------------------------------------------------------------------------------------------
//-------- Fonction qui va empêcher l'utilisateur de rentrer autre chose que des chiffres dans le champ concerné
//-------- mais qui autorise la virgule pour pouvoir saisir un nombre décimal

function numbers_dec(a) {

if (a.which==13 || a.which==8 || a.which==0 || a.which==46) {return true;}
else {if (a.which<48 || a.which>57) {alert('Veuillez rentrer uniquement des chiffres');return false;}}

if (a.keycode==13 || a.keycode==8 || a.keycode==0 || a.keycode==46) {return true;}
else {if (a.keycode<48 || a.keycode>57) {alert('Veuillez rentrer uniquement des chiffres');return false;}}

}

//--------------------------------------------------------------------------------------------------------
//-------- Fonction qui va empêcher l'utilisateur de rentrer autre chose que des chiffres dans le champ concerné
//-------- mais qui autorise le tiret pour pouvoir saisir une date au format aaaa-mm-jj

function numbers_dat(a) {

if (a.which==13 || a.which==8 || a.which==0 || a.which==46 || a.which==45) {return true;}
else {if (a.which<48 || a.which>57) {alert('Veuillez rentrer uniquement des chiffres');return false;}}

if (a.keycode==13 || a.keycode==8 || a.keycode==0 || a.keycode==46 || a.keycode==45) {return true;}
else {if (a.keycode<48 || a.keycode>57) {alert('Veuillez rentrer uniquement des chiffres');return false;}}

}

//--------------------------------------------------------------------------------------------------------
//-------- Fonction qui va vérifier que l'expression rentrée dans un champ date respecte bien la syntaxe suivante
//-------- chiffre chiffre chiffre chiffre - chiffre chiffre - chiffre chiffre


function datum(a) {
var exp = new RegExp("^[0-9]{4,4}[-][0-9]{2,2}[-][0-9]{2,2}$");
if (!exp.test(a)) {return true;}
  else{return date_existe(a);}}

//--------------------------------------------------------------------------------------------------------
//-------- Fonction qui va vérifier que l'expression que les jours, mois et année sont cohérents. Par exemple,
//-------- qu'un jour rentré ne soit pas égal à 60, ou un mois égal à 0.

function date_existe(a) {
       var annee=a.substring(0,4);
       var mois=a.substring(5,7);
       var jour=a.substring(8,10);
	
	if((annee>2100) || (annee<2000) || (jour<1) || (jour>31) || (mois<1) || (mois>12)) 
		{alert('La date rentrée est fantaisiste - Recommencez !!!');return true;}
        else {return date_existe2(a,annee,mois,jour);}}

//--------------------------------------------------------------------------------------------------------
//-------- Fonction qui va vérifier que la date rentrée par l'utilisateur existe, en créant une instance date
//-------- à partir des nombres saisis dans le champ. Si l'instance date crée est égale à la date effectivement
//-------- rentré, c'est que la date est bien dans le calendrier, sinon un message d'erreur est envoyé
//-------- Par exemple, si l'utilisateur rentre 2000-11-31, l'instance date créée à partir de 2000, 11 et 31
//-------- va renvoyer la date du 1er décembre, qui sera donc différente de la chaîne saisie initialement,
//-------- ce qui renverra un return false qui empêchera le formulaire de se valider.

function date_existe2(a,annee,mois,jour) {
		var d2=new Date(annee,mois-1,jour);
        		 j2=d2.getDate();
        		 m2=d2.getMonth()+1;
        		 a2=d2.getFullYear();
        		 if (a2<=100) {a2=1900+a2;}
        		 if ( (jour!=j2)||(mois!=m2)||(annee!=a2) ) 
        		    {alert("La date " + a +" n'existe pas !!!");return true;}
				else {return false;}}

