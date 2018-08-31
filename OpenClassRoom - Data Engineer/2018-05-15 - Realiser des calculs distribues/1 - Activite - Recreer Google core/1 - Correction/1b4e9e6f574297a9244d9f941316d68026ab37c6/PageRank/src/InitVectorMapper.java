package ocr.hadoop.lab.pagerank;

import java.io.IOException;
import org.apache.hadoop.io.DoubleWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.conf.Configuration;

public class InitVectorMapper extends Mapper<Text, Text, Text, DoubleWritable> {

	private Text oKey = new Text();
	private DoubleWritable oValue = new DoubleWritable();
		
	@Override
	/* Fonction Map d'initialisation du vecteur 1
	 *  La 1ère étape du parcours : toutes les pages ont la même probabilité 1/n où n = nombre total de pages
     * 
	 * Entrée : pid, pid1 pid2 ... pidN -1 (pid = index de la page source, pidN : index des pages cibles)
	 * Sortie : pid, 1/n (n = nombre total de pages dans la collection)
	 */
	public void map(Text key, Text value, Context context) throws IOException, InterruptedException {

		Configuration conf = context.getConfiguration();
		
		int n = Integer.parseInt(conf.get("PageRank_n"));

		// Formate le pid sur 4 caractères (ex: 0003, 0024, 0234, 4532, ...)
		String i = String.format("%4s", key.toString()).replace(" ", "0");
		
		oKey.set(i);
		oValue.set(1.0/n);
		
		context.write(oKey, oValue);
	}
}
