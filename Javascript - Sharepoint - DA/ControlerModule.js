/* Version spécifique à PhotoWatt */
/* Ajout du 13/03/2017 */
/* Prise en compte de inputSize : appendToSPWCustomForm(), addChildLine(), appendToSPWDisplayForm() */
/* Ajout du 16/03/2017 */
/* Mise à jour des fonctions checkSauvegardeDA(), checkStatusSauvegardeDA() et ChildTable_retrieveListItems() car le numéro de demande n'est plus nécessaire à la sauvegarde */
/* Ajout de la propriété tooltip aux éléments du tableau cols[] de childTable */
/* Mise à jour du 17/03/2017 */
/* Ecriture d'une nouvelle version plus efficace de checkCTDisplay() */

/* Mise à jour du 20/03/2017 */
/* Ajout d'un contrôle dans checkStatusSauvegardeDA() afin de s'assurer que le tableau détail a bien été regénéré */
/* Ajout des fonctions getTextArea() et updateTextArea() permettant la gestion du contenu d'un champ de plusieurs lignes (texte brut) */
/* Ajout de la fonction ClearUserFieldValue() permettant de vider le contenu d'un champ people picker */

/* Mise à jour du 30/03/2017 */
/* Ajout de class="<data-colId>" afin d'autoriser la création de règles CSS */

var guidDA; // guid du formulaire
var numFormulaire; // numéro de la demande
var siteUrlID = 'http://intranet.photowatt.local/SupplyChain/DA';
var sourceUrlID = 'http://intranet.photowatt.local/SupplyChain/DA/Lists/NumeroDA/AllItems.aspx';
var nomTableID = "NumeroDA";

var childTable = null;
// Objet contenant la table enfant, ou vide si il n'y en a pas
/*
{
	listName: <nom de la liste>
	tableId: <id de l'élément HTML Table>
	headerId: <id de l'élément HTML d'entête>
	lineId: <id de l'élément HTML de chaque ligne (sans numéro d'indice)>
	keyFieldName : <nom du champ clé>
	guidFieldName : <nom du champ guid>
	cols: [] 	// liste des colonnes qui constituent la table enfant, y compris la colonne Indice et les colonnes calculées
				// la colonne Indicea "Indice" pour colId			
				// les colonnes calculées ont un fieldname vide
}

col[0] = {
	colId: <id de l'élément HTML (sans numéro d'indice)>
	fieldName: <nom du champ> ou vide
	fieldType: "texte", "choix", "nombre", "date" ou vide
	source : "PrimaryChoice,<nom de la liste>,<nom du champ>"
	mandatory : true ou vide
// Ajout du 16/03/2017
	tooltip : true ou vide
// Fin de l'ajout
	inputSize : <nbr de caractères du champ input> ou vide
}
*/

var primaryChoices = [];
var childPrimaryChoices = [];
// Tableaux contenant des objects de ce type 
/* 
{
    displayName: <nom du champ> ou <nom de la colonne>
    sourceListName: <nom de la liste>,
    sourceFieldName: <nom du champ>,
    secondaryFields: [], liste d'indices de champs secondaires
    eltId: '',
    eltCurrentValue: '',
    arrayElements: [],
    eltOriginalId: '';
    status: "" // status has 3 possible values : "", "success", "failure"
}
*/

function findPrimaryChoice(dispName) {
    for (var i = 0; i < primaryChoices.length; i++) {
        if (primaryChoices[i].displayName == dispName) return i;
    }
    return null;
}

function findChildPrimaryChoice(dispName) {
    for (var i = 0; i < childPrimaryChoices.length; i++) {
        if (childPrimaryChoices[i].displayName == dispName) return i;
    }
    return null;
}

var secondaryChoices = [];
// Tableau contenant des objects de ce type 
/* 
{
    displayName: <nom du champ>,
    primaryDisplayName: <nom du champ primaire>,
    sourceListName: <nom de la liste>,
    sourceFieldName: <nom du champ>,
    eltId: '',
    eltCurrentValue: '',
    arrayElements: [],
    eltOriginalId: '';
    status: "" // status has 3 possible values : "", "success", "failure"
}
*/

function findSecondaryChoice(dispName) {
    for (var i = 0; i < secondaryChoices.length; i++) {
        if (secondaryChoices[i].displayName == dispName) return i;
    }
    return null;
}

var mandatoryFields = [];
/* Tableau des champs obligatoires
   Il contient des objets de ce type
{
    displayName: <nom du champ>,
    fieldType: "texte", "choix", "nombre", "personne", "date"
} */

var currentUserFields = [];
/* Tableau des champs de type personne qui sont à initialiser avec l'utilisateur courant */
/* Ce tableau contient la liste des displayNames */

function appendToSPWCustomForm() {
    //loop through all the spans in the custom layout      
    var displayName;
    var source;
    $("span.SPWCustomForm").each(function () {
        //get the display name from the custom layout
        displayName = $(this).attr("data-displayname");
        source = $(this).attr("data-source");

        // Regarder si ce champ est obligatoire
        attr = $(this).attr("data-attrib");
        if ((attr) && (attr.indexOf("mandatory") != -1)) {
            var oMandatory = {};
            oMandatory.displayName = displayName;
            var sType = $(this).attr("data-type");
            if (!sType) {
                if (source) {
                    sType = "choix";
                }
                else {
                    sType = "texte";
                }
            }
            oMandatory.fieldType = sType;
            mandatoryFields.push(oMandatory);
        }

        // Regarder si ce champ est à initialiser avec l'identité de l'utilisateur connecté
        if ((attr) && (attr.indexOf("currentUser") != -1)) {
            currentUserFields.push(displayName);
        }

        // Cas particulier lorsque le displayname contient le caractère & : remplace le & seul par &amp;
        displayName = displayName.replace(/&(?!amp;)/g, '&amp;');
        elem = $(this);

        // Cas d'un champ primaire
        if ((source) && (source.indexOf("PrimaryChoice") == 0)) {
            var t = source.split(",");
            var o = {};
            //find the corresponding field from the default form and copy its id
            $("table.ms-formtable td").each(function () {
                if (this.innerHTML.indexOf('FieldName="' + displayName + '"') != -1) {
                    // Extraire l'id de this.innerHTML
                    var sInput = findSubstring(this.innerHTML, "<input", ">");
                    var sId = findSubstring(sInput, 'id="', '"');
                    o.eltOriginalId = sId.substring(4, sId.length - 1);
                }
            });
            o.displayName = displayName;
            o.sourceListName = t[1];
            o.sourceFieldName = t[2];
            if (getParameterFromUrl("ID")) {
                // Formulaire de modification
                o.eltCurrentValue = document.getElementById(o.eltOriginalId).value;
            }
            else {
                // Formulaire de création
                o.eltCurrentValue = '';
            }
            o.secondaryFields = [];
            o.arrayElements = [];
            o.status = '';

            primaryChoices.push(o);
            var nouvDiv = document.createElement("div");
            nouvDiv.id = "select" + displayName.replace(/\s/g, '_x0020_');
            nouvDiv.onchange = function () { primary_onChange(this); };
            $(nouvDiv).appendTo(elem);

        }

        // Cas d'un champ secondaire
        if ((source) && (source.indexOf("SecondaryChoice") == 0)) {
            var t = source.split(",");
            var o = {};
            //find the corresponding field from the default form and copy its id
            $("table.ms-formtable td").each(function () {
                if (this.innerHTML.indexOf('FieldName="' + displayName + '"') != -1) {
                    // Extraire l'id de this.innerHTML
                    var sInput = findSubstring(this.innerHTML, "<input", ">");
                    var sId = findSubstring(sInput, 'id="', '"');
                    o.eltOriginalId = sId.substring(4, sId.length - 1);
                }
            });
            o.displayName = displayName;

            o.sourceListName = t[1];
            o.primaryDisplayName = t[2];
            o.sourceFieldName = t[3];
            if (getParameterFromUrl("ID")) {
                // Formulaire de modification
                o.eltCurrentValue = document.getElementById(o.eltOriginalId).value;
            }
            else {
                // Formulaire de création
                o.eltCurrentValue = '';
            }

            o.arrayElements = [];
            o.status = '';
            for (var i = 0; i < primaryChoices.length; i++) {
                if ((o.sourceListName == primaryChoices[i].sourceListName) && (o.primaryDisplayName == primaryChoices[i].displayName)) {
                    primaryChoices[i].secondaryFields.push(secondaryChoices.length);
                    i = primaryChoices.length;
                }
            }

            secondaryChoices.push(o);
            var nouvDiv = document.createElement("div");
            nouvDiv.id = "select" + displayName.replace(/\s/g, '_x0020_');
            $(nouvDiv).appendTo(elem);
        }

        // Tous les autres cas
        if (!source) {
            //find the corresponding field from the default form and move it
            //into the custom layout
            $("table.ms-formtable td").each(function () {
                if (this.innerHTML.indexOf('FieldName="' + displayName + '"') != -1) {
                    $(this).contents().appendTo(elem);
                }
            });
        }
    });

    // Ajouter les balises <select> pour les choix, et alimenter les listes
    for (var i = 0; i < primaryChoices.length; i++) {
        primaryChoices[i].eltId = addSelect(primaryChoices[i].displayName);
        retrieveElements.call(primaryChoices[i]);
    }
    for (var i = 0; i < secondaryChoices.length; i++) {
        secondaryChoices[i].eltId = addSelect(secondaryChoices[i].displayName);

        var indPrim = findPrimaryChoice(secondaryChoices[i].primaryDisplayName);
        var primValue = primaryChoices[indPrim].eltCurrentValue;

        if ((primValue) && (primValue.length > 0)) {
            retrieveSecondaryElements.call(secondaryChoices[i], primValue);
        }
    }

    // Analyse de la table enfant si elle existe
    $("table.SPWChildTable").each(function () {
        childTable = {};
        childTable.listName = $(this).attr("data-listName");
        childTable.tableId = $(this).attr("id");
        childTable.lineId = $(this).attr("data-lineId");
        childTable.headerId = $(this).attr("data-headerId");
        childTable.keyFieldName = $(this).attr("data-keyFieldName");
        childTable.guidFieldName = $(this).attr("data-guidFieldName");
        childTable.cols = [];
    })

    // Si elle existe, lire la structure de la table enfant...
    if (childTable) {
        var elts = document.getElementById(childTable.headerId).children;
        var x = elts.length;

        for (var i = 0; i < elts.length; i++) {
            var cNode = elts[i];

            childTable.cols[i] = {};
            childTable.cols[i].colId = cNode.getAttribute("data-colId");
            childTable.cols[i].fieldName = cNode.getAttribute("data-fieldName");
            childTable.cols[i].source = cNode.getAttribute("data-source");
            childTable.cols[i].fieldType = cNode.getAttribute("data-type");
/* Ajout du 13/03/17 */
	    childTable.cols[i].inputSize = cNode.getAttribute("data-inputSize");
/* Fin ajout */

            var dataAttrib = cNode.getAttribute("data-attrib");
            if ((dataAttrib) && (dataAttrib.indexOf("mandatory") >= 0)) {
                childTable.cols[i].mandatory = true;
            }
/* Ajout du 16/03/17 */
            if ((dataAttrib) && (dataAttrib.indexOf("tooltip") >= 0)) {
                childTable.cols[i].tooltip = true;
            }
/* Fin ajout */

            if ((!childTable.cols[i].fieldType) && (childTable.cols[i].source)) {
                childTable.cols[i].fieldType = "choix";
            }
            else {
                if (!childTable.cols[i].fieldType) { childTable.cols[i].fieldType = "texte"; }
            }

            // Si la colonne est liée à une source externe, la référencer et charger les éléments correspondants
            if ((childTable.cols[i].source) && (childTable.cols[i].source.indexOf("PrimaryChoice") == 0)) {
                var t = childTable.cols[i].source.split(",");
                var o = {};
                o.displayName = childTable.cols[i].colId;
                o.sourceListName = t[1];
                o.sourceFieldName = t[2];
                o.secondaryFields = [];
                o.arrayElements = [];
                o.status = '';
                childPrimaryChoices.push(o);
                retrieveElements.call(o);
            }
        }
        if (getParameterFromUrl("ID")) {
            // Formulaire de modification
            var keyValue = getInput(childTable.keyFieldName);
            var guidValue = getInput(childTable.guidFieldName);
            ChildTable_retrieveListItems.call(oChildTableInitial, keyValue, guidValue);
        }
        ChildTable_display();
    }
}

