/* 	Ce code javascript permet de gérer les formulaires de création et de modification des demandes d'achat
	Il se compose de 3 parties principales
	1. Initialisation du formulaire
	2. Code spécifique pour gérer la table de détail
	3. Code spécifique pour la sauvegarde du formulaire
*/

// Mise à jour du 16/03/2017 - Correction d'une erreur d'arrondi dans calculPrixTotal() et calculTotal()

// Mise à jour du 20/03/2017 
// 1. Mise à jour de la fonction customPreSaveItem() afin de rendre obligatoire la saisie du motif de la demande 
// 2. Mise à jour de la fonction copyMainSelectedDAonQuerySucceeded pour la recopie du Motif de la demande, du demandeur, du responsable du service 
// d'affectation et du directeur de service 
// 3. Mise à jour de la fonction PreLoadForm() afin de vérifier que le champ numéro de DA n'est pas vide en cas de modification

// Mise à jour du 30/03/2017
// Ajout des fonctions FormatComptable() et FormatCentime()
// Mise à jour des fonctions calculPrixTotal() et calculTotal()
// Mise à jour de l'instruction pu.onchange = function () .....
 

//var siteUrl = 'https://spw2.sharepoint.com/sites/Achats';
//var sourceUrl = 'https://spw2.sharepoint.com/sites/Achats/Lists/Demande%20Achats/AllItems.aspx';
var siteUrl = 'http://intranet.photowatt.local/SupplyChain/DA';
var sourceUrl = 'http://intranet.photowatt.local/SupplyChain/DA/Lists/Demande%20Achats/AllItems.aspx';
var seuil = 2000; // seuil au dela duquel la validation passe de 1 niveau à 2 niveaux
var nomTable = "Demande Achats";
var nomTableDetail = "Demande Achats Detail";

// Version SharePoint Online
var profilePropertyNames = ["PreferredName", "Department", "Manager"];
// Version PhotoWatt
//var profilePropertyNames = ["PreferredName", "SPS-Department", "Manager"];


// =============================================================================================================================
// PARTIE 1 : Initialisation du formulaire

// La fonction PreLoadForm() est exécutée au moment du chargement et permet de valider que l'utilisateur
// est bien habilité à éditer le formulaire. Elle est liée à l'appel de la fonction CheckCurrentUser()

function processFormPage() {
    // Point d'entrée du formulaire personnalisé, cette fonction est appelée automatiquement au moment du chargement du formulaire
	
    //loop through all the spans in the custom layout        
    appendToSPWCustomForm();

    // récupérer les informations sur l'utilisateur connecté
	CheckCurrentUser();

    // Ajoute un onchange à l'élément FournNonReference
    // Si le fournisseur n'est pas référencé, affiche les champs contact, téléphone, mail
    // Si le fournisseur est référencé, ne les affiche pas
    var elt = getInputElement("FournNonReference");
    elt.onchange = yesNoCheck;
    yesNoCheck();

    // Code pour la prise en compte des pièces jointes
	initAttachment();

	// Code pour l'affichage ou le masquage de certaines zones du formulaire en fonction de l'étape dans laquelle se trouve le flux
	// ou en fonction d'autres critères
}

$(function () {
    
    //ExecuteOrDelayUntilScriptLoaded(processFormPage, "sp.js");
    // "clientpeoplepicker.js");
    SP.SOD.loadMultiple(['sp.js', 'clientpeoplepicker.js','userprofile'], processFormPage);
});

// -----------------------------------------------------------------------------------------------------------------------------
// En fonction de la valeur de FournNonReference, afficher ou effacer la ligne qui contient le contact, l'email et le téléphone du fournisseur

function yesNoCheck() {
    var elt = getInputElement("FournNonReference");
    if (elt.checked) {
        document.getElementById("detailFournisseurLigne1").style.visibility = 'visible';
    }
    else {
        document.getElementById("detailFournisseurLigne1").style.visibility = 'hidden';
    }
}

// --------------------------------------------------------------------------------------------------------------------------------
// Fonction spécifique pour la copie du champ Fournisseur non référencé

function updateFournNonReference(result) {

   if (result) {
	updateInput0("FournNonReference",result);
	var elt = getInputElement("FournNonReference");
	 elt.checked = true;
	 document.getElementById("detailFournisseurLigne1").style.visibility = 'visible';
	   }

   if (!result) {
  	updateInput0("FournNonReference",result);
	var elt = getInputElement("FournNonReference");
	 elt.checked = false;
	 document.getElementById("detailFournisseurLigne1").style.visibility = 'hidden';
	   }
}

