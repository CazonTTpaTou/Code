// JavaScript source code

(function () {
    var overrideCtx = {};
    overrideCtx.Templates = {};

    //override 'Etat' field and provide custom rendering functions
    overrideCtx.Templates.Fields = {
        'StatutCode': { 'View': customFieldEtat }
    };

    //register our override
    SPClientTemplates.TemplateManager.RegisterTemplateOverrides(overrideCtx);
})();

function customFieldEtat(ctx) {
    var etat = ctx.CurrentItem.StatutCode;
    var image = "";
    var libelle="";

    if (etat == 1) 
        {image = "http://intranet.photowatt.local/SupplyChain/DA/SiteAssets/Jaune.png";
         libelle = "En attente approbation responsable";}
    if (etat == 2) 
        {image = "http://intranet.photowatt.local/SupplyChain/DA/SiteAssets/Orange.png";
         libelle = "En attente approbation directeur";}
    if (etat == 3) 
        {image = "http://intranet.photowatt.local/SupplyChain/DA/SiteAssets/Saumon.png";
         libelle = "En attente renseignement comptable";}
    if (etat == 4) 
        {image = "http://intranet.photowatt.local/SupplyChain/DA/SiteAssets/Gris.png";
         libelle = "En attente réception Achats";}
    if (etat == 5) 
        {image = "http://intranet.photowatt.local/SupplyChain/DA/SiteAssets/Bleu.png";
         libelle = "Commande en cours de traitement";}
    if (etat == 6) 
        {image = "http://intranet.photowatt.local/SupplyChain/DA/SiteAssets/Vert.png";
         libelle = "Commande envoyée au fournisseur";}
    if (etat == 7) 
        {image = "http://intranet.photowatt.local/SupplyChain/DA/SiteAssets/Noir.png";
         libelle = "Commande réceptionnée";}
    if (etat == 0) 
        {image = "http://intranet.photowatt.local/SupplyChain/DA/SiteAssets/Rouge.png";
         libelle = "Demande refusée";}

    return "<img class='status-image' src='" + image + "' data-val='" + libelle + "' />";
}

