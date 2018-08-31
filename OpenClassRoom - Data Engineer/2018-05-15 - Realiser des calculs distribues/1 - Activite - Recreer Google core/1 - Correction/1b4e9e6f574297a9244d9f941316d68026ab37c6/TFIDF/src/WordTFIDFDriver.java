package ocr.hadoop.lab.tfidf;

import org.apache.hadoop.conf.*;
import org.apache.hadoop.fs.FileStatus;
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

public class WordTFIDFDriver extends Configured implements Tool {

    public int run(String[] args) throws Exception {
        if (args.length != 3) {
            System.out.println("Usage: [input] [output] [source]");
            System.exit(-1);
        }
        
        // Définition des fichiers d'entrée et de sortie
        Path iDir = new Path(args[0]);
        Path oDir = new Path(args[1]);
        Path sDir = new Path(args[2]);

        FileSystem fs = FileSystem.get(new Configuration());
        FileStatus[] status = fs.listStatus(sDir); // "hdfs://test.com:9000/" + oDir
        int nbFiles = status.length;
        
        Configuration conf = getConf();
		conf.set("nbInputFiles", String.valueOf(nbFiles));
		
		// Création du job
        Job job = Job.getInstance(conf);
        job.setJobName("TFIDF");

        // On précise les classes
        job.setJarByClass(WordTFIDFDriver.class);
        job.setMapperClass(WordTFIDFMapper.class);
        job.setReducerClass(WordTFIDFReducer.class);

        // Définition des types Clé/Valeur de sortie de Map
        job.setMapOutputKeyClass(Text.class);
        job.setMapOutputValueClass(Text.class);

        // Définition des types Clé/Valeur de sortie du programme
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(Text.class);

        
		job.setInputFormatClass(KeyValueTextInputFormat.class);
		FileInputFormat.setInputDirRecursive(job, true);
		FileInputFormat.addInputPath(job, iDir);

        FileOutputFormat.setOutputPath(job, oDir);
        job.setOutputFormatClass(TextOutputFormat.class);

        // Suppression du fichier de sortie s'il existe déjà
        if (fs.exists(oDir)) {
            fs.delete(oDir, true);
        }

        int code = job.waitForCompletion(true) ? 0: 1;
        
        return(code);
    }

    public static void main(String[] args) throws Exception {
  	  int exitCode = ToolRunner.run(new WordTFIDFDriver(), args);
  	  System.exit(exitCode);
  }
    
}