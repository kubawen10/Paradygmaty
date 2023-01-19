package zadanie2;

public class Account {
    private final int number;
    private double balance;

    public Account(int accountNumber, double accountBalance){
        number = accountNumber;
        balance = accountBalance;
    }

    public synchronized void deposit(double amount){
        balance += amount;
    }

    public synchronized double withdraw(double amount){
        if(balance - amount < 0){
            return 0;
        }else{
            balance -= amount;
            return amount;
        }
    }

    public synchronized void transfer(Account other, double amount){
        if(other == null){
            return;
        }
        if(withdraw(amount) == amount){
            other.deposit(amount);
        }
    }

    @Override
    public String toString() {
        return "Account number: " + number + " Balance: " + balance;
    }
}
