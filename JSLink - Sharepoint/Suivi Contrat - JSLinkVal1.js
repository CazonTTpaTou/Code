
(function () {

    // Create object that have the context information about the field that we want to change it's output render  
    var priorityFiledContext = {};
    priorityFiledContext.Templates = {};
    priorityFiledContext.Templates.Fields = {
        // Apply the new rendering for Priority field on List View 
        "Val_x002e__x0020_Acheteur": { "View": priorityFiledTemplate }
    };

    SPClientTemplates.TemplateManager.RegisterTemplateOverrides(priorityFiledContext);

})();

// This function provides the rendering logic for list view 
function priorityFiledTemplate(ctx) {

    var Statut = ctx.CurrentItem[ctx.CurrentFieldSchema.Name];

    var Texte = Statut.toString();

    var Cible1 = "Approuvé".toString();
    var Cible2 = "Demande".toString();  
    var Cible3 = "Refusé".toString();
    var Cible4 = "attente".toString();
    var Cible5 = "NC".toString();  

    if(Texte.indexOf(Cible1) >=0) {return "<span>" + Statut + "</span>";} 

    if(Texte.indexOf(Cible2) >=0) {return "<span style='color:#FFFFFF;background-color:#2C75FF;'>" + Statut + "</span>";} 

    if(Texte.indexOf(Cible3) >=0) {return "<span style='color:#FFFFFF;background-color:#FF0000;'>" + Statut + "</span>";} 

    if(Texte.indexOf(Cible4) >=0) {return "<span>" + Statut + "</span>";}                              

    if(Texte.indexOf(Cible5) >=0) {return "<span>" + Statut + "</span>";}    
       
         }                            








