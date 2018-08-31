package ocr.hadoop.lab.pagerank;

import java.io.IOException;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.io.DoubleWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

public class NextStepReducer extends Reducer<Text, DoubleWritable, Text, DoubleWritable> {

	// Probabilité "de se télétransporter, à chaque étape, sur une page quelconque du web"
	private static double s=0.15;
	private Text oKey = new Text();
	private DoubleWritable oValue = new DoubleWritable(0);

	@Override
	/* Fonction Reduce pour la multiplication du vecteur V par la matrice de transition M
	 *  Somme pour la ligne j tous les sous-calculs (Mij x Vj) 
     * 
	 * Entrée : j, p (j = indexe de colonne de la matrice, p = probabilité de la page x probabilité de transition)
	 * Sortie : j, p (j = index de la page, p = somme des probabilités de transition)
	 */
	public void reduce(Text key, Iterable<DoubleWritable> values, Context context) throws IOException, InterruptedException {

		Configuration conf = context.getConfiguration();
		
		// Récupère le nombre total de pages dans la collection
		int n = Integer.parseInt(conf.get("PageRank_n"));
		
		double pr, sum = 0.0;

		// Somme pour la ligne j tous les sous-calculs (Mij x Vj) envoyés par le Mapper 
		for (DoubleWritable dw : values) 
		{
			sum += dw.get();
		}

		// Applique la formule : (1-s)×T + s/n
		pr = (1-s)*sum + s/n;
		
		oKey.set(key);
		oValue.set(pr);
		
		context.write(oKey, oValue);		 
	}
}