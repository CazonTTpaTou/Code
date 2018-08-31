package simulation;

/** 
* La classe Horloge ma�trise l'�volution du temps et des p�riodes au sein du syst�me durant la simulation
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
	/** M�thode permettant de retourner le nombre de jour que comporte une semaine de simulation (une valeur qui est fix�e en param�tre par l'utilisateur).
	 * 
	 * @return
	 * Nombre de jour par semaine.
	 */
	public static int getJourParSemaine() {
		return NbJourParSemaine;
	}
	/** M�thode permettant de fixer le nombre de jour que comporte une semaine de simulation. 
	 * 
	 * @param nbJour
	 * Nombre de jour d'une semaine de simulation.
	 */
	public static void setJourParSemaine(int nbJour) {
		NbJourParSemaine=nbJour;
	}
	/** 
	* M�thode assesseur qui renvoie le num�ro de la semaine dans le Syst�me durant la simulation. La variable semaine repr�sente le num�ro de semaine � l'instant T dans le syst�me de simulation de stock.
	* @return semaine 
	* N� de la semaine en cours.
	* */
	public static int getSemaine() {
		return semaine;
	}
	
	/** M�thode qui renvoie le num�ro du jour en cours dans le syst�me de simulation.
	 * 
	 * @return
	 * N� du jour en cours.
	 */
	public static int getJour() {
		return jour;
	}
	
	/** M�thode renvoyant le num�ro du jour de la semaine en cours.
	 * 
	 * @return
	 * Num�ro de la semaine en cours.
	 */
	public static int getJourSemaine() {
		return JourSemaine;
	}
	
	/** M�thode incr�mentant la valeur de l'attribut Jour. Cette m�thode permet de passer au jour suivant et � la semaine suivante si n�cessaire.
	 * 
	 */
	public static void incrementJour(){
		jour++;
		JourSemaine++;
		int reste = jour % NbJourParSemaine;
		if(reste==1) {incrementSemaine();}
	}
	
	/** M�thode permettant d'incr�menter le num�ro de semaine. Cela permet de passer � la semaine suivante de simulation.
	 * 
	 */
	private static void incrementSemaine(){
		semaine++;
		JourSemaine=1;
		Entrepot.EnregistreCumulDemande();
	}
	
	
	/** Cette m�thode r�initialise les attributs de la classe Horloge.
	 * 
	 */
	public static void remet_a_zero() {
		semaine=0; 
		jour=0;
		JourSemaine=0;
	}
}


