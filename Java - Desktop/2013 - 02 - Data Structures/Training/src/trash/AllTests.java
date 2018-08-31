package trash;

import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

public class AllTests {

	public static Test suite() {
		TestSuite suite = new TestSuite(AllTests.class.getName());
		//$JUnit-BEGIN$
		suite.addTest(new TestSuite(PremiersTest.class));
		//$JUnit-END$
		return suite;
	}
	/* Created on 23 févr. 2013 by Fabien Monnery */
}
