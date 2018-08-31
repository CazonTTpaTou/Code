package simulation;
/** 
* Classe qui effectue les différentes générations de série de nombre aléatoire nécessaire à la simulation.
*/
public class Aleatoire {
	/** Méthode générant un nombre aléatoire selon la loi de Weibull.
	 * 
	 * @param echelle
	 * Premier paramètre d'échelle de la loi de Weibull.
	 * @param forme
	 * Second paramètre de forme de la loi de Weibull.
	 * @return
	 * Retourne un nombre aléatoire généré selon une loi de Weibull.
	 */
	public static double Weibull(int echelle,int forme) {
		Double[] table = new Double[100];	
		
		int i = -1;
		double cumul=0;
		double hasard = Math.random();
		double borne_inf=0;
		double borne_sup=0;

		while(!(hasard<cumul)) {
			i++;
			borne_inf=Math.max(i-0.5, 0);
			borne_sup=i+0.5;
			table[i]=cumul+Math.pow(Math.E,-(Math.pow(borne_inf/echelle,forme)))-Math.pow(Math.E,-(Math.pow(borne_sup/echelle,forme)));
			cumul=table[i]; 	
		}
		//System.out.println("Result : "+ hasard + " rang : "+i+" borne inf : "+borne_inf+" borne_sup : "+borne_sup);
		return i;
	}
	/** Méthode générant des nombres aléatoires selon une loi normale. Etant donné la complexité de la formule de densité de la loi normale, on utilise la méthode de Box-Muller qui effectue une approximation efficace de cette loi.
	 * 
	 * @param esperance
	 * Paramètre de l'espérance de la loi normale.
	 * @param ecart_type
	 * Paramètre de l'écart type de la loi normale.
	 * @return
	 * Un nombre réel généré selon un processus aléatoire de type loi normale gaussienne
	 */
	public static double Normale(double esperance,double ecart_type) 
		 {
		 double n1 = Math.random();
		 double n2 = Math.random();
		 double y;
		 double montant;
		
		 // on ne veut pas que <x1> et <x2> soit nuls
		 while(0 == n1) {n1 = Math.random();}
		 while(0 == n2) {n2 = Math.random();}
		
		 // methode de Boc-Muller
		 // <y> suit une loi normale reduite (m=0,s=1)
		 y = Math.pow(-2.0000*Math.log(n1),1/2)*Math.cos(2.0000*Math.PI*n2);
	   	 montant = esperance + ecart_type*y;
		 montant=Math.max(2.0000, Math.min(38.0000, montant));
		 //System.out.println("Loi normale : y = "+y + " montant = " + montant+ " - n1 = "+n1+" - n2 = "+n2);
		 return montant;
		 } 
		/** Méthode retournant un nombre aléatoire généré par une loi uniforme.
		 * 
		 * @param borne_inf
		 * Paramètre de la valeur plancher du nombre à générer.
		 * @param borne_sup
		 * Paramètre de la valeur plafond du nombre à générer.
		 * @return
		 * Un nombre aléatoire généré selon un processus de type loi uniforme.
		 */
		public static double Uniforme(int borne_inf,int borne_sup) {
			double unif = borne_inf + Math.floor(Math.random()*(borne_sup-borne_inf+1));
			unif = Math.round(unif);
			//System.out.println("Loi uniforme : "+unif);
			return unif;
		}
}






