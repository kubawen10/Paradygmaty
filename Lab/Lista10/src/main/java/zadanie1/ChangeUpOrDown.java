package zadanie1;

import java.util.Random;

public class ChangeUpOrDown extends Thread {
    private final long secondsToLive;
    private final static Random random = new Random();
    private static long changes = 0;

    private static int value = 0;

    public ChangeUpOrDown(long secondsToLive){
        this.secondsToLive = secondsToLive;
    }

    @Override
    public void run() {
        long startTime = System.currentTimeMillis();
        while((System.currentTimeMillis() - startTime) / 1000 < secondsToLive){
            change();
        }
    }

    private synchronized void change(){
        if(random.nextBoolean()) {
            //System.out.println("+: " + value + " -> " + (value+1));
            value += 1;
        }else{
            //System.out.println("-: " + value + " -> " + (value-1));
            value -= 1;
        }
        changes++;

//        try {
//            sleep(100);
//        } catch (InterruptedException e) {
//            e.printStackTrace();
//        }
    }

    public static void main(String[] args) throws InterruptedException {
        int numberOfThreads = 10;
        int seconds = 20;

        Thread[] threads = new Thread[numberOfThreads];

        for (int i = 0; i < threads.length; i++) {
            threads[i] = new ChangeUpOrDown(seconds);
        }
        for (int i = 0; i < threads.length; i++) {
            threads[i].start();
        }
        for (int i = 0; i < threads.length; i++) {
            threads[i].join();
        }

        System.out.println(ChangeUpOrDown.value);
        System.out.println(changes);

        System.out.println(value/(double)changes);
    }
}
