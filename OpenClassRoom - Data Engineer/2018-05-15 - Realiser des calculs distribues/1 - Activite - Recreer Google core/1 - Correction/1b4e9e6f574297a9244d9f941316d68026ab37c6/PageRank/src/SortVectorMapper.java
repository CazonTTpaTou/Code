package ocr.hadoop.lab.pagerank;

import java.io.IOException;
import org.apache.hadoop.io.DoubleWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class SortVectorMapper extends Mapper<Text, Text,DoubleWritable,  Text > {

	private DoubleWritable oKey = new DoubleWritable(0);
	private Text oValue = new Text();
	
	@Override
	/* Fonction Map de tri du vecteur en entrée par PageRank
	 *  Envoie à Reduce la paire inversée (key, value) => (value, key) où key=pid et value=pagerank
	 *  Reduce applique le tri via le comparateur custom DoubleWritableDescSortComparator 
     *  
	 * Entrée : pid, pagerank
	 * Sortie : pagerank, pid
	 */
	public void map(Text key, Text value, Context context) throws IOException, InterruptedException 
	{
		// Inverse la clé et la valeur (pageId <-> pageRank) pour pouvoir trier par PR
		oKey.set(Double.parseDouble(value.toString()));
		oValue = key;
		
		context.write(oKey, oValue);
	}
}
