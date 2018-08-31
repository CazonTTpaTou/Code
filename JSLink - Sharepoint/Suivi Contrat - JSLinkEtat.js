
(function () {

    // Create object that have the context information about the field that we want to change it's output render  
    var priorityFiledContext = {};
    priorityFiledContext.Templates = {};
    priorityFiledContext.Templates.Fields = {
        // Apply the new rendering for Priority field on List View 
        "Etat": { "View": priorityFiledTemplate }
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
            return "<span style='color:#FF0000;background-color:#FF0000;'>00" + Etat + "</span>";
            break;
        case "1":
            return "<span style='color:#FEFEE2;background-color:#FEFEE2;'>00" + Etat + "</span>";
            break;
	case "2":
            return "<span style='color:#BBACAC;background-color:#BBACAC;'>00" + Etat + "</span>";
            break;
        case "3":
            return "<span style='color:#FFE436;background-color:#FFE436;'>00" + Etat + "</span>";
            break;
        case "4":
            return "<span style='color:#FEA347;background-color:#FEA347;'>00" + Etat + "</span>";
            break;        
        case "5":
            return "<span style='color:#87591A;background-color:#87591A;'>00" + Etat + "</span>";
            break;
	case "6":
            return "<span style='color:#C9A0DC;background-color:#C9A0DC;'>00" + Etat + "</span>";
            break;
        case "7":
            return "<span style='color:#120D16;background-color:#120D16;'>00" + Etat + "</span>";
            break;
        case "9":
            return "<span style='color:#77B5FE;background-color:#77B5FE;'>00" + Etat + "</span>";
            break;
        case "10":
            return "<span style='color:#57D53B;background-color:#57D53B;'>0" + Etat + "</span>";
            break;
        default:
            return "<span style='color:#000000;background-color:#000000;'>00" + Etat + "</span>";
            break;
    }
}







