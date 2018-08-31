package view;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Container;
import java.awt.Font;
import java.awt.GridLayout;
import java.awt.Rectangle;
import java.awt.TextArea;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

import javax.swing.AbstractButton;
import javax.swing.BorderFactory;
import javax.swing.BoxLayout;
import javax.swing.ButtonGroup;
import javax.swing.DefaultListModel;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JList;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JRadioButton;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;

import model.Offre;

public class Menu extends JFrame{

	private JPanel Panneau_champs;
	private JPanel Panneau_image;
	private JPanel Panneau_header;
	private JPanel Panneau_texte;
	private JPanel Panneau_valide;
	
	private JLabel Label_Titre;
	private JLabel Label_Societe;
	private JLabel Label_Secteur;
	private JLabel Label_Telephone;
	private JLabel Label_Email;
	private JLabel Label_Nom;
	
	private JLabel Label_Type;
	private JLabel Label_Offre;
	
	private JLabel Label_Candidature;
	private JLabel Label_Reponse;
	

	private JTextField Field_Titre;
	private JTextField Field_Societe;
	private JTextField Field_Secteur;
	private JTextField Field_Telephone;
	private JTextField Field_Email;
	private JTextField Field_Nom;
	private JTextField Field_Candidature;
	private JTextField Field_Reponse;
	
	private TextArea Field_Offre;
	
	private ButtonGroup jRadioMenu1;
	private JRadioButton jRadio1;
	private JRadioButton jRadio2;
	
	private JButton jButton0;
	
	public Menu() {
		initComponents();
	}
	
	private JButton getJButton0() {
		if (jButton0 == null) {
			jButton0 = new JButton();
			jButton0.setText("Enregistrer les informations");
			jButton0.addMouseListener(new MouseAdapter() {
	
				public void mouseClicked(MouseEvent event) {
					jButton0MouseMouseClicked(event);
				}
			});
		}
		return jButton0;
	}
	
	private void jButton0MouseMouseClicked(MouseEvent event) {
		
		String message="";
		String[] response =parametres();
			for(int i=0;i<=9;i++) {
				message+="Champ n°"+i+" a pour valeur "+response[i]+"\n";}
			
			Offre offre = new Offre();
			offre.register(response);
			
			//JOptionPane.showMessageDialog(null, message);
			Menu.this.dispose();}


	private String[] parametres() {
		String[] tampon= new String[12];
		String defaut="Non Renseigné";
		
		if(jRadio2.isSelected())
		{tampon[0]="Candidature Spontanée";}

		if(jRadio1.isSelected())
		{tampon[0]="Réponse à une offre d'emploi";}
		
		if(Field_Titre.getText().equals("")) {tampon[1]=defaut;} else {tampon[1]=Field_Titre.getText();}
		if(Field_Societe.getText().equals("")) {tampon[2]=defaut;} else {tampon[2]=Field_Societe.getText();}
		if(Field_Secteur.getText().equals("")) {tampon[3]=defaut;} else {tampon[3]=Field_Secteur.getText();}
		if(Field_Telephone.getText().equals("")) {tampon[4]=defaut;} else {tampon[4]=Field_Telephone.getText();}
		if(Field_Email.getText().equals("")) {tampon[5]=defaut;} else {tampon[5]=Field_Email.getText();}
		if(Field_Nom.getText().equals("")) {tampon[6]=defaut;} else {tampon[6]=Field_Nom.getText();}
		if(Field_Candidature.getText().equals("")) {tampon[7]=defaut;} else {tampon[7]=Field_Candidature.getText();}
		if(Field_Reponse.getText().equals("")) {tampon[8]=defaut;} else {tampon[8]=Field_Reponse.getText();}
		if(Field_Offre.getText().equals("")) {tampon[9]=defaut;} else {tampon[9]=Field_Offre.getText();}

		return tampon;
	}
		
