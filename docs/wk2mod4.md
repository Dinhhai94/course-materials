# Complex functions

## Fun with Functions

### Delving Deeper in to Functions

We've already seen a variety of functions, from built-in functions like `console.log()`, to a few of our own built using `var functionName = function(){}`. We've also already learned how to _invoke_ or _execute_ functions with `()`, as well as passing in a few simple arguments \(like we've done with `prompt("some string")`\). Let's dig into these a bit deeper.

### a new syntax \(part 1\)

Up to this point, we've been writing functions like this:

```javascript
var someFunction = function someFunction() {};
```

While it's clear what's going on here, we have another way writing functions that's a bit cleaner. It's called a _named functional expression_, and it looks like this:

```javascript
function someFunction() {}
```

While there are some technical differences between the two ways of declaring functions, the latter is used much more widely than the former, and is generally a bit easier to read. As long as we treat the functional expression the same way we were treating it's `var`-based cousin, we should be fine \(and save ourselves a few keystrokes in the process\).

### the `return` keyword

Here's a function that `return`s a value without any side effects:

```javascript
function greeter() {
  return "Hello";
}

// saving the return value
var greeting = greeter();

// using the return value to compose larger expressions
console.log(`${greeting}, nice to meet you.`);

// what's the difference here?
console.log(`${greeter()}, nice to meet you.`);
```

The result of evaluating an expression consisting of a function reference followed by an invocation operator is the value to the right of the keyword `return` inside the function. Easy peasy, right?

```javascript
function sayingGenerator() {
  var phrase = "Heeey, it's the Fonz.";
  return phrase;
}

// What is the return value?
var saying = sayingGenerator();

function brokenSayingGenerator() {
  var phrase = "Heey, it's the Fonz.";
  phrase;
}

// What about now?
var brokenSaying = brokenSayingGenerator();
```

#### Portfolio Project 1:

Refactor every instance of `var someFunction = function()` across your portfolio project into a named functional expression. Be sure to double-check that we haven't caused any regressions!

### Arguments

During every function invocation, you have access to the `arguments` keyword, which contains all the inputs to the function invocation. Play with this concept until you're sure you understand it.

```javascript
function inspector() {
  console.log(arguments);
}

// try each invocation individually and ponder the result
inspector(3);

inspector(3 + 7);
inspector(3, 7);

inspector("hello");
inspector("hello", "how are you");

inspector("hello", 7, true, undefined, null, 3 + 12, "nice to" + " meet you");
```

### Exercise 1:

1. In your dev console, create a function `logAndReturn` that `console.log`s all of its inputs and then `return`s them. HINT:

```javascript
function logAndReturn() {
  console.log(arguments);

  return arguments;
}
```

1. Store the `return` value as a variable `returnedValues`. HINT:

```javascript
var returnedValues = logAndReturn();
```

1. Pass that variable as an argument to a second invocation of `logAndReturn`. HINT:

```javascript
logAndReturn(returnedValues);
```

### Parameters

It's unwieldy to work with the arguments keyword directly. Usually we use named parameters to give our inputs \(arguments\) variable names for the length of the function invocation

```javascript
function valueLogger(value) {
  console.log(value);
}

valueLogger("Howdy ho, neighborino!");

// parameters and variables defined in function invocations are local to that invocation
value; // ReferenceError: No variable 'value' exists

valueLogger(3 + 7);

// where's the seven?
valueLogger(3, 7);

function doubler(num) {
  return num * 2;
}

// is it ten?
var shouldBeTen = doubler(5);

function doubleValueLogger(value1, value2) {
  console.log(value1, value2);
}

doubleValueLogger("hello", "how are you");

// what is value2?
doubleValueLogger("hello");

function add(num1, num2) {
  return num1 + num2;
}

var sum = add(7, 12);
```

### Exercise 3

#### Simple Math

1. Write a function called `tripler` that takes a number and returns triple the value. HINT:

```javascript
function tripler(num) {
  return num * 3;
}
```

1. Create a function `multiply` that takes two numbers as inputs and returns their product. HINT:

```javascript
function multiply(num1, num2) {
  return num1 * num2;
}
```

1. Create a function `divide` that takes two numbers as inputs and returns the result of dividing the first by the second

```javascript
function divide(num1, num2) {
  return num1 / num2;
}
```

1. Create a function `remainder` that takes two numbers as inputs and returns the result of modulo the first by the second

```javascript
function remainder(num1, num2) {
  return num1 % num2;
}
```

1. Using only the functions you wrote above, and no operators, calculate the value of tripling 5, multiplying that by 12, dividing by 2 and then finding the remainder of dividing that by 3.

### Portfolio Project 2

#### Functional Components

Our component library currently consists of four top-level components. So far, these have worked well for our _landing_ page, but we don't yet have a way of using these components across different views. Let's change that by turning these components into more flexible _functional_ components that return markup for us to use.

1. Let's start with the `Header` component, since that will almost always need to change in response to the current page. The first thing that we should do is `export` a `function` that `return`s the original HTML string. Something like:

```javascript
export default function Header() {
  return `
        <div id="header">
            <h1>Welcome to Alex's Savvy Coders Portfolio Project!</h1>
        </div>
    `;
}
```

...which we can use in our `index.js` file with:

```javascript
document.querySelector("#root").innerHTML = `
      ${Navigation}
      ${Header()} // notice the invocation here
      ${Content}
      ${Footer}
    `;
```

1. We should try to think of our components as pure, "dumb" expressions of the state of our application. That application state could eventually get pretty complicated, so let's think of that state as an Object that can eventually store lots of data for us. Let's create that state Object in `index.js`, then pass that state to our component. In `index.js`:

```javascript
var state = {
  title: "Welcome to Alex's Savvy Coders Portfolio"
};

document.querySelector("#root").innerHTML = `
      ${Navigation}
      ${Header(state)} // notice the use of state
      ${Content}
      ${Footer}
    `;
```

...and in `Header.js`:

```javascript
export default function Header(state) {
  return `
        <div id="header">
            <h1>${state.title}</h1>
        </div>
    `;
}
```

1. Let's turn every other component into a functional component to be invoked with a `state` argument \(even if we don't actually respond to any part of that state just yet\). By the time we're done, our application markup generator should look like:

