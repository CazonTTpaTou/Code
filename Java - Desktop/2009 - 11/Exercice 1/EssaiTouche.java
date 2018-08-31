import javax.swing.*;
import java.awt.*;
import  java.awt.event.*;

public class EssaiTouche extends JPanel implements KeyListener
{
  Ardoise ardoise = new Ardoise();
  JLabel labelR = new JLabel(" touche r : disque rouge");
  JLabel labelB = new JLabel(" touche b : disque bleu");
  JLabel labelV = new JLabel(" touche v : disque vert");
  JLabel labelE = new JLabel(" touche e : effacer");
  JPanel indications = new JPanel();
  
  EssaiTouche()
    {
      indications.setLayout(new GridLayout(4, 1));
      indications.add(labelR);
      indications.add(labelB);
      indications.add(labelV);
      indications.add(labelE);
      setLayout(new BorderLayout(5, 5));
      add(indications, BorderLayout.NORTH);
      add(ardoise, BorderLayout.CENTER);
      addKeyListener (this);
    }

  public void keyPressed(KeyEvent evt){ }
  public void keyReleased(KeyEvent evt){}  
  public void keyTyped(KeyEvent evt)
    {
      if (evt.getKeyChar() == 'r')
	ardoise.setForeground(Color.red);
      else if (evt.getKeyChar() == 'b')
	ardoise.setForeground(Color.blue);
      else if (evt.getKeyChar() == 'v')
	ardoise.setForeground(Color.green);
      else if (evt.getKeyChar() == 'e')
	ardoise.setForeground(ardoise.getBackground());
      repaint();
    }
  
  public static void main(String[] argv)
    {
      final JFrame monCadre = new JFrame("Touches");
      monCadre.setContentPane(new EssaiTouche());
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

class Ardoise extends JPanel
{
  Ardoise()
    {
      setPreferredSize(new Dimension(100, 100));
      setForeground(getBackground());
    }

  public  void paintComponent(Graphics g)
  {
    int largeur = getSize().width;
    int hauteur = getSize().height;

    super.paintComponent(g);
    g.fillOval(10, 10, largeur - 20, hauteur - 20);
  }
}

