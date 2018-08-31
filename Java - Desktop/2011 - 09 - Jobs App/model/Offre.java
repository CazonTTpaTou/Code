package model;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.swing.JOptionPane;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;

import control.ControleConnexion;
import control.Quote;


public class Offre {

	static Connection laConnexion ;
	
	@SuppressWarnings("null")
	public void register(String[] data) {
	
	String current_date = control.Dates.date();
	String titre_offre="Offre_"+data[2]+"_"+ current_date + ".pdf";
	String titre_candidature="Candidature_"+data[2]+"_"+ current_date + ".pdf";
	
	System.out.println(" data 7 - "+data[7]);
	
	if(data[7].equals("Non Renseigné")) {data[7]=titre_offre;}
	if(data[8].equals("Non Renseigné")) {data[8]=titre_candidature;}
	
	String[] intitule=new String[10];
	StringBuffer bf = new StringBuffer();
	bf.append("Résumé de l'offre d'emploi : \n \n");
	
	intitule[0]="Type d'offre";
	intitule[1]="Titre de l'emploi";
	intitule[2]="Société";
	intitule[3]="Secteur d'activité";
	intitule[4]="Téléphone";
	intitule[5]="Email";
	intitule[6]="Nom";
	intitule[7]="Fichier de l'offre";
	intitule[8]="Fichier de la candidature";
	intitule[9]="Offre";

	  try {
			laConnexion= (Connection) ControleConnexion.getConnexion();}

	catch (Exception e) {e.printStackTrace();}

	String lecode="insert into offres (Type,Titre,Societe,Secteur,Telephone,Email,Nom,Candidature,Reponse,Offre) values (";
	for(int i=0;i<10;i++) {lecode+="'"+Quote.addSlashes(data[i])+"'";
	                              if(i!=9) {lecode+=",";}}


					lecode += ");";
	 				System.out.println(lecode);
			        
			        try {
			        	    	
			         	Statement state =  (Statement) laConnexion.createStatement();        	
			         	
			                int jeuEnregistrements = state.executeUpdate(lecode);            
			                state.close();
			        }  

	catch (SQLException e) {JOptionPane.showMessageDialog(null, "Problème lors de la recherche.","", JOptionPane.ERROR_MESSAGE);
				            e.printStackTrace();
	                       }
	
 	for (int i=0;i<=9;i++)
		{bf.append(" - ");
		 bf.append(intitule[i]);
		 if(i==9) {bf.append(" : \n\n");}
		 	 else {bf.append(" : ");}
 		 bf.append(data[i]);
		 bf.append("\n\n");
		}
	maker(bf.toString(),titre_offre);
	}

	public void maker(String data,String titre) {
		Document d = new Document (PageSize.A4); 
		try {
			PdfWriter.getInstance(d, new FileOutputStream(titre));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		d.open ();
		Paragraph p = new Paragraph (data);
		try {
			d.add (p);
		} catch (DocumentException e) {
			e.printStackTrace();
		}
		d.close ();

	}

}
