package ocr.hadoop.lab.tfidf;

import java.io.IOException;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class WordTFIDFMapper extends Mapper<Text, Text, Text, Text> {

	/* Fonction map de pré-calcul du TFIDF
	 * Envoie les données à Reduce sur la clé "mot" pour pouvoir compter le nombre de documents contenant le mot
     * 
	 * Entrée : doc_ID:mot, wordcount:wordperdoc
	 * Sortie : mot, doc_ID:wordcount:wordperdoc
	 */
	@Override
    public void map(Text key, Text value, Context context) throws IOException, InterruptedException {

		String[] keysplit = key.toString().split(":");
    	
		context.write(new Text(keysplit[1]), new Text (keysplit[0] + ":" + value.toString()));
    }
}
