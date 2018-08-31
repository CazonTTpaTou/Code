package simulation;

import java.io.IOException;

import trace.Trace;

import modele.FileChainee;
import modele.FilePleineException;
import modele.FileVideException;
import modele.ListePleineException;
import modele.RangInvalideException;
import modele.TypeIncompatibleException;


/** Classe responsable de la cr�ation des instances de la classe Client
 * 
 * @author Fabien Monnery
 *
 */
public class ClientFactory {

	private static int NClient;
	private static FileChainee FASimple;
	private static FileChainee FAPrioritaire;
	private static int EnAttente;
	private static int CumulEnAttente;
	private static int Perdu;
	private static int CumulPerdu;
	
	/** Constructeur statique de la classe permettant d'initialiser les attributs de classe.
	 * 
	 */
	static {
		Class classe=Client.class;
		FASimple = new FileChainee(classe);
		FAPrioritaire = new FileChainee(classe);
		NClient=0;
		EnAttente=0;
		CumulEnAttente=0;
		Perdu=0;
		CumulPerdu=0;
	}
	
	/** M�thode retournant le nombre de clients fabriqu�s la classe ClientFactory
	 * 
	 * @return
	 * Le nombre de clients dans le syst�me de simulation des stocks.
	 */
	public static int getNClient() {
		return NClient;
	}
	/** M�thode retournant le nombre de commandes en attente
	 * 
	 * @return
	 * Nombre de commandes en attente.
	 */
	public static int getEnAttente() {
		return EnAttente;
	}
	/** M�thode retournant le cumul du nombre de commandes en attente depuis le d�but de la simulation.
	 * 
	 * @return
	 * Le cumul du nombre de commandes ayant �t� mises en attente.
	 */
	public static int getCumulEnAttente() {
		return CumulEnAttente;
	}
	/** M�thode retournant le nombre de commandes non prioritaires n'ayant pas pu �tre honor�es et qui sont donc perdues.
	 * 
	 * @return
	 * Nombre de commandes non satisfaites et qui sont d�finitivement perdues.
	 */
	public static int getPerdu() {
		return Perdu;
	}
	/** M�thode retournant le cumul du nombre de commandes perdues depuis le d�but de la simulation de stock.
	 * 
	 * @return
	 * Cumul du nombre de commandes perdues.
	 */
	public static int getCumulPerdu() {
		return CumulPerdu;
	}
	
	/** M�thode qui vide la file d'attente des clients non prioritaires une fois atteinte la rupture de stock
	 * 
	 * @return
	 * Cumul des commandes qui ne seront pas honor�es.
	 * @throws ListePleineException
	 * @throws RangInvalideException
	 * @throws TypeIncompatibleException
	 * @throws FileVideException
	 */
	public static int getFileSimple() throws ListePleineException, RangInvalideException, TypeIncompatibleException, FileVideException {
		int perte=0;
		while(!FASimple.estVide()) {
			Client c = (Client) FASimple.elementDeQueue();
			perte+= c.getDemande();
			FASimple.defiler();
		}
		return perte;
	}
	/** M�thode retournant le nombre de commandes plac�es dans la file d'attente prioritaire
	 * 
	 * @return
	 * La quantit� de commandes � servir dans la file d'attente prioritaire
	 * @throws ListePleineException
	 * @throws RangInvalideException
	 * @throws TypeIncompatibleException
	 * @throws IOException
	 */
	public static int getFilePrioritaire() throws ListePleineException, RangInvalideException, TypeIncompatibleException, IOException {
		int wait=0;
		for(int i=1;i<=FAPrioritaire.longue();i++) {
			Client c = (Client) FAPrioritaire.i�me(i);
			wait+= c.getDemande();
			String messageeeee="Jour n� "+Horloge.getJour()+" - En attente dans la file prioritaire : Client n� "+c.getNum()+ " - demande en attente n� "+i+" de "+c.getDemande()+" unit�s";
			Trace.clientfactory(messageeeee);
		}
		return wait;
	}
	/** M�thode r�initilisant les attributs de la classe lors d'une nouvelle simulation de stock.
	 * 
	 * @throws FileVideException
	 * @throws RangInvalideException
	 * @throws TypeIncompatibleException
	 */
	public static void reinit() throws FileVideException, RangInvalideException, TypeIncompatibleException {
		NClient=0;
		EnAttente=0;
		CumulEnAttente=0;
		Perdu=0;
		CumulPerdu=0;
		while(!FASimple.estVide()) {FASimple.defiler();}
		while(!FAPrioritaire.estVide()) {FAPrioritaire.defiler();}
	}
	/** M�thode cr�ant une nouvelle instance de la classe Client dont la consommation est d�termin�e par le g�n�ratoire de nombre al�atoire de type loi normale gaussienne d'esp�rance 20 et d'�cart type 7.
	 * 
	 *  
	 * @return
	 * Une instance de la classe client enti�rement param�tr�.
	 * @throws IOException
	 */
	public static Client creation() throws IOException {
		Client c;
		c=new Client(Aleatoire.Normale(20, 7));
		int conso = (int) Math.round(c.getDemande());
		Entrepot.setConsommation(conso);
		return c;
	}
	/** M�thode cr�ant un nombre d'instance Client d�termin� par le g�n�rateur de nombre al�atoire de type loi de Weibull. Les instances Client ayant un attribut prioritaire sont stock�s dans une file d'attente prioritaire. Les autres sont stock�s dans une file simple.
	 * 
	 * @throws FilePleineException
	 * @throws RangInvalideException
	 * @throws TypeIncompatibleException
	 * @throws IOException
	 */
	public static void factory() throws FilePleineException, RangInvalideException, TypeIncompatibleException, IOException {
		int demande;
		Client client;
		
		Entrepot.setConsoZero();
		demande= (int) Math.round(Aleatoire.Weibull(8, 4));
		Entrepot.setDemandeJournaliere(demande);
		String message="Jour n� "+Horloge.getJour()+ " - Demande journali�re de " + demande + " clients";
		Trace.clientfactory(message);
		Trace.client(message);
		
		for(int i=0;i<demande;i++) {
			client=creation();
			NClient++;
			if(client.getPrior()) {FAPrioritaire.enfiler(client);}
			else{FASimple.enfiler(client);}
		}
		
		String messagee="Jour n� "+Horloge.getJour()+" - Longueur File prioritaire : "+FAPrioritaire.longue();
		messagee+=" - Longueur File simple : "+FASimple.longue();
		Trace.clientfactory(messagee);
		Entrepot.setCumulConsommation(Entrepot.getConsommation());
		Entrepot.setDemandeHebdomadaire(Entrepot.getConsommation());
	}
	