function appendToSPWDisplayForm() {
    // Cette fonction est appelée à la place de appendToSPWCustomForm() pour l'affichage des formulaires
    //loop through all the spans in the custom layout        
    $("span.SPWCustomForm").each(function () {
        //get the display name from the custom layout
        displayName = $(this).attr("data-displayname");


        // Cas particulier lorsque le displayname contient le caractère & : remplace le & seul par &amp;
        displayName = displayName.replace(/&(?!amp;)/g, '&guid;');

        elem = $(this);
        //find the corresponding field from the default form and move it
        //into the custom layout
        $("table.ms-formtable td").each(function () {
            if (this.innerHTML.indexOf('FieldName="' + displayName + '"') != -1) {
                $(this).contents().appendTo(elem);
            }
        });
    });

    // Analyse de la table enfant si elle existe
    $("table.SPWChildTable").each(function () {
        childTable = {};
        childTable.listName = $(this).attr("data-listName");
        childTable.tableId = $(this).attr("id");
        childTable.lineId = $(this).attr("data-lineId");
        childTable.headerId = $(this).attr("data-headerId");
        childTable.keyFieldName = $(this).attr("data-keyFieldName");
        childTable.guidFieldName = $(this).attr("data-guidFieldName");
        childTable.cols = [];
    })

    // Si elle existe, lire la structure de la table enfant...
    if (childTable) {
        var elts = document.getElementById(childTable.headerId).children;
        var x = elts.length;

        for (var i = 0; i < elts.length; i++) {
            var cNode = elts[i];

            childTable.cols[i] = {};
            childTable.cols[i].colId = cNode.getAttribute("data-colId");
            childTable.cols[i].fieldName = cNode.getAttribute("data-fieldName");
            childTable.cols[i].source = cNode.getAttribute("data-source");
            childTable.cols[i].fieldType = cNode.getAttribute("data-type");
/* Ajout du 13/03/17 */
	    childTable.cols[i].inputSize = cNode.getAttribute("data-inputSize");
/* Fin ajout */

            /*		var dataAttrib = cNode.getAttribute("data-attrib");
                    if ((dataAttrib) && (dataAttrib.indexOf("mandatory") >= 0)) {
                        childTable.cols[i].mandatory = true;
                    }
                    */
/* Ajout du 16/03/17 */
			var dataAttrib = cNode.getAttribute("data-attrib");
            if ((dataAttrib) && (dataAttrib.indexOf("tooltip") >= 0)) {
                childTable.cols[i].tooltip = true;
            }
/* Fin ajout */
					
					
            if (!childTable.cols[i].fieldType) {
                childTable.cols[i].fieldType = "texte";
            }
        }
        var keyValue = getSpanValue(childTable.keyFieldName);
        var guidValue = getSpanValue(childTable.guidFieldName);
        ChildTable_retrieveListItems.call(oChildTableInitial, keyValue, guidValue);
        ChildTable_display();
    }
}

function getSpanValue(spanName) {
    // Bug corrigé
    // Numero_x0020_demande envoyé en arguments
    // Numero demande en data-display dans le fichier HTML
    var newSpanName = spanName.replace("_x0020_", " ");
    spanName = newSpanName;
    var elts = document.getElementsByClassName("SPWCustomForm");
    for (var i = 0; i < elts.length; i++) {
        var dispName = elts[i].getAttribute("data-displayname");
        if ((dispName) && (dispName == spanName)) {
            // alert("*" + elts[i].textContent.trim() + "*");
            return elts[i].textContent.trim();
        }
    }
    return null;
}

