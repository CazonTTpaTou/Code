package analytics;

import java.util.HashMap;
import java.util.Map;
import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import org.apache.storm.task.OutputCollector;
import org.apache.storm.task.TopologyContext;
import org.apache.storm.topology.OutputFieldsDeclarer;
import org.apache.storm.topology.base.BaseWindowedBolt;

import org.apache.storm.windowing.TupleWindow;

import org.apache.storm.tuple.Fields;
import org.apache.storm.tuple.Tuple;
import org.apache.storm.tuple.Values;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

public class UserPageVisitCountBolt extends BaseWindowedBolt {
	/**
	 * 
	 */
    private static final Logger LOG = LoggerFactory.getLogger(UserPageVisitCountBolt.class);
    private OutputCollector outputCollector;
    
    private HashMap<String, Integer> userPageVisitCounts;

	@Override
	public void prepare(Map stormConf, TopologyContext context, OutputCollector collector) {
		userPageVisitCounts = new HashMap<String, Integer>();
		outputCollector = collector;
	}
	
	@Override
	public void execute(TupleWindow inputWindow) {
		HashMap<String, HashMap<Integer, ArrayList<Integer>>> number_of_visits = new HashMap<String, HashMap<Integer, ArrayList<Integer>>>();

		// Collect stats for all tuples, url by url, user by user
		
		//DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		//Date date = new Date();
		
		Integer tupleCount = 0;
		
		for(Tuple input : inputWindow.get()) {
			String url = input.getStringByField("url");
			Integer userId = input.getIntegerByField("userId");
			
			//System.out.printf("%s UserPageVisitCountBolt: Received %s %d\n", dateFormat.format(date), url, userId);
			
			outputCollector.ack(input);
			
			number_of_visits.putIfAbsent(url, new HashMap<Integer, ArrayList<Integer>>());
			number_of_visits.get(url).putIfAbsent(userId, new ArrayList<Integer>());
			number_of_visits.get(url).get(userId).add(1);
			
			tupleCount += 1;
		}
		System.out.printf("======> Received %d tuples\n", tupleCount);
		
		String now = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
		for(Entry<String, HashMap<Integer, ArrayList<Integer>>> userStats: number_of_visits.entrySet()) {
			String url = userStats.getKey();
			System.out.printf("%s url:%s\n", now, url);
			for(Entry<Integer, ArrayList<Integer>> user: userStats.getValue().entrySet()) {
				Integer userId = user.getKey();
				Integer sumVisits = 0;
				for(Integer numVisits: user.getValue()) {
					sumVisits += numVisits;
				}
				System.out.printf("\tUtilisateur:%d => Nb visites:%d\n", userId, sumVisits);
				//outputCollector.emit(new Values(url, user, now, sumVisits));
			}			
		}
	}
	
	  @Override
	    public void declareOutputFields(OutputFieldsDeclarer declarer) {
	        
	}
}
