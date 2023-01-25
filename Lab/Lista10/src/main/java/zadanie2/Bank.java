package zadanie2;

import java.util.ArrayList;
import java.util.Random;

public class Bank {
    private final ArrayList<Account> accounts;
    private final ArrayList<Client> clients;
    private final int openingTime; //represents time of simulation in seconds

    public Bank(int openingTime){
        this.openingTime = openingTime;
        accounts = new ArrayList<>();
        clients = new ArrayList<>();
    }

    //starting threads
    public void openBank() throws InterruptedException {
        for (int i = 0; i < clients.size(); i++) {
            clients.get(i).start();
        }
        for (int i = 0; i < clients.size(); i++) {
            clients.get(i).join();
        }
    }

    public void printAccounts(){
        for (int i = 0; i < accounts.size(); i++) {
            System.out.println(accounts.get(i));
        }
    }

    public void addClient(double initialBalance){
        if(initialBalance < 0){
            initialBalance = 0;
        }
        Account newAccount = new Account(accounts.size(), initialBalance);
        Client newClient = new Client(this, newAccount);

        accounts.add(newAccount);
        clients.add(newClient);
    }

    public Account getAccount(int accountNumber){
        if(accountNumber < accounts.size() && accountNumber >= 0){
            return accounts.get(accountNumber);
        }
        return null;
    }

    public int getOpeningTime(){
        return openingTime;
    }

    public int getNumberOfAccounts(){
        return accounts.size();
    }

    public static void main(String[] args) throws InterruptedException {
        Bank bank = new Bank(5);

        Random r = new Random();

        int initialMaxBalance = 1000;
        for (int i = 0; i < 10; i++) {
            bank.addClient(r.nextDouble() * initialMaxBalance);
        }
        bank.printAccounts();
        bank.openBank();
        bank.printAccounts();
    }
}
