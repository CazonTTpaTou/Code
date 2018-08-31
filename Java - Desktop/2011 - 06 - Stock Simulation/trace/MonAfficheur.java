package trace;

import java.awt.Color;
import java.awt.Component;

import javax.swing.JLabel;
import javax.swing.JTable;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.TableCellRenderer;

/** Classe permettant de formater l'affichage des donn�es de la JTable de pr�sentation du d�roulement de la simulation.
 * 
 * @author Fabien Monnery
 *
 */
public class MonAfficheur extends DefaultTableCellRenderer {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public MonAfficheur() {
		this.setOpaque(true);
}
	/** M�thode fixant un formatage de colonne centr�e horizontalement.
	 * 
	 */
	public Component getTableCellRendererComponent(JTable table, Object value, boolean isSelected, boolean hasFocus, int row, int col) {
		Component cell = super.getTableCellRendererComponent(table,value,isSelected,hasFocus,row,col); 
		this.setHorizontalAlignment((int)Component.CENTER_ALIGNMENT);
		//cell.setBackground(Color.darkGray);
		
		return this;
	}
}
