/* 
 * Package contenant toutes les sources pour la Mission 1 : TF-IDF 
 * 
 * Rappel de la formule : w_t,d = ( tf_t,d / n_d ) × log( N / df_t )
 * 
 * Le processus s'execute en 4 étapes Map/Reduce :
 * 
 *   Etape 1
 *   	Objectif : calcul de la fréquence des mots par document (tf_t,d)
 *   	Entrée   : l'ensemble des fichiers, ligne par ligne
 *   	Sortie   : une ligne par couple mot@fichier et la fréquence associée
 *                 (exemple : added@callwild.txt	6)
 *      Dossiers : ./input/ => ./output/step_1
 *   
 *   Etape 2
 *   	Objectif : calcul du nombre total de mots par document (n_d) pour compléter la formule ( tf_t,d / n_d )
 *   	Entrée   : chaque couple (fichier, mot) et la fréquence associée
 *   	Sortie   : une ligne par fichier et séparée par des virgules, la liste des mots avec la formule associée 
 *                 (exemple : callwild.txt	aaah=1/13457,zeal=1/13457,yukon=7/13457,...)
 *      Dossiers : ./output/step_1 => ./output/step_2
 *   
 *   Etape 3
 *   	Objectif : calcul du nombre de fichiers contenant chaque mot (df_t) pour compléter la formule ( tf_t,d / n_d ) × log( N / df_t )
 *   	Entrée   : une ligne par fichier et séparée par des virgules, la liste des mots avec la formule associée
 *   	Sortie   : une ligne par couple mot@fichier et la formule complète associée 
 *                 (exemple : abate@defoe-robinson-103.txt	12/36610*log(10, 2/1+1)=0.0001563905)
 *      Dossiers : ./output/step_2 => ./output/step_3
 *   
 *   Etape 4
 *   	Objectif : tri des résultats par document et par TF-IDF
 *   	Entrée   : une ligne par couple mot@fichier et la formule complète associée
 *   	Sortie   : une ligne par couple (fichier, mot) et la valeur du TF-IDF associé
 *                 (exemple : defoe-robinson-103.txt, great : 0.0028532480)
 *      Dossiers : ./output/step_3 => ./output/step_4
*/
package ocr.hadoop.lab.tfidf;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Map;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.conf.Configured;
import org.apache.hadoop.fs.FileStatus;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.util.Tool;
import org.apache.hadoop.util.ToolRunner;

public class GetTopK extends Configured implements Tool {

    public int run(String[] args) throws Exception {
        if (args.length != 2) {
            System.out.println("Usage: [folder] [K]");
            System.exit(-1);
        }
        
        Path oDir = new Path(args[0]);
        int k = Integer.parseInt(args[1]);
        
        String[] strspl1, strspl2;
		String docId, word;
		Double tfidf;
		Map<String, Map<String, Double>> fileMap = new HashMap<>();

		FileSystem fs = FileSystem.get(new Configuration());
        FileStatus[] status = fs.listStatus(oDir); // "hdfs://test.com:9000/" + oDir
        
        for (int i=0; i < status.length; i++) {
        	if(status[i].isFile() && status[i].getPath().getName().startsWith("part-")) {
            	BufferedReader br = new BufferedReader(new InputStreamReader(fs.open(status[i].getPath())));

			    String line;
			    while ((line = br.readLine()) != null) {
			       strspl1 = line.split("\t");
			       strspl2 = strspl1[0].split(":");
			       
			       docId = strspl2[0];
			       word = strspl2[1];
			       tfidf = Double.parseDouble(strspl1[1]);
			       
			       if (!fileMap.containsKey(docId))
			    	   fileMap.put(docId, new HashMap<String, Double>());
			       
			       Map<String, Double> map = fileMap.get(docId);
			       map.put(word, tfidf);        	}
            }
        }
		// Filtre le Top 20
		for(String key : fileMap.keySet()) {
			System.out.println("\nTop " + String.valueOf(k) + " words in " + key + " :");
			fileMap.get(key).entrySet().stream()
								        .sorted(Map.Entry.<String, Double>comparingByValue().reversed()) 
								        .limit(k) 
								        .forEach(v -> System.out.println("TFIDF = " + String.format("%.6f", v.getValue()) + " => " + v.getKey()));
		}
		return 0;
    }
	
	/*
	private static void getTop20(String oDir) throws IOException {
	
		String[] strspl1, strspl2;
		String docId, word;
		Double tfidf;
		Map<String, Map<String, Double>> fileMap = new HashMap<>();

 		File[] files = new File(oDir).listFiles();
	    for (File file : files) {
			if (file.isFile() && file.getName().startsWith("part-") ) {
				try (BufferedReader br = new BufferedReader(new FileReader(file.getAbsolutePath()))) {
				    String line;
				    while ((line = br.readLine()) != null) {
				       strspl1 = line.split("\t");
				       strspl2 = strspl1[0].split(":");
				       
				       docId = strspl2[0];
				       word = strspl2[1];
				       tfidf = Double.parseDouble(strspl1[1]);
				       
				       if (!fileMap.containsKey(docId))
				    	   fileMap.put(docId, new HashMap<String, Double>());
				       
				       Map<String, Double> map = fileMap.get(docId);
				       map.put(word, tfidf);
				       				       
				       //System.out.println(docId + "," + word + "," + tfidf);
				    }
				}		    
			}
		}		

		// Filtre le Top 20
		for(String key : fileMap.keySet()) {
			System.out.println("\nTop 20 word in " + key + " :");
			fileMap.get(key).entrySet().stream()
								        .sorted(Map.Entry.<String, Double>comparingByValue().reversed()) 
								        .limit(20) 
								        .forEach(v -> System.out.println("TFIDF = " + String.format("%.5f", v.getValue()) + " => " + v.getKey()));
		}
	}
	*/
	
	public static void main(String[] args) throws Exception {
        
		/*
		// Calcule le nombre de fichiers dans la collection (N dans la formule) utilisé dans l'étape 3
    	//long nbInputFiles = Files.list(Paths.get("/input/")).filter(p -> p.toFile().isFile()).count();
		long nbInputFiles = 2;
    	
    	// Lance le processus Map/Reduce de l'étape 1
    	args = new String[] {"/input/", "/output/step_1"};
    	WordCountDriver step1 = new WordCountDriver();
        int res = ToolRunner.run(step1, args);
        
        // Lance le processus Map/Reduce de l'étape 2
        args = new String[] {"/output/step_1/", "/output/step_2/"};
    	WordPerDocDriver step2 = new WordPerDocDriver();
        res = ToolRunner.run(step2, args);
         
    	// Lance le processus Map/Reduce de l'étape 3
        args = new String[] {"/output/step_2/", "/output/step_3/", String.valueOf(nbInputFiles)};
    	WordTFIDFDriver job3 = new WordTFIDFDriver();
        res = ToolRunner.run(job3, args);
		*/
		

        //System.exit(res);
		int exitCode = ToolRunner.run(new GetTopK(), args);
		System.exit(exitCode);
	}
}
