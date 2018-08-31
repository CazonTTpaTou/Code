package vue;

import java.awt.BorderLayout;
import java.awt.Container;
import java.awt.Font;
import java.awt.GridLayout;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

import javax.swing.ButtonGroup;
import javax.swing.DefaultListModel;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JList;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JRadioButton;
import javax.swing.JRadioButtonMenuItem;
import javax.swing.JScrollPane;

import simulation.Systeme;

/** Classe gérant l'affichage de l'interface utilisateur permettant de choisir les différents paramètres de la simulation de stock.
 * 
 * @author Fabien Monnery
 *
 */
public class Presentation extends JFrame {

	private JList jList1;
	private JList jList2;
	private JList jList3;
	private JList jList4;
	private JList jList5;
	private JList jList6;
	private ButtonGroup jRadioMenu1;
	private JRadioButton jRadio1;
	private JRadioButton jRadio2;
	private ButtonGroup jRadioMenu2;
	private JRadioButton jRadio3;
	private JRadioButton jRadio4;
	private ButtonGroup jRadioMenu3;
	private JRadioButton jRadio5;
	private JRadioButton jRadio6;
	private JRadioButton jRadio7;
	private JScrollPane jScrollPane0;
	private JScrollPane jScrollPane1;
	private JScrollPane jScrollPane2;
	private JScrollPane jScrollPane3;
	private JScrollPane jScrollPane4;
	private JScrollPane jScrollPane5;
	private JScrollPane jScrollPane6;
	private JLabel jLabel1;
	private JLabel jLabel2;
	private JLabel jLabel3;
	private JLabel jLabel4;
	private JLabel jLabel5;
	private JLabel jLabel6;
	private JLabel jLabel7;
	private JLabel jLabel8;
	private JLabel jLabel9;
	private JLabel jLabel10;
	private JLabel jLabel21;
	private JButton jButton0;
	private JPanel jpane0;
	private JPanel jpane00;
	private JPanel jpane1;
	private JPanel jpane2;
	private JPanel jpane3;
	private JPanel jpane4;
	private JPanel jpane5;
	private JPanel jpane6;
	private JPanel jpane7;
	private JPanel jpane8;
	private JPanel jpane9;
	private JPanel jpane10;

	ItemListener selector = new ItemListener() {
		  private JRadioButton selected;
		  
		  public void itemStateChanged(ItemEvent e) {
		    if(ItemEvent.SELECTED == e.getStateChange())
		      {selected = (JRadioButton) e.getItem();}
		  	}
		
		  public String getButton() {
			  String but = selected.toString();
			  System.out.println(but);
		    return but;
		  }
		};
	
	public Presentation() {
		initComponents();
	}
	
	private void initComponents() {

		Container c = getContentPane();
		c.setLayout(new BorderLayout());
		c.add(getJContentPane(), BorderLayout.CENTER);
		c.add(getJButton0(), BorderLayout.PAGE_END);
		c.add(getJContentPane0(), BorderLayout.PAGE_START);

		//this.setContentPane(getJContentPane());
		this.setTitle("Paramètres de la simulation");
		this.setLocation(50, 10);
		this.setVisible(true);
	}
	
	private JPanel getJContentPane() {
		
			if (jpane0==null) {
			jpane0= new JPanel();
			jpane0.setLayout(new GridLayout(3,3));
			
			
			jpane0.add(getJContentPane2());
			jpane0.add(getJContentPane3());
			jpane0.add(getJContentPane1());
			
			jpane0.add(getJContentPane5());
			jpane0.add(getJContentPane10());
			jpane0.add(getJContentPane8());
			
			jpane0.add(getJContentPane6());
			jpane0.add(getJContentPane7());
			jpane0.add(getJContentPane9());
			}
			return jpane0;
			}	
	
	private JPanel getJContentPane0() {
		
		if (jpane00==null) {
		jpane00= new JPanel();
		//jpane1.setLayout(new GridLayout(2,1));
		jpane00.add(getJLabel21());
		}
		return jpane00;
		}	
	
