import javax.swing.*;
import java.awt.*;
import  java.awt.event.*;

public class Exercice1 extends JPanel implements KeyListener
{
  JLabel labelR = new JLabel(" Touche Entrée : changement de focus");
  JLabel labelB = new JLabel(" Autres touches : changement de titre");

  JButton Bouton1 = new JButton("Bouton n°1");
  JButton Bouton2 = new JButton("Bouton n°2");
  
  JPanel indications = new JPanel();
  
  int Curseur=1;

  Exercice1()
    {
      indications.setLayout(new GridLayout(4, 1));
      indications.add(labelR);
      indications.add(labelB);

      indications.add(Bouton1);
      indications.add(Bouton2);
      
      add(indications, BorderLayout.NORTH);

	class Bouton1_FocusListener implements FocusListener {
		public void focusGained(FocusEvent e) {Curseur=1;}
		public void focusLost(FocusEvent e){}}

	class Bouton2_FocusListener implements FocusListener {
		public void focusGained(FocusEvent e) {Curseur=2;}
		public void focusLost(FocusEvent e){}}

     Bouton1.addFocusListener(new Bouton1_FocusListener()); 
	
     Bouton2.addFocusListener(new Bouton2_FocusListener()); 
			
      addKeyListener (this);
      Bouton1.addKeyListener(this);
      Bouton2.addKeyListener(this);
    }

  public void keyPressed(KeyEvent evt){
	if (evt.getKeyCode() == KeyEvent.VK_ENTER) {
		if (Curseur==1)
			{Bouton2.requestFocusInWindow();}
		
	else {Bouton1.requestFocusInWindow();}
			}}

  public void keyReleased(KeyEvent evt){}  
  
  public void keyTyped(KeyEvent evt)
    {
	String touche;

	if (evt.getKeyChar() == KeyEvent.VK_ENTER) {}
	
	else{touche = Character.toString(evt.getKeyChar());
	if (Curseur==1) Bouton1.setText(touche);
	if (Curseur==2) Bouton2.setText(touche);
    }}
  
  public static void main(String[] argv)
    {
      final JFrame monCadre = new JFrame("Exercice n° 1");
      monCadre.setContentPane(new Exercice1());
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



