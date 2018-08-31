
(function () {

    // Create object that have the context information about the field that we want to change it's output render  
    var priorityFiledContext = {};
    priorityFiledContext.Templates = {};
    priorityFiledContext.Templates.Fields = {
        // Apply the new rendering for Priority field on List View 
        "Statut": { "View": priorityFiledTemplate }
    };

    SPClientTemplates.TemplateManager.RegisterTemplateOverrides(priorityFiledContext);

})();

// This function provides the rendering logic for list view 
function priorityFiledTemplate(ctx) {

    var Statut = ctx.CurrentItem[ctx.CurrentFieldSchema.Name];
    var Etat = ctx.CurrentItem["StatutCode"]; 

    // Return html element with appropriate color based on priority value 
    switch (Etat) {
        case "0":
            return "<span style='color:#FFFFFF;background-color:#EE1010;'>" + Statut + "</span>";
            break;
        case "1":
            return "<span style='color:#000000;background-color:#F7FF3C;'>" + Statut + "</span>";
            break;
        case "2":
            return "<span style='color:#000000;background-color:#DFAF2C;'>" + Statut + "</span>";
            break;
        case "3":
            return "<span style='color:#000000;background-color:#F88E55;'>" + Statut + "</span>";
            break;
        case "4":
            return "<span style='color:#000000;background-color:#CECECE;'>" + Statut + "</span>";
            break;
        case "5":
            return "<span style='color:#FFFFFF;background-color:#1E7FCB;'>" + Statut + "</span>";
            break;
        case "6":
            return "<span style='color:#FFFFFF;background-color:#175732;'>" + Statut + "</span>";
            break;
        case "7":
            return "<span style='color:#FFFFFF;background-color:#000000;'>" + Statut + "</span>";
            break;
        case "8":
            return "<span style='color:#FFFFFF;background-color:#FF0921;'>" + Statut + "</span>";
            break;
        default:
            return "<span style='color:#FFFFFF;background-color:#000000;'>" + Etat + "</span>";
            break;
    }
}







