package recursif;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Reader;

public class Naturel {

	public Naturel() {compteur = 0;}
	
	private static int compteur;
	
	public int getCompteur() {
		return compteur;
	}
	
	public void setCompteur(int num) {
		compteur += num;
	}
	
	public void decompose(int number) {
		if (number/10>=1) {decompose(number/10);}
		this.setCompteur(number%10);
		System.out.println( String.valueOf(number%10));
	}
	public static void main(String[] args) throws NumberFormatException, IOException {
		
		Reader byteToChar = new InputStreamReader(System.in);
		BufferedReader entree = new BufferedReader(byteToChar);
		
		System.out.println("Votre chiffre :");
		Naturel na = new Naturel();
		
		na.decompose(Integer.parseInt(entree.readLine())); 
		System.out.println("La somme des entiers vaut : " + na.getCompteur());
	}
}
