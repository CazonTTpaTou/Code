package trace;

import java.awt.Color;
import java.awt.Component;

import javax.swing.JLabel;
import javax.swing.JTable;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.TableCellRenderer;

/** Classe implémentant un formatage de données spécifique aux lignes correspondant aux jours de simulation où le stock est en rupture.
 * 
 * @author Fabien Monnery
 *
 */
public class Surligne extends DefaultTableCellRenderer {
	
	int[] ligne;
	 
	private static final long serialVersionUID = 1L;
	
	/** Constructeur admettant en surcharge un tableau d'entier contenant les lignes à formater.
	 * 
	 * @param lig
	 * Tableau des lignes dont la colonne stock est à 0 et dont les colonnes En attente et Commande Perdue sont supérieures à 0.
	 */
	public Surligne(int[] lig) {
		this.setOpaque(true);
		ligne=lig;
}
	/** Méthode spécifiant un formatage de cellule à fond gris pour les numéros de ligne présents dans le tableau de paramètres.
	 * 
	 */
	public Component getTableCellRendererComponent(JTable table, Object value, boolean isSelected, boolean hasFocus, int row, int col) {
		Component cell = super.getTableCellRendererComponent(table,value,isSelected,hasFocus,row,col); 
		this.setHorizontalAlignment((int)Component.CENTER_ALIGNMENT);
		//cell.setBackground(Color.darkGray);
		//if( value instanceof Integer )
		if( trouve(row))
		{
           // Integer amount = (Integer) value;
           // if( amount.intValue() == 0 )
           // {
                cell.setBackground( Color.lightGray);
                // You can also customize the Font and Foreground this way
                // cell.setForeground();
                // cell.setFont();
            }
            else
            {
                cell.setBackground( Color.white );
            }
        //}
		return this;
	}
	/** Méthode permettant d'indiquer par un booléen si l'entier passé en paramètre se trouve bien dans le tableau de lignes - attribut de la classe.
	 * 
	 * @param r
	 * Numéro de ligne du modèle de données passé en paramètre.
	 * @return
	 * Booléen dont la valeur est déterminée par la présence ou non du numéro de ligne passé en paramètre dans le tableau de lignes - attribut de la classe.
	 */
	private boolean trouve(int r) {
		boolean flag=false;
		for(int i=0;i<ligne.length;i++) {
			if(ligne[i]==r) {flag=true;}
		}
		return flag;
	}
}


