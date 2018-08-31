import javax.swing.*;
import java.awt.*;
import  java.awt.event.*;


public class Exercice3 extends Frame
{
  JTextField labelB = new JTextField("Bonjour ça va ??? ");

  MenuBar mb = new MenuBar();
  Menu m1 = new Menu("COULEUR");
  Menu m2 = new Menu("FONT");
  MenuItem i1 = new MenuItem("* Bleu ");
  MenuItem i2 = new MenuItem("* Jaune ");
  MenuItem i3 = new MenuItem("* Gras ");
  MenuItem i4 = new MenuItem("* Italique");

  Exercice3(int a, int b)
    {	
      super("Exercice n° 3");

      m1.add(i1);
      m1.add(i2);
      m2.add(i3);
      m2.add(i4);

      mb.add(m1);
      mb.add(m2);

      this.setMenuBar(mb);
      this.setVisible(true);
      this.setLocation(100,100);
      this.setSize(a,b);
      this.add(labelB,BorderLayout.CENTER);
      labelB.setHorizontalAlignment(JTextField.CENTER);

	class Ecoute_Menu implements ActionListener {

		public void actionPerformed(ActionEvent evenement) {

			if (evenement.getSource()==i1){
				labelB.getParent().setBackground(Color.BLUE);
				labelB.setBackground(Color.BLUE);}
			if (evenement.getSource()==i2){
				labelB.getParent().setBackground(Color.YELLOW);
				labelB.setBackground(Color.YELLOW);}
			if (evenement.getSource()==i3){
				labelB.setFont(new Font("Arial", Font.BOLD, 12));}
			if (evenement.getSource()==i4){
				labelB.setFont(new Font("Arial", Font.ITALIC, 12));}
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
      final Exercice3 Essai = new Exercice3(200,400);
      Essai.addWindowListener(new WindowAdapter()
		  {
		   public void windowClosing(WindowEvent e)
		     { 
		       System.exit(0);  
		     }
		  });
    }
}