// -----------------------------------------------------------------------------------------------------------------------------
// La fonction PreLoadForm() est utilisée pour vérifier que le formulaire peut être édité
// par l'utilisateur courant

// Elle est appelée automatiquement depuis la fonction onGcuSuccess() située dans SPWFormV3.js

function PreLoadForm() {
    // Renvoie false si les conditions ne sont pas remplies    
	
	if (getParameterFromUrl("ID")) { // S'il s'agit d'une modification de demande d'achat
		/* Ajout du 20/03/2017 */
		var sNum = getInput("Numero_x0020_demande");
		if ((!sNum) || (sNum.length == 0)) {
			alert("Désolé, mais la demande d'achat est en cours de traitement système. Merci de patienter quelques instants avant de renouveler votre opération !!");
			return false;
		/* Fin ajout */
		}
	}
	else {
		getUserProperties(oCurrentUser.fullLogin);
	}
    return true;
}

// =============================================================================================================================
// PARTIE 2 : Code spécifique pour gérer la table de détail

function customUpdateChildItem(indLigne) {
	// Cette fonction est appelée automatiquement lors de l'ajout d'une nouvelle ligne dans le tableau enfant
	// Elle permet une personnalisation avancée, par exemple la prise en compte de certaines colonnes calculées
	var qte = getInputElement("Qte" + indLigne.toString());
    qte.onchange = function () { calculPrixTotal(this); calculTotal();};
    var pu = getInputElement("PU" + indLigne.toString());
    pu.onchange = function () { FormatCentime(this); calculPrixTotal(this); calculTotal(); }; // Modification du 30/03/2017
	calculPrixTotal(qte);
}

function customUpdateChildTable() {
	// Cette fonction est appelée automatiquement lors de l'ajout ou la suppression d'une ligne dans le tableau enfant
	calculTotal();
}

// Ajout du 30/03/2017 
function FormatCentime(obj) {
	// récupérer l'identifiant de l'élément en cours
    //var s = obj.id;
	//var x = document.getElementById(obj.id).value;
	
	var x = obj.value;
	
	// s'il y a un point, le remplacer par une virgule
    if (x.indexOf(".") >= 0) {
        x = x.replace(".", ",");
    }
	
	var i = x.indexOf(",");
	
	if (i < 0) {
		// Exemple 12
		y = x + ",00";
	}
	if ((i >= 0) && (i == (x.length - 1))) {
		// Exemple 12,
		y = x + "00";
	}
	if ((i >= 0) && (i == (x.length - 2))) {
		// Exemple 12,1
		y = x + "0";
	}
	if ((i >= 0) && (i != (x.length -1)) && (i != (x.length - 2))) {
		// Dans tous les autres cas
		y = x;
	}
	
	obj.value = y;

}

function FormatMille(sNombre) {
	if (sNombre.length <= 3) {
		return sNombre;
	}
	var sNombre1 = sNombre.substring(0,sNombre.length - 3);
	var sNombre2 = sNombre.substring(sNombre.length-3, sNombre.length);
	return FormatMille(sNombre1) + "." + sNombre2;
}
function FormatComptable(sNombreCentimes) {
	// sNombreCentines contient un montant en centimes
	if ((!sNombreCentimes) || (sNombreCentimes.length == 0)) {
		return "0,00";
	}
	if (sNombreCentimes.length == 1) {
		return "0,0" + sNombreCentimes;
	}
	
	if (sNombreCentimes.length == 2) {
		return "0," + sNombreCentimes;
	}
	
	var sEuros = sNombreCentimes.substring(0, sNombreCentimes.length - 2 );
	var sCentimes = sNombreCentimes.substring(sNombreCentimes.length - 2, sNombreCentimes.length);
	return FormatMille(sEuros) + "," + sCentimes;
}
// Fin de l'ajout

