package analytics;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ThreadLocalRandom;

import org.apache.storm.task.OutputCollector;
import org.apache.storm.task.TopologyContext;
import org.apache.storm.topology.OutputFieldsDeclarer;
import org.apache.storm.topology.base.BaseRichBolt;
import org.apache.storm.tuple.Tuple;

public class UserPageVisitCountBolt extends BaseRichBolt,BaseWindowedBolt  {
	private OutputCollector outputCollector;
	private HashMap<Integer, Integer> userVisitCounts;
	private HashMap<String, Integer> pageVisitCounts;
	private HashMap<String, userVisitCounts>;

	@Override
	public void prepare(Map stormConf, TopologyContext context, OutputCollector collector) {
		userVisitCounts = new HashMap<Integer, Integer>();
		pageVisitCounts = new HashMap<String, Integer>();
		userPageVisitCounts = new HashMap<String, userVisitCounts>()
		outputCollector = collector;
	}

	@Override
	public void execute(Tuple input) {

		/* Détermination de la fenêtre glissante à un intervalle d'une heure */
		int slidingInterval = 1000*60*60
		withWindow(Count windowLength, Duration slidingInterval)

		long tupleCount = 0

		String url = input.getStringByField("url");
		pageVisitCounts.put(url, pageVisitCounts.getOrDefault(url, 0) + 1);

		Integer userId = input.getIntegerByField("userId");
		userVisitCounts.put(userId, userVisitCounts.getOrDefault(userId, 0) + 1);

		/* Mise à jour du bolt userPageVisit */
		userPageVisitCounts.put(url,userVisitCounts);

		userPageVisitCounts.get(url).get(userid).add(userVisitCounts);

		if(ThreadLocalRandom.current().nextInt(10) == 0) {
			outputCollector.fail(input);
		}
		else {
			outputCollector.ack(input);
			tupleCount += 1;
		}

		// Emit average stats by hour, page and user
		String now = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
		long totaluserPageVisit = 0;

		for(Entry<String, HashMap<Long, ArrayList<Long>>> userStats: userPageVisitCounts.entrySet()) {
			String url = userPageVisitCounts.getKey();
			Double visit = 0.;
			for(Entry<Long, ArrayList<Long>> userId: userVisitCounts.getValue().entrySet()) {
				Double userPageVisit = 0.;
				for(Long nbVisit: userVisitCounts.getValue()) {
					userPageVisit += nbVisit;
				}
				if(!userVisitCounts.getValue().isEmpty()) {
					userPageVisit /= userVisitCounts.getValue().size();
				}
				totaluserPageVisit += userPageVisit;
			}
			outputCollector.emit(new Values(city, now, totaluserPageVisit));
		}
	}
	}

	@Override
	public void declareOutputFields(OutputFieldsDeclarer declarer) {
	}

}
