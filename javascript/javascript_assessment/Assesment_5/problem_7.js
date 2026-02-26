class Animal {
    makeSound() {
        console.log("Animal makes a sound.");
    }
}
class Dog extends Animal {
    makeSound() {
        console.log("Dog says Woof Woof");
    }
}
class Cat extends Animal {
    makeSound() {
        console.log("Cat says Meow Meow");
    }
}
class Cow extends Animal {
    makeSound() {
        console.log("Cow says Moo Moo");
    }
}
let animals = [
    new Dog(),
    new Cat(),
    new Cow()
];
animals.forEach(function(a) {
    a.makeSound();
});