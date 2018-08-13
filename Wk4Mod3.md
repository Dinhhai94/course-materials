## Advanced Objects
### Object-Oriented Programming and Design Patterns

Organizing code structures around Objects rather than functions is called Object-Oriented Programming (or OOP).

As we've seen already, Objects can have keys which are Strings, and values which can be any data type: Strings, Numbers, Arrays, Objects... even functions!

```javascript
var person = {
  name: 'Bob',
  location: 'Los Angeles',
  age: 56,
  hobbies: ['working', 'partying'],
  cat: {
    name: "mr fuzzles",
    hobbies: [ "being inert", "nudging things off tables" ]
  },
  party: function throwParty(){
    console.log('dance, dance, dance!')
  }
}
person.name
person.age

person.hobbies[0]
person.cat.name

person.party // what does this do?
person.party() // how about this?
```

And as we've briefly seen before, Objects can use the `this` keyword to access their calling context. Review the following in your console:

```javascript
function logContext(){
  console.log(arguments, this)
}

logContext("These are the arguments...", "What is the calling context? -->")
```

Now what happens when we call a function in the context of an Object?

```javascript
var obj = {
  key1: 'value 1',
  key2: 'value 2',
  method: function(){
    console.log("I'm being invoked in the context of...", this)
  }
}

obj.method();
```

So how is this useful?

```javascript
person.work = function work(){
    console.log("Welcome to McDonald's, I'm " + this.name + ". May I take your order?")
    console.log("Enjoy this beautiful day in " + this.location)
    console.log("Would you like to hear a story about " + this.cat.name + " and his " + this.cat.hobbies[1])
}

person.work()
```

---

### Exercise 1
#### Here in my car

We can also change our object properties by referencing them with `this`:

```javascript
var car = {
    type: "Honda Civic",
    position: 1,
    move: function move(){
        var prev = this.position;
        this.position = this.position + 1;
        console.log(this.type + " is moving from " + prev + " to " + this.position);
    }
}
```

1. Invoke car's `move` method and see what happens.
2. Invoke it a few more times. Then check its `position` property.
3. Add a `speed` property (an integer) to car.
4. When a car moves, adjust its position by adding its speed. HINT:
  ```javascript
  var car = {
    type: "Honda Civic",
    position: 1,
    speed: 8,
    move: function move(){
      var prev = this.position;
      this.position = this.position + this.speed;
      console.log(this.type + " is moving from " + prev + " to " + this.position);
    }
  }
  ```
5. Instead of defining the method inline, it can be useful to have it defined first and referenced as a variable in the object instantiation. This will allow us to share the function between multiple objects later. Try this out with the `move()` method. HINT:
  ```javascript
function moveCar(){
    var prev = this.position;
    this.position = this.position + this.speed;
    console.log(this.type + " is moving from " + prev + " to " + this.position);
  };

  var car = {
    type: "Honda Civic",
    position: 1,
    speed: 8,
    move: moveCar
  };
  ```
6. Now share the `moveCar` function with a brand new car object! Then try invoking the `.move()` method a few times. HINT:
  ```javascript
function moveCar(){
    var prev = this.position;
    this.position = this.position + this.speed;
    console.log(this.type + " is moving from " + prev + " to " + this.position);
  };

  var honda = {
    type: "Honda Civic",
    position: 1,
    speed: 8,
    move: moveCar
  };

  var lambo = {
    type: "Lamborghini Murcielago",
    position: 1,
    speed: 20,
    move: moveCar
  };

  honda.move();
  lambo.move();
  ```

### Design Patterns
#### The Decorator Pattern

When we pass an object as an input to a function which adds functionality to it, we call this code structure the _Decorator Pattern_.

```javascript
function addReverse(car){
    car.reverse = function reverse() {
      this.position = this.position - this.speed
    }
}

addReverse(car1);
addReverse(car2);
```
---

#### Factory Pattern

When we use a function to instantiate new Objects of a certain type, we call this code structure the _Factory Pattern_.

```javascript
function buildCar(type, speed) {
  var car = {};

  car.position = 0;
  car.type = type;
  car.speed = speed;

  car.move = function () {
    this.position += this.speed;
  };

  return car;
};

var newToyota = buildCar('Toyota Hilux', 3);
var newHonda = buildCar('Honda Accord', 5);
```

Try creating a car factory that can create car Objects like the ones you created already!

---
