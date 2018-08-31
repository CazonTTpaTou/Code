package simulation;

import java.io.IOException;

import trace.Trace;

/** Classe g�rant le processus de r�assort de l'entrepot durant la p�riode simulation des stocks.
 * 
 * @author Fabien Monnery
 *
 */
public class Reassort {

	private static int DureeReassortFixe;
	private static int DureeReassortJour;
	private static int JourDeReassort;
	private static int QuantiteReassort;
	private static int CumulReassort;
	private static int DateReassort;
	private static boolean LivraisonPrevue;
	
	/** M�thode permettant de r�initiliser les attributs de la classe.
	 * 
	 */
	public static void reinit() {
		LivraisonPrevue=false;
		QuantiteReassort=0;
		CumulReassort=0;
		DateReassort=0;
	}
	/** M�thode permettant de renvoyer la dur�e du d�lai de livraison exprim� en jours fixes, lorsque cette option de r�assort a �t� choisie.
	 * 
	 * @return
	 * Laps de temps fixe n�cessaire avant la livraison d'un r�assort.
	 */
	public static int getDureeReassortFixe() {
		return DureeReassortFixe;
	}
	/** M�thode permettant de fixer le d�lai de r�assort lorsque l'option d�lai de livraison en jours fixe a �t� choisi.
	 * 
	 * @param jour
	 * Nombre de jour n�cessaire � la livraison d'un r�assort.
	 */
	public static void setDureeReassortFixe(int jour) {
		DureeReassortFixe = jour;
	}
	/** M�thode renvoyant le jour de semaine d'un r�assort lorsque l'option livraison � jour de semaine fixe a �t� choisi par l'utilisateur.
	 * 
	 * @return
	 * Num�ro du jour de la semaine durant lequel s'effectue la livraison d'un r�assort.
	 */
	public static int getDureeReassortJour() {
		return DureeReassortJour;
	}
	/** M�thode permettant de fixer le num�ro de jour de semaine durant lequel aura lieu le r�assort.
	 * 
	 * @param jour
	 * Num�ro du jour de semaine de livraison du r�assort.
	 */
	public static void setDureeReassortJour(int jour) {
		DureeReassortJour = jour;
	}
	/** M�thode renvoyant le jour durant lequel est pr�vu le prochain r�assort.
	 * 
	 * @return
	 * Num�ro du jour du prochain r�assort pr�vu.
	 */
	public static int getJourDeReassort() {
		return JourDeReassort;
	}
	/** M�thode permettant de fixer le num�ro du jour du prochain r�assort pr�vu.
	 * 
	 * @param jour
	 * Num�ro du jour du prochain r�assort pr�vu.
	 */
	public static void setJourDeReassort(int jour) {
		JourDeReassort = jour;
	}
	/** M�thode renvoyant la quantit� du r�assort � livrer � l'entrepot de stockage.
	 * 
	 * @return
	 * Quantit� du r�assort.
	 */
	public static int getQuantiteReassort() {
		LivraisonPrevue=false;
		return QuantiteReassort;
	}
	/** M�thode renvoyant la valeur cumul�e de tous les r�assorts effectu�s durant la simulation.
	 * 
	 * @return
	 * Cumul des quantit�s de tous les r�assorts de la p�riode de simulation.
	 */
	public static int getCumulReassort() {
		return CumulReassort;
	}
	/** M�thode renvoyant la date du prochain r�assort.
	 * 
	 * @return
	 * Date du prochain r�assort pr�vu.
	 */
	public static int getDateReassort() {
		return DateReassort;
	}
	/** M�thode renvoyant un bool�en indiquant si un futur r�assort a d�j� �t� programm� ou non.
	 * 
	 * @return
	 * Bool�en indiquant si un r�assort est d�j� programm�.
	 */
	public static boolean getLivraisonPrevue() {
		return LivraisonPrevue;
	}
	/** M�thode fixant l'attribut quantit� de r�assort.
	 * 
	 * @param quant
	 * Quantit� de marchandises que doit contenir le futur r�assort.
	 */
	public static void setQuantiteReassort(int quant) {
		QuantiteReassort=quant;
	}
	/** M�thode permettant d'incr�menter le cumul de tous les r�assorts de la simulation.
	 * 
	 * @param quant
	 * Quantit� du r�assort � incr�menter au total calcul�.
	 */
	public static void setCumulReassort(int quant) {
		CumulReassort+=quant;
	}
	/** M�thode d�terminant la date du futur r�assort � partir du choix de l'utilisateur rentr� en param�tre.
	 * 
	 * @param choix
	 * Num�ro du choix de type de r�assort effectu� par l'utilisateur en d�but de simulation lors de la saisie de tous les param�tres.
	 * @throws IOException
	 */
	public static void setDateReassort(int choix) throws IOException {
		int date=0;
		if(choix==1) {date= (int) Aleatoire.Uniforme(1, 3);}
		if(choix==2) {date= getDureeReassortFixe();}
		if(choix==3 & getDureeReassortJour()<=Horloge.getJourSemaine()) {date= getDureeReassortJour()+(Horloge.getJourParSemaine()-Horloge.getJourSemaine());}
		if(choix==3 & getDureeReassortJour()>Horloge.getJourSemaine())  {date= getDureeReassortJour() - Horloge.getJourSemaine();}
		
		DateReassort=Horloge.getJour()+date;
		LivraisonPrevue=true;
		
		String message="Jour n� "+Horloge.getJour()+ " - Le r�assort est pr�vu pour le jour n� "+DateReassort;
		Trace.reassort(message);
	}
	/** M�thode d�terminant la quantit� de marchandises du r�assort en fonction de l'option choisie en param�tre par l'utilisateur.
	 * 
	 * @param choix
	 * Option de mode r�assort choisie par l'utilisateur en d�but de simulation.
	 * @return
	 * Quantit� de marchandises � livrer dans l'entrepot lors du prochain r�assort.
	 * @throws IOException
	 */
	public static int quantiteReassort(int choix) throws IOException {
		int reassort;
	
		if(choix==2 && Horloge.getSemaine()>1) {reassort=Math.min(Entrepot.getCumulDemandeSemaine(),Entrepot.getCapaciteStockage());}
		else{reassort=Entrepot.getCapaciteStockage();}
		QuantiteReassort=reassort;
		
		String messagee="Jour n� "+Horloge.getJour()+ " R�assort de quantit� "+reassort;
		Trace.reassort(messagee);
		return reassort;
	}
	
