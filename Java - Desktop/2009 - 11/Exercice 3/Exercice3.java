import javax.swing.*;
import java.awt.*;
import  java.awt.event.*;


public class Exercice3 extends JPanel 
{
  JLabel labelR = new JLabel("");
  JTextArea labelB = new JTextArea(" Bonjour ça va ??? ");
  JLabel labelC = new JLabel("");

  JMenuBar mb = new JMenuBar();
  JMenu m1 = new JMenu("COULEUR");
  JMenu m2 = new JMenu("FONT");
  JMenuItem i1 = new JMenuItem("* Bleu ");
  JMenuItem i2 = new JMenuItem("* Jaune ");
  JMenuItem i3 = new JMenuItem("* Gras ");
  JMenuItem i4 = new JMenuItem("* Italique");

  JPanel indications = new JPanel();

  Exercice3()
    {	
      m1.add(i1);
      m1.add(i2);
      m2.add(i3);
      m2.add(i4);

      mb.add(m1);
      mb.add(m2);

      indications.add(mb);

      indications.setLayout(new GridLayout(3,1));
      indications.add(labelB);
      //indications.add(labelR);
      //indications.add(labelC);
      add(indications, BorderLayout.NORTH);
      indications.setVisible(true);

	class Ecoute_Menu implements ActionListener {
		public void actionPerformed(ActionEvent evenement) {
			if (evenement.getSource()==i1){indications.setBackground(Color.BLUE);labelB.setBackground(Color.BLUE);}
			if (evenement.getSource()==i2){indications.setBackground(Color.YELLOW);labelB.setBackground(Color.YELLOW);}
			if (evenement.getSource()==i3){labelB.setFont(new Font("Serif", Font.BOLD, 16));}
			if (evenement.getSource()==i4){labelB.setFont(new Font("Serif", Font.ITALIC, 16));}
			//http://www.javafr.com/forum/sujet-SOULIGNE-TEXTE-SVP-EST-URGENT_210814.aspx#3
			//http://www.developpez.net/forums/d64648/java/interfaces-graphiques-java/awt-swing/composants/textuels/couleur-mettre-gras-text-d-jtextarea/
			}}

	Ecoute_Menu Ecoutons = new Ecoute_Menu(); 

	i1.addActionListener(Ecoutons);
	i2.addActionListener(Ecoutons);
	i3.addActionListener(Ecoutons);
	i4.addActionListener(Ecoutons);
    }

  
  
  public static void main(String[] argv)
    {
      final JFrame monCadre = new JFrame("Exercice n° 2");
      monCadre.setContentPane(new Exercice3());
      monCadre.addWindowListener(new WindowAdapter()
		  {
		   public void windowClosing(WindowEvent e)
		     { 
		       System.exit(0);  
		     }
		   public void windowActivated(WindowEvent e)
		     { 		       
		      monCadre.getContentPane().requestFocus();	
		     }
		  });

      monCadre.pack();
      monCadre.setVisible(true);
    }
}

