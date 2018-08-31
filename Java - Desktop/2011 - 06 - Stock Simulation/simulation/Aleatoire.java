package simulation;
/** 
* Classe qui effectue les diff�rentes g�n�rations de s�rie de nombre al�atoire n�cessaire � la simulation.
*/
public class Aleatoire {
	/** M�thode g�n�rant un nombre al�atoire selon la loi de Weibull.
	 * 
	 * @param echelle
	 * Premier param�tre d'�chelle de la loi de Weibull.
	 * @param forme
	 * Second param�tre de forme de la loi de Weibull.
	 * @return
	 * Retourne un nombre al�atoire g�n�r� selon une loi de Weibull.
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
	/** M�thode g�n�rant des nombres al�atoires selon une loi normale. Etant donn� la complexit� de la formule de densit� de la loi normale, on utilise la m�thode de Box-Muller qui effectue une approximation efficace de cette loi.
	 * 
	 * @param esperance
	 * Param�tre de l'esp�rance de la loi normale.
	 * @param ecart_type
	 * Param�tre de l'�cart type de la loi normale.
	 * @return
	 * Un nombre r�el g�n�r� selon un processus al�atoire de type loi normale gaussienne
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
		/** M�thode retournant un nombre al�atoire g�n�r� par une loi uniforme.
		 * 
		 * @param borne_inf
		 * Param�tre de la valeur plancher du nombre � g�n�rer.
		 * @param borne_sup
		 * Param�tre de la valeur plafond du nombre � g�n�rer.
		 * @return
		 * Un nombre al�atoire g�n�r� selon un processus de type loi uniforme.
		 */
		public static double Uniforme(int borne_inf,int borne_sup) {
			double unif = borne_inf + Math.floor(Math.random()*(borne_sup-borne_inf+1));
			unif = Math.round(unif);
			//System.out.println("Loi uniforme : "+unif);
			return unif;
		}
}






