package recursif;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Reader;

public class Finobacci {
	
	public int Fino(int number) {
		if ((number==1) || (number== 2)) {return number;}
		else {return this.Fino(number-1) + this.Fino(number-2);}
	}
	
public static void main (String arg[] ) throws NumberFormatException, IOException {
	
	int Num;
	
	Reader byteToChar = new InputStreamReader(System.in);
	BufferedReader entree = new BufferedReader(byteToChar);
	
	System.out.println("Votre chiffre :");
	Finobacci cl = new Finobacci();
	
	Num = cl.Fino(Integer.parseInt(entree.readLine())); 
	
	System.out.println(Num);

}
}