	/** M�thode permettant de simuler les demandes de consommation des clients stock�s dans la file d'attente pass�e en param�tre, tant que le stock n'est pas � 0.
	 * 
	 * @param file
	 * File d'attente contenant les clients ayant des achats � effectuer dans le syst�me.
	 * @throws FileVideException
	 * @throws RangInvalideException
	 * @throws TypeIncompatibleException
	 * @throws IOException
	 */
	public static void acheter(FileChainee file) throws FileVideException, RangInvalideException, TypeIncompatibleException, IOException {
		Client obj;
		while(!file.estVide() && Entrepot.getStock()>0)
		{obj= (Client) file.elementDeQueue();
		 int achat= (int) Math.round(obj.getDemande());
		 int retour =satisfactionDemande(achat);
		 if(retour==0) {file.defiler();}
		 if(retour>0) {obj.setDemande(retour);}
		}
	}
	/** M�thode v�rifiant que la demande pour un client particulier peut �tre bien satisfaite, quitte � n'en satisfaire qu'une partie lorsque le stock est en rupture. Dans ce cas, le reliquat non satisfait est param�tr� dans l'attribut demande se l'instance client.
	 * 
	 * @param Demande
	 * @return
	 * L'�ventuel reliquat de la demande qui n'a pas �t� satisfaite en raison d'une rupture de stock.
	 * @throws IOException
	 */
	public static int satisfactionDemande(int Demande) throws IOException {
		int reliquat=0;
		
		if(Entrepot.getStock()<Demande) {reliquat=Demande-Entrepot.getStock();
										 Demande=Math.min(Demande, Entrepot.getStock());}
			
			Entrepot.setDemandeServie(Demande);
			Entrepot.setStock(Demande);
			
			String messageee="Diminution de stock de "+Demande + " - Reliquat de :"+reliquat;
			Trace.clientfactory(messageee);
			
			return reliquat;
		}
	/** M�thode simulant une journ�e d'achat dans le syst�me de gestion des stocks. En premier sont satisfaites les demandes contenues dans la file d'attente prioritaire, selon les disponibilit�s du stock. Ensuite sont trait�es les demandes des clients contenus dans la file d'attente classique. Lorsque le stock est en rupture, le reste de la file d'attente simple est d�fil�, entrainant la perte des commandes qu'elle contenait.
	 *  
	 * @throws FileVideException
	 * @throws RangInvalideException
	 * @throws TypeIncompatibleException
	 * @throws IOException
	 */
	public static void JourneeAchat() throws FileVideException, RangInvalideException, TypeIncompatibleException, IOException {
		acheter(FAPrioritaire);
		acheter(FASimple);
		EnAttente=getFilePrioritaire();
		CumulEnAttente+=EnAttente;
		Perdu=getFileSimple();
		CumulPerdu+=Perdu;		
		String messageeee="Demande en attente : "+EnAttente+" - Demande perdue : "+Perdu;
		Trace.clientfactory(messageeee);
	}
}