	private JPanel getJContentPane1() {
		
		if (jpane1==null) {
		jpane1= new JPanel();
		//jpane1.setLayout(new GridLayout(2,1));
		jpane1.add(getJLabel1());
		jpane1.add(getJScrollPane0());

		}
		return jpane1;
		}	
	
	private JPanel getJContentPane2() {
		
		if (jpane2==null) {
		jpane2 = new JPanel();
		//jpane2.setLayout(new GridLayout(2,1));
		jpane2.add(getJLabel3());
		jpane2.add(getJScrollPane1());

		}
		return jpane2;
		}
	
	private JPanel getJContentPane3() {
		
		if (jpane3==null) {
		jpane3 = new JPanel();
		//jpane3.setLayout(new GridLayout(2,1));
		jpane3.add(getJLabel2());
		jpane3.add(getJScrollPane2());

		}
		return jpane3;
		}
	
private JPanel getJContentPane4() {
		
		if (jpane4==null) {
		jpane4 = new JPanel();
		//jpane3.setLayout(new GridLayout(2,1));
		jpane4.add(getJLabel2());
		jpane4.add(getJScrollPane3());

		}
		return jpane4;
		}
	
	private JPanel getJContentPane7() {
		
		if (jpane7==null) {
		jpane7= new JPanel();
		jpane7.add(getJLabel6());
		jpane7.add(getJScrollPane4());}
		return jpane7;
		}	
	
private JPanel getJContentPane8() {
		
		if (jpane8==null) {
		jpane8= new JPanel();
		jpane8.add(getJLabel8());
		jpane8.add(getJScrollPane5());}
		return jpane8;
		}

private JPanel getJContentPane9() {
	
	if (jpane9==null) {
	jpane9= new JPanel();
	jpane9.add(getJLabel10());
	jpane9.add(getJScrollPane6());}
	return jpane9;
	}
	
	private JPanel getJContentPane5() {
		
		if (jpane5==null) {
		jpane5= new JPanel();
		jpane5.setLayout(new GridLayout(3,1));
		jpane5.add(getJLabel4());
		jpane5.add(getJRadioButton1());
		jpane5.add(getJRadioButton2());
		getJRadioMenu1();}
		return jpane5;
		}	
	
private JPanel getJContentPane10() {
		
		if (jpane10==null) {
		jpane10= new JPanel();
		jpane10.setLayout(new GridLayout(3,1));
		jpane10.add(getJLabel5());
		jpane10.add(getJRadioButton3());
		jpane10.add(getJRadioButton4());
		getJRadioMenu2();}
		return jpane10;
		}	
	
	
	private JPanel getJContentPane6() {
				
			if (jpane6==null) {
			jpane6= new JPanel();
			jpane6.setLayout(new GridLayout(4,1));
			jpane6.add(getJLabel7());
			jpane6.add(getJRadioButton5());
			jpane6.add(getJRadioButton6());
			jpane6.add(getJRadioButton7());
			getJRadioMenu3();}
			return jpane6;
			}		

	private JLabel getJLabel21() {
		if (jLabel21 == null) {
			jLabel21 = new JLabel();
			jLabel21.setFont(new Font("Dialog", Font.BOLD, 14));
			jLabel21.setText("<html><u>Veuillez choisir les différents paramètres de la simulation SVP :</u></html>");
		}
		return jLabel21;
	}
	
	private ButtonGroup getJRadioMenu1() {
		if (jRadioMenu1 == null) {
			ButtonGroup jRadioMenu1 = new ButtonGroup();
			jRadioMenu1.add(getJRadioButton1());
			jRadioMenu1.add(getJRadioButton2());
			}
		return jRadioMenu1;
		}
	
	private ButtonGroup getJRadioMenu2() {
		if (jRadioMenu2 == null) {
			jRadioMenu2 = new ButtonGroup();
			jRadioMenu2.add(getJRadioButton3());
			jRadioMenu2.add(getJRadioButton4());
			}
		return jRadioMenu2;
		}
	
	private ButtonGroup getJRadioMenu3() {
		if (jRadioMenu3 == null) {
			jRadioMenu3 = new ButtonGroup();
			jRadioMenu3.add(getJRadioButton5());
			jRadioMenu3.add(getJRadioButton6());
			jRadioMenu3.add(getJRadioButton7());
			}
		return jRadioMenu3;
		}
	
