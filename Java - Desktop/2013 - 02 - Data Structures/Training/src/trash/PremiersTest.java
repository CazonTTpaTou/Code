package trash;

import static org.junit.Assert.*;

import org.junit.Test;

import recursif.Premiers;

public class PremiersTest {
	
	@Test
	public void testFirst() {
		Premiers p = new Premiers();
		for(int i=2;i<=20;i++){
		assertTrue(i + " = Premier",p.First(i, 2)==0);}
	/* Created on 23 févr. 2013 by Fabien Monnery */
	}
}
