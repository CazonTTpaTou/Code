package recursif;

public class Multi {

	public String Mult(int number) {
		if((number%3==0)&&(number%5==0)) {return "FizzBuzz";}
		if (number%3==0) {return "Fizz";}
		if (number%5==0) {return "Buzz";}
		else return String.valueOf(number);
	}
	
	public static void main(String[] args) {
		Multi m = new Multi();
		for(int i=0;i<=100;++i) {
			System.out.println(m.Mult(i));
		}
	}

}