	private JRadioButton getJRadioButton1() {
		if (jRadio1 == null) {
			jRadio1 = new JRadioButton("Approvisionnement à capacité MAX");
			jRadio1.addItemListener(selector);
}
		return jRadio1;
		}
	
	private JRadioButton getJRadioButton2() {
		if (jRadio2 == null) {
			jRadio2 = new JRadioButton("Approvisionnement à demande cumulée");
			jRadio1.addItemListener(selector);
		}
		return jRadio2;
		}
	
	private JRadioButton getJRadioButton3() {
		if (jRadio3 == null) {
			jRadio3 = new JRadioButton("Réassortiment à jour fixe");
			}
		return jRadio3;
		}
	
	private JRadioButton getJRadioButton4() {
		if (jRadio4 == null) {
			jRadio4 = new JRadioButton("Réassortiment par alerte stock");
			}
		return jRadio4;
		}
	
	private JRadioButton getJRadioButton5() {
		if (jRadio5 == null) {
			jRadio5 = new JRadioButton("Aléatoire");
			}
		return jRadio5;
		}
	
	private JRadioButton getJRadioButton6() {
		if (jRadio6 == null) {
			jRadio6 = new JRadioButton("Nombre jours");
			}
		return jRadio6;
		}
	
	private JRadioButton getJRadioButton7() {
		if (jRadio7 == null) {
			jRadio7 = new JRadioButton("Jour fixe");
			}
		return jRadio7;
		}
	
	private JScrollPane getJScrollPane0() {
		if (jScrollPane0 == null) {
			jScrollPane0 = new JScrollPane();
			jScrollPane0.setViewportView(getJList1());
		}
		return jScrollPane0;
	}
	
	private JScrollPane getJScrollPane1() {
		if (jScrollPane1 == null) {
			jScrollPane1 = new JScrollPane();
			jScrollPane1.setViewportView(getJList2());
		}
		return jScrollPane1;
	}
	
	private JScrollPane getJScrollPane2() {
		if (jScrollPane2 == null) {
			jScrollPane2 = new JScrollPane();
			jScrollPane2.setViewportView(getJList3());
		}
		return jScrollPane2;
	}
	
	private JScrollPane getJScrollPane3() {
		if (jScrollPane3 == null) {
			jScrollPane3 = new JScrollPane();
			jScrollPane3.setViewportView(getJList4());
		}
		return jScrollPane3;
	}
	
	private JScrollPane getJScrollPane4() {
		if (jScrollPane4 == null) {
			jScrollPane4 = new JScrollPane();
			jScrollPane4.setViewportView(getJList4());
		}
		return jScrollPane4;
	}
	
	private JScrollPane getJScrollPane5() {
		if (jScrollPane5 == null) {
			jScrollPane5 = new JScrollPane();
			jScrollPane5.setViewportView(getJList6());
		}
		return jScrollPane5;
	}
	
	private JScrollPane getJScrollPane6() {
		if (jScrollPane6 == null) {
			jScrollPane6 = new JScrollPane();
			jScrollPane6.setViewportView(getJList5());
		}
		return jScrollPane6;
	}
	
	private JList getJList1() {
		if (jList1 == null) {
			jList1 = new JList();
			DefaultListModel listModel = new DefaultListModel();
			
			for(int a=1;a<=500;a++) {
				listModel.addElement(a*10);
				}
			jList1.setModel(listModel);
		}
		return jList1;
	}

	private JList getJList2() {
		if (jList2 == null) {
			jList2 = new JList();
			DefaultListModel listModel = new DefaultListModel();
			
			for(int a=1;a<=7;a++) {
				listModel.addElement(a);
				}
			jList2.setModel(listModel);
		}
		return jList2;
	}
	
	private JList getJList3() {
		if (jList3 == null) {
			jList3 = new JList();
			DefaultListModel listModel = new DefaultListModel();
			
			for(int a=1;a<=400;a++) {
				listModel.addElement(a);
				}
			jList3.setModel(listModel);
		}
		return jList3;
	}
	
