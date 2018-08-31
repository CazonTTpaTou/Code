package trace;

import javax.swing.table.AbstractTableModel;

/** Classe gérant le modèle des données qui sera affiché par le biais de la JTable de présentation du déroulement de la simulation de stock.
 * 
 * @author Fabien Monnery
 *
 */
public class MonModele  extends AbstractTableModel{ 
	
	private static final long serialVersionUID = 1L;
	Object donnees[][];
	String titres[];
	
	/** Constructeur du modèle de données.
	 * 
	 * @param donnees
	 * Données qui seront affichées par le biais du modèle de données.
	 * @param titres
	 * En tête des colonnes du modèle de données.
	 */
	public MonModele(Object donnees[][], String titres[]){ 
		this.donnees = donnees; 
		this.titres = titres; 
		} 
	/** Méthode retournant le nombre de colonne du modèle de données.
	 * 
	 */
	public int getColumnCount(){ 
		return donnees[0].length; 
	}
	/** Méthode renvoyant la valeur contenue à une case précise du modèle de données.
	 * 
	 */
	public Object getValueAt(int parm1, int parm2){ 
		return donnees[parm1][parm2]; 
	}
	/** Méthode renvoyant le nombre de lignes du modèle de données.
	 * 
	 */
	public int getRowCount() { 
		return donnees.length; 
	}
	/** Méthode renvoyant le nom de la colonne dont le numéro est passé en paramètre.
	 * 
	 */
	public String getColumnName(int col){ 
		return titres[col]; 
	} 
	/** Méthode permettant de fixer les valeurs du tableau du modèle de données.
	 * 
	 * @param data
	 * Données à transmettre au modèle de données pour pouvoir l'afficher par le biais d'une JTable. Cette méthode déclenche un évènement de type TableEvent qui pourra être intercepté par un Listener implémentée par une JTable.
	 */
	public void setData(Object[][] data) {
        this.donnees = data;
        fireTableDataChanged();
	}

}


