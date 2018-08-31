package ocr.hadoop.lab.pagerank;

import java.io.InputStreamReader;
import java.io.BufferedReader;
import org.apache.hadoop.conf.*;
import org.apache.hadoop.fs.FileStatus;
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

public class NextStepDriver extends Configured implements Tool {

	public int run(String[] args) throws Exception {
		if (args.length != 3) {
			System.out.println("Usage: [input] [output] [i]");
			System.exit(-1);
		}

		String step = args[2];

		// Définition des fichiers d'entrée et de sortie
		Path iDir = new Path(args[0]);
		Path oDir = new Path(args[1]);
		
        Configuration conf = getConf();
		FileSystem fs = FileSystem.get(conf);

		BufferedReader br;
		String line, vector = "";
		int n=0;

		// Charge le vecteur en mémoire
        FileStatus[] status = fs.listStatus(oDir);
        for (int i=0; i < status.length; i++) {
        	if(status[i].isFile() && status[i].getPath().getName().startsWith("part-")) {
            	//System.out.println(status[i].getPath());
        		br = new BufferedReader(new InputStreamReader(fs.open(status[i].getPath())));
		
				while((line = br.readLine()) != null) {
					vector += line + " ";
					n++;
				}
				br.close();

        	}
        }
		conf.set("vector", vector);
		conf.set("PageRank_n", String.valueOf(n));
		
		// Création du job
		Job job = Job.getInstance(conf);
		job.setJobName("Etape " + step);

		// On précise les classes
		job.setJarByClass(NextStepDriver.class);
		job.setMapperClass(NextStepMapper.class);
		job.setReducerClass(NextStepReducer.class);

		// Définition des types Clé/Valeur de sortie de Map
		job.setMapOutputKeyClass(Text.class);
		job.setMapOutputValueClass(DoubleWritable.class);

		// Définition des types Clé/Valeur de sortie de Reduce
		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(DoubleWritable.class);

		job.setInputFormatClass(KeyValueTextInputFormat.class);
		FileInputFormat.setInputDirRecursive(job, true);
		FileInputFormat.addInputPath(job, iDir);

        job.setOutputFormatClass(TextOutputFormat.class);
        FileOutputFormat.setOutputPath(job, oDir);
        
        /*
        job.setOutputFormatClass(LazyOutputFormat.class);
        LazyOutputFormat.setOutputFormatClass(job, TextOutputFormat.class);
        
        MultipleOutputs.addNamedOutput(job, "matrix", TextOutputFormat.class, Text.class, Text.class);
        MultipleOutputs.addNamedOutput(job, "vector", TextOutputFormat.class, Text.class, Text.class);
		*/
        
		// Suppression du fichier de sortie s'il existe déjà
		if (fs.exists(oDir)) {
			fs.delete(oDir, true);
		}

		int code = job.waitForCompletion(true) ? 0 : 1;

		return (code);
	}

    public static void main(String[] args) throws Exception {
    	  int exitCode = ToolRunner.run(new NextStepDriver(), args);
    	  System.exit(exitCode);
    }

}