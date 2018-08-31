package simulation;

import java.io.IOException;

import trace.Trace;
/** La classe Client est l'entité qui va effectuer des achats dans le système de simulation des stocks
 * 
 * @author Fabien Monnery
 *
 */
public class Client {

	private static int NumClient=0;
	private boolean Prioritaire;
	private double Demande;
	private boolean InSysteme;
	/** Constructeur permettant d'instancier un objet client en déterminant son statut prioritaire selon que son numéro de fabrication soit un multiple de 5 ou non
	 * 
	 * @param demande
	 * Nombre d'unités que le client achètera dans le système de simulation des stocks.
	 * @throws IOException
	 */
	Client(double demande) throws IOException {
		NumClient++;
		if(NumClient%5==0) {Prioritaire=true;}
		else {Prioritaire=false;}
		Demande=demande;
		InSysteme=true;
		
		String message="Client n° "+ NumClient +" - Demande : "+ demande +" - Etat : ";
		if(Prioritaire) {message+="Prioritaire";}
		else {message+="Normal";}
		Trace.client(message);
	}
	
	/** Méthode retournant le statut prioritaire ou non du client
	 * 
	 * @return
	 * Un booléen indiquant le statut prioritaire ou non du client.
	 */
	public boolean getPrior() {
		return Prioritaire;
	}
	
	/** Méthode permettant de fixer la quantité de biens que le client va acheter dans le système
	 * 
	 * @param dem
	 * Quantité de biens que le client doit encore acheter dans le système
	 */
	public void setDemande(double dem) {
		Demande=dem;
	}
	/** Méthode retournant la quantité de biens que doit acheter le client.
	 * 
	 * @return
	 * Quantité de biens à acheter.
	 */
	public double getDemande() {
		return Demande;
	}
	/** Méthode permettant de mettre l'attribut HorsSysteme à true.
	 * 
	 */
	public void setHorsSysteme() {
		InSysteme=false;
	}
	/** Méthode retournant le numéro du client.
	 * 
	 * @return
	 * Le numéro du client attribué lors de son instanciation.
	 */
	public int getNum() {
		return NumClient;
	}
}

