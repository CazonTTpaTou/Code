package analytics;

import org.apache.storm.Config;
import org.apache.storm.LocalCluster;
import org.apache.storm.StormSubmitter;
import org.apache.storm.generated.AlreadyAliveException;
import org.apache.storm.generated.AuthorizationException;
import org.apache.storm.generated.InvalidTopologyException;
import org.apache.storm.generated.StormTopology;
import org.apache.storm.topology.TopologyBuilder;
import org.apache.storm.tuple.Fields;

public class App 
{
	public static void main( String[] args ) throws AlreadyAliveException, InvalidTopologyException, AuthorizationException
	{
		TopologyBuilder builder = new TopologyBuilder();

		builder.setSpout("page-visits", new PageVisitSpout());

		builder.setBolt("visit-counts", new VisitCountBolt(), 1)
			.shuffleGrouping("page-visits");
		builder.setBolt("user-visit-counts", new UserVisitCountBolt(), 2)
			.fieldsGrouping("visit-counts", new Fields("userId"));
		builder.setBolt("page-visit-counts", new PageVisitCountBolt(), 2)
			.fieldsGrouping("visit-counts", new Fields("url"));

		/* Création d'un Bolt pour comptabiliser les statistiques par page et utilisateur dans la dernière heure */
		builder.setBolt("user-page-visit-counts", new UserPageVisitCount  , 3)

		StormTopology topology = builder.createTopology();
		
		Config config = new Config();

		Config config = new Config();

		/* Détermination de la fenêtre glissante à un intervalle d'une heure */
		int slidingInterval = 1000*60*60
		config.setMessageTimeoutSecs(slidingInterval);

		String topologyName = "analytics-topology";
		if(args.length > 0 && args[0].equals("remote")) {
			StormSubmitter.submitTopology(topologyName, config, topology);
		}
		else {
			LocalCluster cluster = new LocalCluster();
			cluster.submitTopology(topologyName, config, topology);
		}
	}
}
