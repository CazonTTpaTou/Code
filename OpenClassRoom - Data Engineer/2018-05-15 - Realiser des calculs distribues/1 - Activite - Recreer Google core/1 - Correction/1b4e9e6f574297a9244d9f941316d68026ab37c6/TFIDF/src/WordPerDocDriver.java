package ocr.hadoop.lab.tfidf;

import org.apache.hadoop.conf.*;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.input.KeyValueTextInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.mapreduce.lib.output.TextOutputFormat;
import org.apache.hadoop.util.Tool;
import org.apache.hadoop.util.ToolRunner;

public class WordPerDocDriver extends Configured implements Tool {

    public int run(String[] args) throws Exception {
        if (args.length != 2) {
            System.out.println("Usage: [input] [output]");
            System.exit(-1);
        }
        
        Configuration conf = getConf();
		
		// Création du job
        Job job = Job.getInstance(conf);
        job.setJobName("WordPerDoc");

        // On précise les classes MyProgram, Map et Reduce
        job.setJarByClass(WordPerDocDriver.class);
        job.setMapperClass(WordPerDocMapper.class);
        job.setReducerClass(WordPerDocReducer.class);

        // Définition des types Clé/Valeur de sortie de Map
        job.setMapOutputKeyClass(Text.class);
        job.setMapOutputValueClass(Text.class);

        // Définition des types Clé/Valeur de sortie de Reduce
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(Text.class);

        // Définition des répertoires d'entrée et de sortie
        Path iDir = new Path(args[0]);
        Path oDir = new Path(args[1]);
        
		// Lit le fichier d'entrée ligner par ligne, au format clé/valeur
        job.setInputFormatClass(KeyValueTextInputFormat.class);
		FileInputFormat.setInputDirRecursive(job, true);
		FileInputFormat.addInputPath(job, iDir);

        FileOutputFormat.setOutputPath(job, oDir);
        job.setOutputFormatClass(TextOutputFormat.class);

        // Suppression du fichier de sortie s'il existe déjà
        FileSystem fs = FileSystem.newInstance(conf);
        if (fs.exists(oDir)) {
            fs.delete(oDir, true);
        }

        int code = job.waitForCompletion(true) ? 0: 1;
        
        return(code);
    }

    public static void main(String[] args) throws Exception {
  	  int exitCode = ToolRunner.run(new WordPerDocDriver(), args);
  	  System.exit(exitCode);
  }

}