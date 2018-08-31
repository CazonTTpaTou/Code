package ocr.hadoop.lab.pagerank;

import java.io.IOException;

import org.apache.hadoop.io.DoubleWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class TransMatrixMapper extends Mapper<Text, Text, Text, DoubleWritable> {

	private Text oKey = new Text();
	private DoubleWritable oValue = new DoubleWritable();
		
	@Override
	/* Fonction Map de transposition de la liste adjacente sous forme de matrice
	 *  au format (page source, page cible) => probabilité de passer de la page source à la page cible
     * 
	 * Entrée : pid, pid1 pid2 ... pidN -1 (pid = index de la page source, pidN : index des pages cibles)
	 * Sortie : i:j, p (i = index de la page source, j = index de la page cible, p = probabilité de transition)
	 */
	public void map(Text key, Text value, Context context) throws IOException, InterruptedException {

		// Formate le pid sur 4 caractères (ex: 0003, 0024, 0234, 4532, ...)
		String i = String.format("%4s", key.toString()).replace(" ", "0");
		String j;
		
		// Liste des liens sortants séparés par un espace, terminée par -1 
		String line = value.toString();
		
		// Compte le nombre de liens sortants de la page
		int nbLinks = line.split(" ").length-2;

		// Dans tous les cas, ajoute une entrée "dummy" de la page vers elle-même
		//  pour conserver toutes les pages dans la matrice, y compris celles qui n'ont pas de liens entrants
		oKey.set(i + ":" + i);
		oValue.set(0.0);
		context.write(oKey, oValue);

		// Construit la matrice de transition au format : i:j, p (où p = probabilité de passer de la page i à la page j)
		for (String item : line.split(" ")) 
		{
			if (item.length() > 0 && item.compareTo("-1") != 0) 
			{
				// Formate le pid sur 4 caractères (ex: 0003, 0024, 0234, 4532, ...)
				j = String.format("%4s", item).replace(" ", "0");
				
				// Construit la clé i:j
				oKey.set(i + ":" + j);
				// Calcule la probabilité de transition : 1 / nombre total de liens sortants
				oValue.set(1.0/nbLinks);
				
				context.write(oKey, oValue);
			}
		}
	}
}
