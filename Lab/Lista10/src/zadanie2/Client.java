package zadanie2;

import java.util.Random;

public class Client extends Thread{
    private final Bank bank;
    private Account account;
    private final Random random;

    public Client(Bank bank, Account account){
        this.bank = bank;
        this.account = account;

        random = new Random();
    }

    @Override
    public void run(){
        long startTime = System.currentTimeMillis();

        while((System.currentTimeMillis() - startTime) / 1000 < bank.getOpeningTime()){
            double amount = random.nextDouble() * 500;
            //3 actions: deposit, withdraw, transfer
            int action = random.nextInt(3);


            switch(action){
                case 0:
                    //System.out.println("Client " + getName() + " deposits " + amount);
                    account.deposit(amount);
                    break;

                case 1:
                    //System.out.println("Client " + getName() + " withdraws " + amount);
                    account.withdraw(amount);
                    break;
                case 2:
                    //System.out.println("Client " + getName() + " transfers " + amount);
                    int numberOfAccount = random.nextInt(bank.getNumberOfAccounts());
                    account.transfer(bank.getAccount(numberOfAccount), amount);
                    break;
            }
            try {
                Thread.sleep(1500);
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
        }
    }
}