function addChildLine(tableId, lineId, indLigne, values) { 
// Ajoute une ligne à la table enfant
// Cette fonction n'est appelée que lorsque toutes les listes de choix ont été chargées avec succès

// si le tableau values n'est pas null, il contient le spid suivi de la valeur de chaque colonne
// pour les colonnes Indice et des colonnes calculées, la valeur est ""

    //<tr id="[lineId][indLigne]" class="[lineId]">
    //    <td>[indLigne]</td>
    //    <td><input id="Qte1" type="text" maxlength="10" value=""/></td>
    //    <td><input id="Designation1" type="text" maxlength="255" value=""/></td>
    //    <td></td>
    //</tr>
	
	if (! tableId) {
		tableId = childTable.tableId;
	}
	if (! lineId) {
		lineId = childTable.lineId;
	}
	var tableauDetail = document.getElementById(tableId);
    var tableauBody = tableauDetail.children[0];
	
	// Si indLigne n'est pas renseigné, récupérer le numéro de ligne le plus élevé
    if (!indLigne) {
        var nbr = 0;
        var elts = document.getElementsByClassName(lineId);
        for (var i = 0; i < elts.length; i++) {
            if (elts[i].id.length > lineId.length) {
                var ind = parseInt(elts[i].id.substring(lineId.length, elts[i].id.length));
                if (ind > nbr) {
                    nbr = ind;
                }
            }
        }
        indLigne = nbr + 1;
    }
	
	// Vérifier que la ligne n'existe pas déjà
    if (document.getElementById(lineId + indLigne.toString())) return;
	
	// La ligne n'existe pas, nous allons la créer

    var nouvLigne = document.createElement("tr");
    nouvLigne.id = lineId + indLigne.toString();
    nouvLigne.className = lineId;
	
	if (values) {
		nouvLigne.setAttribute("data-spid", values[0]);
	}
	else {
		nouvLigne.setAttribute("data-spid", "");
	}
    
	for (var i=0; i < childTable.cols.length; i++) {
		var col = childTable.cols[i];
		var nouvTDElt = document.createElement("td");
		var nouvElt = null;
		if (col.fieldName) {
			if ((col.fieldType == "texte") || (col.fieldType == "nombre") || (col.fieldType == "date")) {
				nouvElt = document.createElement("input");
				nouvElt.type = "text";
/* Ajout du 13/03/17 */
				if (col.inputSize) {
					nouvElt.size = col.inputSize;
				}
/* Fin ajout */
				if (col.fieldType == "nombre") {
					nouvElt.maxLength = "12";
				}
				else {
					nouvElt.maxLength = "255";
				}
				if (values) {
					nouvElt.value = values[i+1];
				}
				else {
					nouvElt.value = "";
				}
				
			}
			if (col.fieldType == "choix") {
				nouvElt = document.createElement("select");
			}
		}
		if (!nouvElt) {
			
			if (col.colId == "Indice") {
				nouvElt = document.createElement("div");
				var nouvIndice = document.createTextNode(indLigne.toString());
				nouvElt.appendChild(nouvIndice);
			}
/* Ajout du 13/03/17 */
			if (col.colId == "Suppr") {
				nouvElt = document.createElement("button");
				nouvElt.id = "Suppr" + indLigne.toString();
				nouvElt.type = "button";
				nouvElt.innerHTML = "Suppr.";
				nouvElt.onclick = function () { deleteChildLine(this); };
			}
			if ((col.colId != "Indice") && (col.colId != "Suppr")) {
				nouvElt = document.createElement("div");
			}
		}
		if (nouvElt) {
			nouvElt.id = col.colId + indLigne.toString();
			nouvElt.className = col.colId; // Ajout du 30/03/2017
			nouvTDElt.appendChild(nouvElt);
			nouvLigne.appendChild(nouvTDElt);
		}
	}
	
/* Suppression du 13/03/17 */
/*
	var nouvTDSuppr = document.createElement("td");
    var nouvButton = document.createElement("button");
    nouvButton.id = "Suppr" + indLigne.toString();
    nouvButton.type = "button";
    nouvButton.innerHTML = "-";
    nouvButton.onclick = function () { deleteChildLine(this); };
    nouvTDSuppr.appendChild(nouvButton);
    nouvLigne.appendChild(nouvTDSuppr);
	*/
	
	tableauBody.appendChild(nouvLigne);
	
	// Initialiser les champs de type choix
	for (var i=0; i < childTable.cols.length; i++) {
		var col = childTable.cols[i];
		if (col.fieldType == "choix") {
			var cpc = findChildPrimaryChoice(col.fieldName);
			if (cpc != null) {
				if (values) {
					//alert("addChildLine 1 : " + childPrimaryChoices[cpc].arrayElements.length.toString() + " éléments");
					resetChildList(col.colId + indLigne.toString(), childPrimaryChoices[cpc].arrayElements, values[i+1]);
				}
				else {
					//alert("addChildLine 2 : " + childPrimaryChoices[cpc].arrayElements.length.toString() + " éléments");
					resetChildList(col.colId + indLigne.toString(), childPrimaryChoices[cpc].arrayElements, "");
				}
			}
		}
	}
	
	
	// Associer aux champs dates du tableau les contrôles d'affichage de calendrier

    for (var i = 0; i < childTable.cols.length; i++) {
        var col = childTable.cols[i];
        if (col.fieldType == "date") {
            $("#" + col.colId + indLigne.toString()).datepicker({
                showWeek: true,
                firstDay: 1,
                numberOfMonths: 1,
                showButtonPanel: true,
                changeMonth: true,
                changeYear: true
            });
        }
    }
	
	// Ajout du 16/03/2017
	// Ajouter aux champs dont data-attrib contient tooltip, les contrôles d'affichage de tooltip
	for (var i = 0; i < childTable.cols.length; i++) {
        var col = childTable.cols[i];
        if (col.tooltip) {
            $("#" + col.colId + indLigne.toString()).tooltip({
				items: "input",
				// content: "Awesome"
				content: function() {
					return $(this).val();
				}
				
            });
        }
    }
	// Fin de l'ajout
	
	customUpdateChildItem(indLigne);
	customUpdateChildTable();
	
	
	/*
	var nouvTDQuantite = document.createElement("td");
    var nouvQuantite = document.createElement("input");
    nouvQuantite.id = "Qte" + indLigne.toString();
    nouvQuantite.type = "text";
    nouvQuantite.maxLength = "10";
    nouvQuantite.value = "";
    nouvQuantite.onchange = function () { calculPrixTotal(this); calculTotal(); };
    nouvTDQuantite.appendChild(nouvQuantite);
    nouvLigne.appendChild(nouvTDQuantite);
	
	var nouvTDUnite = document.createElement("td");
    var nouvUnite = document.createElement("select");
    nouvUnite.id = "Unite" + indLigne.toString();
    nouvTDUnite.appendChild(nouvUnite);
    nouvLigne.appendChild(nouvTDUnite);
	*/
}

function deleteChildLine(obj) {
    // récupérer l'identifiant de l'élément en cours
    var s = obj.id;
    var id;

    if (s.indexOf("Suppr") == 0) {
        id = s.substring(5, s.length);
    }

    var ligne = document.getElementById(childTable.lineId + id);
    if (ligne) {
        var spid = ligne.getAttribute("data-spid");
        ligne.parentNode.removeChild(ligne);
        if ((spid) && (spid.length > 0)) {
            var o = {};
            o.spid = parseInt(spid);
            o.status = "";
            daSuppr.push(o);
        }
        customUpdateChildTable();
    }
}

function addSelect(fieldName, onChangeFunction) {
    var fieldDiv = document.getElementById("select" + fieldName.replace(/\s/g, '_x0020_'));
    if (fieldDiv) {
        var newNode = document.createElement("select");        
        newNode.id = fieldName.replace(/\s/g, '_x0020_') + "_$DropDownChoice";
        newNode.title = fieldName;
        if (onChangeFunction) {
            newNode.onchange = onChangeFunction;
        }
        fieldDiv.appendChild(newNode);
        return newNode.id;
    }
    else {
        return null;
    }
}

function primary_onChange(elt) {
    var parent = elt.parentNode;
    var dName = parent.getAttribute("data-displayname");

    for (var i = 0; i < primaryChoices.length; i++) {
        if (primaryChoices[i].displayName == dName) {
            for (var j = 0; j < primaryChoices[i].secondaryFields.length; j++) {
                var k = primaryChoices[i].secondaryFields[j];
                var secondObj = secondaryChoices[k];
                retrieveSecondaryElements.call(secondObj, document.getElementById(primaryChoices[i].eltId).value);
            }
        }
    }
}
// =============================================================================================================================
function retrieveElements() {
    var clientContext = new SP.ClientContext(siteUrl);
    this.oList = clientContext.get_web().get_lists().getByTitle(this.sourceListName);
    this.status = "";

    var camlQuery = new SP.CamlQuery();
    camlQuery.set_viewXml(
    "<View><Query>" +
    "<OrderBy><FieldRef Name='" + this.sourceFieldName + "' Ascending='TRUE'/></OrderBy>" +
    "<Where>" +
    "<IsNotNull><FieldRef Name='ID' /></IsNotNull>" +
    "</Where>" +
    "</Query></View>"
    );
    this.collItems = this.oList.getItems(camlQuery);

    clientContext.load(this.collItems);
    clientContext.executeQueryAsync(Function.createDelegate(this, retrieveElementsonQuerySucceeded), Function.createDelegate(this, retrieveElementsonQueryFailed));
}

function retrieveSecondaryElements(primaryValue) {
    var clientContext = new SP.ClientContext(siteUrl);
    var primIndice = findPrimaryChoice(this.primaryDisplayName);
    this.oList = clientContext.get_web().get_lists().getByTitle(this.sourceListName);
    this.status = "";

    var camlQuery = new SP.CamlQuery();
    camlQuery.set_viewXml(
    "<View><Query>" +
    "<Where><Eq>" +
    "<FieldRef Name='" + primaryChoices[primIndice].sourceFieldName + "'></FieldRef><Value Type='Text'>" + primaryValue + "</Value>" +
    "</Eq></Where>" +
    "</Query></View>"
    );
    this.collItems = this.oList.getItems(camlQuery);

    clientContext.load(this.collItems);
    clientContext.executeQueryAsync(Function.createDelegate(this, retrieveElementsonQuerySucceeded), Function.createDelegate(this, retrieveElementsonQueryFailed));
}

function retrieveElementsonQuerySucceeded(sender, args) {
    // Reinitialize list
    this.arrayElements = [];
    // Get elements and remove duplicates 
    var listItemInfo = '';
    var listItemEnumerator = this.collItems.getEnumerator();
    var prec = "";
    var title = "";
    while (listItemEnumerator.moveNext()) {
        var oListItem = listItemEnumerator.get_current();
        title = oListItem.get_item(this.sourceFieldName);
        if (title != prec) {
            this.arrayElements.push(title);
        }
        prec = title;
    }
    this.status = "success";
    if (this.eltId != "") {
        resetOptions(this.eltId, this.arrayElements, this.eltCurrentValue);
    }
}

function retrieveElementsonQueryFailed(sender, args) {
    this.status = "failure";
}

// =============================================================================================================================


function formLogError(errMessage) {
    var log = document.getElementById("formLog");
    var log2 = document.getElementById("formLog2");
    log.innerHTML = errMessage;
    log2.innerHTML = errMessage;
}

function PreSaveItemSPW() {
    if (tentativeSauvegarde) {
        // Une première tentative de sauvegarde a été tentée et n'a pas été jusqu'au bout
        tentativeSauvegarde = false;
        demandeNumeroAchat = false;
        demandeSauvegardeTableDetaille = false;
        demandeSuppressionElements = false;
        demandeRechargementTableau = false;
        rechargementTableauEffectue = false;
        lDetailActionsResultats = [];
        // en cas de création , remettre le champ Numero de demande à vide
        if (!getParameterFromUrl("ID")) {
            updateInput("Numero_x0020_demande", "");
        }
    }

    // récupérer le guid de la demande d'achat
    guidDA = getGuid();

    if (checkStatusSauvegardeDA()) {
        // Le corps de la demande est prêt à être enregistré
        tentativeSauvegarde = true;
        return true;
    }
    else {
        processSauvegardeDA();
        return false;
    }
}

