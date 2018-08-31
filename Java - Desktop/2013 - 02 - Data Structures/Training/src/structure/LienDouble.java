package structure;

public class LienDouble extends Lien {

	protected Lien precedent;
	protected Lien precedent() {return precedent;}
	protected void precedent(Lien s) {precedent=s;}

	}



