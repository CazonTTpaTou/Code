package recursif;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Reader;

public class PGCD {

	public int diviseur(int num1,int num2,int div) {
		
			if ((num1%div==0) && (num2%div==0)) return div;
			else return diviseur(num1,num2,div-1);}			

	public static void main(String[] args) throws NumberFormatException, IOException {
		
		int Num;
		
		Reader byteToChar = new InputStreamReader(System.in);
		BufferedReader entree = new BufferedReader(byteToChar);
		
		System.out.println("Vos chiffres :");
		PGCD pg = new PGCD();
		
		int first = Integer.parseInt(entree.readLine());
		int second = Integer.parseInt(entree.readLine());
		
		Num = pg.diviseur(first,second,Math.min(first,second)); 
		
		System.out.println("Le plus grand diviseur communs à " + first + " et " + second + " est : " + Num);

	}

}
