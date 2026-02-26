class Student {
    constructor(name) {
        this.name = name;
        this.marks = [];
    }
    addMark(mark) {
        this.marks.push(mark);
        console.log(`Mark ${mark} added.`);
    }
    getAverage() {
        let sum = 0;
        for (let mark of this.marks) {
            sum += mark;
        }
        return sum / this.marks.length;
    }
    getGrade() {
        let avg = this.getAverage();

        if (avg >= 90) return "A";
        else if (avg >= 75) 
            return "B";
        else if (avg >= 50)
             return "C";
        else
             return "Fail";
    }
}
let s1 = new Student("Priya");
s1.addMark(85);
s1.addMark(92);
s1.addMark(78);
console.log("Average:", s1.getAverage());
console.log("Grade:", s1.getGrade());