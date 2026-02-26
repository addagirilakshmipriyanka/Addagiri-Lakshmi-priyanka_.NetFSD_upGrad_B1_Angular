let cart = [
  { id: 1, product: "Laptop", price: 60000, qty: 1 },
  { id: 2, product: "Headphones", price: 2000, qty: 2 },
  { id: 3, product: "Mouse", price: 800, qty: 1 }
];
let total = cart.reduce((t, i) => t + i.price * i.qty, 0);
console.log(total);
cart = cart.map(i => i.id === 2 ? { ...i, qty: i.qty + 1 } : i);
cart = cart.filter(i => i.id !== 3);
cart = cart.map(i => i.price > 10000 ? { ...i, price: i.price * 0.9 } : i);
cart.sort((a, b) => (a.price * a.qty) - (b.price * b.qty));
let costly = cart.some(i => i.price > 50000);
console.log(costly);
let allInStock = cart.every(i => i.qty > 0);
console.log(allInStock);
let invoice = cart.map(i => `${i.product} x${i.qty} = ₹${i.price * i.qty}`).join("\n");
console.log(invoice);
let expensive = cart.reduce((max, i) => i.price > max.price ? i : max);
console.log(expensive);
let gst = total * 0.18;
console.log(gst);