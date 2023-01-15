import java.util.Random;
import java.util.concurrent.Semaphore;

public class Feast {
    private final int philosophersNumber;
    private final Stick[] sticks;
    private final Doorman doorman;
    private final Philosopher[] philosophers;

    public static void main(String[] args) {
        Feast f = new Feast(5);
        f.begin();
    }

    Feast(int philosophersNumber){
        this.philosophersNumber = philosophersNumber;
        sticks = new Stick[philosophersNumber];
        doorman = new Doorman(philosophersNumber - 1);
        philosophers = new Philosopher[philosophersNumber];

        for (int i = 0; i < philosophersNumber; i++) {
            sticks[i] = new Stick();
        }
        for (int i = 0; i < philosophersNumber; i++) {
            philosophers[i] = new Philosopher(i);
        }
    }

    public void begin(){
        for (int i = 0; i < philosophersNumber; i++) {
            philosophers[i].start();
        }
    }

    public class Philosopher extends Thread {
        private final int place;
        private final Stick left;
        private final Stick right;

        Philosopher(int place){
            super("Philosopher " + place);
            this.place = place;
            left = sticks[(place+1) % philosophersNumber];
            right = sticks[place];
        }

        private void eat() throws InterruptedException {
            doorman.getIn();
            left.take();
            right.take();
            System.out.println(getName() + " is eating");
            sleep(new Random().nextInt(1000));
            System.out.println(getName() + " finished eating");
            left.putDown();
            right.putDown();
            doorman.getOut();
            meditate();
        }

        private void meditate() throws InterruptedException {
            System.out.println(getName() + " is meditating");
            sleep(new Random().nextInt(1000));
            System.out.println(getName() + " finished meditating");
            eat();
        }

        @Override
        public void run(){
            try{
                meditate();
            }catch (InterruptedException e){
                e.printStackTrace();
            }
        }
    }

    public class Stick{
        private final Semaphore available = new Semaphore(1);

        public Stick(){}

        public void take() throws InterruptedException {
            available.acquire();
        }

        public void putDown(){
            available.release();
        }

    }

    public class Doorman{
        private final Semaphore doorman;

        public Doorman(int allow){
            doorman = new Semaphore(allow, true);
        }

        public void getIn() throws InterruptedException{
            doorman.acquire();
        }

        public void getOut(){
            doorman.release();
        }
    }
}