	/** M�thode qui organise un futur r�assort en fonction de la date du jour et des choix d'option saisis par l'utilisateur.
	 * 
	 * @param choix0
	 * Option sur la quantit� de r�assort.
	 * @param choix1
	 * Option sur le d�clenchement du r�assort.
	 * @param choix2
	 * Option sur la date de livraison du r�assort.
	 * @return
	 * Retourne un bool�en selon l'organisation ou non d'un futur r�assort � la date du jour de simulation.
	 * @throws IOException
	 */
	public static boolean organiseReassort(int choix0,int choix1,int choix2) throws IOException {
		boolean reassort=false;
		if(!Reassort.getLivraisonPrevue()) {
			if(choix1==1 && Horloge.getJourSemaine()==Reassort.getJourDeReassort()) {
				setDateReassort(choix2);
				quantiteReassort(choix0);
				reassort=true;}
			if(choix1==2 && Entrepot.getStock()<=Entrepot.getStockageAlerte()) {
				setDateReassort(choix2);
				quantiteReassort(choix0);
				reassort=true;}
			}
		String messageee="Jour n� "+Horloge.getJour()+" - Organisation d'un r�assort : ";
		if (reassort) {messageee+="OUI";}
		else{messageee+="NON";}
		Trace.reassort(messageee);
		return reassort;
			}
	
	/** M�thode qui g�re le processus de livraison d'un r�assort dans l'entrepot, � un jour donn� de la simulation.
	 * 
	 * @return
	 * Quantit� livr�e en r�assort dans l'entrepot de la simulation, incr�mentant directement la valeur du stock.
	 * @throws IOException
	 */
	public static int livraison() throws IOException {
		int reassort=0;
		if(Reassort.getLivraisonPrevue() && getDateReassort()==Horloge.getJour())
		{reassort=QuantiteReassort;
		if (reassort+Entrepot.getStock()>Entrepot.getCapaciteStockage()) {reassort=Math.min(reassort,Entrepot.getCapaciteStockage()-Entrepot.getStock());}
		 CumulReassort+=reassort;
		 LivraisonPrevue=false;
		 QuantiteReassort=0;
		 Entrepot.setStockReassort(reassort);
		}
		String messageeee="Jour n� "+Horloge.getJour()+" - Livraison de "+reassort+" unit�s";
		Trace.reassort(messageeee);
		return reassort;
	}
}	