```javascript
document.querySelector("#root").innerHTML = `
      ${Navigation(state)}
      ${Header(state)}
      ${Content(state)}
      ${Footer(state)}
    `;
```

To make this a bit more useful, we need to learn a bit more about how users can interact with our application through [Events](https://developer.mozilla.org/en-US/docs/Web/Events).

### Events

An _event handler_ is a function that is run when some pre-defined "event" occurs in the browser. Try to make the following work in the dev console while inspecting your Portfolio Project:

```javascript
function sayHey() {
  console.log("heeey");
}
// Alternately, we can ask the browser to run it at a later time

// The below is called an event handler, take a guess at what it does...
// Add it to an HTML document containing a div#target and test it out
document.querySelector("#target").addEventListener("click", sayHey);

// Often times, instead of using a variable, we'll just define the function inline
document
  .querySelector("#target")
  .addEventListener("click", function saySameDeal() {
    console.log("same deal");
  });
```

### A new syntax \(part 2\)

When a function is used as a callback, it's often written inline as in the example above. These function traditionally don't have names of their own, and are instead referred to as **anonymous functions**.

As you see in the examples above, they can be fairly tedious to write out. To help with this \(and with the binding of the `this` keyword, which we'll cover later\), JavaScript has given us a new syntax for anonymous functions called "arrow" syntax. It looks like this:

```javascript
// original syntax
document.querySelector("div").addEventListener("click", function logOnClick() {
  console.log("A div has been clicked!");
});

// arrow function
document
  .querySelector("div")
  .addEventListener("click", () => console.log("A div has been clicked"));
```

## Portfolio Project 3

See if you can add some `click` event listeners that log different page names to the console when a navigation bar link is clicked. HINT: be sure to add your event listeners _after_ the `innerHTML` of the `#root` element has been set!