function PreSaveItem() {


    // Vérifier les champs obligatoires
    var errMessage = "";
    for (var i = 0; i < mandatoryFields.length; i++) {
        if (mandatoryFields[i].fieldType == "texte") {
            var x = getInput(mandatoryFields[i].displayName.replace(/\s/g, '_x0020_'));
            if ((!x) || (x.length == 0)) {
                errMessage += ("Champ " + mandatoryFields[i].displayName + " obligatoire. ");
            }
        }
        if (mandatoryFields[i].fieldType == "choix") {
            var x = getSelectedValue(mandatoryFields[i].displayName.replace(/\s/g, '_x0020_'));
            if ((!x) || (x.length == 0)) {
                errMessage += ("Champ " + mandatoryFields[i].displayName + " obligatoire. ");
            }
        }
        if (mandatoryFields[i].fieldType == "personne") {
            var x = getUserField(mandatoryFields[i].displayName.replace(/\s/g, '_x0020_'));
            if ((!x) || (x.length == 0)) {
                errMessage += ("Champ " + mandatoryFields[i].displayName + " obligatoire. ");
            }
        }
        // A compléter - Traiter les cas nombre, personne et date
    }
    if (errMessage != "") {
        formLogError(errMessage);
        return false;
    }


    // Vérifier les champs obligatoires enfant
    var errMessage = "";
    if (childTable) {
        var elts = document.getElementsByClassName(childTable.lineId);
        for (var i = 0; i < childTable.cols.length; i++) {
            if ((childTable.cols[i].fieldName) && (childTable.cols[i].mandatory)) {
                // Pour chaque colonne de la table enfant associée à un champ SharePoint
                for (var j = 0; j < elts.length; j++) {
                    // Pour chaque ligne du tableau
                    if (elts[j].id.length > childTable.lineId.length) {
                        var sIndice = elts[j].id.substring(childTable.lineId.length, elts[j].id.length);
                        if (detailNonVide(sIndice)) {

                            var elt = document.getElementById(childTable.cols[i].colId + sIndice);
                            var eltVal = elt.value;
                            if ((!eltVal) || (eltVal.length == 0)) {
                                errMessage += ("Champ " + childTable.cols[i].fieldName + " obligatoire. ");
                            }
                        }
                    }
                }
            }
        }
    }
    if (errMessage != "") {
        formLogError(errMessage);
        return false;
    }

    // Vérifier les contraintes personnalisées
    if (!customPreSaveItem()) {
        return false;
    }

    if (!PreSaveItemSPW()) return false;

    // Recopier les valeurs des Primary Choice et des Secondary Choice dans les champs d'origine
    for (var i = 0; i < primaryChoices.length; i++) {
        var elt = document.getElementById(primaryChoices[i].eltOriginalId);
        if (elt) { elt.value = getSelectedValue(primaryChoices[i].displayName, primaryChoices[i].eltId); }
    }
    for (var i = 0; i < secondaryChoices.length; i++) {
        var elt = document.getElementById(secondaryChoices[i].eltOriginalId);
        if (elt) { elt.value = getSelectedValue(secondaryChoices[i].displayName, secondaryChoices[i].eltId); }
    }

    return true;
}

function getSelectElement(fieldName) {
    // Recherche tous les éléments qui correspondent au tag select
    var selects = document.getElementsByTagName("select");
    // Parmi les éléments remontés, rechercher l'élément dont l'id commence par le fieldName
    var idField = null;
    for (var i = 0; i < selects.length; i++) {
        if (selects[i].id.indexOf(fieldName + "_") == 0) { return selects[i]; }
        if ((selects[i].id.indexOf(fieldName) == 0) && (selects[i].id.length == fieldName.length)) { return selects[i]; }
    }
    // l'élément n'a pas été trouvé. Retourner null
    return null;
}

function setSelectedValue(fieldName, newValue) {
    // Recherche tous les éléments qui correspondent au tag select
    var selects = document.getElementsByTagName("select");
    // Parmi les éléments remontés, rechercher l'élément dont l'id commence par le fieldName
    var idList = null;
    for (var i = 0; i < selects.length; i++) {
        if (selects[i].id.indexOf(fieldName + "_") == 0) { idList = selects[i].id; }
    }
    // Si l'élément a été trouvé, sélectionner l'élément dont la valeur est newValue
    if (idList) {
        var node = document.getElementById(idList);
        for (var i = 0; i < node.childNodes.length; i++) {
            if (node.childNodes[i].value == newValue) { node.childNodes[i].selected = "selected"; }
        }
    }
}

function getSelectedValue(fieldName, fieldId) {
    // fieldId est optionnel, 
    // s'il est connu, on l'utilise directement, 
    // sinon, on recherche sa valeur en utilisant fieldName

    if (!fieldId) {
        // Recherche tous les éléments qui correspondent au tag select
        var selects = document.getElementsByTagName("select");
        // Parmi les éléments remontés, rechercher l'élément dont l'id commence par le fieldName
        for (var i = 0; i < selects.length; i++) {
            if (selects[i].id.indexOf(fieldName + "_") == 0) { fieldId = selects[i].id; }
        }
    }
    // Si l'élément a été trouvé, retourner la valeur de l'élément sélectionné, sinon retourner null
    if (fieldId) {
        var node = document.getElementById(fieldId);
        for (var i = 0; i < node.childNodes.length; i++) {
            if (node.childNodes[i].selected) return node.childNodes[i].value;
        }
    }
    else {
        return null;
    }
}


function updateInput(fieldName, newVal) {
    // Recherche tous les éléments qui correspondent au tag input
    var inputs = document.getElementsByTagName("input");
    // Parmi les éléments remontés, rechercher l'élément dont l'id commence par le fieldName
    var idField = null;
    for (var i = 0; i < inputs.length; i++) {
        if (inputs[i].id.indexOf(fieldName + "_") == 0) { idField = inputs[i].id; }
    }
    // si l'élement a été trouvé, modifier sa valeur
    if (idField) {
        document.getElementById(idField).value = newVal;
    }
    return idField;
}

function updateInput0(fieldName, newVal) {
    // Recherche tous les éléments qui correspondent au tag input
    var inputs = document.getElementsByTagName("input");
    // Parmi les éléments remontés, rechercher l'élément dont l'id commence par le fieldName
    var idField = null;
    for (var i = 0; i < inputs.length; i++) {
        if (inputs[i].id.indexOf(fieldName) == 0) { idField = inputs[i].id; }
    }
    // si l'élement a été trouvé, modifier sa valeur
    if (idField) {
        document.getElementById(idField).value = newVal;
    }
    return idField;
}

function getInput(fieldName) {
    // Recherche tous les éléments qui correspondent au tag input
    var inputs = document.getElementsByTagName("input");
    // Parmi les éléments remontés, rechercher l'élément dont l'id commence par le fieldName
    var idField = null;
    for (var i = 0; i < inputs.length; i++) {
        if (inputs[i].id.indexOf(fieldName + "_") == 0) { idField = inputs[i].id; }
    }
    // si l'élement a été trouvé, retourner sa valeur, sinon retourner null
    if (idField) {
        return document.getElementById(idField).value;
    }
    else {
        return null;
    }
}

function getInputElement(fieldName) {
    // Recherche tous les éléments qui correspondent au tag input
    var inputs = document.getElementsByTagName("input");
    // Parmi les éléments remontés, rechercher l'élément dont l'id commence par le fieldName
    var idField = null;
    for (var i = 0; i < inputs.length; i++) {
        if (inputs[i].id.indexOf(fieldName + "_") == 0) { return inputs[i]; }
        if ((inputs[i].id.indexOf(fieldName) == 0) && (inputs[i].id.length == fieldName.length)) { return inputs[i]; }
    }
    // l'élément n'a pas été trouvé. Retourner null
    return null;
}

/* Ajouts du 20/03/2017 : fonctions getTextArea() et updateTextArea() */
function getTextArea(fieldName) {
	    // Recherche tous les éléments qui correspondent au tag textarea
    var textareas = document.getElementsByTagName("textarea");
    // Parmi les éléments remontés, rechercher l'élément dont l'id commence par le fieldName
    var idField = null;
    for (var i = 0; i < textareas.length; i++) {
        if (textareas[i].id.indexOf(fieldName + "_") == 0) { idField = textareas[i].id; }
    }
    // si l'élement a été trouvé, retourner sa valeur, sinon retourner null
    if (idField) {
        return document.getElementById(idField).value;
    }
    else {
        return null;
    }
}

function updateTextArea(fieldName, newVal) {
    // Recherche tous les éléments qui correspondent au tag textarea
    var textareas = document.getElementsByTagName("textarea");
    // Parmi les éléments remontés, rechercher l'élément dont l'id commence par le fieldName
    var idField = null;
    for (var i = 0; i < textareas.length; i++) {
        if (textareas[i].id.indexOf(fieldName + "_") == 0) { idField = textareas[i].id; }
    }
    // si l'élement a été trouvé, modifier sa valeur
    if (idField) {
        document.getElementById(idField).value = newVal;
    }
    return idField;
}
// =================================================================================================================
// La fonction resetList met à jour la structure HTML correspondant à la liste de choix pour un champ donné

