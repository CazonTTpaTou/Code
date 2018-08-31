package simulation;

import java.io.IOException;

import trace.Trace;

/** Classe gérant le processus de réassort de l'entrepot durant la période simulation des stocks.
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
	
	/** Méthode permettant de réinitiliser les attributs de la classe.
	 * 
	 */
	public static void reinit() {
		LivraisonPrevue=false;
		QuantiteReassort=0;
		CumulReassort=0;
		DateReassort=0;
	}
	/** Méthode permettant de renvoyer la durée du délai de livraison exprimé en jours fixes, lorsque cette option de réassort a été choisie.
	 * 
	 * @return
	 * Laps de temps fixe nécessaire avant la livraison d'un réassort.
	 */
	public static int getDureeReassortFixe() {
		return DureeReassortFixe;
	}
	/** Méthode permettant de fixer le délai de réassort lorsque l'option délai de livraison en jours fixe a été choisi.
	 * 
	 * @param jour
	 * Nombre de jour nécessaire à la livraison d'un réassort.
	 */
	public static void setDureeReassortFixe(int jour) {
		DureeReassortFixe = jour;
	}
	/** Méthode renvoyant le jour de semaine d'un réassort lorsque l'option livraison à jour de semaine fixe a été choisi par l'utilisateur.
	 * 
	 * @return
	 * Numéro du jour de la semaine durant lequel s'effectue la livraison d'un réassort.
	 */
	public static int getDureeReassortJour() {
		return DureeReassortJour;
	}
	/** Méthode permettant de fixer le numéro de jour de semaine durant lequel aura lieu le réassort.
	 * 
	 * @param jour
	 * Numéro du jour de semaine de livraison du réassort.
	 */
	public static void setDureeReassortJour(int jour) {
		DureeReassortJour = jour;
	}
	/** Méthode renvoyant le jour durant lequel est prévu le prochain réassort.
	 * 
	 * @return
	 * Numéro du jour du prochain réassort prévu.
	 */
	public static int getJourDeReassort() {
		return JourDeReassort;
	}
	/** Méthode permettant de fixer le numéro du jour du prochain réassort prévu.
	 * 
	 * @param jour
	 * Numéro du jour du prochain réassort prévu.
	 */
	public static void setJourDeReassort(int jour) {
		JourDeReassort = jour;
	}
	/** Méthode renvoyant la quantité du réassort à livrer à l'entrepot de stockage.
	 * 
	 * @return
	 * Quantité du réassort.
	 */
	public static int getQuantiteReassort() {
		LivraisonPrevue=false;
		return QuantiteReassort;
	}
	/** Méthode renvoyant la valeur cumulée de tous les réassorts effectués durant la simulation.
	 * 
	 * @return
	 * Cumul des quantités de tous les réassorts de la période de simulation.
	 */
	public static int getCumulReassort() {
		return CumulReassort;
	}
	/** Méthode renvoyant la date du prochain réassort.
	 * 
	 * @return
	 * Date du prochain réassort prévu.
	 */
	public static int getDateReassort() {
		return DateReassort;
	}
	/** Méthode renvoyant un booléen indiquant si un futur réassort a déjà été programmé ou non.
	 * 
	 * @return
	 * Booléen indiquant si un réassort est déjà programmé.
	 */
	public static boolean getLivraisonPrevue() {
		return LivraisonPrevue;
	}
	/** Méthode fixant l'attribut quantité de réassort.
	 * 
	 * @param quant
	 * Quantité de marchandises que doit contenir le futur réassort.
	 */
	public static void setQuantiteReassort(int quant) {
		QuantiteReassort=quant;
	}
	/** Méthode permettant d'incrémenter le cumul de tous les réassorts de la simulation.
	 * 
	 * @param quant
	 * Quantité du réassort à incrémenter au total calculé.
	 */
	public static void setCumulReassort(int quant) {
		CumulReassort+=quant;
	}
	/** Méthode déterminant la date du futur réassort à partir du choix de l'utilisateur rentré en paramètre.
	 * 
	 * @param choix
	 * Numéro du choix de type de réassort effectué par l'utilisateur en début de simulation lors de la saisie de tous les paramètres.
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
		
		String message="Jour n° "+Horloge.getJour()+ " - Le réassort est prévu pour le jour n° "+DateReassort;
		Trace.reassort(message);
	}
	/** Méthode déterminant la quantité de marchandises du réassort en fonction de l'option choisie en paramètre par l'utilisateur.
	 * 
	 * @param choix
	 * Option de mode réassort choisie par l'utilisateur en début de simulation.
	 * @return
	 * Quantité de marchandises à livrer dans l'entrepot lors du prochain réassort.
	 * @throws IOException
	 */
	public static int quantiteReassort(int choix) throws IOException {
		int reassort;
	
		if(choix==2 && Horloge.getSemaine()>1) {reassort=Math.min(Entrepot.getCumulDemandeSemaine(),Entrepot.getCapaciteStockage());}
		else{reassort=Entrepot.getCapaciteStockage();}
		QuantiteReassort=reassort;
		
		String messagee="Jour n° "+Horloge.getJour()+ " Réassort de quantité "+reassort;
		Trace.reassort(messagee);
		return reassort;
	}
	
	/** Méthode qui organise un futur réassort en fonction de la date du jour et des choix d'option saisis par l'utilisateur.
	 * 
	 * @param choix0
	 * Option sur la quantité de réassort.
	 * @param choix1
	 * Option sur le déclenchement du réassort.
	 * @param choix2
	 * Option sur la date de livraison du réassort.
	 * @return
	 * Retourne un booléen selon l'organisation ou non d'un futur réassort à la date du jour de simulation.
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
		String messageee="Jour n° "+Horloge.getJour()+" - Organisation d'un réassort : ";
		if (reassort) {messageee+="OUI";}
		else{messageee+="NON";}
		Trace.reassort(messageee);
		return reassort;
			}
	
	/** Méthode qui gère le processus de livraison d'un réassort dans l'entrepot, à un jour donné de la simulation.
	 * 
	 * @return
	 * Quantité livrée en réassort dans l'entrepot de la simulation, incrémentant directement la valeur du stock.
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
		String messageeee="Jour n° "+Horloge.getJour()+" - Livraison de "+reassort+" unités";
		Trace.reassort(messageeee);
		return reassort;
	}
}	
