int compteur;

for (compteur=0,compteur<100,compteur++)
    {
        if (compteur%15 == 0)
            {Console.WriteLine("GinFizzBuzz")}
        else { 
            if(compteur%5 == 0)
                {Console.WriteLine("Fizz")}
            else{
                if(compteur%3 == 0)
                        {Console.WriteLine("Buzz")}
                else{
                        Console.WriteLine("Gin")}
                }
                }
    }
    

    