package ocr.hadoop.lab.tfidf;

import java.io.IOException;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class WordPerDocMapper extends Mapper<Text, Text, Text, Text> {

    /* Fonction map de pré-comptage du nombre total de mot par fichier (wordperdoc)
     * Envoie les données à Reduce sur la clé doc_ID pour que le compte des mots soit groupé par document
     * 
	 * Entrée : doc_ID:mot, wordcount
	 * Sortie : doc_ID, mot:wordcount
	 */
	@Override
    public void map(Text key, Text value, Context context) throws IOException, InterruptedException {
		
		String[] splstr = key.toString().split(":");
		
		String docId = splstr[0];
		String word  = splstr[1];
		
		int wordcount = Integer.parseInt(value.toString()); 
		
		// Ecrit la sortie de Map : (doc_ID, mot:wordcount)
		context.write(new Text(docId), new Text(word + ":" + String.valueOf(wordcount)));		
    }
}
