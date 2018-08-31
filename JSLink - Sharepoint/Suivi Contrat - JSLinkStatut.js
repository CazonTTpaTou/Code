
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
    var Etat = ctx.CurrentItem["Etape_Nbre"]; 

    // Return html element with appropriate color based on priority value 
    switch (Etat) {
        case "0":
            return "<span style='color:#FFFFFF;background-color:#FF0000;'>0" + Statut + "</span>";
            break;
        case "1":
            return "<span style='color:#000000;background-color:#FEFEE2;'>0" + Statut + "</span>";
            break;
	case "2":
            return "<span style='color:#000000;background-color:#BBACAC;'>0" + Statut + "</span>";
            break;
        case "3":
            return "<span style='color:#000000;background-color:#FFE436;'>0" + Statut + "</span>";
            break;
        case "4":
            return "<span style='color:#000000;background-color:#FEA347;'>0" + Statut + "</span>";
            break;        
        case "5":
            return "<span style='color:#FFFFFF;background-color:#87591A;'>0" + Statut + "</span>";
            break;
	case "6":
            return "<span style='color:#FFFFFF;background-color:#C9A0DC;'>0" + Statut + "</span>";
            break;
        case "7":
            return "<span style='color:#FFFFFF;background-color:#120D16;'>0" + Statut + "</span>";
            break;
        case "9":
            return "<span style='color:#FFFFFF;background-color:#77B5FE;'>0" + Statut + "</span>";
            break;
        case "10":
            return "<span style='color:#FFFFFF;background-color:#57D53B;'>" + Statut + "</span>";
            break;
        default:
            return "<span style='color:#FFFFFF;background-color:#000000;'>0" + Statut + "</span>";
            break;
    }
}