	private void maker_Champs() {
		
		if ( Label_Titre==null) { Label_Titre=new JLabel("Titre de l'emploi :" );}
		if (Field_Titre==null) {Field_Titre=new JTextField( );}
		if ( Label_Societe==null) { Label_Societe=new JLabel("Nom de la société :" );}
		if (Field_Societe==null) {Field_Societe=new JTextField( );}
		if ( Label_Telephone==null) { Label_Telephone=new JLabel("N° de téléphone :" );}
		if (Field_Telephone==null) {Field_Telephone=new JTextField( );}
		if ( Label_Email==null) { Label_Email=new JLabel("E-mail du contact :" );}
		if (Field_Email==null) {Field_Email=new JTextField( );}
		if ( Label_Nom==null) { Label_Nom=new JLabel("Nom du contact :" );}
		if (Field_Nom==null) {Field_Nom=new JTextField( );}
		if ( Label_Candidature==null) { Label_Candidature=new JLabel("Fichier de l'offre :" );}
		if (Field_Candidature==null) {Field_Candidature=new JTextField( );}
		if ( Label_Reponse==null) { Label_Reponse=new JLabel("Fichier de la candidature :" );}
		if (Field_Reponse==null) {Field_Reponse=new JTextField( );}
		if ( Label_Secteur==null) { Label_Secteur=new JLabel("Secteur d'activité :" );}
		if (Field_Secteur==null) {Field_Secteur=new JTextField( );}
		
		Panneau_champs.setLayout(new GridLayout(8,2,20,20));
		
		Panneau_champs.add( Label_Titre);
		Panneau_champs.add(Field_Titre);
		Panneau_champs.add( Label_Societe);
		Panneau_champs.add(Field_Societe);
		Panneau_champs.add( Label_Secteur);
		Panneau_champs.add(Field_Secteur);
		Panneau_champs.add( Label_Telephone);
		Panneau_champs.add(Field_Telephone);
		Panneau_champs.add( Label_Email);
		Panneau_champs.add(Field_Email);
		Panneau_champs.add( Label_Nom);
		Panneau_champs.add(Field_Nom);
		Panneau_champs.add( Label_Candidature);
		Panneau_champs.add(Field_Candidature);
		Panneau_champs.add( Label_Reponse);
		Panneau_champs.add(Field_Reponse);		
		}
	
	private JPanel getJContentPane() {
		
		if (Panneau_champs==null) {
			Panneau_champs= new JPanel();
			maker_Champs();}
		
		return Panneau_champs;
		}	
	
	private JPanel getJContentPaneHeader() {
		
		if (Panneau_header==null) {
			Panneau_header= new JPanel();
			if (Label_Type==null) {Label_Type=new JLabel("Type de l'offre : ");}
			//Panneau_champs.setLayout(new GridLayout(1,3));
			Panneau_header.add(Label_Type);
			Panneau_header.add(getJRadioButton1());
			Panneau_header.add(getJRadioButton2());
			getJRadioMenu1();}
		
		return Panneau_header;
		}	
	
	private JPanel getJContentPaneTexte() {
		
		if (Panneau_texte==null) {
			Panneau_texte= new JPanel();
			if (Label_Offre==null) {Label_Offre=new JLabel("Descriptif de l'offre : ");}
			if (Field_Offre==null) {Field_Offre=new TextArea(20,40);}
			Panneau_texte.add(Label_Offre);
			Panneau_texte.add(Field_Offre);	}
		
		return Panneau_texte;
		}	
	
     private JPanel getJContentPaneValide() {
		
		if (Panneau_valide==null) {
			Panneau_valide= new JPanel();
			Panneau_valide.add(getJButton0());}
		
		return Panneau_valide;
		}	
	
	private JPanel getJContentPaneImage() {
		
		if (Panneau_image==null) {Panneau_image= new JPanel();
		ImageIcon icone =  new ImageIcon("RH.jpeg");
		int haut = icone.getIconHeight();
		int larg = icone.getIconWidth();
	    JLabel image = new JLabel(icone); 
	    //image.setBounds(new Rectangle(20, 75, larg, haut));
	    image.setSize(Panneau_image.getWidth(),Panneau_image.getHeight());
	 
	    Panneau_image.add(image);
		Panneau_image.repaint();}
		
		return Panneau_image;
	}
	
	private ButtonGroup getJRadioMenu1() {
		if (jRadioMenu1 == null) {
			ButtonGroup jRadioMenu1 = new ButtonGroup();
			jRadioMenu1.add(getJRadioButton1());
			jRadioMenu1.add(getJRadioButton2());
			}
		return jRadioMenu1;
		}
	
	private JRadioButton getJRadioButton1() {
		if (jRadio1 == null) {
			jRadio1 = new JRadioButton("Réponse offre d'emploi",true);
}
		return jRadio1;
		}
	
	private JRadioButton getJRadioButton2() {
		if (jRadio2 == null) {
			jRadio2 = new JRadioButton("Candidature spontanée");
		}
		return jRadio2;
		}
	
	
	private void initComponents() {
		
		Container c = getContentPane();
		c.setLayout(new BorderLayout());
		c.add(getJContentPane(), BorderLayout.CENTER);
		c.add(getJContentPaneImage(), BorderLayout.WEST);
		c.add(getJContentPaneHeader(), BorderLayout.NORTH);
		c.add(getJContentPaneTexte(), BorderLayout.EAST);
		c.add(getJContentPaneValide(), BorderLayout.SOUTH);
		this.setTitle("Gestion des offres d'emploi");
		this.setLocation(50, 50);
		this.setVisible(true);
	}
	
	  public static void affiche() {
		  Menu menu = new Menu();
		  menu.pack();
		  menu.setVisible(true);
		  
	  }
	  
	  
}