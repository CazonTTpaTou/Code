package simulation;

/** 
* La classe Horloge maîtrise l'évolution du temps et des périodes au sein du système durant la simulation
* */
public class Horloge {
	
	private static int NbJourParSemaine;
	private static int JourSemaine;
	private static int semaine;
	private static int jour;
	
	/** Constructeur statique de la classe Horloge initialisant tous les attributs de classe.
	 * 
	 */
	static {
			semaine=0; 
			jour=0;
			JourSemaine=0;
		}
	/** Méthode permettant de retourner le nombre de jour que comporte une semaine de simulation (une valeur qui est fixée en paramètre par l'utilisateur).
	 * 
	 * @return
	 * Nombre de jour par semaine.
	 */
	public static int getJourParSemaine() {
		return NbJourParSemaine;
	}
	/** Méthode permettant de fixer le nombre de jour que comporte une semaine de simulation. 
	 * 
	 * @param nbJour
	 * Nombre de jour d'une semaine de simulation.
	 */
	public static void setJourParSemaine(int nbJour) {
		NbJourParSemaine=nbJour;
	}
	/** 
	* Méthode assesseur qui renvoie le numéro de la semaine dans le Système durant la simulation. La variable semaine représente le numéro de semaine à l'instant T dans le système de simulation de stock.
	* @return semaine 
	* N° de la semaine en cours.
	* */
	public static int getSemaine() {
		return semaine;
	}
	
	/** Méthode qui renvoie le numéro du jour en cours dans le système de simulation.
	 * 
	 * @return
	 * N° du jour en cours.
	 */
	public static int getJour() {
		return jour;
	}
	
	/** Méthode renvoyant le numéro du jour de la semaine en cours.
	 * 
	 * @return
	 * Numéro de la semaine en cours.
	 */
	public static int getJourSemaine() {
		return JourSemaine;
	}
	
	/** Méthode incrémentant la valeur de l'attribut Jour. Cette méthode permet de passer au jour suivant et à la semaine suivante si nécessaire.
	 * 
	 */
	public static void incrementJour(){
		jour++;
		JourSemaine++;
		int reste = jour % NbJourParSemaine;
		if(reste==1) {incrementSemaine();}
	}
	
	/** Méthode permettant d'incrémenter le numéro de semaine. Cela permet de passer à la semaine suivante de simulation.
	 * 
	 */
	private static void incrementSemaine(){
		semaine++;
		JourSemaine=1;
		Entrepot.EnregistreCumulDemande();
	}
	
	
	/** Cette méthode réinitialise les attributs de la classe Horloge.
	 * 
	 */
	public static void remet_a_zero() {
		semaine=0; 
		jour=0;
		JourSemaine=0;
	}
}


