package view;

import java.awt.Desktop;
import java.io.*;

public class IHM {

	public static void affichePDF()
	
		{
			String commande = "c:/Documents and Settings/Fabien Monnery/Bureau/";
			commande+="CV - Fabien Monnery.pdf";
			
			Runtime runtime = Runtime.getRuntime();
			Process process = null;
			try
			{
				//process = runtime.exec(new String[]{"open", commande});
				File pdf = new File(commande);
				Desktop.getDesktop().open(pdf);

			}
	 
			catch(Exception err)
			    {System.out.println("Erreur = " + err);}  
		}
	
	public static void main(String[] args) {
		//affichePDF();
		Menu.affiche();
		}
}
	

