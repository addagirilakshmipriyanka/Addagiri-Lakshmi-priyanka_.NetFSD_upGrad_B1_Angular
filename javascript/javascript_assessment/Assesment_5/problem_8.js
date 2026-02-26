
class Payment {
pay(amount) {
        console.log("Processing payment of ₹" + amount);
    }
}
class CreditCardPayment extends Payment {
pay(amount) {
    console.log("Paid ₹" + amount + " using Credit Card.");
    }
}
class UPIPayment extends Payment {
pay(amount) {
    console.log("Paid ₹" + amount + " using UPI.");
    }
}
class CashPayment extends Payment {
pay(amount) {
    console.log("Paid ₹" + amount + " in Cash.");
    }
}
let payments = [
new CreditCardPayment(),
new UPIPayment(),
new CashPayment()
];
payments.forEach(function(p) {
    p.pay(1000);
});