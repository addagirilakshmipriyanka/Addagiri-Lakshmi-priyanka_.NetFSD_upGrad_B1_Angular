class User {
    constructor(username) {
        this.username = username;
        this._password = "";
    }
    set password(value) {
        if (value.length >= 6) {
            this._password = value;
            console.log("Password set successfully.");
        } else {
            console.log("Password must be at least 6 characters.");
        }
    }
    get password() {
        return this._password;
    }
}
let user1 = new User("Priya");
user1.password = "12345";     
user1.password = "123456";    
console.log(user1.password);