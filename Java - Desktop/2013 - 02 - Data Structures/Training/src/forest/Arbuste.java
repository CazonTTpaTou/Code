package forest;

import structure.*;

public class Arbuste {

	public static void creation() throws Exception {
		ForêtChaînée f1 = new ForêtChaînée();
		ForêtChaînée f2 = new ForêtChaînée();
		ForêtChaînée f3 = new ForêtChaînée();
		ForêtChaînée f4 = new ForêtChaînée();
		ArbreChaîné a1 = new ArbreChaîné("A", f2);
		ArbreChaîné a2 = new ArbreChaîné("B", f3);
		ArbreChaîné a3 = new ArbreChaîné("C", f4);
		ArbreChaîné a4 = new ArbreChaîné("D", null);
		f1.ajouterArbre(1, a1);
		f2.ajouterArbre(1, a2);
		f3.ajouterArbre(1, a3);
		f3.ajouterArbre(2, a3);
		f4.ajouterArbre(1, a4);
		f1.ièmeArbre(1).parcoursPréfixe(new OperationAfficher());
		// ar.ièmeArbre(0).parcoursPréfixe(op)
	}

	public void afficher() throws Exception {

	}

	public static void main(String arg[]) {
		try {
			creation();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