// Les paramètres de cette fonction sont :
// * fieldName  : le nom du champ 
// * newVals    : Tableau des valeurs possibles
// * action     : Fonction à exécuter lorsqu'une valeur est sélectionnée dans la liste
// * selectedVal: Valeur initialement sélectionnée dans la liste

// Elle retourne comme valeur l'id de l'élément HTML

function resetList(fieldName, newVals, action, selectedVal) {
    // Recherche tous les éléments qui correspondent au tag select
    var selects = document.getElementsByTagName("select");
    // Parmi les éléments remontés, rechercher l'élément dont l'id commence par le fieldName
    var idList = null;
    for (i = 0; i < selects.length; i++) {
        if (selects[i].id.indexOf(fieldName + "_") == 0) { idList = selects[i].id; }
        if ((selects[i].id.indexOf(fieldName) == 0) && (selects[i].id.length == fieldName.length)) { idList = selects[i].id; }
    }
    // Si l'élément a été trouvé, supprimer tous les éléments enfants
    if (idList) {
        while (document.getElementById(idList).childNodes.length > 0) {
            var lChild = document.getElementById(idList).lastChild;
            lChild.parentNode.removeChild(lChild);
        }
    }
    // Si l'élément a été trouvé, ajouter les nouveaux éléments
    // <option value="...">...</option>
    if (idList) {
        for (i = -1; i < newVals.length; i++) {
            var newNode = document.createElement("option");
            if (i == -1) {
                newNode.value = "";
                if ((!selectedVal) || (selectedVal.length == 0)) newNode.selected = "selected";
            }
            else {
                newNode.value = newVals[i];
                newNode.innerText = newVals[i];
                if (selectedVal == newVals[i]) newNode.selected = "selected";
            }
            document.getElementById(idList).appendChild(newNode);
        }
    }

    // si l'élément a été trouvé, ajouter l'action onchange
    if ((idList) && (action)) {
        document.getElementById(idList).onchange = action;
    }
    return idList;
}

function resetOptions(fieldName, newVals, selectedVal) {
    resetList(fieldName, newVals, null, selectedVal);
}


// =================================================================================================================
// La fonction resetChildList met à jour la structure HTML correspondant à la liste de choix pour élément d'une table enfant

// Les paramètres de cette fonction sont :
// * eltId  	: l'id de l'élément 
// * newVals    : Tableau des valeurs possibles
// * selectedVal: Valeur initialement sélectionnée dans la liste

function resetChildList(eltId, newVals, selectedVal) {
/* Ajout pour debogage */
// alert("resetChildList : " + newVals.length.toString() + " éléments");
/* Fin ajout */

    // Supprimer les éventuels éléments enfants
    while (document.getElementById(eltId).childNodes.length > 0) {
        var lChild = document.getElementById(eltId).lastChild;
        lChild.parentNode.removeChild(lChild);
    }

    // Ajouter les nouveaux éléments
    // <option value="...">...</option>
    for (i = -1; i < newVals.length; i++) {
        var newNode = document.createElement("option");
        if (i == -1) {
            newNode.value = "";
            if ((!selectedVal) || (selectedVal.length == 0)) newNode.selected = "selected";
        }
        else {
            newNode.value = newVals[i];
            newNode.innerText = newVals[i];
            if (selectedVal == newVals[i]) newNode.selected = "selected";
        }
        document.getElementById(eltId).appendChild(newNode);
    }
}

function resetOptions(fieldName, newVals, selectedVal) {
    resetList(fieldName, newVals, null, selectedVal);
}


// =================================================================================================================
// Fonctions diverses

// Conversion du format DD/MM/AAAA ou DD-MM-AAAA au format MM/DD/AAAA
function reverseMonthDay(dateStr) {
    dateStr = dateStr.replace(/\-/g, "/");
    var parts = dateStr.split("/");
    return (parts[1] + "/" + parts[0] + "/" + parts[2]);
}

// Conversion d'une chaîne de caractères en date
function toDate(dateStr) {
    var parts = dateStr.split("/");
    return new Date(parts[2], parts[1] - 1, parts[0]);
}

// Calcul du nombre de jours entre 2 dates
function daysBetween(date1, date2) {
    //Get 1 day in milliseconds
    var one_day = 1000 * 60 * 60 * 24;

    // Convert both dates to milliseconds
    var date1_ms = date1.getTime();
    var date2_ms = date2.getTime();

    // Calculate the difference in milliseconds
    var difference_ms = date2_ms - date1_ms;

    // Convert back to days and return
    return Math.abs(Math.round(difference_ms / one_day));
}
function getParameterFromUrl(pName) {
    // Renvoi la valeur d'un paramètre dans une URL si le paramètre existe, null sinon
    var t = window.location.search.substring(1).split('&');
    for (var i = 0; i < t.length; i++) {
        var x = t[i].split('=');
        if (x[0] == pName) return x[1];
    }
    return null;
}
// Source : http://byronsalau.com/blog/how-to-create-a-guid-uuid-in-javascript/
function createGuid() {
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
        var r = Math.random() * 16 | 0, v = c === 'x' ? r : (r & 0x3 | 0x8);
        return v.toString(16);
    });
}

function findSubstring(s, start, end) {
    var i1 = s.indexOf(start);
    if (i1 == -1) return null;
    var s2 = s.substring(i1 + start.length, s.length);
    var i2 = s2.indexOf(end);
    if (i2 == -1) return null;
    return s.substring(i1, i1 + start.length + i2 + end.length);
}
// -----------------------------------------------------------------------------------------------------------------------------
var oCurrentUser = {
    fullLogin: null,
    login: null,
    status: "", // status has 3 possible values : "", "success", "failure"
}

function CheckCurrentUser() {
    var requestUri = _spPageContextInfo.webAbsoluteUrl + "/_api/web/currentuser";
    var requestHeaders = { "accept": "application/json;odata=verbose" };
    $.ajax({
        url: requestUri,
        contentType: "application/json;odata=verbose",
        headers: requestHeaders,
        success: onGcuSuccess,
        error: onGcuError
    });
}

function onGcuSuccess(data, request) {
    var userName = data.d.LoginName;
    //parse the value. 
    var t = userName.toString().split("|");
    //userName=t[t.length-1];
    //SetUserFieldValue("Demandeur",userName);
    oCurrentUser.fullLogin = data.d.LoginName;
    oCurrentUser.login = t[t.length - 1];
    oCurrentUser.status = "success";
    if (!PreLoadForm()) {
        location.href = sourceUrl;
    };

    // En cas de création de formulaire, initialiser les éventuels champs dont data-attrib contient currentUser
    // ainsi que le champ DemandeurLogin

    if (!getParameterFromUrl("ID")) {
        for (var i = 0; i < currentUserFields.length; i++) {
            SetUserFieldValue(currentUserFields[i], oCurrentUser.login);
        }
        updateInput("DemandeurLogin", oCurrentUser.login)
    }


}

function onGcuError(error) {
    oCurrentUser.status = "failure";
    alert("Désolé, ce formulaire va être fermé car nous n'avons pas pu vous authentifier.");
    location.href = sourceUrl;
}

function SetUserFieldValue(fieldName, userName) {
    // fieldName est le nom du champ à initialiser
    // userName est le login de l'utilisation, par exemple brian@spw2.onmicrosoft.com

    var _PeoplePicker = $("div[title='" + fieldName + "']");
    var _PeoplePickerTopId = _PeoplePicker.attr('id');
    //var _PeoplePickerEditer = $("input[title='" + fieldName + "']");
    var _PeoplePickerEditer = $("input[id='" + _PeoplePickerTopId + "_EditorInput']");
    _PeoplePickerEditer.val(userName);
    var _PeoplePickerOject = SPClientPeoplePicker.SPClientPeoplePickerDict[_PeoplePickerTopId];
	_PeoplePickerOject.AddUnresolvedUserFromEditor(true);
}

/* Ajout du 20/03/2017 */
function ClearUserFieldValue(fieldName) {
    // fieldName est le nom du champ à initialiser

    var _PeoplePicker = $("div[title='" + fieldName + "']");
    var _PeoplePickerTopId = _PeoplePicker.attr('id');
    var _PeoplePickerOject = SPClientPeoplePicker.SPClientPeoplePickerDict[_PeoplePickerTopId];
	_PeoplePickerOject.DeleteProcessedUser();
}
/* Fin ajout */


function getUserField(fieldName) {
    var _PeoplePicker = $("div[title='" + fieldName + "']");
    var _PeoplePickerTopId = _PeoplePicker.attr('id');
    var child = document.getElementById(_PeoplePickerTopId + "_HiddenInput");
    return child.value;
}

// ======================================================================================================================================
// Gestion du tableau enfant

// Partie 1 : Chargement du tableau
// Récupérer la liste des éléments du tableau enfant

var oChildTableInitial = {
    arrayElements: [], // Contient l'ensemble des lignes, avec en début de chaque ligne le spid (sharepoint id)
    status: "" // status has 3 possible values : "", "success", "failure"
}

function resetChildTableInitial() {
    oChildTableInitial.arrayElements = [];
    oChildTableInitial.status = "";
}

