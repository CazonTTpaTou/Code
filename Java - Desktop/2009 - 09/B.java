class A
{
  int nombre = 200;
}

public class B extends A
{
  int nombre;
  void affiche()
  {
    System.out.println(this.nombre);
    System.out.println(super.nombre);
  }

public static void main(String[] args)
  {
    B b = new B();
    b.nombre = 100;
    b.affiche();
  }
}

