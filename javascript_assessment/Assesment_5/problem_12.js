class Wallet {
    #balance = 0;  
    addMoney(amount) {
        this.#balance += amount;
        console.log("Added ₹" + amount);
    }
    spendMoney(amount) {
        if (amount > this.#balance) {
            console.log("Not enough balance.");
        } else {
            this.#balance -= amount;
            console.log("Spent ₹" + amount);
        }
    }
    getBalance() {
        return this.#balance;
    }
}
let myWallet = new Wallet();
myWallet.addMoney(2000);
myWallet.spendMoney(500);
console.log("Current Balance: ₹" + myWallet.getBalance());