	private JList getJList4() {
		if (jList4 == null) {
			jList4 = new JList();
			DefaultListModel listModel = new DefaultListModel();
			listModel.addElement("Lundi");
			listModel.addElement("Mardi");
			listModel.addElement("Mercredi");
			listModel.addElement("Jeudi");
			listModel.addElement("Vendredi");
			listModel.addElement("Samedi");
			listModel.addElement("Dimanche");
			jList4.setModel(listModel);}
		
		return jList4;}
	
	private JList getJList5() {
		if (jList5 == null) {
			jList5 = new JList();
			DefaultListModel listModel = new DefaultListModel();
			
			for(int a=1;a<=10;a++) {
				listModel.addElement(a);
				}
			jList5.setModel(listModel);
		}
		return jList5;
	}
	
	private JList getJList6() {
		if (jList6 == null) {
			jList6 = new JList();
			DefaultListModel listModel = new DefaultListModel();
			listModel.addElement("Lundi");
			listModel.addElement("Mardi");
			listModel.addElement("Mercredi");
			listModel.addElement("Jeudi");
			listModel.addElement("Vendredi");
			listModel.addElement("Samedi");
			listModel.addElement("Dimanche");
			jList6.setModel(listModel);}
		
		return jList6;}
	
	private JLabel getJLabel1() {
		if (jLabel1 == null) {
			jLabel1 = new JLabel();
			jLabel1.setFont(new Font("Dialog", Font.BOLD, 13));
			jLabel1.setText("Capacité de stockage :");
		}
		return jLabel1;
	}
	
	private JLabel getJLabel2() {
		if (jLabel2 == null) {
			jLabel2 = new JLabel();
			jLabel2.setFont(new Font("Dialog", Font.BOLD, 13));
			jLabel2.setText("Nombre semaine de simulation : ");
		}
		return jLabel2;
	}
	
	private JLabel getJLabel3() {
		if (jLabel3 == null) {
			jLabel3 = new JLabel();
			jLabel3.setFont(new Font("Dialog", Font.BOLD, 13));
			jLabel3.setText("Nombre de jours par semaine : ");
		}
		return jLabel3;
	}
	
	private JLabel getJLabel4() {
		if (jLabel4 == null) {
			jLabel4 = new JLabel();
			jLabel4.setFont(new Font("Dialog", Font.BOLD, 13));
			jLabel4.setText("<html><u>Quantité réapprovisionnement : </u></html>");
		}
		return jLabel4;
	}
	
	private JLabel getJLabel5() {
		if (jLabel5 == null) {
			jLabel5 = new JLabel();
			jLabel5.setFont(new Font("Dialog", Font.BOLD, 13));
			jLabel5.setText("<html><u>Mode réapprovisionnement : </u></html>");
		}
		return jLabel5;
	}
	
	private JLabel getJLabel6() {
		if (jLabel6 == null) {
			jLabel6 = new JLabel();
			jLabel6.setFont(new Font("Dialog", Font.BOLD, 13));
			jLabel6.setText("<html><u>Jour livraison : </u></html>");
		}
		return jLabel6;
	}
	
	private JLabel getJLabel7() {
		if (jLabel7 == null) {
			jLabel7 = new JLabel();
			jLabel7.setFont(new Font("Dialog", Font.BOLD, 13));
			jLabel7.setText("<html><u>Délai de livraison : </u></html>");
		}
		return jLabel7;
	}
	
	private JLabel getJLabel8() {
		if (jLabel8 == null) {
			jLabel8 = new JLabel();
			jLabel8.setFont(new Font("Dialog", Font.BOLD, 13));
			jLabel8.setText("<html><u>Jour réassort : </u></html>");
		}
		return jLabel8;
	}
	
	private JLabel getJLabel9() {
		if (jLabel9 == null) {
			jLabel9 = new JLabel();
			jLabel9.setFont(new Font("Dialog", Font.BOLD, 13));
			jLabel9.setText("<html><u>Jour livraison : </u></html>");
		}
		return jLabel9;
	}
	
