package analytics;

import java.io.File;

import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.storm.shade.org.apache.commons.io.FileUtils;
import org.apache.storm.task.OutputCollector;
import org.apache.storm.task.TopologyContext;
import org.apache.storm.topology.OutputFieldsDeclarer;
import org.apache.storm.topology.base.BaseRichBolt;

import org.apache.storm.tuple.Tuple;

public class UserPageVisitCount extends BaseRichBolt {
	private OutputCollector outputCollector;
	private Long timestampStart;
	private String currentFile;
	private final static Integer SEC = 30;

	@Override
	public void prepare(Map stormConf, TopologyContext context, OutputCollector collector) {
		outputCollector = collector;
		timestampStart = new Timestamp(System.currentTimeMillis()).getTime();
		currentFile = null;
	}

	@Override
	public void execute(Tuple input) {

		try {
			process(input);
			// ack Input
			outputCollector.ack(input);
			// Display
			if (timestampStart + UserPageVisitCount.SEC * 1000 <= new Timestamp(System.currentTimeMillis()).getTime()) {
				displayLastHoursVisit(currentFile);
				timestampStart = new Timestamp(System.currentTimeMillis()).getTime();
			}
		} catch (IOException e) {
			e.printStackTrace();
			outputCollector.fail(input);
		}

	}

	public void process(Tuple input) throws IOException {

		HashMap<String, Integer> userPageVisitCounts = new HashMap<String, Integer>();
		Integer userId = input.getIntegerByField("userId");
		String url = input.getStringByField("url");
		String key = Integer.toString(userId) + "-" + url;
		
		String filePath = String.format("%s", new SimpleDateFormat("yyyy-MM-dd HH").format(new Date()));
		currentFile = filePath; // pour lecture

		// csv reader
		userPageVisitCounts = createHashMapFromCsvFile(filePath);

		// add
		addTupleToHashMap(userPageVisitCounts, key);

		// Write stats to file
		writeHashMapToCsvFile(filePath, userPageVisitCounts);

	}

	private void addTupleToHashMap(HashMap<String, Integer> userPageVisitCounts, String key) {
		if (userPageVisitCounts != null) {
			Integer value = userPageVisitCounts.get(key);
			if (value != null) {
				userPageVisitCounts.put(key, value + 1); // get value from data in csv and add 1
			} else {
				userPageVisitCounts.put(key, 1); // create new row
			}
		} else {
			userPageVisitCounts.put(key, 1); // create new row
		}

	}

	private void displayLastHoursVisit(String currentFile) throws IOException {
		String[] userPageVisit;
		System.out.println("====== Print Last Hour Result User Page Visits =======");
		File csvFile = new File(currentFile);
		if (csvFile.exists()) {
			List<String> lines = FileUtils.readLines(csvFile, "UTF-8");
			for (String line : lines) {
				userPageVisit = line.split(";");
				System.out.println("User ID : " + userPageVisit[0] + " Page : " + userPageVisit[1] + " Nb Visits : "
						+ Integer.parseInt(userPageVisit[2]));
			}
		}
	}

	private void writeHashMapToCsvFile(String filePath, HashMap<String, Integer> userPageVisitCounts)
			throws IOException {
		String eol = System.getProperty("line.separator");

		Writer writer = new FileWriter(new File(filePath).getAbsoluteFile());
		for (String key : userPageVisitCounts.keySet()) {
			String user = key.substring(0, key.indexOf("-"));
			String urluser = key.substring(user.length() + 1, key.length() - user.length() + 1);
			writer.append(user).append(';').append(urluser).append(';')
					.append(Integer.toString(userPageVisitCounts.get(key))).append(eol);
		}
		writer.close();

	}

	private HashMap<String, Integer> createHashMapFromCsvFile(String filePath) throws IOException {
		// private variable
		String[] userPageVisit = null;
		HashMap<String, Integer> userPageVisitFile = new HashMap<String, Integer>();

		File csvFile = new File(filePath);
		if (csvFile.exists()) {
			List<String> lines = FileUtils.readLines(csvFile, "UTF-8");
			for (String line : lines) {
				// System.out.println("line " + line);
				userPageVisit = line.split(";");
				if (userPageVisit.length > 2) {
					userPageVisitFile.put(userPageVisit[0] + "-" + userPageVisit[1],
							Integer.parseInt(userPageVisit[2]));
				}
			}
		}
		return userPageVisitFile;
	}

	@Override
	public void declareOutputFields(OutputFieldsDeclarer declarer) {

	}

}
