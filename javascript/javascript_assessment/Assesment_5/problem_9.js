class Product {
    constructor({ name, price, category = "General" }) {
        this.name = name;
        this.price = price;
        this.category = category;
    }
    getDetails = () => {
        console.log(`Product: ${this.name}`);
        console.log(`Price: ₹${this.price}`);
        console.log(`Category: ${this.category}`);
    };
}
let productData = {
    name: "Laptop",
    price: 50000
};
let newProduct = new Product({ ...productData });
newProduct.getDetails();