package simulation;

import java.io.IOException;

import trace.Trace;
import vue.Tableau;

/** Classe repr�sentant l'entit� entrepot de la simulation. C'est dans cette entit� que sont g�r�s les fluctuations du stock et la comptabilisation des diff�rentes demandes.
 * 
 * @author Fabien Monnery
 *
 */
public class Entrepot {
	
	static private int StockAlerte;
	static private int CapaciteStockage;
	private static int stock;
	private static int CumulStock;
	private static int CarreCumulStock;
	private static boolean penurie;
	private static int CumulPenurie;
	private static int demandeJournaliere;
	private static int CumulDemande;
	private static int DemandeServie;
	private static int CumulDemandeServie;
	private static int CumulDemandeServieSemaine;
	private static int CumulDemandeSemaine;
	private static int Consommation;
	private static int CumulConsommation;
	
	/** Constructeur statique initialisant les attributs de la classe.
	 * 
	 */
	static {
		stock=0;
		CumulStock=0;
		CarreCumulStock=0;
		CumulPenurie=0;
		demandeJournaliere=0;
		CumulDemande=0;
		DemandeServie=0;
		CumulDemandeServie=0;
		CumulDemandeServieSemaine=0;
		CumulDemandeSemaine=0;
		Consommation=0;
		CumulConsommation=0;
	}
	/** M�thode permettant de r�initiser les attributs de classe en cas de nouvelle simulation de stocks.
	 * 
	 */
	public static void reinit() {
		stock=0;
		CumulStock=0;
		CumulPenurie=0;
		CarreCumulStock=0;
		demandeJournaliere=0;
		CumulDemande=0;
		DemandeServie=0;
		CumulDemandeServie=0;
		CumulDemandeServieSemaine=0;
		CumulDemandeSemaine=0;
		Consommation=0;
		CumulConsommation=0;
	}
	/** M�thode incr�mentant le cumul des consommations depuis le d�but de la simulation.
	 * 
	 * @param conso
	 * Param�tre de la quantit� consomm�e � incr�menter dans le cumul total.
	 */
	public static void setCumulConsommation(int conso) {
		CumulConsommation+=conso;
	}
	/** M�thode retournant le cumul des quantit�s de biens consomm�s depuis le d�but de la simulation.
	 * 
	 * @return
	 * Cumul des quantit�s consomm�es.
	 */
	public static int getCumulConsommation() {
		return CumulConsommation;
	}
	/** M�thode retournant la somme des carr�s des diff�rentes valeurs prises par le stock au cours de la simulation. Ce montant doit servir au calcul de la variance.
	 * 
	 * @return
	 * Somme des carr�s des valeurs du stock.
	 */
	public static int getCarreStock() {
		return CarreCumulStock;
	}
	/** M�thode indiquant si le syst�me est en rupture de stock et donc en �tat de p�nurie.
	 * 
	 * @return 
	 * Un bool�en indiquant l'�tat de rupture de stock ou non.
	 */
	public static boolean penurie(){
		boolean pen=false;
		if (ClientFactory.getEnAttente()>0||ClientFactory.getPerdu()>0)
		{pen=true;}
		penurie=pen;
		return penurie;
	}
	/** M�thode d�nombrant le nombre de jours de simulation o� le syst�me est en situation de rupture de stock donc de p�nurie.
	 * 
	 * @return
	 * Le nombre de jours de rupture de stock durant toute la dur�e de la simulation
	 */
	public static int NJourPenurie() {
		return CumulPenurie;
	}
	/** M�thode comptabilisant le cumul des stocks durant toute la dur�e de la simulation.
	 * 
	 * @return
	 * Somme totale de tous les stocks afin de pouvoir effectu� une moyenne globale. 
	 */
	public static int getCumulStock() {
		return CumulStock;
	}
	/** M�thode permettant d'incr�menter le cumul du stock de la classe Entrepot.
	 * 
	 */
	public static void setStockduJour() {
		CumulStock+=stock;
		if(penurie()) {CumulPenurie++;}
		CarreCumulStock+=Math.pow(stock,2);
	}
	/** M�thode remettant le cumul de la consommation journali�re � 0.
	 * 
	 */
	public static void setConsoZero() {
		Consommation=0;
	}
	/** M�thode permettant d'incr�menter l'attribut de classe consommation.
	 * 
	 * @param conso
	 * Quantit� r�ellement consomm�e durant un maps de temps d�termin�.
	 */
	public static void setConsommation(int conso) {
		Consommation+=conso;
	}
	/** M�thode permettant d'obtenir la quantit� de biens consomm�es durant la journ�e de simualtion.
	 * 
	 * @return
	 * Quantit� journali�re consomm�e.
	 */
	public static int getConsommation() {
		return Consommation;
	}
	/** M�thode fixant le seuil d'alerte de r�assort. 
	 * 
	 * @param capacite
	 * Seuil en dessous duquel un r�assort est d�clench�.
	 */
	public static void setStockageAlerte(int capacite) {
		StockAlerte=capacite;
	}
	/** M�thode retournant la valeur du seuil d'alerte du stock.
	 * 
	 * @return
	 * Valeur du seuil d'alerte de stockage
	 */
	public static int getStockageAlerte() {
		return StockAlerte;
	}
	/** Fixe les capacit�s maximales de stockage de l'entrepot.
	 *  
	 * @param capacite
	 * Conenance maximale de l'entrepot de stockage.
	 */
	public static void setCapaciteStockage(int capacite) {
		CapaciteStockage=capacite;
	}
	/** M�thode retournant la capacit� de stockage de l'entrepot.
	 * 
	 * @return
	 * Capacit� maximale de l'entrep�t.
	 */
	public static int getCapaciteStockage() {
		return CapaciteStockage;
	}
	/** M�thode retournant la valeur du stock de l'entrep�t � l'instant T.
	 * 
	 * @return
	 * Valeur du stock.
	 * @throws IOException
	 */
	public static int getStock() throws IOException {
		String message="Jour n� "+Horloge.getJour()+" - Le stock est de "+stock+" unit�s sur une capacit� de "+ CapaciteStockage;
		Trace.entrepot(message);
		return stock;
	}
	/** M�thode retournant le nombre de clients acheteurs diff�rents au cours d'une journ�e. Ce nombre ne consi�re pas les commandes en attente pr�c�dentes, trait�es prioritairement.
	 *@return 
	 * Nombre de demandes d'achat re�u dans la journ�e de simulation.
	 */
	public static int getDemandeJournaliere() {
		int demande;
		demande=demandeJournaliere;
		demandeJournaliere=0;
		return demande;
	}
	/** M�thode retournant le cumul des demandes durant toute la dur�e de la simulation.
	 * 
	 * @return
	 * Nombre total de demandes client.
	 */
	public static int getCumulDemande() {
		return CumulDemande;
	}
	/** M�thode retournant le nombre de demande honor�e durant la journ�e de simulation.
	 * 
	 * @return
	 * Nombre de commande honor�e dans la journ�e.
	 * @throws IOException
	 */
	public static int getDemandeServie() throws IOException {
		int demande;
		demande=DemandeServie;
		DemandeServie=0;
		
		String messagee="Jour n� "+Horloge.getJour()+" - Demande servie : "+demande+ " unit�s";
		Trace.entrepot(messagee);
		
		return demande;
	}
	/** M�thode retournant le cumul des commandes honor�es durant toute la dur�e de la simulation.
	 * 
	 * @return
	 * Cumul total des commandes honor�es int�gralement.
	 */
	public static int getCumulDemandeServie() {
		return CumulDemandeServie;
	}
	/** D�termine le nombre de commandes du jour.
	 * 
	 * @param demande
	 * Nombre de demande d'achat re�u durant la journ�e.
	 */
	public static void setDemandeJournaliere(int demande) {
		demandeJournaliere+=demande;
		CumulDemande+=demande;
	}
	/** D�termine la consommation de biens r�alis�es sur un laps de temps d'une semaine compl�te. Ce montant doit servir pour le r�assort, lorsque l'option r�assort par demande cumul�e a �t� activ� par l'utilisateur.
	 * 
	 * @param demande
	 * Quantit� de demande pass�e durant la semaine �coul�e.
	 */
	public static void setDemandeHebdomadaire(int demande) {
		CumulDemandeServieSemaine+=demande;

	}
	/** M�thode permettant de fixer la valeur de l'attribut stock.
	 * 
	 * @param quantite
	 * Valeur du stock � l'intant T.
	 */
	public static void setStock(int quantite) {
		stock-=quantite;
	}
	/** M�thode permettant de fixer la valeur de l'attribut DemandeServie, qui d�nombre les commandes honor�es le jour m�me.
	 * 
	 * @param demande
	 * Nombre de demande r�ellement et int�gralement honor�e durant la journ�e.
	 */
	public static void setDemandeServie(int demande) {
		DemandeServie+=demande;
		CumulDemandeServie+=demande;
	}
	/** M�thode permettant d'incr�menter la valeur du stock de la quantit� de biens contenus dans le r�assort.
	 * 
	 * @param quantite
	 * Quantit� du r�assort � int�grer dans le stock de l'entrepot.
	 */
	public static void setStockReassort(int quantite) {
		stock+=quantite;
	}
	/** M�thode stockant la valeur tampon du total des demandes servies durant la semaine pr�c�dente. 
	 *  
	 */
	public static void EnregistreCumulDemande() {
		CumulDemandeSemaine=CumulDemandeServieSemaine;
		CumulDemandeServieSemaine=0;
	}
	/** M�thode retournant la quantit� des demandes pass�es la semaine pr�c�dente. Cette valeur sert pour les r�assorts � option demande cumul�e.
	 *  
	 * @return
	 * Quantit� des commandes pass�es durant la semaine pr�c�dente.
	 */
	public static int getCumulDemandeSemaine() {
		return CumulDemandeSemaine;
	}
}


