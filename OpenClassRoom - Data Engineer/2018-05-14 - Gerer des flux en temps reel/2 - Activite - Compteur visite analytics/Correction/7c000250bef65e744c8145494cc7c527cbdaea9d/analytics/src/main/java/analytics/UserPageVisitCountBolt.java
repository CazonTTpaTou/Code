package analytics;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ThreadLocalRandom;
import org.apache.storm.topology.base.BaseWindowedBolt;
import org.apache.storm.task.OutputCollector;
import org.apache.storm.task.TopologyContext;
import org.apache.storm.topology.OutputFieldsDeclarer;
import org.apache.storm.topology.base.BaseRichBolt;
import org.apache.storm.tuple.Tuple;

public class UserVisitCountBolt extends BaseWindowedBolt {
	private OutputCollector outputCollector;
	
	@Override
	public void prepare(Map stormConf, TopologyContext context, OutputCollector collector) {
		outputCollector = collector;
	}

	@Override
	public void execute(TupleWindow inputWindow) {
    	// initialisation du HashMap comme cle url et comme valeur un autre HashMap avec cle id et valeur nombre de visite
    	HashMap<String, HashMap<String, Integer>> urlIdCount = new HashMap<String, HashMap<String, Integer>>();
    	
		Integer tupleCount = 0;
		for(Tuple input : inputWindow.get()) {
    		// recuperation des donnee
			String idUser = input.getStringByField("userId");
			String idUrl = input.getLongByField("url");
			// incrementation de nos stats			
			urlIdCount.putIfAbsent(idUrl, new HashMap<String, Integer>());
			urlIdCount.get(idUrl).putIfAbsent(idUser, new Integer());
			urlIdCount.get(idUrl).put(idUser, urlIdCount.get(idUrl).get(idUser)+1);
			
			outputCollector.ack(input);
			tupleCount += 1;
		}
		System.out.printf("====== UserPageVisitCountBolt: Received %d tuples\n", tupleCount);
		
		
		// Affichage des statistiques a la console
		for(Entry<String, HashMap<String, Integer>> urluserStats: urlIdCount.entrySet()) {
			String my_url = urluserStats.getKey();
			for(Entry<String, Integer> my_user: urluserStats.getValue().entrySet()) {
				
				System.out.printf("### URL %s visited %d times by user %s %n", my_url, my_user.getValue(), my_user.getKey());
			}			
		}
				
	}

	@Override
	public void declareOutputFields(OutputFieldsDeclarer declarer) {
	}

}