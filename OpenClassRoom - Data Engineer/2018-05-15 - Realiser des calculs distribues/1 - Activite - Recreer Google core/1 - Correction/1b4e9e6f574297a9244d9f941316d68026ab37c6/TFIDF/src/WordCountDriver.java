package ocr.hadoop.lab.tfidf;

import java.io.InputStreamReader;
import java.io.BufferedReader;
import org.apache.hadoop.conf.*;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.util.Tool;
import org.apache.hadoop.util.ToolRunner;

// Classe principale de l'étape 1
public class WordCountDriver extends Configured implements Tool {

    public int run(String[] args) throws Exception {
        if (args.length != 3) {
            System.out.println("Usage: [input] [output] [resources]");
            System.exit(-1);
        }
        
        // Définition des répertoires d'entrée et de sortie
        Path iDir = new Path(args[0]);
        Path oDir = new Path(args[1]);
        Path rDir = new Path(args[2]);

        // Ouvre et lit le fichier des mots inutiles
        
        //FileReader freader = new FileReader("./stopwords_en.txt");  
        //BufferedReader br = new BufferedReader(freader);
        
        //InputStream in = getClass().getResourceAsStream("/stopwords_en.txt"); 
        //BufferedReader br = new BufferedReader(new InputStreamReader(in));

        Configuration conf = getConf();

        Path pt=new Path(rDir + "/stopwords_en.txt");
        FileSystem fs = FileSystem.get(conf);
        BufferedReader br=new BufferedReader(new InputStreamReader(fs.open(pt)));

        String line, stopwords = "|";
        while((line = br.readLine()) != null) {  
        	stopwords += line + "|";
        }  
        br.close();  
        
        // Sauvegarde le contenu dans l'objet Configuration pour être accessible dans les tâches Map et Reduce
 		conf.set("stopwords", stopwords);
		
		// Création du job
        Job job = Job.getInstance(conf);
        job.setJobName("WordCount");

        // On précise les classes
        job.setJarByClass(WordCountDriver.class);
        job.setMapperClass(WordCountMapper.class);
        job.setReducerClass(WordCountReducer.class);

        // Définition des types Clé/Valeur de sortie de Map
        job.setMapOutputKeyClass(Text.class);
        job.setMapOutputValueClass(IntWritable.class);

        // Définition des types Clé/Valeur de sortie du Reduce/programme
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(IntWritable.class);

        FileInputFormat.setInputDirRecursive(job, true);
        FileInputFormat.addInputPath(job, iDir);
        FileOutputFormat.setOutputPath(job, oDir);

        // Suppression du répertoire de sortie s'il existe déjà
        if (fs.exists(oDir)) {
            fs.delete(oDir, true);
        }

        // Lancement du job
        int code = job.waitForCompletion(true) ? 0: 1;
        
        return(code);
    }
    
    public static void main(String[] args) throws Exception {
    	  int exitCode = ToolRunner.run(new WordCountDriver(), args);
    	  System.exit(exitCode);
    }

}