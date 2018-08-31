
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
            return "<span style='color:#000000;background-color:#BBACAC;'>" + Statut + "</span>";
            break;
        case "2":
            return "<span style='color:#000000;background-color:#FFE436;'>" + Statut + "</span>";
            break;
        case "3":
            return "<span style='color:#000000;background-color:#F88E55;'>" + Statut + "</span>";
            break;
        case "4":
            return "<span style='color:#000000;background-color:#FEBFD2;'>" + Statut + "</span>";
            break;
        case "5":
            return "<span style='color:#000000;background-color:#FEA347;'>" + Statut + "</span>";
            break;
        case "6":
            return "<span style='color:#FFFFFF;background-color:#175732;'>" + Statut + "</span>";
            break;
        case "7":
            return "<span style='color:#FFFFFF;background-color:#318CE7;'>" + Statut + "</span>";
            break;
        case "8":
            return "<span style='color:#FFFFFF;background-color:#000000;'>" + Statut + "</span>";
            break;
	case "9":
            return "<span style='color:#FFFFFF;background-color:#A5D152;'>" + Statut + "</span>";
            break;
        case "10":
            return "<span style='color:#FFFFFF;background-color:#A5D152;'>" + Statut + "</span>";
            break;
        case "11":
            return "<span style='color:#FFFFFF;background-color:#A5D152;'>" + Statut + "</span>";
            break;
        default:
            return "<span style='color:#FFFFFF;background-color:#000000;'>" + Etat + "</span>";
            break;
    }
}







