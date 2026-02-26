let sales = [1200, 1500, 900, 1800, 2000, 1100, 1700];
let total = 0;
let best = sales[0];
let worst = sales[0];
for (let i = 0; i < sales.length; i++) {
    total += sales[i];
if (sales[i] > best) {
        best = sales[i];
    }
    if (sales[i] < worst) {
    worst = sales[i];   }
}
console.log("Total Weekly Sales =", total);
console.log("Best Day Sales =", best);
console.log("Worst Day Sales =", worst);
