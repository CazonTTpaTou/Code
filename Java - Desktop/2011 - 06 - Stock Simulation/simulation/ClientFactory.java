package simulation;

import java.io.IOException;

import trace.Trace;

import modele.FileChainee;
import modele.FilePleineException;
import modele.FileVideException;
import modele.ListePleineException;
import modele.RangInvalideException;
import modele.TypeIncompatibleException;


/** Classe responsable de la création des instances de la classe Client
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
	
	/** Méthode retournant le nombre de clients fabriqués la classe ClientFactory
	 * 
	 * @return
	 * Le nombre de clients dans le système de simulation des stocks.
	 */
	public static int getNClient() {
		return NClient;
	}
	/** Méthode retournant le nombre de commandes en attente
	 * 
	 * @return
	 * Nombre de commandes en attente.
	 */
	public static int getEnAttente() {
		return EnAttente;
	}
	/** Méthode retournant le cumul du nombre de commandes en attente depuis le début de la simulation.
	 * 
	 * @return
	 * Le cumul du nombre de commandes ayant été mises en attente.
	 */
	public static int getCumulEnAttente() {
		return CumulEnAttente;
	}
	/** Méthode retournant le nombre de commandes non prioritaires n'ayant pas pu être honorées et qui sont donc perdues.
	 * 
	 * @return
	 * Nombre de commandes non satisfaites et qui sont définitivement perdues.
	 */
	public static int getPerdu() {
		return Perdu;
	}
	/** Méthode retournant le cumul du nombre de commandes perdues depuis le début de la simulation de stock.
	 * 
	 * @return
	 * Cumul du nombre de commandes perdues.
	 */
	public static int getCumulPerdu() {
		return CumulPerdu;
	}
	
	/** Méthode qui vide la file d'attente des clients non prioritaires une fois atteinte la rupture de stock
	 * 
	 * @return
	 * Cumul des commandes qui ne seront pas honorées.
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
	/** Méthode retournant le nombre de commandes placées dans la file d'attente prioritaire
	 * 
	 * @return
	 * La quantité de commandes à servir dans la file d'attente prioritaire
	 * @throws ListePleineException
	 * @throws RangInvalideException
	 * @throws TypeIncompatibleException
	 * @throws IOException
	 */
	public static int getFilePrioritaire() throws ListePleineException, RangInvalideException, TypeIncompatibleException, IOException {
		int wait=0;
		for(int i=1;i<=FAPrioritaire.longue();i++) {
			Client c = (Client) FAPrioritaire.ième(i);
			wait+= c.getDemande();
			String messageeeee="Jour n° "+Horloge.getJour()+" - En attente dans la file prioritaire : Client n° "+c.getNum()+ " - demande en attente n° "+i+" de "+c.getDemande()+" unités";
			Trace.clientfactory(messageeeee);
		}
		return wait;
	}
	/** Méthode réinitilisant les attributs de la classe lors d'une nouvelle simulation de stock.
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
	/** Méthode créant une nouvelle instance de la classe Client dont la consommation est déterminée par le génératoire de nombre aléatoire de type loi normale gaussienne d'espérance 20 et d'écart type 7.
	 * 
	 *  
	 * @return
	 * Une instance de la classe client entièrement paramétré.
	 * @throws IOException
	 */
	public static Client creation() throws IOException {
		Client c;
		c=new Client(Aleatoire.Normale(20, 7));
		int conso = (int) Math.round(c.getDemande());
		Entrepot.setConsommation(conso);
		return c;
	}
	/** Méthode créant un nombre d'instance Client déterminé par le générateur de nombre aléatoire de type loi de Weibull. Les instances Client ayant un attribut prioritaire sont stockés dans une file d'attente prioritaire. Les autres sont stockés dans une file simple.
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
		String message="Jour n° "+Horloge.getJour()+ " - Demande journalière de " + demande + " clients";
		Trace.clientfactory(message);
		Trace.client(message);
		
		for(int i=0;i<demande;i++) {
			client=creation();
			NClient++;
			if(client.getPrior()) {FAPrioritaire.enfiler(client);}
			else{FASimple.enfiler(client);}
		}
		
		String messagee="Jour n° "+Horloge.getJour()+" - Longueur File prioritaire : "+FAPrioritaire.longue();
		messagee+=" - Longueur File simple : "+FASimple.longue();
		Trace.clientfactory(messagee);
		Entrepot.setCumulConsommation(Entrepot.getConsommation());
		Entrepot.setDemandeHebdomadaire(Entrepot.getConsommation());
	}
	
	/** Méthode permettant de simuler les demandes de consommation des clients stockés dans la file d'attente passée en paramètre, tant que le stock n'est pas à 0.
	 * 
	 * @param file
	 * File d'attente contenant les clients ayant des achats à effectuer dans le système.
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
	/** Méthode vérifiant que la demande pour un client particulier peut être bien satisfaite, quitte à n'en satisfaire qu'une partie lorsque le stock est en rupture. Dans ce cas, le reliquat non satisfait est paramétré dans l'attribut demande se l'instance client.
	 * 
	 * @param Demande
	 * @return
	 * L'éventuel reliquat de la demande qui n'a pas été satisfaite en raison d'une rupture de stock.
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
	/** Méthode simulant une journée d'achat dans le système de gestion des stocks. En premier sont satisfaites les demandes contenues dans la file d'attente prioritaire, selon les disponibilités du stock. Ensuite sont traitées les demandes des clients contenus dans la file d'attente classique. Lorsque le stock est en rupture, le reste de la file d'attente simple est défilé, entrainant la perte des commandes qu'elle contenait.
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