// En fonction de la valeur de UniteX et PUX, recalculer le prix total
function calculPrixTotal(obj) {
    // récupérer l'identifiant de l'élément en cours
    var s = obj.id;
    var id;
    if (s.indexOf("Qte") == 0) {
        id = s.substring(3, s.length);
    }
    if (s.indexOf("PU") == 0) {
        id = s.substring(2, s.length);
    }
    var qte = document.getElementById("Qte" + id).value;
    var pu = document.getElementById("PU" + id).value;
    var ptDiv = document.getElementById("PT" + id);
	
    // s'il y a une virgule dans qte ou dans pu, la remplacer par un point
    if (qte.indexOf(",") >= 0) {
        qte = qte.replace(",", ".");
    }
    if (pu.indexOf(",") >= 0) {
        pu = pu.replace(",", ".");
    }

    if ((qte) && (qte.length > 0) && (pu) && (pu.length > 0)) {
        var pt = Number(qte) * Number(pu);
        // arrondir pt au centime
/* correction du 16/03/2017 */
        var spt2 = (Math.round(pt * 100)).toString();
// Modification du 30/03/2017
        ptDiv.innerHTML = FormatComptable(spt2);
    }
    else {
        ptDiv.innerHTML = "";
    }
}

// Pour éviter les problèmes d'arrondis, le Total est calculé en centimes
function calculTotal() {

    var tableauDetailDA = document.getElementById("DetailDA");
    var tableauBody = tableauDetailDA.children[0];
    var elts = tableauBody.getElementsByClassName("DetailDALigne");
    var calTotal = 0;
    for (var i = 0; i < elts.length; i++) {
        var elt = elts[i];
        var sIndice = elt.id.substring(13, elt.id.length);

        var qte = document.getElementById("Qte" + sIndice).value;
        var pu = document.getElementById("PU" + sIndice).value;

        // s'il y a une virgule dans qte ou dans pu, la remplacer par un point
        if (qte.indexOf(",") >= 0) {
            qte = qte.replace(",", ".");
        }
        if (pu.indexOf(",") >= 0) {
            pu = pu.replace(",", ".");
        }

        if ((qte) && (qte.length > 0) && (pu) && (pu.length > 0)) {
            var pt = Number(qte) * Number(pu);
            // arrondir pt au centime
/* correction du 16/03/2017 */
            var spt2 = (Math.round(pt * 100)).toString();
			
            pt = parseInt(spt2)
            calTotal += pt;
        }

        var sCalTotal = calTotal.toString();
        if (sCalTotal.length == 1) {
            sCalTotal = "00" + sCalTotal;
        }
        if (sCalTotal.length == 2) {
            sCalTotal = "0" + sCalTotal;
        }
    }
    var sCalTotal2 = sCalTotal.substring(0, sCalTotal.length - 2) + "," + sCalTotal.substring(sCalTotal.length - 2, sCalTotal.length);
	
	/* Ajout du 30/03/2017 */
	var sCalTotalComptable = FormatComptable(sCalTotal);
	updateInput("sTotal", sCalTotalComptable);
	/* Fin ajout */

    	updateInput("Total", sCalTotal2);
	
}

function detailNonVide(indLigne) {
	// renvoie true si la ligne de détail n'est pas vide, false sinon
	var eltQte = getInputElement("Qte" + indLigne.toString());
	var quantite = eltQte.value;
	return ((quantite) && (quantite.length > 0));
}


// =============================================================================================================================
// PARTIE 3 : Code spécifique pour la sauvegarde du formulaire

