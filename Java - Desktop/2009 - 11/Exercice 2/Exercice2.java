import javax.swing.*;
import java.awt.*;
import  java.awt.event.*;
import java.text.NumberFormat;

public class Exercice2 extends JPanel implements KeyListener
{
  JLabel labelR = new JLabel("Température en Farenheit:");
  JLabel labelB = new JLabel("Température en Degrés Celsius:");

  JTextField ChampF = new JTextField(10);
  JTextField ChampD = new JTextField(10);
  
  JPanel indications = new JPanel();

  Exercice2()
    {
      indications.setLayout(new GridLayout(4, 1));

      indications.add(labelR);
      indications.add(ChampF);
 
      indications.add(labelB);
      indications.add(ChampD);
      
      add(indications, BorderLayout.NORTH);
			
     ChampF.addKeyListener(this);
   
    }

   public String translate(String T) throws Exception {
		
		NumberFormat fmt = NumberFormat.getInstance();
		Number number = fmt.parse(T);
		double Temperature = number.doubleValue();
		
		double Converse = 5*(Temperature-32)/9;

		double ConverseB = Math.round(Converse*100);
		double ConverseC = ConverseB/100;

		String ConverseT = String.valueOf(ConverseC) + " Degrés Celsius.";
		return ConverseT;}

  public void keyPressed(KeyEvent evt){

	if (evt.getKeyCode() == KeyEvent.VK_ENTER) {

		try{ChampD.setText(translate(ChampF.getText()));}

		catch(Exception e) {JOptionPane.showMessageDialog(null,"Format numérique incorrect!!!");}}
	}

  public void keyReleased(KeyEvent evt){}  
  public void keyTyped(KeyEvent evt) {}
   
  
  public static void main(String[] argv)
    {
      final JFrame monCadre = new JFrame("Exercice n° 2");
      monCadre.setContentPane(new Exercice2());
      
      monCadre.pack();
      monCadre.setVisible(true);
    }
}

