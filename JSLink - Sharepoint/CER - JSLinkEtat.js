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

    var etat = ctx.CurrentItem["StatutCode"];
    var image = "";
    var libelle="";

    if (etat == 0) 
        {image = "http://intranet.photowatt.local/SupplyChain/CER/SiteAssets/Rouge.png";
         libelle = "Demande CER refusée";}

    if (etat == 1) 
        {image = "http://intranet.photowatt.local/SupplyChain/CER/SiteAssets/Gris.png";
         libelle = "En attente approbation responsable";}

    if (etat == 2) 
        {image = "http://intranet.photowatt.local/SupplyChain/CER/SiteAssets/Jaune.png";
         libelle = "En attente approbation directeur";}

    if (etat == 4) 
        {image = "http://intranet.photowatt.local/SupplyChain/CER/SiteAssets/Saumon.png";
         libelle = "En attente négociation acheteur";}

    if (etat == 5) 
        {image = "http://intranet.photowatt.local/SupplyChain/CER/SiteAssets/Orange.png";
         libelle = "En attente approbation directeur Supply Chain";}

    if (etat == 7) 
        {image = "http://intranet.photowatt.local/SupplyChain/CER/SiteAssets/Bleu.png";
         libelle = "En attente approbation directeur financier";}

    if (etat == 8) 
        {image = "http://intranet.photowatt.local/SupplyChain/CER/SiteAssets/Noir.png";
         libelle = "En attente approbation directeur général délégué";}

    if (etat == 9) 
        {image = "http://intranet.photowatt.local/SupplyChain/CER/SiteAssets/Vert.png";
         libelle = "Demande CER approuvée";}

    if (etat == 10) 
        {image = "http://intranet.photowatt.local/SupplyChain/CER/SiteAssets/Vert.png";
         libelle = "Demande CER approuvée";}

    if (etat == 11) 
        {image = "http://intranet.photowatt.local/SupplyChain/CER/SiteAssets/Vert.png";
         libelle = "Demande CER approuvée";}

    return "<img class='status-image' src='" + image + "' data-val='" + libelle + "' />";
}



