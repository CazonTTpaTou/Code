package ocr.hadoop.lab.pagerank;

import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.apache.hadoop.io.DoubleWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.conf.Configuration;

public class NextStepMapper extends Mapper<Text, Text, Text, DoubleWritable> {

	private Text oKey = new Text();
	private DoubleWritable oValue = new DoubleWritable(0);
	
	// Recherche dans le vecteur la valeur de la probabilité pour le lien i
	private double getVectorValue(String vector, String i)
	{
		// Matche la clé key dans la chaîne vector et retourne la valeur au format scientifique
		// Ex : 0019	2.6421208876397157E-26 => renvoie 2.6421208876397157E-26 pour i=0019
		//      0091	1.4349268438881987E-25 => renvoie 1.4349268438881987E-25 pour i=0091
		Pattern pattern = Pattern.compile(i + "\\t-?\\d+(\\.\\d+)?(E-?\\d+)?");
        Matcher matcher = pattern.matcher(vector);
        if (matcher.find()) {
            return(Double.parseDouble(matcher.group(0).substring(4, matcher.group(0).length())));
        } else return (0.0);
	}
	
	@Override
	/* Fonction Map pour la multiplication du vecteur V par la matrice de transition M
	 *  Envoie à Reduce les sous-calculs (Mij x Vj) 
     * 
	 * Entrée : i:j, p (i,j coordonnées de la matrice de transition, p = probabilité de transition)
	 * Sortie : j, p (j = indexe de colonne de la matrice, p = probabilité de la page x probabilité de transition)
	 */
	public void map(Text key, Text value, Context context) throws IOException, InterruptedException 
	{
		Configuration conf = context.getConfiguration();
		
		// Récupère le vecteur de l'étape en cours
		String vector = conf.get("vector");

		String[] strspl = key.toString().split(":");
		String i = strspl[0];
		String j = strspl[1];
		
		// Récupère la probabilité de la page i de l'étape en cours
		double vectorValue = getVectorValue(vector, i);
		
		oKey.set(j);
		oValue.set(vectorValue * Double.parseDouble(value.toString()));

		context.write(oKey, oValue);
	}
}
