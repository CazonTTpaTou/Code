package simulation;

import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.io.IOException;
import java.util.ArrayList;

import javax.swing.JOptionPane;
import javax.swing.event.TableModelEvent;
import javax.swing.event.TableModelListener;

import trace.MonModele;
import trace.Trace;
import vue.Presentation;
import vue.Tableau;

/** Classe centrale organisant les différentes séquences de la simulation de gestion des stocks.
 * 
 * @author Fabien Monnery
 *
 */
public class Systeme {

	static private int NSimulation=0;
	static private int NombreJour;
	static private int NombreSemaine;
	static private int CapaciteStockage;
	static private int CapaciteReassort;
	static private int ModeReassort;
	static private int JourReassort;
	static private int DelaiLivraison;
	static private int JourLivraison;
	static private int LapsLivraison;
	
	static private String[] columnNames={"N°Jour",
        "Semaine",
        "Jour Semaine",
        "Clients",
        "Demande",
        "Stock",
        "Reassort",
        "Demande Servie",
        "En Attente",
        "Perdu"};
	static private Object [][] grille;
	static private String[] Journee=new String[8];
	
	/** Méthode gérant le compteur du nombre de simulation opérée.
	 * 
	 * @throws IOException
	 */
	public static void setNSimulation() throws IOException {
		NSimulation++;
		String Message="\n\n ----------- Simulation n° "+NSimulation+"------------ \n\n";
		Trace.client(Message);
		Trace.clientfactory(Message);
		Trace.entrepot(Message);
		Trace.reassort(Message);
		Trace.result(Message);
	}
	/** Méthode retournant le numéro de la simulation de stock en cours.
	 * 
	 * @return
	 * Numéro de la simulation.
	 */
	public static int getNSimulation() {
		return NSimulation;
	}
	/** Méthode initialisant les différents attributs de classe.
	 * 
	 * @param param
	 * Paramètres rentrés par l'utilisateur par le biais de l'IHM Présentation du package vue. 
	 */
	public static void init(int[] param) {

		NombreJour=param[0];
		CapaciteStockage=param[1];
		NombreSemaine=param[2];
		CapaciteReassort=param[3];
		ModeReassort=param[4];
		JourReassort=param[5]+1;
		DelaiLivraison=param[6];
		JourLivraison=param[7]+1;
		LapsLivraison=param[8]+1;
			
		Journee[1]="Lundi";
		Journee[2]="Mardi";
		Journee[3]="Mercredi";
		Journee[4]="Jeudi";
		Journee[5]="Vendredi";
		Journee[6]="Samedi";
		Journee[7]="Dimanche";
		
		Reassort.setJourDeReassort(JourReassort);
		Reassort.setDureeReassortJour(JourLivraison);
		Reassort.setDureeReassortFixe(LapsLivraison);
		int capacite = Math.round(CapaciteStockage/4);
		Entrepot.setStockageAlerte(capacite);
		Horloge.setJourParSemaine(NombreJour);
		Entrepot.setCapaciteStockage(CapaciteStockage);
		Entrepot.setStock(-CapaciteStockage);

	} 
	/** Méthode permettant de réinitialiser tous les paramètres et les attributs des classes impliquées dans le processus de simulation de stock.
	 * 
	 */
	public static void reinit() {
		try {
			Horloge.remet_a_zero();
			ClientFactory.reinit();
			Reassort.reinit();
			Entrepot.reinit();
			Entrepot.setStockReassort(CapaciteStockage);
			}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	/** Méthode ordonnançant les différents processus à l'oeuvre dans la gestion de simulation de stock. La méthode gère également le modèle de données qui sera fournie à la JTable de présentation des résultats de la simulation.
	 * 
	 * @param param
	 * Tableau de paramètres rentrés par l'utilisateur et transmis par le biais de l'IHM Presentation du package vue.
	 */
	public static void simulation(int[] param) {
		ArrayList<Integer> ligne_souligne =new ArrayList();
		
		
		try {
			setNSimulation();
			if(getNSimulation()==1) {init(param);}
				else{reinit();}
			int NJour=NombreJour*NombreSemaine;
			grille = new Object[NJour][10];
			MonModele mm = new MonModele(grille,columnNames);
			Tableau.affiche(mm);
			
			for(int i=0;i<NJour;i++) {
				
				Horloge.incrementJour();
				
				int tampon = Reassort.livraison();
				ClientFactory.factory();
				ClientFactory.JourneeAchat();
				Entrepot.setStockduJour();
				Reassort.organiseReassort(CapaciteReassort, ModeReassort, DelaiLivraison);
				
				grille[i][0]=Horloge.getJour();
				grille[i][1]=Horloge.getSemaine();
				grille[i][2]=Journee[Horloge.getJourSemaine()];
				grille[i][3]=Entrepot.getDemandeJournaliere();
				grille[i][4]=Entrepot.getConsommation();
				if(Entrepot.penurie()) {ligne_souligne.add(i);}
				grille[i][5]=Entrepot.getStock();
				grille[i][6]=tampon;
				grille[i][7]= Entrepot.getDemandeServie();
				grille[i][8]=ClientFactory.getEnAttente();
				grille[i][9]=ClientFactory.getPerdu();
				mm.setData(grille);
				}
			int[] ligne=new int[ligne_souligne.size()];
			for(int i=0;i<ligne_souligne.size();i++)
				{ligne[i]=ligne_souligne.get(i);}
			Tableau.souligne(ligne);
			resultat();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
	/** Méthode calculant tous les totaux, sous totaux, proportions, moyennes et autres statistiques de cumul de la simulation de stock. Cette méthode calcule les résultats proprement dit de la simulation de stock.
	 *  
	 * @throws IOException
	 */
	public static void resultat() throws IOException {
		
		int Njour=Entrepot.NJourPenurie();
		double PenurieMoyenne=Math.round(((double)Entrepot.NJourPenurie()/(double)Horloge.getSemaine())*100.00)/100.00;
		double StockMoyen=Math.round(((double)Entrepot.getCumulStock()/(double)Horloge.getJour())*100.00)/100.00;
		double SomCarreStock=(Math.round(((double)Entrepot.getCarreStock()/(double)Horloge.getJour())*100.00)/100.00);
		double varianceStock=Math.round((SomCarreStock-Math.pow(StockMoyen, 2))*100.00)/100.00;
		double ecartTypeStock=Math.round(Math.pow(varianceStock,0.5)*100.00)/100.00;
		
		String message1=" Nombre de jours de pénurie : "+Njour;
		String message2="Pénurie moyenne par semaine : "+PenurieMoyenne;
		String message3="Stock moyen journalier : "+StockMoyen;
		String message4="Variance du stock : "+varianceStock;
		String message5="Ecart type du stock : "+ecartTypeStock;
		
		String message6="Cumul des demandes perdues : "+ClientFactory.getCumulPerdu();
		String message7="Moyenne journalière des demandes perdues : "+Math.round(((double)ClientFactory.getCumulPerdu()/(double)Horloge.getJour())*100.00)/100.00;

		String message8="Cumul des demandes en attente : "+ClientFactory.getCumulEnAttente();
		String message9="Moyenne journalière des demandes en attente : "+Math.round(((double)ClientFactory.getCumulEnAttente()/(double)Horloge.getJour())*100.00)/100.00;
		
		String message10="Cumul des demandes journalières: "+Entrepot.getCumulConsommation();
		String message11="Moyenne journalière des demandes journalières : "+Math.round(((double)Entrepot.getCumulConsommation()/(double)Horloge.getJour())*100.00)/100.00;
		String message12="Moyenne hebdomadaire des demandes journalières : "+Math.round(((double)Entrepot.getCumulConsommation()/(double)Horloge.getSemaine())*100.00)/100.00;
	
		String message13="Cumul des réassorts: "+Reassort.getCumulReassort();
		String message14="Moyenne journalière des réassorts : "+Math.round(((double)Reassort.getCumulReassort()/(double)Horloge.getJour())*100.00)/100.00;
		String message15="Moyenne hebdomadaire des réassorts : "+Math.round(((double)Reassort.getCumulReassort()/(double)Horloge.getSemaine())*100.00)/100.00;
		
		String message16="Proportion de jours de pénurie : "+Math.round(((double)Njour/(double)Horloge.getJour())*100.00)+ " % ";
		String message17="Proportion de demande honorée : "+Math.round((((double)Entrepot.getCumulConsommation()-(double)ClientFactory.getCumulPerdu())/(double)Entrepot.getCumulConsommation())*100.00)+ " % ";
		String message18="Proportion globale de demande en attente : "+Math.round((((double)ClientFactory.getCumulEnAttente()-(double)ClientFactory.getEnAttente())/(double)Entrepot.getCumulConsommation())*100.00)+ " % ";
		String message19="Proportion de demande perdue : "+Math.round((((double)ClientFactory.getCumulPerdu())/(double)Entrepot.getCumulConsommation())*100.00)+ " % ";
		String message20="Proportion de demande traitée le jour même : "+Math.max(0,Math.round((((double)Entrepot.getCumulConsommation()-(double)ClientFactory.getCumulEnAttente()-(double)ClientFactory.getCumulPerdu())/(double)Entrepot.getCumulConsommation())*100.00))+ " % ";
		
		String message=message1+" \n ";
		message+=message2+" \n ";
		message+=" \n ";
		message+=message3+" \n ";
		message+=message4+" \n ";
		message+=message5+" \n ";
		message+=" \n ";
		message+=message16+" \n ";
		message+=message17+" \n ";
		message+=message18+" \n ";
		message+=message19+" \n ";
		message+=message20+" \n ";
		message+=" \n ";
		message+=message6+" \n ";
		message+=message7+" \n ";
		message+=" \n ";
		message+=message8+" \n ";
		message+=message9+" \n ";
		message+=" \n ";
		message+=message10+" \n ";
		message+=message11+" \n ";
		message+=message12+" \n ";
		message+=" \n ";
		message+=message13+" \n ";
		message+=message14+" \n ";
		message+=message15+" \n ";
		
		Trace.result(message);
		JOptionPane.showMessageDialog(null, message);
	}
	/** Méthode principale du projet permettant son exécution. Elle lance l'IHM presentation du package vue qui propose à l'utilisateur de saisir ses paramètres de simulation. A partir de cet IHM, tous les processus de la simulation vont s'enchaîner indépendamment.
	 * 
	 * @param args
	 */
	public static void main(String[] args) {

		Presentation.affiche();
		
	}
	
}


