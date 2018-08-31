package ocr.hadoop.lab.pagerank;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import org.apache.hadoop.conf.*;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.DoubleWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.input.KeyValueTextInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.mapreduce.lib.output.TextOutputFormat;
import org.apache.hadoop.util.Tool;
import org.apache.hadoop.util.ToolRunner;

public class TransMatrixDriver extends Configured implements Tool {

	public int run(String[] args) throws Exception {
		if (args.length != 2) {
			System.out.println("Usage: [input] [output]");
			System.exit(-1);
		}

        Configuration conf = getConf();
		conf.set("mapreduce.input.keyvaluelinerecordreader.key.value.separator", ": ");
		
		FileSystem fs = FileSystem.get(conf);
		BufferedReader br = new BufferedReader(new InputStreamReader(fs.open(new Path(args[0]))));
		int count=0;
		while(br.readLine() != null) {
			count++;
		}
		br.close();
		conf.set("PageRank_n", String.valueOf(count));
        
		// Création du job
		Job job = Job.getInstance(conf);
		job.setJobName("Matrice de transition");

		// On précise les classes
		job.setJarByClass(TransMatrixDriver.class);
		job.setMapperClass(TransMatrixMapper.class);
		
		// Utilisation du Reducer Identity
		// job.setReducerClass(Reducer.class);
		
		// job.setReducerClass(TransMatrixReduce.class);

		// Définition des types Clé/Valeur de sortie de Map
		job.setMapOutputKeyClass(Text.class);
		job.setMapOutputValueClass(DoubleWritable.class);

		// Définition des types Clé/Valeur de sortie de Reduce
		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(DoubleWritable.class);

		// Définition des fichiers d'entrée et de sortie
		Path iFile = new Path(args[0]);
		Path oDir = new Path(args[1]);

		job.setInputFormatClass(KeyValueTextInputFormat.class);
		FileInputFormat.addInputPath(job, iFile);

        job.setOutputFormatClass(TextOutputFormat.class);
        FileOutputFormat.setOutputPath(job, oDir);

        /*
        job.setOutputFormatClass(LazyOutputFormat.class);
        LazyOutputFormat.setOutputFormatClass(job, TextOutputFormat.class);
        
        MultipleOutputs.addNamedOutput(job, "matrix", TextOutputFormat.class, Text.class, Text.class);
        MultipleOutputs.addNamedOutput(job, "vector", TextOutputFormat.class, Text.class, Text.class);
        */
        
		// Suppression du dossier de sortie s'il existe déjà
		if (fs.exists(oDir)) {
			fs.delete(oDir, true);
		}

		int code = job.waitForCompletion(true) ? 0 : 1;

		return (code);
	}
	
    public static void main(String[] args) throws Exception {
  	  int exitCode = ToolRunner.run(new TransMatrixDriver(), args);
  	  System.exit(exitCode);
  }

}