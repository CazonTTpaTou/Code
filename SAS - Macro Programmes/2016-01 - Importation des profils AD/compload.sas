/* compare and generate delta */
%mducmp(master=ead, target=mymeta, change=mychg);
/* check for errors */

%mduchgv(change=mychg, target=mymeta,temp=myerror);

/* load update in metadata*/
%mduchglb(change=mychg);

