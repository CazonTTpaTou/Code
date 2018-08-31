package trace;

import java.awt.Color;
import java.awt.Component;
import java.awt.Font;

import javax.swing.JLabel;
import javax.swing.JTable;
import javax.swing.SwingConstants;
import javax.swing.UIManager;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.TableCellRenderer;

/** Classe gérant la mise en forme des données d'en tête de la JTable Tableau de présentation du déroulement de la simulation.
 * 
 * @author Fabien Monnery
 *
 */
public class Header extends DefaultTableCellRenderer {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/** Méthode permettant de créer un type de formatage police Gras et Centré pour les données d'en tête de la JTable.
	 * 
	 */
	public Component getTableCellRendererComponent(JTable table,Object value, boolean isSelected, boolean hasFocus,int row, int column)
	{
	String txt = value.toString();
	//JLabel label = new JLabel("<html><body><b><u><center>" + txt + "</center></u></b></body></html>");
	JLabel label = new JLabel (txt);
	
	//label.setAlignmentY((int)Component.CENTER_ALIGNMENT);
	//this.setHorizontalAlignment((int)Component.CENTER_ALIGNMENT);
	
	label.setFont(new Font("Courier New", Font.BOLD, 12));	
	label.setBackground(Color.BLACK);
	label.setForeground(Color.WHITE);
	label.setAlignmentX(SwingConstants.CENTER);
	label.setAlignmentY(SwingConstants.CENTER);
	
	return label;
	}
}


