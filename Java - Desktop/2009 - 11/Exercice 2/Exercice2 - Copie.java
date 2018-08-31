import javax.swing.*;
import java.awt.*;
import  java.awt.event.*;
import java.text.NumberFormat;

public class Exercice2 extends JPanel implements KeyListener
{
  JLabel labelR = new JLabel("Température en Farenheit:");
  JLabel labelB = new JLabel("Température en Degrés Celsius:");
  JLabel labelV = new JLabel("");

  JTextField ChampF = new JTextField(10);
  JTextField ChampD = new JTextField(10);
  
  JPanel indications = new JPanel();
  
  int Curseur=1;

  Exercice2()
    {
      indications.setLayout(new GridLayout(4, 1));

      indications.add(labelR);
      indications.add(ChampF);
      //indications.add(labelV);
      indications.add(labelB);
      indications.add(ChampD);
      
      add(indications, BorderLayout.NORTH);

	class ChampF_FocusListener implements FocusListener {
		public void focusGained(FocusEvent e) {}
		public void focusLost(FocusEvent e){}
		public boolean isFocusTraversable() { return false; }}

	class ChampD_FocusListener implements FocusListener {
		public void focusGained(FocusEvent e) {}
		public void focusLost(FocusEvent e){}
		public boolean isFocusTraversable() { return false; }}

     ChampF.addFocusListener(new ChampF_FocusListener()); 
	
     ChampD.addFocusListener(new ChampD_FocusListener()); 
			
     ChampF.addKeyListener(this);
   
    }

   public String translate(String T) throws Exception {
		
		NumberFormat fmt = NumberFormat.getInstance();
		Number number = fmt.parse(T);
		double Temperature = number.doubleValue();
		System.out.println(Temperature);
		//int Temperature = Integer.parseInt(ChampF.getText());
		double Converse = 5*(Temperature-32)/9;
		System.out.println(Converse);
		double ConverseB = Math.round(Converse*100);
		System.out.println(ConverseB);
		double ConverseC = ConverseB/100;
		System.out.println(ConverseC);
		//System.out.format("%.2f",Converse);
		String ConverseT = String.valueOf(ConverseC) + " Degrés Celsius.";
		System.out.println(ConverseT);
		return ConverseT;}

  public void keyPressed(KeyEvent evt){
	if (evt.getKeyCode() == KeyEvent.VK_ENTER) {

		try{
		
		ChampD.setText(translate(ChampF.getText()));}

		catch(Exception e) {JOptionPane.showMessageDialog(null,"Format numérique incorrect!!!");}
			}
	}
  public void keyReleased(KeyEvent evt){}  
  public void keyTyped(KeyEvent evt)
    {
	//if (evt.getKeyChar() == 'a') {Bouton1.requestFocus();System.out.println("Bonjour");}
       //if (evt.getKeyCode() == KeyEvent.VK_ENTER) {Bouton1.requestFocus();System.out.println("Bonjour");}
	//ardoise.setForeground(Color.red);
      //else if (evt.getKeyChar() == 'b')
	//ardoise.setForeground(Color.blue);
      //else if (evt.getKeyChar() == 'v')
	//ardoise.setForeground(Color.green);
      //else if (evt.getKeyChar() == 'e')
	//ardoise.setForeground(ardoise.getBackground());
     // repaint();
    }
  
  public static void main(String[] argv)
    {
      final JFrame monCadre = new JFrame("Exercice n° 2");
      monCadre.setContentPane(new Exercice2());
      monCadre.addWindowListener(new WindowAdapter()
		  {
		   public void windowClosing(WindowEvent e)
		     { 
		       System.exit(0);  
		     }

		   public void focusLost(WindowEvent e){
		      monCadre.getContentPane().requestFocus();}

		   public void windowActivated(WindowEvent e)
		     { 		       
		      monCadre.getContentPane().requestFocus();	
		     }

		   public void windowDeactivated(WindowEvent e)
		     { 		       
		      monCadre.getContentPane().requestFocus();	
		      }

		  });

      class Fen_FocusListener implements WindowFocusListener {
		public void windowGainedFocus(WindowEvent e) {}
		public void windowLostFocus(WindowEvent e) {
			monCadre.getContentPane().requestFocus();}}

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

//http://java.sun.com/docs/books/tutorial/uiswing/misc/focus.html#properties
//http://baptiste-wicht.developpez.com/tutoriel/java/swing/focus/#LV


