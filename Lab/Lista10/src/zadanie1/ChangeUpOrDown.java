package zadanie1;

import java.util.Random;

public class ChangeUpOrDown extends Thread {
    private final long secondsToLive;
    private final static Random random = new Random();

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
            value += 1;
        }else{
            value -= 1;
        }
    }

    public static void main(String[] args) throws InterruptedException {
        int numberOfThreads = 10;
        int seconds = 10;

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
    }
}
