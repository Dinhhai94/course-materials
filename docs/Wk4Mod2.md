## Object-Oriented Programming

Organizing code structures around Objects rather than functions is called Object-Oriented Programming (or OOP).

As we've seen already, Objects can have keys which are Strings, and values which can be any data type: Strings, Numbers, Arrays, Objects... even functions!

```javascript
const person = {
  name: "Bob",
  location: "Los Angeles",
  age: 56,
  hobbies: ["working", "partying"],
  cat: {
    name: "mr fuzzles",
    hobbies: ["being inert", "nudging things off tables"]
  },
  party: function throwParty() {
    console.log("dance, dance, dance!");
  }
};
```

There are a number of powerful additions to this basic understanding of Objects that allow us to more meaningfully group the _data_ that represents a thing to the _actions_ (called "methods") that operate on or are associated with those other pieces of data.

### Methods and `this`

In the example above, `party` is a `function`. If a `function` is attached to an Object, we refer to that `function` as a _method_. While it's perfectly valid to notate the `party` method as above, we can also use a shorter syntax:

```javascript
const person = {
  // other properties here

  party() {
    console.log("dance, dance, dance");
  }
}
```

And we can call this method by invoking `person.party()`. But what does this give us (besides a bit of organizational and semantic clarity)?

One of the big benefits of attaching methods to Objects is access to the _calling context_ (or parent Object) of that method through the `this` keyword. See if you can get the following to work:

```javascript
const person = {
  name: "Bob",

  // other properties and methods

  greet(){
    console.log(`Hi, my name is ${this.name}`);
  }
};
```

`this` is a tough concept in JavaScript, but the thing to remember: `this` refers to the _calling context_ of a `function`. Which, as a matter of fact, is always an Object of some sort. Try this regular `function`:

```javascript
function logDefaultContext(){
  console.log(`what's this? -> ${this}`);
}
```

You should find that the above `function`, which doesn't appear to be attached to any Object, does have a default calling context that's built into the browser. What's the value of that context?

---

### Exercise 1

#### Here in my car

We can also change an Object's properties by referencing them with `this`:

```javascript
const car = {
  type: "Honda Civic",
  position: 1,
  move() {
    let prev = this.position;
    this.position = this.position + 1;
    console.log(`${this.type} is moving from ${prev} to ${this.position}`);
  }
};
```

1. Invoke `car`'s `move` method and see what happens.
2. Invoke it a few more times. Then check its `position` property.
3. Add a `speed` property (an integer) to car.
4. When a car moves, adjust its position by adding its speed. HINT:

```javascript
const car = {
  type: "Honda Civic",
  position: 1,
  speed: 8,
  move() {
    let prev = this.position;
    this.position = this.position + this.speed;
    console.log(`${this.type} is moving from ${prev} to ${this.position}`);
  }
};
```

---

### Constructor `function`s

The car example above works well as long as we're dealing with a single type of car. But what if we'd like to share properties and methods of cars amongst a number of more specific types of cars? To put it another way: how can we treact "car" as a category of things, and than create specific _instances_ of that category later on? The answer is to _construct_ an _instance_ of a car Object. One way that we can do that is with something called a _constructor `function`_, which might look like this:

```javascript
// constructor names are capitalized by convention
function Car(type, speed){
  // to what does "this" refer?

  this.position = 1;
  this.type = type;
  this.speed = speed;
}
```

This constructor gives us the ability to create a specific instance of this more general `Car` idea. To create that instance, we need to use a keyword that we saw previously when we set up our client side router: `new`. Try the following:

```javascript
const civic = new Car("Honda Civic", 8);
const camry = new Car("Toyota Camry", 7);
```

What are the data types of `civic` and `camry`? Hopefully, they're Objects that have similar properties (`speed`, `type`, and `position`).

---

### `prototype` and inheritance

But what of our `move()` method? These newly-constructed cars have a consistent set of properties, which is nice, but they don't yet share a consistent set of behaviors. We _could_, if we wanted to, define a `move` function on the constructor. But it's more ideomatic for each `Car` to _inherit_ behaviors.

Most OOP languages have a concept of inheritance. JavaScript is a bit unique among programming languages in that Objects inherit behaviors from something called a `prototype`. Every Object has at least one `prototype`, which is itself an Object. Every instance of constructed Object has a prototype that is inherited from its constructor. To put it another way: if you look at the `__proto__` property of your `civic` Object in your developer tools, you should see that `__proto__` (short for `prototype`) is listed as `Car`. `Car`, too, has its own `__proto__`, which is listed as `Object`. And that `Object` `prototype` has a number of methods attached to it that can be implemented by _any_ Object in JavaScript.

This is what we refer to as a `prototype` chain! Every Object can (and does) inherit behavior from the `prototype` chain, even without explicit instantiation in a constructor.

This is all well and good, but how do we implement new, shared behavior for our instances of `Car`? The answer is that we modify the `Car`'s attached `prototype` Object directly:

```javascript
Car.prototype.move = function move(){
  // what is "this"?
  let prev = this.position;
  this.position = this.position + this.speed;
  console.log(`${this.type} is moving from ${prev} to ${this.position}`);
}
```

Now you should notice the following:

1. `civic.move()` and `camry.move()` work without modifying the constructor or re-instantiating our individual cars.
2. the `this` in `move` still refers to the correct instance! This is why `this` is referred to as a `function`'s _calling context_: it matches the Object that _calls_ the function, rather than the Object to which that `function` is directly attached (which is, in this case, `Car.prototype`)

> NOTE: Try creating an Array. Notice that any Array that you create has a `prototype` chain, too. What does that tell us about Arrays?

---

### `class`

For decades, Object-Oriented Programming in JavaScript was built around constructor `function`s and direct `prototype` modification. This worked, but was very cumbersome to write and maintain when compared to other programming languages. To make OOP a bit easier for web developers, JavaScript now has a `class` keyword that allows us to re-write our `Car` constructor + `prototype` mangling as follows

```javascript
class Car {
  // this constructor should look familiar
  constructor(type, speed){
    this.position = 1;
    this.type = type;
    this.speed = speed;
  }

