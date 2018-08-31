var siteUrl = 'http://intranet.photowatt.local/SupplyChain/CER';
var sourceUrl = 'http://intranet.photowatt.local/SupplyChain/CER/Lists/Demande%20Achats/AllItems.aspx';
var nomTable = "Demande Achats";
var nomTableDetail = "Demande Achats Detail";

// =============================================================================================================================
// PARTIE 1 : Initialisation du formulaire

function processFormPage() {
    //loop through all the spans in the custom layout        
    appendToSPWDisplayForm();

    //demandeAchat_retrieveListItems.call(oDetailInitial);

    // Code pour la prise en compte des pièces jointes
    var elt = document.getElementsByClassName("ms-formtable")[0];
    changeId(elt, "idAttachmentsRow", "idAttachmentsRow2")

    $("#idAttachmentsRow2").contents().appendTo("#idAttachmentsRow");
    // var x = document.getElementById("onetidIOFile"); attachmentsOnClient
    //var x = document.getElementById("attachmentsOnClient");
    //x.onchange = function () { displayFileAttachMessage(true); };

    // Code pour l'affichage des détails du fournisseur s'il n'est pas déjà référencé
    //if (getSpanValue('FournNonReference') == "Oui") {
    //    document.getElementById("detailFournisseurLigne1").style.display = "inline";
    //}
    //else {document.getElementById("detailFournisseurLigne1").style.display = "none";}

}


$(function () {
    
    ExecuteOrDelayUntilScriptLoaded(processFormPage, "sp.js");
    // "clientpeoplepicker.js");
    //SP.SOD.loadMultiple(['sp.js', 'clientpeoplepicker.js'], processFormPage);

});

function displayFileAttachMessage(onOff) {
    var elt = document.getElementById("FileAttachMessage");
    if (onOff) {
        elt.style.display = "inline";
    }
    else {
        elt.style.display = "none";
    }
}

// =============================================================================================================================
// PARTIE 2 : Code spécifique pour gérer la table de détail

function customUpdateChildItem(indLigne) {
	// Cette fonction est appelée automatiquement lors de l'ajout d'une nouvelle ligne dans le tableau enfant
	// Elle permet une personnalisation avancée, par exemple la prise en compte de certaines colonnes calculées
	var qte = getInputElement("Qte" + indLigne.toString());
    qte.onchange = function () { calculPrixTotal(this); calculTotal();};
    var pu = getInputElement("PU" + indLigne.toString());
    pu.onchange = function () { calculPrixTotal(this); calculTotal(); };
	calculPrixTotal(qte);
}

function customUpdateChildTable() {
	// Cette fonction est appelée automatiquement lors de l'ajout ou la suppression d'une ligne dans le tableau enfant
	calculTotal();
}

// Ajout du 30/03/2017 

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
