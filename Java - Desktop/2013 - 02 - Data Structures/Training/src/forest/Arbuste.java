package forest;

import structure.*;

public class Arbuste {

	public static void creation() throws Exception {
		For�tCha�n�e f1 = new For�tCha�n�e();
		For�tCha�n�e f2 = new For�tCha�n�e();
		For�tCha�n�e f3 = new For�tCha�n�e();
		For�tCha�n�e f4 = new For�tCha�n�e();
		ArbreCha�n� a1 = new ArbreCha�n�("A", f2);
		ArbreCha�n� a2 = new ArbreCha�n�("B", f3);
		ArbreCha�n� a3 = new ArbreCha�n�("C", f4);
		ArbreCha�n� a4 = new ArbreCha�n�("D", null);
		f1.ajouterArbre(1, a1);
		f2.ajouterArbre(1, a2);
		f3.ajouterArbre(1, a3);
		f3.ajouterArbre(2, a3);
		f4.ajouterArbre(1, a4);
		f1.i�meArbre(1).parcoursPr�fixe(new OperationAfficher());
		// ar.i�meArbre(0).parcoursPr�fixe(op)
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