function ChildTable_retrieveListItems(keyValue, guidValue) {
    //function ChildTable_retrieveListItems() {
    //   var key = getInput(childTable.keyFieldName);

/* Modification du 16/03/2017 : la variable keyValue n'est plus utilisée. Seul le guidValue sert à localiser le détail des achats  */ 
/*    if ((keyValue) && (keyValue.length > 0)) { */
        //      var guidElt = getInput(childTable.guidFieldName);
        var clientContext = new SP.ClientContext(siteUrl);
        this.oList = clientContext.get_web().get_lists().getByTitle(childTable.listName);
        this.status = "";

        var camlQuery = new SP.CamlQuery();
/* Modification du 16/03/2017 : Seul le guid est utilisé pour retrouver les éléments de détail */ 
/*
        camlQuery.set_viewXml(
        "<View><Query>" +
        "<OrderBy><FieldRef Name='Indice' Ascending='TRUE'/></OrderBy>" +
        "<Where><And>" +
        "<Eq><FieldRef Name='" + childTable.keyFieldName + "'/><Value Type='Text'>" + keyValue + "</Value></Eq>" +
        "<Eq><FieldRef Name='" + childTable.guidFieldName + "'/><Value Type='Text'>" + guidValue + "</Value></Eq>" +
        "</And></Where>" +
        "</Query></View>"
        );
		*/
		camlQuery.set_viewXml(
        "<View><Query>" +
        "<OrderBy><FieldRef Name='Indice' Ascending='TRUE'/></OrderBy>" +
        "<Where>" +
        "<Eq><FieldRef Name='" + childTable.guidFieldName + "'/><Value Type='Text'>" + guidValue + "</Value></Eq>" +
        "</Where>" +
        "</Query></View>"
        );
/* Fin de la modification */
        this.collItems = this.oList.getItems(camlQuery);

        clientContext.load(this.collItems);
        clientContext.executeQueryAsync(Function.createDelegate(this, CTRetrieveListItemsonQuerySucceeded), Function.createDelegate(this, CTRetrieveListItemsonQueryFailed));
/*    } */
}

