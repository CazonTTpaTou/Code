package trace;

import java.awt.Color;
import java.awt.Component;

import javax.swing.JLabel;
import javax.swing.JTable;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.TableCellRenderer;

/** Classe impl�mentant un formatage de donn�es sp�cifique aux lignes correspondant aux jours de simulation o� le stock est en rupture.
 * 
 * @author Fabien Monnery
 *
 */
public class Surligne extends DefaultTableCellRenderer {
	
	int[] ligne;
	 
	private static final long serialVersionUID = 1L;
	
	/** Constructeur admettant en surcharge un tableau d'entier contenant les lignes � formater.
	 * 
	 * @param lig
	 * Tableau des lignes dont la colonne stock est � 0 et dont les colonnes En attente et Commande Perdue sont sup�rieures � 0.
	 */
	public Surligne(int[] lig) {
		this.setOpaque(true);
		ligne=lig;
}
	/** M�thode sp�cifiant un formatage de cellule � fond gris pour les num�ros de ligne pr�sents dans le tableau de param�tres.
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
	/** M�thode permettant d'indiquer par un bool�en si l'entier pass� en param�tre se trouve bien dans le tableau de lignes - attribut de la classe.
	 * 
	 * @param r
	 * Num�ro de ligne du mod�le de donn�es pass� en param�tre.
	 * @return
	 * Bool�en dont la valeur est d�termin�e par la pr�sence ou non du num�ro de ligne pass� en param�tre dans le tableau de lignes - attribut de la classe.
	 */
	private boolean trouve(int r) {
		boolean flag=false;
		for(int i=0;i<ligne.length;i++) {
			if(ligne[i]==r) {flag=true;}
		}
		return flag;
	}
}


