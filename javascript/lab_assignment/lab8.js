let prices = [250, 400, 300, 200, 150];
let total = 0;
for (let i = 0; i < prices.length; i++) {
    total += prices[i];
}
let discount = 0;
let finalAmount = total;
if (total > 1000) {
    discount = total * 0.10;
    finalAmount = total - discount;
}
console.log("Total Amount:", total);
console.log("Discount:", discount);
console.log("Final Amount:", finalAmount);
