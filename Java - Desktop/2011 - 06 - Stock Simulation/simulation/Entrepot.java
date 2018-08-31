package simulation;

import java.io.IOException;

import trace.Trace;
import vue.Tableau;

/** Classe représentant l'entité entrepot de la simulation. C'est dans cette entité que sont gérés les fluctuations du stock et la comptabilisation des différentes demandes.
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
	/** Méthode permettant de réinitiser les attributs de classe en cas de nouvelle simulation de stocks.
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
	/** Méthode incrémentant le cumul des consommations depuis le début de la simulation.
	 * 
	 * @param conso
	 * Paramètre de la quantité consommée à incrémenter dans le cumul total.
	 */
	public static void setCumulConsommation(int conso) {
		CumulConsommation+=conso;
	}
	/** Méthode retournant le cumul des quantités de biens consommés depuis le début de la simulation.
	 * 
	 * @return
	 * Cumul des quantités consommées.
	 */
	public static int getCumulConsommation() {
		return CumulConsommation;
	}
	/** Méthode retournant la somme des carrés des différentes valeurs prises par le stock au cours de la simulation. Ce montant doit servir au calcul de la variance.
	 * 
	 * @return
	 * Somme des carrés des valeurs du stock.
	 */
	public static int getCarreStock() {
		return CarreCumulStock;
	}
	/** Méthode indiquant si le système est en rupture de stock et donc en état de pénurie.
	 * 
	 * @return 
	 * Un booléen indiquant l'état de rupture de stock ou non.
	 */
	public static boolean penurie(){
		boolean pen=false;
		if (ClientFactory.getEnAttente()>0||ClientFactory.getPerdu()>0)
		{pen=true;}
		penurie=pen;
		return penurie;
	}
	/** Méthode dénombrant le nombre de jours de simulation où le système est en situation de rupture de stock donc de pénurie.
	 * 
	 * @return
	 * Le nombre de jours de rupture de stock durant toute la durée de la simulation
	 */
	public static int NJourPenurie() {
		return CumulPenurie;
	}
	/** Méthode comptabilisant le cumul des stocks durant toute la durée de la simulation.
	 * 
	 * @return
	 * Somme totale de tous les stocks afin de pouvoir effectué une moyenne globale. 
	 */
	public static int getCumulStock() {
		return CumulStock;
	}
	/** Méthode permettant d'incrémenter le cumul du stock de la classe Entrepot.
	 * 
	 */
	public static void setStockduJour() {
		CumulStock+=stock;
		if(penurie()) {CumulPenurie++;}
		CarreCumulStock+=Math.pow(stock,2);
	}
	/** Méthode remettant le cumul de la consommation journalière à 0.
	 * 
	 */
	public static void setConsoZero() {
		Consommation=0;
	}
	/** Méthode permettant d'incrémenter l'attribut de classe consommation.
	 * 
	 * @param conso
	 * Quantité réellement consommée durant un maps de temps déterminé.
	 */
	public static void setConsommation(int conso) {
		Consommation+=conso;
	}
	/** Méthode permettant d'obtenir la quantité de biens consommées durant la journée de simualtion.
	 * 
	 * @return
	 * Quantité journalière consommée.
	 */
	public static int getConsommation() {
		return Consommation;
	}
	/** Méthode fixant le seuil d'alerte de réassort. 
	 * 
	 * @param capacite
	 * Seuil en dessous duquel un réassort est déclenché.
	 */
	public static void setStockageAlerte(int capacite) {
		StockAlerte=capacite;
	}
	/** Méthode retournant la valeur du seuil d'alerte du stock.
	 * 
	 * @return
	 * Valeur du seuil d'alerte de stockage
	 */
	public static int getStockageAlerte() {
		return StockAlerte;
	}
	/** Fixe les capacités maximales de stockage de l'entrepot.
	 *  
	 * @param capacite
	 * Conenance maximale de l'entrepot de stockage.
	 */
	public static void setCapaciteStockage(int capacite) {
		CapaciteStockage=capacite;
	}
	/** Méthode retournant la capacité de stockage de l'entrepot.
	 * 
	 * @return
	 * Capacité maximale de l'entrepôt.
	 */
	public static int getCapaciteStockage() {
		return CapaciteStockage;
	}
	/** Méthode retournant la valeur du stock de l'entrepôt à l'instant T.
	 * 
	 * @return
	 * Valeur du stock.
	 * @throws IOException
	 */
	public static int getStock() throws IOException {
		String message="Jour n° "+Horloge.getJour()+" - Le stock est de "+stock+" unités sur une capacité de "+ CapaciteStockage;
		Trace.entrepot(message);
		return stock;
	}
	/** Méthode retournant le nombre de clients acheteurs différents au cours d'une journée. Ce nombre ne consière pas les commandes en attente précédentes, traitées prioritairement.
	 *@return 
	 * Nombre de demandes d'achat reçu dans la journée de simulation.
	 */
	public static int getDemandeJournaliere() {
		int demande;
		demande=demandeJournaliere;
		demandeJournaliere=0;
		return demande;
	}
	/** Méthode retournant le cumul des demandes durant toute la durée de la simulation.
	 * 
	 * @return
	 * Nombre total de demandes client.
	 */
	public static int getCumulDemande() {
		return CumulDemande;
	}
	/** Méthode retournant le nombre de demande honorée durant la journée de simulation.
	 * 
	 * @return
	 * Nombre de commande honorée dans la journée.
	 * @throws IOException
	 */
	public static int getDemandeServie() throws IOException {
		int demande;
		demande=DemandeServie;
		DemandeServie=0;
		
		String messagee="Jour n° "+Horloge.getJour()+" - Demande servie : "+demande+ " unités";
		Trace.entrepot(messagee);
		
		return demande;
	}
	/** Méthode retournant le cumul des commandes honorées durant toute la durée de la simulation.
	 * 
	 * @return
	 * Cumul total des commandes honorées intégralement.
	 */
	public static int getCumulDemandeServie() {
		return CumulDemandeServie;
	}
	/** Détermine le nombre de commandes du jour.
	 * 
	 * @param demande
	 * Nombre de demande d'achat reçu durant la journée.
	 */
	public static void setDemandeJournaliere(int demande) {
		demandeJournaliere+=demande;
		CumulDemande+=demande;
	}
	/** Détermine la consommation de biens réalisées sur un laps de temps d'une semaine complète. Ce montant doit servir pour le réassort, lorsque l'option réassort par demande cumulée a été activé par l'utilisateur.
	 * 
	 * @param demande
	 * Quantité de demande passée durant la semaine écoulée.
	 */
	public static void setDemandeHebdomadaire(int demande) {
		CumulDemandeServieSemaine+=demande;

	}
	/** Méthode permettant de fixer la valeur de l'attribut stock.
	 * 
	 * @param quantite
	 * Valeur du stock à l'intant T.
	 */
	public static void setStock(int quantite) {
		stock-=quantite;
	}
	/** Méthode permettant de fixer la valeur de l'attribut DemandeServie, qui dénombre les commandes honorées le jour même.
	 * 
	 * @param demande
	 * Nombre de demande réellement et intégralement honorée durant la journée.
	 */
	public static void setDemandeServie(int demande) {
		DemandeServie+=demande;
		CumulDemandeServie+=demande;
	}
	/** Méthode permettant d'incrémenter la valeur du stock de la quantité de biens contenus dans le réassort.
	 * 
	 * @param quantite
	 * Quantité du réassort à intégrer dans le stock de l'entrepot.
	 */
	public static void setStockReassort(int quantite) {
		stock+=quantite;
	}
	/** Méthode stockant la valeur tampon du total des demandes servies durant la semaine précédente. 
	 *  
	 */
	public static void EnregistreCumulDemande() {
		CumulDemandeSemaine=CumulDemandeServieSemaine;
		CumulDemandeServieSemaine=0;
	}
	/** Méthode retournant la quantité des demandes passées la semaine précédente. Cette valeur sert pour les réassorts à option demande cumulée.
	 *  
	 * @return
	 * Quantité des commandes passées durant la semaine précédente.
	 */
	public static int getCumulDemandeSemaine() {
		return CumulDemandeSemaine;
	}
}


