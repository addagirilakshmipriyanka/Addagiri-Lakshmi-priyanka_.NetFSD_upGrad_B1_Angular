class Shape {
    calculateArea() {
        console.log("Area not defined for this shape.");
    }
}
class Circle extends Shape {
constructor(radius) {
        super();
        this.radius = radius;
    }
calculateArea() {
let area = Math.PI * this.radius * this.radius;
        console.log("Circle Area is: " + area.toFixed(2));
    }
}
class Rectangle extends Shape {
constructor(length, width) {
        super();
        this.length = length;
        this.width = width;
    }
calculateArea() {
    let area = this.length * this.width;
    console.log("Rectangle Area is: " + area);
    }
}
class Triangle extends Shape {
constructor(base, height) {
    super();
    this.base = base;
    this.height = height;
    }
    calculateArea() {
    let area = 0.5 * this.base * this.height;
    console.log("Triangle Area is: " + area);
    }
}
let shapes = [
    new Circle(4),
    new Rectangle(5, 6),
    new Triangle(3, 8)
];
for (let shape of shapes) {
    shape.calculateArea();
}