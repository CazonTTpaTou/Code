package simulation;

import java.io.IOException;

import trace.Trace;
/** La classe Client est l'entit� qui va effectuer des achats dans le syst�me de simulation des stocks
 * 
 * @author Fabien Monnery
 *
 */
public class Client {

	private static int NumClient=0;
	private boolean Prioritaire;
	private double Demande;
	private boolean InSysteme;
	/** Constructeur permettant d'instancier un objet client en d�terminant son statut prioritaire selon que son num�ro de fabrication soit un multiple de 5 ou non
	 * 
	 * @param demande
	 * Nombre d'unit�s que le client ach�tera dans le syst�me de simulation des stocks.
	 * @throws IOException
	 */
	Client(double demande) throws IOException {
		NumClient++;
		if(NumClient%5==0) {Prioritaire=true;}
		else {Prioritaire=false;}
		Demande=demande;
		InSysteme=true;
		
		String message="Client n� "+ NumClient +" - Demande : "+ demande +" - Etat : ";
		if(Prioritaire) {message+="Prioritaire";}
		else {message+="Normal";}
		Trace.client(message);
	}
	
	/** M�thode retournant le statut prioritaire ou non du client
	 * 
	 * @return
	 * Un bool�en indiquant le statut prioritaire ou non du client.
	 */
	public boolean getPrior() {
		return Prioritaire;
	}
	
	/** M�thode permettant de fixer la quantit� de biens que le client va acheter dans le syst�me
	 * 
	 * @param dem
	 * Quantit� de biens que le client doit encore acheter dans le syst�me
	 */
	public void setDemande(double dem) {
		Demande=dem;
	}
	/** M�thode retournant la quantit� de biens que doit acheter le client.
	 * 
	 * @return
	 * Quantit� de biens � acheter.
	 */
	public double getDemande() {
		return Demande;
	}
	/** M�thode permettant de mettre l'attribut HorsSysteme � true.
	 * 
	 */
	public void setHorsSysteme() {
		InSysteme=false;
	}
	/** M�thode retournant le num�ro du client.
	 * 
	 * @return
	 * Le num�ro du client attribu� lors de son instanciation.
	 */
	public int getNum() {
		return NumClient;
	}
}

