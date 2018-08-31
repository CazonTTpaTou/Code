package trace;

import javax.swing.table.AbstractTableModel;

/** Classe g�rant le mod�le des donn�es qui sera affich� par le biais de la JTable de pr�sentation du d�roulement de la simulation de stock.
 * 
 * @author Fabien Monnery
 *
 */
public class MonModele  extends AbstractTableModel{ 
	
	private static final long serialVersionUID = 1L;
	Object donnees[][];
	String titres[];
	
	/** Constructeur du mod�le de donn�es.
	 * 
	 * @param donnees
	 * Donn�es qui seront affich�es par le biais du mod�le de donn�es.
	 * @param titres
	 * En t�te des colonnes du mod�le de donn�es.
	 */
	public MonModele(Object donnees[][], String titres[]){ 
		this.donnees = donnees; 
		this.titres = titres; 
		} 
	/** M�thode retournant le nombre de colonne du mod�le de donn�es.
	 * 
	 */
	public int getColumnCount(){ 
		return donnees[0].length; 
	}
	/** M�thode renvoyant la valeur contenue � une case pr�cise du mod�le de donn�es.
	 * 
	 */
	public Object getValueAt(int parm1, int parm2){ 
		return donnees[parm1][parm2]; 
	}
	/** M�thode renvoyant le nombre de lignes du mod�le de donn�es.
	 * 
	 */
	public int getRowCount() { 
		return donnees.length; 
	}
	/** M�thode renvoyant le nom de la colonne dont le num�ro est pass� en param�tre.
	 * 
	 */
	public String getColumnName(int col){ 
		return titres[col]; 
	} 
	/** M�thode permettant de fixer les valeurs du tableau du mod�le de donn�es.
	 * 
	 * @param data
	 * Donn�es � transmettre au mod�le de donn�es pour pouvoir l'afficher par le biais d'une JTable. Cette m�thode d�clenche un �v�nement de type TableEvent qui pourra �tre intercept� par un Listener impl�ment�e par une JTable.
	 */
	public void setData(Object[][] data) {
        this.donnees = data;
        fireTableDataChanged();
	}

}


