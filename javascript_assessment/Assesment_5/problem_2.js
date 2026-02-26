class BankAccount {
    constructor(accountHolder, balance) {
        this.accountHolder = accountHolder;
        this.balance = balance;
    }
    deposit(amount) {
        this.balance += amount;
        console.log(`₹${amount} deposited successfully.`);
    }
    withdraw(amount) {
        if (amount > this.balance) {
            console.log("Insufficient balance! Withdrawal failed.");
        } else {
            this.balance -= amount;
            console.log(`₹${amount} withdrawn successfully.`);
        }
    }
    checkBalance() {
        console.log(`Current Balance: ₹${this.balance}`);
    }
}
let acc1 = new BankAccount("Rahul", 5000);
acc1.deposit(2000);
acc1.withdraw(3000);
acc1.withdraw(6000);  
acc1.checkBalance();