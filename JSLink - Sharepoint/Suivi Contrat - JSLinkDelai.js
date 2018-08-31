
(function () {

    // Create object that have the context information about the field that we want to change it's output render  
    var priorityFiledContext = {};
    priorityFiledContext.Templates = {};
    priorityFiledContext.Templates.Fields = {
        // Apply the new rendering for Priority field on List View 
        "D_x00e9_lai_x0020_Cde": { "View": priorityFiledTemplate }
    };

    SPClientTemplates.TemplateManager.RegisterTemplateOverrides(priorityFiledContext);

})();

// This function provides the rendering logic for list view 
function priorityFiledTemplate(ctx) {
   
    var Creation = ctx.CurrentItem["Created"];
    var DateCmde = ctx.CurrentItem["Date_x0020_Validation"];
           
    var fromdt= ConvertDateTime(Creation);
 
if (DateCmde.length == 0)  {var now = new Date();}
                     else  {var now = ConvertDateTime(DateCmde);}                                                                                         

    var dec2 = Math.round((dateDiff(fromdt,now).hour/24)*100);
    var dec2S = dec2.toString();
    if (dec2S.length == 1) {var zero ="0";}
       else {var zero ="";}   

    var delai = dateDiff(fromdt,now).day + ',' + zero + Math.round((dateDiff(fromdt,now).hour/24)*100) + ' j';

    if(dateDiff(fromdt,now).day >= 10) {
					return "<span style='color:#FFFFFF;background-color:#C60800;'>" + delai + "</span>";
    }
       else {

					return "<span style='color:#FFFFFF;background-color:#0072c6;'>" + delai + "</span>";} 
      
} 

function dateDiff(date1, date2) {
    var diff = {}                           // Initialisation du retour
    var tmp = date2 - date1;

    tmp = Math.floor(tmp / 1000);             // Nombre de secondes entre les 2 dates
    diff.sec = tmp % 60;                    // Extraction du nombre de secondes

    tmp = Math.floor((tmp - diff.sec) / 60);    // Nombre de minutes (partie entière)
    diff.min = tmp % 60;                    // Extraction du nombre de minutes

    tmp = Math.floor((tmp - diff.min) / 60);    // Nombre d'heures (entières)
    diff.hour = tmp % 24;                   // Extraction du nombre d'heures

    tmp = Math.floor((tmp - diff.hour) / 24);   // Nombre de jours restants
    diff.day = tmp;

    return diff;
}

function diffdate(d1,d2){
    var WNbJours = d2.getTime() - d1.getTime();
    return Math.ceil(WNbJours/(1000*60*60*24));
}

function ConvertDate(dateT) {
				 
    var d='dd/mm/yyyy hh:MM';
    var d1=dateT.split(" ");
    var date=d1[0].split("/");
    var dd=date[0];
    var mm=date[1];
    var yy=date[2];

    return new Date(yy,mm-1,dd,0,0);
}
 
function ConvertDateTime(dateT) {
				 
    var d='dd/mm/yyyy hh:MM';
    var d1=dateT.split(" ");
    var date=d1[0].split("/");
    var time=d1[1].split(":");
    var dd=date[0];
    var mm=date[1];
    var yy=date[2];
    var hh=time[0];
    var min=time[1];

    return new Date(yy,mm-1,dd,hh,min);
}   

