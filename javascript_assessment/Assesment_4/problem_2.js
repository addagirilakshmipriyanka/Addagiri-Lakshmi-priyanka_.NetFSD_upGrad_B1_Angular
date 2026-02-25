let students = [
  { name: "Akhil", marks: 85 },
  { name: "Priya", marks: 72 },
  { name: "Ravi", marks: 90 },
  { name: "Meena", marks: 45 },
  { name: "Karan", marks: 30 }
];
let passed = students.filter(s => s.marks >= 40);
console.log(passed);
let distinction = students.filter(s => s.marks >= 85);
console.log(distinction);
let average = students.reduce((t, s) => t + s.marks, 0) / students.length;
console.log(average);
let topper = students.reduce((max, s) => s.marks > max.marks ? s : max);
console.log(topper);
let failedCount = students.filter(s => s.marks < 40).length;
console.log(failedCount);
let withGrades = students.map(s => ({...s,
  grade:
    s.marks >= 85 ? "A" :
    s.marks >= 60 ? "B" :
    s.marks >= 40 ? "C" : "Fail"
}));
console.log(withGrades);
let ranked = [...students]
  .sort((a, b) => b.marks - a.marks)
  .map((s, i) => ({ ...s, rank: i + 1 }));
console.log(ranked);
let removedLowest = [...students].sort((a, b) => b.marks - a.marks).slice(0, -1);
console.log(removedLowest);
let leaderboard = [...students].sort((a, b) => b.marks - a.marks);
console.log(leaderboard);