function customPreSaveItem() {
	// Cette fonction renvoie true si le formulaire est valide et peut être sauvegardé, false sinon.
	
	// Première partie - Vérification du corps de la demande
    var errMessage = "";

	// Si le montant de la demande d'achat dépasse un certain seuil, le champ Direction du service devient obligatoire
    var total = parseFloat(getInput("Total"));
    if (total > seuil) {
        var respDirectionService = getUserField("RespDirectionService");
        if ((!respDirectionService) || (respDirectionService.length == 0)) {
            errMessage += "Direction du service manquant. ";
        }
    }

	// Si le fournisseur n'est pas référencé, le champ Motif Fournisseur devient obligatoire
    var elt = getInputElement("FournNonReference");
    if (elt.checked) {

		var FournMotif = getInput("FournMotif");
		if ((!FournMotif) || (FournMotif.length == 0)) {
				errMessage += "Nom du motif justifiant le fournisseur manquant. ";
			}
    }

	/* Ajout du 20/03/17 : Vérifier que le motif de la demande est bien précisé */
	var sMotifDemande = getTextArea("Motif_x0020_demande");
	if ((!sMotifDemande) || (sMotifDemande.length == 0)) {
		errMessage += "Motif de la demande obligatoire";
	}
	
	//var motifDemande = getInput("Motif_x0020_demande");
	//var motifDemandes = new String(motifDemande);
        //var texteMotif = motifDemandes.substring(3+motifDemande.lastIndexOf('<p>'),motifDemande.lastIndexOf('</p>'));
        //texteMotif.replace(/ /g,"");
	//alert(motifDemande);
        //alert(eval(motifDemandes));
	//alert(texteMotif);
        //alert(texteMotif.length);
        //if ((!motifDemande) || (texteMotif.length <= 1)) {
        //    errMessage += "Motif demande manquant. ";
        //    motifDemande = null;
        //    texteMotif  = null;
        // }

        //var contactFourn = getInput("FournContact");
        //if ((!contactFourn) || (contactFourn.length == 0)) {
        //    errMessage += "Nom du contact fournisseur manquant. ";
        //}
        //var telFourn = getInput("FournTelephone");
        //if ((!telFourn) || (telFourn.length == 0)) {
        //    errMessage += "Téléphone fournisseur manquant. ";
        //}
        //var mailFourn = getInput("FournMail");
        //if ((!mailFourn) || (mailFourn.length == 0)) {
        //    errMessage += "Mail fournisseur manquant. ";
        //}
  

    if (errMessage.length > 0) {
        formLogError(errMessage);
        return false;
    }

	// Deuxième partie - Remplissage automatique de certains champs

    // regarder si la date est renseignée, si ce n'est pas le cas, appliquer la date du jour
    var dateDemande = getInput("Date");
    if ((!dateDemande) || (dateDemande.length == 0)) {
        var dateJour = new Date();
        var dateJourString = dateJour.getDate().toString() + "/" + (dateJour.getMonth() + 1).toString() + "/" + dateJour.getFullYear().toString();
        updateInput("Date", dateJourString);
    }

	return true;

}

// =============================================================================================================================
// Code spécifique pour le remplissage automatique de la direction, du service, du n+1 et du n+2

var userProfileProperties;
var oCurrentUserProperty = {
	preferredName: "",
	department: "",
	manager: "",
    status: "", // status has 3 possible values : "", "success", "failure"
}
var oCurrentUserProperty2 = {
	direction: "",
	managerN2: "",
    status: "", // status has 3 possible values : "", "success", "failure"
}

function getUserProperties(targetUser) {
	// targetUser contient le login de l'utilisateur
    // var targetUser = "i:0#.f|membership|brian@spw2.onmicrosoft.com";
    // ? var targetUser = "domainName\\userName";
	// ? var targetUser = "PHOTOWATT\\Debug-fmonnery";


    // Get the current client context and PeopleManager instance.
    var clientContext = new SP.ClientContext.get_current();
    var peopleManager = new SP.UserProfiles.PeopleManager(clientContext);

    var userProfilePropertiesForUser = 
        new SP.UserProfiles.UserProfilePropertiesForUser(
            clientContext,
            targetUser,
            profilePropertyNames);

    // Get user profile properties for the target user.
    // To get the value for only one user profile property, use the
    // getUserProfilePropertyFor method.
    userProfileProperties = peopleManager.getUserProfilePropertiesFor(
        userProfilePropertiesForUser);

    // Load the UserProfilePropertiesForUser object and send the request.
    clientContext.load(userProfilePropertiesForUser);
    clientContext.executeQueryAsync(onRequestSuccess, onRequestFail);
}

// This function runs if the executeQueryAsync call succeeds.
function onRequestSuccess() {
	oCurrentUserProperty.preferredName = userProfileProperties[0];
	oCurrentUserProperty.department = userProfileProperties[1];
	oCurrentUserProperty.manager = userProfileProperties[2];
	oCurrentUserProperty.status = "success";
	
	SetUserFieldValue("RespServiceAffectation",oCurrentUserProperty.manager);
	getUserProperties2.call(oCurrentUserProperty2);
}

// This function runs if the executeQueryAsync call fails.
function onRequestFail(sender, args) {
    oCurrentUserProperty.status = "failure";
}

