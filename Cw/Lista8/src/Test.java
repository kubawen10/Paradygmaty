public class Test {

    int zawartość = 0;

    static void argNiemodyfikowalny(final Test zmienna) {
        zmienna.zawartość = 1;
        //zmienna = null; //nie mozna zmienic zawartosci final
    }
    static void argModyfikowalny(Test zmienna) {
        zmienna.zawartość = 1;
        zmienna = null;
    }

    public static void main(String[] args){
        // ZADANIE 1
        try {
            //zad1();
        }catch(Exception e){
            e.printStackTrace();
        }

        // ZADANIE 2
        /*
        za kazdym razem bedzie 1 bo
        argument ktory jest przekazywany to REFERENCJA do obiektu
        a nie sam obiekt
        wiec jesli ob1 jest pod adresem 69 i przekazemy go
        zostanie stworzona referencja do 69, czyli 69 = null zmieni tylka ta wartosc
        a nie obiekt pod tym adresem

        no a final zmienia tylko to ze nie mozna przypisac nic do tej zmiennej
        ale mozna uzywac na niej metod ktore ja zmieniaja
        */

        Test modyfikowalna = new Test();
        final Test niemodyfikowalna = new Test();

        //a
        //argNiemodyfikowalny(modyfikowalna);
        //System.out.println(modyfikowalna.zawartość); //1

        //b
        //argNiemodyfikowalny(niemodyfikowalna);
        //System.out.println(niemodyfikowalna.zawartość); //1

        //c
        //argModyfikowalny(modyfikowalna);
        //System.out.println(modyfikowalna.zawartość); //1

        //d
        //argModyfikowalny(niemodyfikowalna);
        //System.out.println(niemodyfikowalna.zawartość); //1

    }

    public static void zad1() throws Exception{
        MyQueue<Integer> q = new QueueCyclic<>(3);

        System.out.println(q.isEmpty());
        System.out.println(q.isFull());

        //q.first();

        q.enqueue(1);
        System.out.println(q.isEmpty());
        System.out.println(q.isFull());
        q.enqueue(2);
        q.enqueue(3);

        System.out.println(q.isEmpty());
        System.out.println(q.isFull());
        //q.enqueue(4);

        System.out.println(q.first());
        q.dequeue();
        System.out.println(q.first());
        q.dequeue();
        q.dequeue();
    }
}
