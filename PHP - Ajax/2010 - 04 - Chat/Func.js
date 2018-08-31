
//------- Fonction qui vérifie la validité des champs du formulaire d'inscription

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


//--------- Fonction qui désactive le remplissage automatique des champs du navigateur

function init() {

if (!document.getElementById) {return false;}
var f = document.getElementById('auto_off');
var u = f.elements[0];
f.setAttribute("autocomplete", "off");
u.focus();
} 

//---------- Fonction qui affiche un message de remerciement lors de la déconnexion de l'utilisateur

function quit(c) {

alert("Merci de vous être connecté - A bientôt !!!");
var a=c.top;
a.close();

}