function getUserProperties2() {
	var clientContext = new SP.ClientContext(siteUrl);
	this.oList = clientContext.get_web().get_lists().getByTitle("DirectionService");
	this.status = "";

	var camlQuery = new SP.CamlQuery();
	camlQuery.set_viewXml(
	"<View><Query>" +
	"<Where>" +
	"<Eq><FieldRef Name='Service'/><Value Type='Text'>" + oCurrentUserProperty.department + "</Value></Eq>" +
	"</Where>" +
	"</Query></View>"
	);
	this.collItems = this.oList.getItems(camlQuery);

	clientContext.load(this.collItems);
	clientContext.executeQueryAsync(Function.createDelegate(this, guProp2onQuerySucceeded), Function.createDelegate(this, guProp2onQueryFailed));
}


function guProp2onQuerySucceeded(sender, args) {
    // Get elements
    var listItemInfo = '';
    var listItemEnumerator = this.collItems.getEnumerator();
    var i = 0;

    while (listItemEnumerator.moveNext()) { 
        i = i + 1;
        var oListItem = listItemEnumerator.get_current();
		
		this.direction = oListItem.get_item("Title");
		this.managerN2 = oListItem.get_item("DirecteurLogin");
		SetUserFieldValue("RespDirectionService",this.managerN2);
		directionServiceInit();
    }
    this.status = "success";
}

function guProp2onQueryFailed(sender, args) {
    //ajouterTrace('Request failed from demandeAchat_retrieveListItems', args.get_message() + '\n' + args.get_stackTrace());
	this.status = "failure";
    // alert('Request failed from demandeAchat_retrieveListItems. ' + args.get_message() + '\n' + args.get_stackTrace());
}

// =============================================================================================================================

/*
var iPrim = findPrimaryChoices("Direction");
primaryChoices[iPrim].eltCurrentValue = direction;
var iSecond = findSecondaryChoice("Service");
secondaryChoices[iSecond].eltCurrentValue = departement;
retrieveSecondaryElements.call(secondaryChoices[iSecond], direction);
*/

var handlerTimeoutDirectionService;
var handlerIntervalDirectionService;

function checkDirectionService() {
	var allSuccess = 1;
	for (var i=0; i < childPrimaryChoices.length; i++) {
		if (childPrimaryChoices[i].status != "success") {
			allSuccess = 0;
		}
	}
	if (allSuccess) {
		clearTimeout(handlerTimeoutDirectionService);
        clearInterval(handlerIntervalDirectionService);
		
		var iPrim = findPrimaryChoice("Direction");
		primaryChoices[iPrim].eltCurrentValue = oCurrentUserProperty2.direction;
		setSelectedValue("Direction", oCurrentUserProperty2.direction);
		var iSecond = findSecondaryChoice("Service");
		secondaryChoices[iSecond].eltCurrentValue = oCurrentUserProperty.department;
		retrieveSecondaryElements.call(secondaryChoices[iSecond], oCurrentUserProperty2.direction);
	}
}

function timeoutDirectionService() {
	clearInterval(handlerIntervalDirectionService);
}

function directionServiceInit() {
    handlerTimeoutDirectionService = setTimeout(timeoutDirectionService, 5000); // Timeout after 5 seconds
    handlerIntervalDirectionService = setInterval(checkDirectionService, 200); // Check every 0,2 second
}

// =============================================================================================================================
var oLastDAs = {
    status: "" // status has 3 possible values : "", "success", "failure"
}

var oSelectedDA = {
    status: "" // status has 3 possible values : "", "success", "failure"
}

var oSelectedDAChildTable = {
    arrayElements: [], // Contient l'ensemble des lignes, avec en début de chaque ligne le spid (sharepoint id)
    status: "" // status has 3 possible values : "", "success", "failure"
}
function getLastDAs() {
	// S'assurer que la personne connectée est bien identifiée
	if (oCurrentUser.status != "success") {
		alert("Utilisateur connecté non encore identifié. Merci d'essayer ultérieurement.")
	}
	else {
        var clientContext = new SP.ClientContext(siteUrl);
        this.oList = clientContext.get_web().get_lists().getByTitle(nomTable);
        this.status = "";

        var camlQuery = new SP.CamlQuery();
        camlQuery.set_viewXml(
        "<View><Query>" +
        "<OrderBy><FieldRef Name='ID' Ascending='FALSE'/></OrderBy>" +
        "<Where>" +
        "<Eq><FieldRef Name='DemandeurLogin'/><Value Type='Text'>" + oCurrentUser.login + "</Value></Eq>" +
        "</Where>" +
        "</Query></View>"
        );
        this.collItems = this.oList.getItems(camlQuery);

		clientContext.load(this.collItems);
        clientContext.executeQueryAsync(Function.createDelegate(this, getLastDAsonQuerySucceeded), Function.createDelegate(this, getLastDAsonQueryFailed));
	}
}

