package recursif;

public class Dichotomie {
	/* Created on 23 f�vr. 2013 by Fabien Monnery */
	static {
		gruyere = new String[1000];
		remplir();
	}
	
	private static String[] gruyere;
	
	public static int dicho(int[] tableau,int bg,int bd,int value) {
		if(tableau[bg]==value) return bg;
		if(tableau[bd]==value) return bd;
		if(bd-bg <=1) return bg;
		if (value >= tableau[(int)(bg+bd)/2]) return dicho(tableau,(int) (bg+bd)/2,bd,value);
		else return dicho(tableau,bg,(int) (bg+bd)/2,value);
	}
	
	public static int dicho_t(String[] tableau,int bg,int bd,String value) {
		if(tableau[bg].equals(value)) return bg;
		if(tableau[bd].equals(value)) return bd;
		if(bd-bg <=1) return bg;
		if (tableau[(int)(bg+bd)/2].compareTo(value)<=0) return dicho_t(tableau,(int) (bg+bd)/2,bd,value);
		else return dicho_t(tableau,bg,(int) (bg+bd)/2,value);
	}
	
	public static void remplir() {
		gruyere[0]="aa@g-p-i.fr";
		gruyere[1]="accueil@progilone.com";
		gruyere[2]="actual2@wanadoo.f";
		gruyere[3]="ag.lyon@pagesjaunes.fr";
		gruyere[4]="agscom@agscom.com";
		gruyere[5]="alphasys@niva.tm.fr";
		gruyere[6]="applications@sysfera.com";
		gruyere[7]="bbecheras@abelia.fr";
		gruyere[8]="bonjour@novaway.fr";
		gruyere[9]="bu.lyon.candidature@open-groupe.com";
		gruyere[10]="candidature.spontanee@mairie-lyon.fr";
		gruyere[11]="claire@mbcreation.net";
		gruyere[12]="CLMinfos@cegedim.fr";
		gruyere[13]="cn@ice-dev.com";
		gruyere[14]="Commercial@Applirh.com";
		gruyere[15]="commercial@aveis.net";
		gruyere[16]="communication@osiatis.com";
		gruyere[17]="contact.pj@ankaa.fr";
		gruyere[18]="contact@2atech.com";
		gruyere[19]="contact@apollossc.com";
		gruyere[20]="contact@appsfactory.fr ";
		gruyere[21]="contact@a-sis.com";
		gruyere[22]="contact@atpmg.com";
		gruyere[23]="contact@avanim-prod.com";
		gruyere[24]="contact@bfsi.fr";
		gruyere[25]="contact@corexpert.net";
		gruyere[26]="contact@eolia-consulting.com";
		gruyere[27]="contact@e-partner.pro";
		gruyere[28]="contact@fredel.fr";
		gruyere[29]="contact@igone.fr";
		gruyere[30]="contact@ilosoft.fr";
		gruyere[31]="contact@inovaction.fr";
		gruyere[32]="contact@kalmeo.com";
		gruyere[33]="contact@kpitechno.fr";
		gruyere[34]="contact@l-expert-comptable.com";
		gruyere[35]="contact@logsystem.fr";
		gruyere[36]="contact@lyon-web-agency.fr";
		gruyere[37]="contact@mcube.fr";
		gruyere[38]="contact@neolab-systems.fr";
		gruyere[39]="contact@netapsys.fr";
		gruyere[40]="contact@obs.contactrh.com ";
		gruyere[41]="contact@picviz.com ";
		gruyere[42]="contact@pilogis.fr";
		gruyere[43]="contact@prodaxis.com";
		gruyere[44]="contact@simlinx.com";
		gruyere[45]="contact@smartconcept.fr";
		gruyere[46]="contact@spiralnet.net";
		gruyere[47]="contact@synerlan.com";
		gruyere[48]="contact@telamon.eu";
		gruyere[49]="contact@wotol.com";
		gruyere[50]="contact@zol.fr";
		gruyere[51]="contactrh@computacenter.fr";
		gruyere[52]="directionnrse@norsys.fr";
		gruyere[53]="drh@bdoc.com";
		gruyere[54]="drh@cegedim-activ.com";
		gruyere[55]="drh@clever-age.com";
		gruyere[56]="drh@coachis.fr";
		gruyere[57]="drh@optimindwinter.com";
		gruyere[58]="e.cochaux@akteis.fr";
		gruyere[59]="emploi@ever-team.com";
		gruyere[60]="emploi@prowebce.com";
		gruyere[61]="equipe@epfactory.com";
		gruyere[62]="fgrevey@libel.fr";
		gruyere[63]="gil@rinfo.fr";
		gruyere[64]="hello@teapotapps.com";
		gruyere[65]="inelys@inelys.fr";
		gruyere[66]="info.lyon@creative-it.net";
		gruyere[67]="info@adebeo.com";
		gruyere[68]="info@anthemis.fr";
		gruyere[69]="info@axantech.com�� �";
		gruyere[70]="info@bmg-aec.fr";
		gruyere[71]="info@chiffres-conseils.fr";
		gruyere[72]="info@ciss.fr";
		gruyere[73]="info@comparex.fr";
		gruyere[74]="info@fr.coretechnologie.com";
		gruyere[75]="info@goconsultants.fr";
		gruyere[76]="info@humansourcing.com";
		gruyere[77]="info@obigestion.fr";
		gruyere[78]="info@pci-info.com";
		gruyere[79]="info@usicad.com";
		gruyere[80]="info@visoon.com";
		gruyere[81]="job@pointcube.fr";
		gruyere[82]="jobs@amigolog.com";
		gruyere[83]="jobs@digdog-studio.com";
		gruyere[84]="la-BI-immediate@bial-x.com";
		gruyere[85]="magazine@magazine.fr";
		gruyere[86]="maranzana.sebastien@gmail.com";
		gruyere[87]="mathieu@adthink-media.com";
		gruyere[88]="mmaudelonde@prestaconcept.net�";
		gruyere[89]="mtech@mtech-industries.fr";
		gruyere[90]="psilhol@ydris.com";
		gruyere[91]="quadratus@quadratus.fr";
		gruyere[92]="recrut.rhonealpes@thalesgroup.com";
		gruyere[93]="recrut-devsx@everwin.fr";
		gruyere[94]="recrute@sovec.fr ";
		gruyere[95]="recrutement@actuaris.com";
		gruyere[96]="recrutement@groupe-belink.fr";
		gruyere[97]="recrutement@hardis.fr ";
		gruyere[98]="recrutement@intuitiv.fr";
		gruyere[99]="recrutement@isi-developpement.com";
		gruyere[100]="recrutement@kitware.fr";
		gruyere[101]="recrutement@power.fr ";
		gruyere[102]="recrutement@synolia.com";
		gruyere[103]="rh@aceinformatique.com";
		gruyere[104]="rh@apollossc.com";
		gruyere[105]="rh@intrinsec.com";
		gruyere[106]="rhcv@esker.fr";
		gruyere[107]="s.foret@comimpact.net";
		gruyere[108]="service.commercial@axess-omt.fr";
		gruyere[109]="setec@setec.fr";
		gruyere[110]="societe@3-s-i.fr";
		gruyere[111]="software@drillscan.com";
		gruyere[112]="stages@akoba-solutions.com";
		gruyere[113]="tda@tdalogiciels.com";
		gruyere[114]="warmup@warmup.fr";
		gruyere[115]="webcontact@tactilabs.com";
	}
	public static String[]  getData() {
		return gruyere;
	}
	public static int Size(Object[] tab) {
		int i = 0;
		while((Object) tab[i]!=null) ++i;
		i--;
		return i;
	}
	
	public static void main(String arg[]) {
		
		int position;
		String position1,position2,position3,position4;
		String valeur = "m";
		
		position = dicho_t(getData(),0,Size((Object[])getData()),valeur);
		position1 = gruyere[position+1];
		position2 = gruyere[position+2];
		position3 = gruyere[position+3];
		position4 = gruyere[position+4];
		System.out.println("Place de "+ valeur+ " : position n� " + position + " a pour suite : "+position1+" - "+position2+" - "+position3+" - "+position4);
		}
	}
