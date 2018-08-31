// List view, display, add and edit – Percent Complete Sample 
// Muawiyah Shannak , @MuShannak 
 
(function () { 
 
    // Create object that have the context information about the field that we want to change it's output render  
    var percentCompleteFiledContext = {}; 
    percentCompleteFiledContext.Templates = {}; 
    percentCompleteFiledContext.Templates.Fields = { 
        // Apply the new rendering for PercentComplete field on List View, Display, New and Edit forms 
        "Evolution": {  
            "View": percentCompleteViewFiledTemplate, 
            "DisplayForm": percentCompleteViewFiledTemplate
        } 
    }; 
 
    SPClientTemplates.TemplateManager.RegisterTemplateOverrides(percentCompleteFiledContext); 
 
})(); 
 
// This function provides the rendering logic for View and Display form 
function percentCompleteViewFiledTemplate(ctx) { 
 
    var percentComplete = ctx.CurrentItem[ctx.CurrentFieldSchema.Name]; 
    var Etat = ctx.CurrentItem["StatutCode"];


   if (Etat=="0") {             percentComplete = 0;

				return "<div style='background-color: #FF866A; width: 100px;  display:inline-block;'> \
            			<div style='width: 0%; background-color: #0094ff;'> \
           		        &nbsp;</div></div>&nbsp;" + percentComplete + ' %';
			     }

    else {  			return "<div style='background-color: #e5e5e5; width: 100px;  display:inline-block;'> \
                                <div style='width: " + percentComplete.replace(/\s+/g, '') + "; background-color: #0072c6;'> \
                                &nbsp;</div></div>&nbsp;" + percentComplete;
         }

} 
 


 