function getLastDAsonQuerySucceeded(sender, args) {
	var o = document.getElementById("listeDAs");
	var guidDemande, numDemande, nomFournisseur, dateDemande, sDay, sMonth, sYear, totalDemande, deviseDemande;
	var elt;
	// Reinitialize list
    while (o.childNodes.length > 0) {
		var lc = o.lastChild;
		lc.parentNode.removeChild(lc);
	}
    // Add elements in the list
    var listItemEnumerator = this.collItems.getEnumerator();
    var title;
    while (listItemEnumerator.moveNext()) {
        var oListItem = listItemEnumerator.get_current();
		guidDemande = oListItem.get_item("GuidDemande");
                numDemande = oListItem.get_item("Numero_x0020_demande");
		nomFournisseur = oListItem.get_item("FournNom");
		dateDemande = oListItem.get_item("Date");
		sDay = dateDemande.getDate().toString();
		sMonth = (dateDemande.getMonth()+1).toString();
		sYear = dateDemande.getFullYear().toString();
		totalDemande = oListItem.get_item("Total");
		deviseDemande = oListItem.get_item("Devise");
		elt = document.createElement("option");
		elt.value = guidDemande;
		elt.innerHTML = numDemande + " - " + nomFournisseur + " - " + sDay + "/" + sMonth + "/" + sYear + " - " + totalDemande + " " + deviseDemande;
		o.appendChild(elt);
    }
	
	this.status = "success";
}

function getLastDAsonQueryFailed(sender, args) {
	this.status = "failure";
	alert("get last DAs failed");
}

function copySelectedDA() {
	var o = document.getElementById("listeDAs");
	copyMainSelectedDA.call(oSelectedDA,o.value);
	copyDetailSelectedDA.call(oSelectedDAChildTable,o.value);
}

function copyMainSelectedDA(guidDA) {
	    var clientContext = new SP.ClientContext(siteUrl);
        this.oList = clientContext.get_web().get_lists().getByTitle(nomTable);
        this.status = "";

        var camlQuery = new SP.CamlQuery();
        camlQuery.set_viewXml(
        "<View><Query>" +
        "<OrderBy><FieldRef Name='ID' Ascending='FALSE'/></OrderBy>" +
        "<Where>" +
        "<Eq><FieldRef Name='GuidDemande'/><Value Type='Text'>" + guidDA + "</Value></Eq>" +
        "</Where>" +
        "</Query></View>"
        );
        this.collItems = this.oList.getItems(camlQuery);

		clientContext.load(this.collItems);
        clientContext.executeQueryAsync(Function.createDelegate(this, copyMainSelectedDAonQuerySucceeded), Function.createDelegate(this, copyMainSelectedDAonQueryFailed));
}