  // this attaches move to the Car prototype
  move() {
    let prev = this.position;
    this.position = this.position + this.speed;
    console.log(`${this.type} is moving from ${prev} to ${this.position}`);
  }
}
```

Now all of our data and logic is organized in one spot once again! But now, perhaps, you're imagining deeper `prototype` chains, with `class`es inheriting behaviors from other `class`es. Now you can more easily implement something like this by using the `extend` keyword. Let's try to create a class of `Dragster` that inherits some behavior from the more general `Car` class, like so:

```javascript
class Dragster extends Car {
  constructor(speed){
    // super calls the constructor from Car
    super("dragster", speed)
  }

  pitStop(){
    console.log(`Making a pit stop at ${this.position}`);
  }
}

const dragster = new Dragster(100);

dragster.move(); // still works!
dragster.pitStop(); // has access to same calling context
```

Try a few more examples with other categories of things that we might represent abstractly with Objects and `class`es. Maybe Users, Actions, Components, or Forms... the possibilities are endless!

---

### Portfolio Project 1

#### `Store` and uni-directional data flow

Up to this point, we've been using a Plain Ol' JavaScript Object (sometimes called a "POJO") to hold all of our application state. This is an important pattern that we should continue to use! Unfortunately, the rules that govern how that state changes is pretty lax, and is scattered throughout the application. Let's refactor that state into a `class` that manages both application data and how that application data is modified.

1. Instead of `export`-ing a number of different pieces of our state tree from `store/index.js`, let's `export` a single `class` called `Store` by default. Something like:

   ```javascript
   export default class Store {};
   ```

2. Next, we'll need to create a `constructor` that bundles up all of the pieces of state that we were previously exporting into an internal `state` property, e.g.:

   ```javascript
   export default class Store {
     constructor(){
       this.state = {
         Home: Home,
         Blog: Blog,
         // etc etc
       }
     }
   }
   ```

3. Now we should be able to replace our `import * as State` line in our projects's main `index.js` file with a single `import Store from './store'`. Then we can create a new store with:

   ```javascript
   const store = new Store();
   ```

4. We _could_, at this point, access `store.state` directly. But it's better if we restrict direct access to the `state` if we can. This will make our implementation of `state` easier to change later if we want, _decoupling_ our state from the use of that state in our application. To do that, we're going to implement a pattern that we've seen before when dealing with `event`s called the Listener pattern. One way to think about this pattern is to say that our application will _listen_ for changes in _state_. Let's create an Array of listeners managed by our Store like so:

   ```javascript
   export default class Store {
     constructor(){
       this.listeners = [];
       this.state = {
         // same state stuff
       };
     }

     addStateListener(listener){
       // listener should be a function
       this.listeners.push(listener);
     }
   }
   ```

5. Thinking about how listeners work, it makes sense that _render_ is the primary listener of application state, i.e. when state updates, we want to re-render! So add the following to the bottom of your main `index.js` file before the `router` is configured or activated:

   ```javascript
   store.addStateListener(render);

   // router stuff here
   ```

6. At this point, we have a state to update, and we have a way of adding functions that should be called when that state updates, but we don't yet have a way of updating that state. The way that we're going to update state is with a special method called `dispatch`. The idea here is that we're going to _dispatch_ an _action_ that will modify our application state and call our listeners with our newly-updated state:

   ```javascript
   export default class Store {
     constructor {
       this.listeners = [];
       this.state = {
         // state stuff
       };
     }

     addStateListener(listener){
       this.listeners.push(listener);
     }

     dispatch(reducer){
       // a reducer is a pure function
       // it takes in state and returns a new state
       this.state = reducer(this.state);

       // call each listener with updated state
       this.listeners.forEach(listener => listener(this.state));
     }
   }
   ```
7. Now, every change that we make to state can be done through `store`'s `dispatch` method! The only requirement is that we pass in a valid `reducer`, where a `reducer` is a pure `function` that takes in a state and returns a new state. So `handleRoute` might be refactored into something like this:

   ```javascript
   function handleRoute(params) {
     store.dispatch(state => assign(state, { active: params.page }));
   };
   ```

You should now be able to represent every change in your application as a s`reducer` `function` passed to `store.dispatch` as an argument. See if you can make that work across you portfolio project!
