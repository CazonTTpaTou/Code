package ocr.hadoop.lab.tfidf;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

public class WordPerDocReducer extends Reducer<Text, Text, Text, Text> {
    
	/* Fonction reduce de comptage du nombre total de mot par fichier
	 * Somme tous les wordcount des mots par fichier
     * 
	 * Entrée : doc_ID, mot:wordcount
	 * Sortie : doc_ID:mot, wordcount:wordperdoc
	 */
	@Override
	public void reduce(Text key, Iterable<Text> values, Context context) throws IOException,InterruptedException
    {
		List<Text> cache = new ArrayList<Text>();
		String sValue, sKey;
		String[] strspl;
		
		int wordcount;
		int total = 0;
		
    	// Calcule le nombre total de mots dans le fichier : wordperdoc = somme(wordcount)
		for (Text item : values) {
			wordcount = Integer.parseInt(item.toString().split(":")[1]);
			total += wordcount;
			// Crée un cache de values pour pouvoir ré-itérer
			cache.add(new Text(item));
		}
   
		// Pour chaque mot du fichier
		for (Text item : cache) {
			// Split mot:wordcount
			strspl = item.toString().split(":");

			// Concatène la clé doc_ID:mot
			sKey = key.toString() + ":" + strspl[0];
			// Concatène la valeur wordcount:wordperdoc
			sValue = strspl[1] + ":" + String.valueOf(total);
					
			// Ecrit la sortie de Reduce
			context.write(new Text(sKey), new Text(sValue));
		}
    }
}