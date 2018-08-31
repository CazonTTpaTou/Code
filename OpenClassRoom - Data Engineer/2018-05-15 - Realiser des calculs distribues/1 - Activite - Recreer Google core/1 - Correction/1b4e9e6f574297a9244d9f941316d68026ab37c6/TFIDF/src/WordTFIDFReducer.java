package ocr.hadoop.lab.tfidf;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;
import org.mariuszgromada.math.mxparser.Expression;

public class WordTFIDFReducer extends Reducer<Text, Text, Text, Text> {
    
	/* Fonction Reduce de calcul du TFIDF
	 * Compte le nombre de documents contenant le mot et finalise le calcul du TFIDF
     * 
	 * Entrée : mot, doc_ID:wordcount:wordperdoc
	 * Sortie : doc_ID:mot, TFIDF
	 */
	@Override
	public void reduce(Text key, Iterable<Text> values, Context context) throws IOException,InterruptedException
    {
		List<Text> cache = new ArrayList<Text>();
		String[] strspl;
		String sKey, sValue, sTfidf, formula;
		int nbdoc = 0;
    	//Expression e = new Expression();
    	double dTfidf;
    	
    	int nbInputFiles = Integer.parseInt(context.getConfiguration().get("nbInputFiles"));
    	
		for (Text item : values) {
			nbdoc++;
			// Crée un cache de values pour pouvoir ré-itérer
			cache.add(new Text(item));
		}

		// Pour chaque mot du fichier
		for (Text item : cache) {
			// Split doc_ID:wordcount:wordperdoc
			strspl = item.toString().split(":");
			
			// Ex: 1/13457*log(10, 2/1+1)=0.0000354552
			// Stocke la formule en chaîne (pour debug)
			formula = strspl[1] + "/" + strspl[2] + "*log(10, " + String.valueOf(nbInputFiles) + "/" + String.valueOf(nbdoc) + "+1)";
			//e.setExpressionString(formula);
			//sTfidf = String.format("%.10f", e.calculate());
    		dTfidf = Double.parseDouble(strspl[1]) / Double.parseDouble(strspl[2]) * Math.log10(nbInputFiles/nbdoc+1);
			
			sKey = strspl[0] + ":" + key.toString();
			// sValue = strspl[1] + ":" + strspl[2] + ":" + String.valueOf(nbdoc) + ":" + formula + ":" + String.valueOf(tfidf);
			// sValue = String.valueOf(sTfidf);
			sValue = String.valueOf(String.valueOf(dTfidf));
			
			// Ecrit la sortie de Reduce
			context.write(new Text(sKey), new Text(sValue));
			
		}
		
		
    }
}

//defoe-robinson-103.txt:54/89299xlog(3/3),stopwords_en.txt:1/501xlog(3/3),callwild.txt:2/26287xlog(3/3)