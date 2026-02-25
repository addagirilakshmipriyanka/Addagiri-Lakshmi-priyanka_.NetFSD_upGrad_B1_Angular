let employees = [
 { id:1, name:"Ravi", dept:"IT", salary:70000 },
 { id:2, name:"Anita", dept:"HR", salary:50000 },
 { id:3, name:"Karan", dept:"IT", salary:80000 },
 { id:4, name:"Meena", dept:"Finance", salary:60000 }
];
let totalSalary = employees.reduce((t, e) => t + e.salary, 0);
console.log(totalSalary);
let highest = employees.reduce((max, e) => e.salary > max.salary ? e : max);
let lowest = employees.reduce((min, e) => e.salary < min.salary ? e : min);
console.log(highest, lowest);
employees = employees.map(e =>
  e.dept === "IT" ? { ...e, salary: e.salary * 1.15 } : e
);
let grouped = employees.reduce((g, e) => {
  (g[e.dept] = g[e.dept] || []).push(e);
  return g;
}, {});
console.log(grouped);
let deptAvg = Object.keys(grouped).map(d => ({
  dept: d,
  avg: grouped[d].reduce((t, e) => t + e.salary, 0) / grouped[d].length
}));
console.log(deptAvg);
employees.sort((a, b) => b.salary - a.salary);
console.log(employees);
let afterTax = employees.map(e => ({ ...e, salary: e.salary * 0.9 }));
console.log(afterTax);
let avgSalary = totalSalary / employees.length;
let aboveAvg = employees.filter(e => e.salary > avgSalary);
console.log(aboveAvg);
let table = `<table border="1">
<tr><th>ID</th><th>Name</th><th>Dept</th><th>Salary</th></tr>
${employees.map(e => `<tr><td>${e.id}</td><td>${e.name}</td><td>${e.dept}</td><td>${e.salary}</td></tr>`).join("")}
</table>`;
console.log(table);