	private JLabel getJLabel10() {
		if (jLabel10 == null) {
			jLabel10 = new JLabel();
			jLabel10.setFont(new Font("Dialog", Font.BOLD, 13));
			jLabel10.setText("<html><u>Délai livraison : </u></html>");
		}
		return jLabel10;
	}
	
	private JButton getJButton0() {
		if (jButton0 == null) {
			jButton0 = new JButton();
			jButton0.setText("OK");
			jButton0.addMouseListener(new MouseAdapter() {
	
				public void mouseClicked(MouseEvent event) {
					jButton0MouseMouseClicked(event);
				}
			});
		}
		return jButton0;
	}
	
	public int[] parametres() throws ChampVideException {
		int[] tampon = new int[9];
		tampon[0] = (Integer) jList2.getSelectedValue();
		tampon[1] = (Integer) jList1.getSelectedValue();
		tampon[2] = (Integer) jList3.getSelectedValue();
		
		tampon[5] = (Integer) jList6.getSelectedIndex();
		tampon[7] = (Integer) jList4.getSelectedIndex();
		tampon[8] = (Integer) jList5.getSelectedIndex();
		
		if(tampon[5]>=tampon[0]) {tampon[5]=(tampon[5]%tampon[0]);}
		if(tampon[7]>tampon[0]) {tampon[7]=(tampon[7]%tampon[0]);}
		
		if(jRadio1.isSelected())
				{tampon[3]=1;}
		
		if(jRadio2.isSelected())
				{tampon[3]=2;}
		
		if(jRadio3.isSelected())
			{tampon[4]=1;
			 if(tampon[5]==-1) {throw new ChampVideException();}}
		if(!jRadio3.isSelected()) {tampon[5]=0;}
		
		if(jRadio4.isSelected())
			{tampon[4]=2;}
		
		if(jRadio5.isSelected())
			{tampon[6]=1;}
		
		if(jRadio6.isSelected())
			{tampon[6]=2;
			 if(tampon[8]==-1) {throw new ChampVideException();}}
		if(!jRadio6.isSelected()) {tampon[8]=0;}

		if(jRadio7.isSelected())
			{tampon[6]=3;
			 if(tampon[7]==-1) {throw new ChampVideException();}}
		if(!jRadio7.isSelected()) {tampon[7]=0;}
		
		if(!jRadio5.isSelected()&&!jRadio6.isSelected()&&!jRadio7.isSelected()) {
			throw new ChampVideException();
		}
		
		return tampon;
		}
	
	public static void  affiche()
	{
	  Presentation menu = new Presentation();
	  menu.pack();
	  menu.setVisible(true);
	 }
	
	private void jButton0MouseMouseClicked(MouseEvent event) {

		try{
			String message = "Rappel des paramètres choisis pour la simulation : ";
			message+=" \n ";
			message+=" \n ";
			String Qr="Réassort par cumul semaine";
			String Mr="Mode de réassort par alerte stock";
			String Dl="Jour de semaine fixe";
			int[] tampon = parametres();
			if(tampon[3]==1) {Qr="Réassort par capacité MAX";}
			if(tampon[4]==1) {Mr="Réassort à jour fixe";}
			if(tampon[6]==1) {Dl="Délai de livraison aléatoire";}
			if(tampon[6]==2) {Dl="Délai de livraison constant";}

			message+= " - Quantité réassort : " + Qr;
			message+=" \n ";
			message+= " - Mode réassort : " + Mr;
			message+=" \n ";
			message+= " - Livraison : " + Dl;
			message+=" \n ";
			message+= " - Capacité stockage : "+ (Integer) jList1.getSelectedValue();
			message+=" \n ";
			message+= " - Nombre semaine de simulation : "+ (Integer) jList3.getSelectedValue();
			message+=" \n ";
			message+=" - Nombre de jour par semaine: "+ (Integer) jList2.getSelectedValue();
			
			JOptionPane.showMessageDialog(null, message);
			Presentation.this.dispose();
			Systeme.simulation(parametres());
		}

		catch(Exception e) {
				
				String message = "Attention tous les champs n'ont pas été remplis !!!! ";
				JOptionPane.showMessageDialog(null, message);	
				e.printStackTrace();
				
				}}
	
	
}
