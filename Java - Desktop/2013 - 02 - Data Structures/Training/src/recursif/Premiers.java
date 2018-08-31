package recursif;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Reader;

public class Premiers {

	public int First(int number,int div) {
		
		if (div<=1) return number;
		else 
			{if (number%div==0) return 0;
			else return First(number,div-1);}
	}
	
	public static void main(String[] args) throws NumberFormatException, IOException {
		
		Premiers fr = new Premiers();
				
		for(int i=0;i<=100;++i) {
			if(fr.First(i, i-1)!=0) {System.out.println(i + " est un nombre premier.");}
		}
	}

}