function CTRetrieveListItemsonQuerySucceeded(sender, args) {
    this.arrayElements = [];
    // Get elements
    var listItemInfo = '';
    var listItemEnumerator = this.collItems.getEnumerator();
    var i = 0;

    while (listItemEnumerator.moveNext()) {
        i = i + 1;
        var oListItem = listItemEnumerator.get_current();

        var elt = [];
        elt.push(oListItem.get_item('ID'));
        for (var i = 0; i < childTable.cols.length; i++) {
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
        oChildTableInitial.arrayElements.push(elt);
    }
    this.status = "success";
}

function CTRetrieveListItemsonQueryFailed(sender, args) {
    //ajouterTrace('Request failed from demandeAchat_retrieveListItems', args.get_message() + '\n' + args.get_stackTrace());
    this.status = "failure";
    alert('Request failed from demandeAchat_retrieveListItems. ' + args.get_message() + '\n' + args.get_stackTrace());
}

// -----------------------------------------------------------------------------------------------------------------------------
// Partie 2 : Affichage du tableau enfant 

var handlerTimeoutCTDisplay;
var handlerIntervalCTDisplay;

/* Ancienne version */
/*
function checkCTDisplay() {
    var allSuccess = 1;
    for (var i = 0; i < childPrimaryChoices.length; i++) {
        if (childPrimaryChoices[i].status != "success") {
            allSuccess = 0;
        }
    }
    if (getParameterFromUrl("ID")) {
        // Formulaire de modification
        if (oChildTableInitial.status != "success") { allSuccess = 0; }
    }
    if (allSuccess) {
        clearTimeout(handlerTimeoutCTDisplay);
        clearInterval(handlerIntervalCTDisplay);
        if (getParameterFromUrl("ID")) {
            // Formulaire de modification
            for (var i = 0; i < oChildTableInitial.arrayElements.length; i++) {
                addChildLine(childTable.tableId, childTable.lineId, i + 1, oChildTableInitial.arrayElements[i]);
            }
        }
        else {
            // Formulaire de création
            for (var i = 0; i < 2; i++) {
                addChildLine(childTable.tableId, childTable.lineId, i + 1);
            }
        }
    }
}
*/
function checkCTDisplay() {
    for (var i = 0; i < childPrimaryChoices.length; i++) {
        if (childPrimaryChoices[i].status != "success") {
            return;
        }
    }
    if (getParameterFromUrl("ID")) {
        // Formulaire de modification
        if (oChildTableInitial.status != "success") { return; }
    }

	// Les conditions sont remplies pour afficher le tableau détail
	clearTimeout(handlerTimeoutCTDisplay);
	clearInterval(handlerIntervalCTDisplay);
	if (getParameterFromUrl("ID")) {
		// Formulaire de modification
		for (var i = 0; i < oChildTableInitial.arrayElements.length; i++) {
			addChildLine(childTable.tableId, childTable.lineId, i + 1, oChildTableInitial.arrayElements[i]);
		}
	}
	else {
		// Formulaire de création
		for (var i = 0; i < 2; i++) {
			addChildLine(childTable.tableId, childTable.lineId, i + 1);
		}
	}

}

function timeoutCTDisplay() {
    clearInterval(handlerIntervalCTDisplay);
    for (var i = 0; i < childPrimaryChoices.length; i++) {
        childPrimaryChoices[i].status = "failure";
    }
    if (getParameterFromUrl("ID")) {
        oChildTableInitial.status = "failure";
    }
}

function ChildTable_display() {
    handlerTimeoutCTDisplay = setTimeout(timeoutCTDisplay, 5000); // Timeout after 5 seconds
    handlerIntervalCTDisplay = setInterval(checkCTDisplay, 200); // Check every 0,2 second
}

// -----------------------------------------------------------------------------------------------------------------------------
// Cas 1 : Formulaire de création
/*
var handlerTimeoutCFNew;
var handlerIntervalCFNew;

function checkCFNew() {
    // Check Child Fields - New Form
	var allSuccess = 1;
	for (var i=0; i < childPrimaryChoices.length; i++) {
		if (childPrimaryChoices[i].status != "success") {
			allSuccess = 0;
		}
	}
	
	if (allSuccess) {
		clearTimeout(handlerTimeoutCFNew);
        clearInterval(handlerIntervalCFNew);
		
		// Insert the code to execute when all lists are available
        for (var i=0; i < 2; i++) {
			addChildLine(childTable.tableId, childTable.lineId, i+1);
		}
	}
	else {
		for (var i=0; i < childPrimaryChoices.length; i++) {
		if (childPrimaryChoices[i].status == "failure") {
			childPrimaryChoices[i].status = "";
			retrieveElements.call(childPrimaryChoices[i]);
		}
	}	
	}
}


function timeoutCFNew() {
	// Timeout Child Fields - New Form
	clearInterval(handlerIntervalCFNew);
	for (var i=0; i < childPrimaryChoices.length; i++) {
		childPrimaryChoices[i].status = "failure";
	}
}

function processCFNew() {
	// Process Child Fields - New Form
    handlerTimeoutCFNew = setTimeout(timeoutCFNew, 5000); // Timeout after 5 seconds
    handlerIntervalCFNew = setInterval(checkCFNew, 200); // Check every 0,2 second
}
*/
// -----------------------------------------------------------------------------------------------------------------------------
// Cas 2 : Formulaire de modification
/*
var handlerTimeoutCFUpdate;
var handlerIntervalCFUpdate;

function checkCFUpdate() {
	// Check Child Fields - Update Form
	var allSuccess = 1;
	for (var i=0; i < childPrimaryChoices.length; i++) {
		if (childPrimaryChoices[i].status != "success") {
			allSuccess = 0;
		}
	}
	if ((allSuccess) && (oChildTableInitial.status == "success")) {
		clearTimeout(handlerTimeoutCFUpdate);
        clearInterval(handlerIntervalCFUpdate);
		
		// Insert the code to execute when all lists are available
        for (var i=0; i < oChildTableInitial.arrayElements.length; i++) {
			addChildLine(childTable.tableId, childTable.lineId, i+1, oChildTableInitial.arrayElements[i]);
		}
	}
	else {
		for (var i=0; i < childPrimaryChoices.length; i++) {
			if (childPrimaryChoices[i].status == "failure") {
				childPrimaryChoices[i].status = "";
				retrieveElements.call(childPrimaryChoices[i]);
			}
		}
		
		if (oChildTableInitial.status == "failure") {
			oChildTableInitial.status = "";
			ChildTable_retrieveListItems.call(oChildTableInitial);
		}
	}
}

function timeoutCFUpdate() {
	clearInterval(handlerIntervalCFUpdate);
	for (var i=0; i < childPrimaryChoices.length; i++) {
		childPrimaryChoices[i].status = "failure";
	}
    oChildTableInitial.status = "failure";
}

function processCFUpdate() {
    handlerTimeoutCFUpdate = setTimeout(timeoutCFUpdate, 5000); // Timeout after 5 seconds
    handlerIntervalCFUpdate = setInterval(checkCFUpdate, 200); // Check every 0,2 second
}
*/
// ======================================================================================================================================
// Partie 2.1 : Sauvegarde du tableau détail

// Cette structure est utilisée par les fonctions ajouterLigneDA et modifierLigneDA
// On stocke pour chaque ligne l'action que l'on va réaliser ("ajout" ou "modification"), et le résultat de l'action ("success" ou "failure")

var lDetailActionsResultats = [];
/* Ce tableau contient des objets ayant la structure suivante :
{
    indice: <numéro d'indice de l'élément dans le tableau>
    typeOperation: "ajout" ou "modification"
    status: "" ou "success" ou "failure"
}
*/

function initlDetailActionsResultats() {
    var indice;

    lDetailActionsResultats = [];

    var tableauDetailDA = document.getElementById(childTable.tableId);
    var tableauBody = tableauDetailDA.children[0];
    var elts = tableauBody.getElementsByClassName(childTable.lineId);
    for (var i = 0; i < elts.length; i++) {
        var elt = elts[i];
        var sIndice = elt.id.substring(childTable.lineId.length, elt.id.length);
        if (detailNonVide(sIndice)) {
            indice = i + 1;
            var o = {};
            o.indice = indice;
            var spId = elt.getAttribute("data-spid");
            if ((!spId) || (spId.length == 0)) {
                o.typeOperation = "ajout";
            }
            else {
                o.typeOperation = "modification";
            }
            o.status = "";
            lDetailActionsResultats.push(o);
        }
    }
}

function enregistrerLignesDA() {
    var cle = getInput(childTable.keyFieldName);
    var indice;
    var quantite;
    var unite;
    var designation;

    // Ajouter les lignes pour lesquelles data-spid est vide
    // Mettre à jour les lignes pour lesquelles data-spid n'est pas vide

    var tableauDetailDA = document.getElementById(childTable.tableId);
    var tableauBody = tableauDetailDA.children[0];
    var elts = tableauBody.getElementsByClassName(childTable.lineId);

    for (var i = 0; i < elts.length; i++) {
        var elt = elts[i];
        var sIndice = elt.id.substring(childTable.lineId.length, elt.id.length);
        indice = i + 1;

        if (detailNonVide(sIndice)) {
            var spId = elt.getAttribute("data-spid");
            if ((!spId) || (spId.length == 0)) {

                ajouterLigneDA.call(lDetailActionsResultats[i], cle, indice, sIndice);
            }
            else {
                modifierLigneDA.call(lDetailActionsResultats[i], cle, spId, sIndice);
            }
        }
    }
}


function ajouterLigneDA(cle, indice, sIndice) {

    // quantite, unite, designation, reference, prixUnitaire, dateLivraisonSouhaitee

    var clientContext = new SP.ClientContext(siteUrl);
    this.oList = clientContext.get_web().get_lists().getByTitle(nomTableDetail);
    this.status = "";

    var itemCreateInfo = new SP.ListItemCreationInformation();
    this.oListItem = this.oList.addItem(itemCreateInfo);

    this.oListItem.set_item(childTable.keyFieldName, cle);
    this.oListItem.set_item(childTable.guidFieldName, guidDA);
    this.oListItem.set_item('Indice', indice);

    for (var i = 0; i < childTable.cols.length; i++) {
        var col = childTable.cols[i];
        var elt, eltVal;
        if (col.fieldName) {
            if (col.fieldType == "texte") {
                elt = getInputElement(col.colId + sIndice);
                eltVal = elt.value;
                this.oListItem.set_item(col.fieldName, eltVal);
            }
            if (col.fieldType == "choix") {
                elt = getSelectElement(col.colId + sIndice);
                eltVal = elt.value;
                this.oListItem.set_item(col.fieldName, eltVal);
            }
            if (col.fieldType == "nombre") {
                elt = getInputElement(col.colId + sIndice);
                eltVal = elt.value;
                this.oListItem.set_item(col.fieldName, eltVal.replace(",", "."));
            }
            if (col.fieldType == "date") {
                elt = getInputElement(col.colId + sIndice);
                eltVal = elt.value;
                this.oListItem.set_item(col.fieldName, reverseMonthDay(eltVal));
            }
        }
    }

    this.oListItem.update();
    clientContext.load(this.oListItem);
    clientContext.executeQueryAsync(Function.createDelegate(this, ajouterLigneDA_onQuerySucceeded), Function.createDelegate(this, ajouterLigneDA_onQueryFailed));
}

function ajouterLigneDA_onQuerySucceeded() {
    this.status = "success";
    //alert('Item created: ' + oListItem.get_id());
}

function ajouterLigneDA_onQueryFailed(sender, args) {
    // ajouterTrace('Request failed from ajouterLigneDA', args.get_message() + '\n' + args.get_stackTrace());
    this.status = "failure";
    alert('Request failed from ajouterLigneDA ' + args.get_message() + '\n' + args.get_stackTrace());

}

function modifierLigneDA(cle, spId, sIndice) {
    // cle contient le numéro du formulaire
    // spid contient le sharepoint id de l'élément à mettre à jour
    // sIndice contient l'indice tel qu'il apparait en find d'id HTML de la ligne qui contient les nouvelles valeurs
    var clientContext = new SP.ClientContext(siteUrl);
    this.oList = clientContext.get_web().get_lists().getByTitle(nomTableDetail);
    this.status = "";

    this.oListItem = this.oList.getItemById(parseInt(spId));
    this.oListItem.set_item(childTable.keyFieldName, cle);

    for (var i = 0; i < childTable.cols.length; i++) {
        var col = childTable.cols[i];
        var elt, eltVal;
        if (col.fieldName) {
            if (col.fieldType == "texte") {
                elt = getInputElement(col.colId + sIndice);
                eltVal = elt.value;
                this.oListItem.set_item(col.fieldName, eltVal);
            }
            if (col.fieldType == "choix") {
                elt = getSelectElement(col.colId + sIndice);
                eltVal = elt.value;
                this.oListItem.set_item(col.fieldName, eltVal);
            }
            if (col.fieldType == "nombre") {
                elt = getInputElement(col.colId + sIndice);
                eltVal = elt.value;
                this.oListItem.set_item(col.fieldName, eltVal.replace(",", "."));
            }
            if (col.fieldType == "date") {
                elt = getInputElement(col.colId + sIndice);
                eltVal = elt.value;
                this.oListItem.set_item(col.fieldName, reverseMonthDay(eltVal));
            }
        }
    }
    this.oListItem.update();

    clientContext.executeQueryAsync(Function.createDelegate(this, modifierLigneDA_onQuerySucceeded), Function.createDelegate(this, modifierLigneDA_onQueryFailed));
}

function modifierLigneDA_onQuerySucceeded() {
    this.status = "success";
}

function modifierLigneDA_onQueryFailed(sender, args) {
    // ajouterTrace('Request failed from modifierLigneDA', args.get_message() + '\n' + args.get_stackTrace());
    this.status = "failure";
    alert('Request failed from modifierLigneDA. ' + args.get_message() + '\n' + args.get_stackTrace());

}

// -----------------------------------------------------------------------------------------------------------------------------
// Partie 2.2 : Au moment de la sauvegarde, permet de coder le traitement des lignes à supprimer

var daSuppr = [];
/* Ce tableau contient des objets ayant la structure suivante :
{
    spid: ID SharePoint de l'élément à supprimer
    status: "" ou "success" ou "failure"
}
*/

// Code pour la suppression des lignes 
function supprimerLignesDA() {
    for (var i = 0; i < daSuppr.length; i++) {
        supprimerLigneDA.call(daSuppr[i]);
    }
}

function supprimerLigneDA() {
    var clientContext = new SP.ClientContext(siteUrl);
    this.oList = clientContext.get_web().get_lists().getByTitle(nomTableDetail);
    this.status = "";

    this.oListItem = this.oList.getItemById(this.spid);
    this.oListItem.deleteObject();
    clientContext.executeQueryAsync(Function.createDelegate(this, supprimerLigneDA_onQuerySucceeded), Function.createDelegate(this, supprimerLigneDA_onQueryFailed));
}

function supprimerLigneDA_onQuerySucceeded() {
    this.status = "success";
}

function supprimerLigneDA_onQueryFailed(sender, args) {
    //ajouterTrace('Request failed from supprimerLigneDA', args.get_message() + '\n' + args.get_stackTrace());
    this.status = "failure";
    alert('Request failed from supprimerLigneDA. ' + args.get_message() + '\n' + args.get_stackTrace());
}

// =====================================================================================================================================================
// Recherche d'un numéro de clé disponible

var oLastNum = {
    spListName: "",
    spField: "",
    numero: null,
    status: "", // status has 3 possible values : "", "success", "failure"
}

/* Modification du 16/03/2017 : La fonction getLastNum() n'est plus nécessaire */
/*
function getLastNum() {
    // Récupère le dernier numéro s'il existe
    // Cette fonction est lancée dans le contexte de l'objet défini précédemment
    // getLastID.call(o)

    this.spListName = nomTableID;
    this.spField = childTable.keyFieldName;

    var clientContext = new SP.ClientContext(siteUrl);
    this.oList = clientContext.get_web().get_lists().getByTitle(this.spListName);
    this.status = "";

    var camlQuery = new SP.CamlQuery();
    camlQuery.set_viewXml(
    "<View><Query>" +
    "<OrderBy><FieldRef Name='ID' Ascending='False' /></OrderBy>" +
    "<Where><IsNotNull><FieldRef Name='ID' /></IsNotNull></Where>" +
    "</Query><RowLimit>1</RowLimit></View>"
    );
    this.collItems = this.oList.getItems(camlQuery);

    clientContext.load(this.collItems);
    clientContext.executeQueryAsync(Function.createDelegate(this, getLastNumSucceeded), Function.createDelegate(this, getLastNumFailed));
}

function getLastNumSucceeded() {

    var listItemInfo = '';
    var listItemEnumerator = this.collItems.getEnumerator();
    if (listItemEnumerator.moveNext()) {
        // Get the first element of the list
        var oListItem = listItemEnumerator.get_current();
        this.numero = oListItem.get_item(this.spField);
    }
    else {
        // Ask for the number to use
        var sNum = prompt("Quel est le numéro à utiliser pour cet élément ?");
        this.numero = (parseInt(sNum) - 1).toString();
    }
    this.status = "success";
    updateInput(childTable.keyFieldName, (parseInt(this.numero) + 1).toString());
    // updateInput("Numero_x0020_demande", (parseInt(this.numero) + 1).toString());
}

function getLastNumFailed() {
    this.status = "failure";
}
*/
// -----------------------------------------------------------------------------------------------------------------------------
function getGuid() {
    // Récupère le guid de la demande d'achat s'il existe
    // Sinon, génère un nouveau guid et l'associe à la demande d'achat
    var res = getInput('GuidDemande');
    if ((!res) || (res == "")) {
        res = createGuid();
        updateInput('GuidDemande', res);
        return res;
    }
    else {
        return res;
    }
}

// =====================================================================================================================================================
// Traitements lors de la sauvegarde de la demande d'achats

var handlerTimeoutSauvegardeDA;
var handlerIntervalSauvegardeDA;

var tentativeSauvegarde = false; // Cette variable est mise à true par PreSaveItem uniquement dans le cas où cette fonction renvoie true
var demandeNumeroAchat = false;
var demandeSauvegardeTableDetaille = false;
var demandeSuppressionElements = false;
var demandeRechargementTableau = false;
var rechargementTableauEffectue = false;

function checkStatusSauvegardeDA() {
    // Renvoie true si toutes les conditions pour la sauvegarde sont réunies, et false sinon

	/* Modification du 16/03/2017 : Le numéro de demande n'est plus nécessaire */
	/*
    numFormulaire = getInput(childTable.keyFieldName);
    if ((!numFormulaire) || (numFormulaire.length == 0)) {
        return false;
    }
	*/
    for (var i = 0; i < daSuppr.length; i++) {
        if (daSuppr[i].status != "success") return false;
    }

    if (lDetailActionsResultats.length == 0) {
        initlDetailActionsResultats();
    }
    for (var i = 0; i < lDetailActionsResultats.length; i++) {
        if (lDetailActionsResultats[i].status != "success") return false;
    }
    if (oChildTableInitial.status != "success") return false;

	/* Ajout du 20/03/2017 */
	if (!rechargementTableauEffectue) {
		return false;
	}
	/* Fin ajout */
	
    return true;
}

function checkSauvegardeDA() {
    if (checkStatusSauvegardeDA()) {
        clearTimeout(handlerTimeoutSauvegardeDA);
        clearInterval(handlerIntervalSauvegardeDA);

        // Insert the code to execute when DA is ready to be saved
        var elts = document.getElementsByTagName("input")
        for (var i = 0; i < elts.length; i++) {
            if (elts[i].value == "Enregistrer") {
                saveButton = elts[i];
                i = elts.length;
            }
        }
        if (saveButton) {
            //alert("Simulation click sur bouton Save")
            saveButton.onclick();
        }
        else {
            formLogError("Bouton de sauvegarde introuvable");
        }
        return;
    }

    // Cas où le numéro de demande d'achat n'est pas connu
	/* Mise à jour du 16/03/2017 : le numéro de demande n'est plus nécessaire à la sauvegarde */
	/*
    numFormulaire = getInput(childTable.keyFieldName);
    if ((!numFormulaire) || (numFormulaire.length == 0)) {
        if (!demandeNumeroAchat) {
            demandeNumeroAchat = true;
            getLastNum.call(oLastNum);
            return;
        }
        else {
            if (oLastNum.status != "success") {
                return;
            }
            else {
                updateInput(childTable.keyFieldName, oLastNum.numero + 1);
                numFormulaire = oLastNum.numero + 1;
            }
        }
    }
	*/

    // Cas où tous les éléments à supprimer ne l'ont pas été avec succès
    var allSuccess = true;
    for (var i = 0; i < daSuppr.length; i++) {
        if (daSuppr[i].status != "success") { allSuccess = false; }
    }
    if (!allSuccess) {
        if (!demandeSuppressionElements) {
            demandeSuppressionElements = true;
            resetChildTableInitial();
            supprimerLignesDA();
        }
        return;
    }

    // Cas où tous les éléments à ajouter ou à modifier ne l'ont pas été avec succès

    if (lDetailActionsResultats.length == 0) {
        initlDetailActionsResultats();
    }
    var allSuccess = true;
    for (var i = 0; i < lDetailActionsResultats.length; i++) {
        if (lDetailActionsResultats[i].status != "success") { allSuccess = false; }
    }
    if (!allSuccess) {
        if (!demandeSauvegardeTableDetaille) {
            demandeSauvegardeTableDetaille = true;
            resetChildTableInitial();
            enregistrerLignesDA();
        }
        return;
    }

    // Cas où le tableau n'a pas pu être rechargé avec succès
    if (oChildTableInitial.status != "success") {
        if (!demandeRechargementTableau) {
            demandeRechargementTableau = true;
            var keyValue = getInput(childTable.keyFieldName);
            var guidValue = getInput(childTable.guidFieldName);
            ChildTable_retrieveListItems.call(oChildTableInitial, keyValue, guidValue);
            //ChildTable_retrieveListItems.call(oChildTableInitial);
        }
        return;
    }

    if (!rechargementTableauEffectue) {
        // Vider le tableau enfant
        reinitialiserTableau();
        // Recharger le tableau enfant
        for (var i = 0; i < oChildTableInitial.arrayElements.length; i++) {
            addChildLine(childTable.tableId, childTable.lineId, i + 1, oChildTableInitial.arrayElements[i]);
        }
        rechargementTableauEffectue = true;
        return;
    }


    // Normalement on ne doit arriver à ce niveau du code

}

function timeoutSauvegardeDA() {
    formLogError("Timeout Sauvegarde Demande d'achats");
    clearInterval(handlerIntervalSauvegardeDA);
}

function processSauvegardeDA() {
    handlerTimeoutSauvegardeDA = setTimeout(timeoutSauvegardeDA, 500000); // Timeout after 500 seconds
    handlerIntervalSauvegardeDA = setInterval(checkSauvegardeDA, 200); // Check every 0,2 second
}

// -----------------------------------------------------------------------------------------------------------------------------
// Les 2 fonctions qui suivent (supprimerDerniereLigneTableau et reinitialiserTableau) n'interviennent qu'au niveau
// de la structure HTML. Elles n'ont pas d'impact sur la liste associée à la table enfant

function supprimerDerniereLigneTableau() {
    // Récupérer le numéro de ligne le plus élevé
    var elt = null;
    var nbr = 0;
    var elts = document.getElementsByClassName(childTable.lineId);
    for (var i = 0; i < elts.length; i++) {
        if (elts[i].id.length > childTable.lineId.length) {
            var ind = parseInt(elts[i].id.substring(childTable.lineId.length, elts[i].id.length));
            if (ind > nbr) {
                nbr = ind;
                elt = elts[i];
            }
        }
    }

    if (elt) {
        elt.parentNode.removeChild(elt);
    }
}


function reinitialiserTableau() {
    // Supprime toutes les lignes du tableau de détail
    var i = document.getElementsByClassName(childTable.lineId).length;
    while (i > 0) {
        supprimerDerniereLigneTableau();
        i = i - 1;
    }
}
// =====================================================================================================================================================
// Fonctions utilitaires

function isDate(s) {
    if ((!s) || (s.length == 0)) return false;
    if (s.match(/^(\d{2})\/(\d{2})\/(\d{4})$/)) {
        // Vérifier le format JJ/MM/AAAA
        return true;
    }
    if (s.match(/^(\d{2})\-(\d{2})\-(\d{4})$/)) {
        // Vérifier le format JJ-MM-AAAA
        return true;
    }
    return false;
}
// s.match(/^(\d{4})\/(\d{1,2})\/(\d{1,2})$/);

function isNumber(num) {
    if (num.match(/^\d+$/)) {
        //valid integer
        return true;
    };
    if (num.match(/^\d+\.\d+$/)) {
        //valid float
        return true;
    };
    if (num.match(/^\d+\,\d+$/)) {
        //valid float
        return true;
    };
    return false;
}

// Gestion du champ Pièces jointes

function initAttachment() {
    var elt = document.getElementsByClassName("ms-formtable")[0];
    changeId(elt, "idAttachmentsRow", "idAttachmentsRow2")

    $("#idAttachmentsRow2").contents().appendTo("#idAttachmentsRow");
    // var x = document.getElementById("onetidIOFile"); attachmentsOnClient
    var x = document.getElementById("attachmentsOnClient");
    x.onchange = function () { displayFileAttachMessage(true); };
}

function displayFileAttachMessage(onOff) {
    // Cette fonction est appelée dès que le contenu de l'élément id "attachmentsOnClient" change
    var elt = document.getElementById("FileAttachMessage");
    if (onOff) {
        elt.style.display = "inline";
    }
    else {
        elt.style.display = "none";
    }
}

function changeId(eltParent, oldId, newId) {
    // Exemple : changeId("ms-formtable","idAttachmentsRow","idAttachmentsRow2")
    if (eltParent.id == oldId) {
        eltParent.id = newId;
    }
    var childs = eltParent.childNodes;
    for (var i = 0; i < childs.length; i++) {
        changeId(childs[i], oldId, newId);
    }
}
