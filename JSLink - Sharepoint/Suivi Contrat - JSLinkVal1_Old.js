
(function () {

    // Create object that have the context information about the field that we want to change it's output render  
    var priorityFiledContext = {};
    priorityFiledContext.Templates = {};
    priorityFiledContext.Templates.Fields = {
        // Apply the new rendering for Priority field on List View 
        "Val_x002e__x0020_Inititateur": { "View": priorityFiledTemplate }
    };

    SPClientTemplates.TemplateManager.RegisterTemplateOverrides(priorityFiledContext);

})();

// This function provides the rendering logic for list view 
function priorityFiledTemplate(ctx) {

    var Statut = ctx.CurrentItem[ctx.CurrentFieldSchema.Name];

    var Texte = Statut.toString();
    var Cible = "Créé".toString();

    if(Texte.indexOf(Cible) >=0) {return "<span>" + Statut + "</span>";} 
    if(Texte.indexOf(Cible) <0)  {return "<span>" + Statut + "</span>";}                                 
       
         }                            








