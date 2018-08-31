package vue;

import java.awt.BorderLayout;
import java.awt.Component;
import java.awt.Container;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.GridLayout;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.event.TableModelEvent;
import javax.swing.event.TableModelListener;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.TableCellRenderer;
import javax.swing.table.TableColumn;
import javax.swing.table.TableModel;

import simulation.Systeme;
import trace.Header;
import trace.MonAfficheur;
import trace.MonModele;
import trace.Surligne;

/** Classe présentant l'interface graphique de type JTable contenant les données de déroulement de la simulation de stock. La classe ne gère que l'affichage proprement dit des données. Le modèle des données qui lui sont transmis en paramètre est de type AbstractTableModel et est géré par la classe MonModele du package trace. Cette séparation des tâches affichage des données et gestion des données respecte bien le pattern MVC - qui a guidé l'architecture de ce projet.
 * 
 * @author Fabien Monnery
 *
 */
public class Tableau extends JFrame {
	
	private static final long serialVersionUID = 1L;
	
	JButton jButton0;
	JButton jButton1;
	JPanel jpane0;
	static JTable table;
	JScrollPane scrollPane;
	
	String[] columnNames = 
			{"N°Jour",
            "Semaine",
            "Jour Semaine",
            "Clients",
            "Demande",
            "Stock",
            "Reassort",
            "Demande Servie",
            "En Attente",
            "Perdu"};

	
	
	
	public Tableau(TableModel data) {
		//data.addTableModelListener((TableModelListener) this);
		table = new JTable(data);
		
		MonAfficheur affiche = new MonAfficheur();
		Header head = new Header();
		for(int i=0;i<10;i++) {
			table.getColumnModel().getColumn(i).setCellRenderer(affiche);
			//table.getColumnModel().getColumn(i).setHeaderRenderer(head);
			} 	
			//table.setRowMargin(5);

		FontMetrics fm = table.getFontMetrics(table.getFont());
	        for (int i = 0 ; i < table.getColumnCount() ; i++)
	        {
	            int taille = fm.stringWidth((String)columnNames[i]);
	           // System.out.println("Taille colonne n° "+i+" largeur de "+taille);
	           // String nom = (String)table.getColumnModel().getColumn(i).getIdentifier();
	          //  System.out.println("Taille colonne n° "+i+" largeur de "+nom);
	            //  int taille = fm.stringWidth(nom);
	          //  if (taille > max)
	          int max = (int) Math.round(taille*1.5);
	           table.getColumnModel().getColumn(i).setPreferredWidth(max);
	        }

		//table.getColumnModel().getColumn(3).setPreferredWidth(175);
		scrollPane = new JScrollPane(table);
		scrollPane.setSize(750, 450);
		initComponents();
	}
	private void initComponents() {

		Container c = getContentPane();
		c.setLayout(new BorderLayout());
		c.add(scrollPane,BorderLayout.CENTER);
		c.add(getJContentPane0(), BorderLayout.PAGE_END);
		this.setTitle("Fluctuations du stock");
		this.setLocation(50, 10);
		this.setVisible(true);
		this.setSize(900, 500);
		}
	
	private JPanel getJContentPane0() {
		
		if (jpane0==null) {
		jpane0= new JPanel();
		jpane0.setSize(850, 450);
		jpane0.setLayout(new GridLayout(1,2));
		jpane0.add(getJButton0());
		jpane0.add(getJButton1());
		
		}
		return jpane0;
		}	  

	public static void affiche(TableModel data) {
		 Tableau menu = new Tableau(data);
		  menu.setVisible(true);
	}	
	public static void  souligne(int[] ligne) {
		Surligne surl = new Surligne(ligne);
		for(int i=0;i<10;i++) {
			table.getColumnModel().getColumn(i).setCellRenderer(surl);} 
	}
	private JButton getJButton0() {
		if (jButton0 == null) {
			jButton0 = new JButton();
			jButton0.setText("Recommencer la simulation");
			jButton0.addMouseListener(new MouseAdapter() {
	
				public void mouseClicked(MouseEvent event) {
					jButton0MouseMouseClicked(event);
				}
			});
		}
		return jButton0;
	}
	
	private JButton getJButton1() {
		if (jButton1 == null) {
			jButton1 = new JButton();
			jButton1.setText("Quitter l'application");
			jButton1.addMouseListener(new MouseAdapter() {
	
				public void mouseClicked(MouseEvent event) {
					jButton1MouseMouseClicked(event);
				}
			});
		}
		return jButton1;
	}
	
	private void jButton0MouseMouseClicked(MouseEvent event) {

		try{Tableau.this.dispose();
			Systeme.simulation(null);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
	private void jButton1MouseMouseClicked(MouseEvent event) {
		try{
			Tableau.this.dispose();
			String message="Merci d'avoir utilisé notre application de gestion des stocks !!!";
			JOptionPane.showMessageDialog(null, message);
	}
	catch(Exception e) {
		e.printStackTrace();}
	}
}