function copyMainSelectedDAonQuerySucceeded(sender, args) {
	var nomFournisseur, motifDemande, deviseDemande, natureDepense, imputationAnalytique, contactFournisseur, telFournisseur, mailFournisseur;
	var demandeur, respServiceAffectation, respDirectionService;

    var listItemEnumerator = this.collItems.getEnumerator();
    if (listItemEnumerator.moveNext()) {
        var oListItem = listItemEnumerator.get_current();

		nomFournisseur = oListItem.get_item("FournNom");
		deviseDemande = oListItem.get_item("Devise");
		natureDepense = oListItem.get_item("Nature_x0020_depense");
		imputationAnalytique = oListItem.get_item("Imputation_x0020_analytique");
                motifDemande = oListItem.get_item("Motif_x0020_demande");
		contactFournisseur = oListItem.get_item("FournContact");
                telFournisseur = oListItem.get_item("FournMail");
                mailFournisseur = oListItem.get_item("FournTelephone");
		FournNonReference = oListItem.get_item("FournNonReference");
		FournMotif = oListItem.get_item("FournMotif");
				
/* Ajout du 20/03/2017 */
		demandeur = oListItem.get_item("Demandeur").get_lookupValue();
		respServiceAffectation = oListItem.get_item("RespServiceAffectation").get_lookupValue();
		respDirectionService = oListItem.get_item("RespDirectionService").get_lookupValue();
/* Fin ajout */
				
/* Modification du 20/03/2017 */
  /*                      
                if (motifDemande) {var texteMotif = motifDemande.substring(3+motifDemande.lastIndexOf('<p>'),motifDemande.lastIndexOf('</p>'));
                                   updateInput("Motif_x0020_demande",texteMotif);}    
*/
		if ((motifDemande) && (motifDemande.length > 0)) {
			updateTextArea("Motif_x0020_demande", motifDemande);
		}		
/* Fin modification */		

/* Ajout du 20/03/2017 */
		ClearUserFieldValue("Demandeur");
		ClearUserFieldValue("RespServiceAffectation");
		ClearUserFieldValue("RespDirectionService");
		SetUserFieldValue("Demandeur", demandeur);
		SetUserFieldValue("RespServiceAffectation", respServiceAffectation);
		SetUserFieldValue("RespDirectionService", respDirectionService);

/* Fin ajout */
		  					
		updateInput("FournNom",nomFournisseur);		
		updateInput("FournContact",contactFournisseur);	
		updateInput("FournMail",telFournisseur);	
		updateInput("FournTelephone",mailFournisseur);	
		updateInput("FournMotif",FournMotif);	

		updateFournNonReference(FournNonReference);		

		setSelectedValue("Devise",deviseDemande);
		setSelectedValue("Nature_x0020_depense",natureDepense);
		setSelectedValue("Imputation_x0020_analytique",imputationAnalytique);
    }
	this.status = "success";
}

function copyMainSelectedDAonQueryFailed (sender, args) {
	this.status = "failure";
}

function copyDetailSelectedDA(guidDA) {
	    var clientContext = new SP.ClientContext(siteUrl);
        this.oList = clientContext.get_web().get_lists().getByTitle(nomTableDetail);
        this.status = "";

        var camlQuery = new SP.CamlQuery();
        camlQuery.set_viewXml(
        "<View><Query>" +
        "<OrderBy><FieldRef Name='Indice' Ascending='TRUE'/></OrderBy>" +
        "<Where>" +
        "<Eq><FieldRef Name='GuidDemande'/><Value Type='Text'>" + guidDA + "</Value></Eq>" +
        "</Where>" +
        "</Query></View>"
        );
        this.collItems = this.oList.getItems(camlQuery);

        clientContext.load(this.collItems);
        clientContext.executeQueryAsync(Function.createDelegate(this, copyDetailSelectedDAonQuerySucceeded), Function.createDelegate(this, copyDetailSelectedDAonQueryFailed));
}

function copyDetailSelectedDAonQuerySucceeded(sender, args) {
	this.arrayElements = [];
    // Get elements
    var listItemInfo = '';
    var listItemEnumerator = this.collItems.getEnumerator();

    while (listItemEnumerator.moveNext()) { 
        var oListItem = listItemEnumerator.get_current();

        var elt = [];
		//elt.push(oListItem.get_item('ID'));
		elt.push(""); // On copie tous les éléments à l'exception du spid
		for (var i=0; i < childTable.cols.length; i++) {
			if (childTable.cols[i].fieldName) {
				if (childTable.cols[i].fieldType == "date") {
					var sDate = oListItem.get_item(childTable.cols[i].fieldName).format("dd/MM/yyyy");
					elt.push(sDate);
				}
				else {
					elt.push(oListItem.get_item(childTable.cols[i].fieldName));
				}
			}
			else {
				elt.push("");
			}
		}
		this.arrayElements.push(elt);
    }
    this.status = "success";
	
	// Reinitialize the childtable
	var tableauDetail = document.getElementById(childTable.tableId);
    var tableauBody = tableauDetail.children[0];
	// Supprimer tous les éléments enfants de tableauBody à l'exception du premier
	while (tableauBody.children.length > 1) {
		var eltLigne = tableauBody.lastChild;
		eltLigne.parentNode.removeChild(eltLigne);
		//tableauBody = tableauDetail.children[0];
	}
	// Copy elements in the childtable
	for (var i=0; i < this.arrayElements.length; i++) {
		addChildLine(childTable.tableId, childTable.lineId, i+1, this.arrayElements[i]);
	}
}

function copyDetailSelectedDAonQueryFailed(sender, args) {
	this.status = "failure";
}