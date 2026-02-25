let books = [
  { id: 1, title: "JavaScript Basics", price: 450, stock: 10 },
  { id: 2, title: "React Guide", price: 650, stock: 5 },
  { id: 3, title: "Node.js Mastery", price: 550, stock: 8 },
  { id: 4, title: "CSS Complete", price: 300, stock: 12 }
];
books.map(b => console.log(b.title));
let totalValue = books.reduce((t, b) => t + (b.price * b.stock), 0);
console.log(totalValue);
let costlyBooks = books.filter(b => b.price > 500);
console.log(costlyBooks);
books = books.map(b => ({ ...b, price: Math.round(b.price * 1.05) }));
books.sort((a, b) => a.price - b.price);
books = books.filter(b => b.id !== 2);
let outOfStock = books.some(b => b.stock === 0);
console.log(outOfStock);
let grouped = books.reduce((g, b) => {
  let r = b.price <= 400 ? "Low" : b.price <= 600 ? "Medium" : "High";
  (g[r] = g[r] || []).push(b);
  return g;
}, {});
console.log(grouped);
let discounted = books.map(b =>
  b.price > 600 ? { ...b, price: Math.round(b.price * 0.9) } : b
);
console.log(discounted);
let invoice = books.map(b => `${b.title} - ₹${b.price}`).join("\n");
console.log(invoice);