package ocr.hadoop.lab.tfidf;

import java.io.IOException;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.lib.input.FileSplit;

public class WordCountMapper extends Mapper<LongWritable, Text, Text, IntWritable> {

    private final static IntWritable one = new IntWritable(1);
    private static Text wordkey = new Text();

    // Supprime la ponctuation et les caractère inutiles
    private String cleanLine(String line) {
    	line = line.trim().toLowerCase();
		line = line.replaceAll("\\p{Punct}|\\p{Digit}", "");
    	return(line);
    }
    
    private boolean validate(String word, Context context) {
    	return word.length() >= 3 && context.getConfiguration().get("stopwords").indexOf("|" + word + "|") == -1 ;
    }
    
	
    /* Fonction map de type wordcount : lit une ligne et pour chaque mot, envoie (mot, 1)
     * 
	 * Entrée : index de la ligne, contenu de la ligne 
	 * Sortie : doc_ID:mot, 1
	 */ 
	@Override
	public void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
        
        // Récupère l'id du fichier en cours de traitement
		String docId = ((FileSplit)context.getInputSplit()).getPath().getName();
    	
    	// Lit et nettoie la ligne en entrée
		String line = value.toString();
    	line = cleanLine(line);

    	// Pour chaque mot de la ligne...
    	for (String word : line.split("\\s+")) {
    		// ... si le mot est assez long et "utile"...
    		if (validate(word, context)) {
    			// ... affecte la clé (mot, doc_ID)
    			wordkey.set(docId + ":" + word);
    			// ... écrit la sortie de Map : ((mot, doc_ID), 1)
    			context.write(wordkey, one);
    		}
    	}
    }
}
