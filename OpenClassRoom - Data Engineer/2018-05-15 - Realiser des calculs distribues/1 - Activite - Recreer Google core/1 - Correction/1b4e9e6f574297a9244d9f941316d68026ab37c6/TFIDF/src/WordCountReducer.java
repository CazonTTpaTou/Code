package ocr.hadoop.lab.tfidf;

import java.io.IOException;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

public class WordCountReducer extends Reducer<Text, IntWritable, Text, IntWritable> {
    
	private IntWritable count = new IntWritable();
	
    /* Fonction reduce de type wordcount : pour chaque mot, calcule la fréquence dans le fichier (wordcount)
     * 
	 * Entrée : doc_ID:mot, (1, 1, ...)
	 * Sortie : doc_ID:mot, wordcount
	 */ 
    @Override
    public void reduce(Text key, Iterable<IntWritable> values, Context context) throws IOException,InterruptedException
    {
		int sum = 0;
		
    	// Somme les occurrences
		for (IntWritable i : values) {
			sum += i.get();
		}
    	
    	// Affecte la valeur de sortie
		count.set(sum);
    	
    	// Ecrit la sortie de Reduce
    	context.write(key, count);
    }
}