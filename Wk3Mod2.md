## Fun with Functions
### Delving Deeper in to Functions

We've already seen a variety of functions, from built-on functions like `console.log()`, to functions from external libraries like `$()` from jQuery, to a few of our own built using `var functionName = function(){}`. We've also already learned how to _invoke_ or _execute_ functions with `()`, as well as passing in a few simple arguments (like we've done with `.css("property", "value")`). Let's dig into these a bit deeper.

---
### a new syntax (part 1)

Up to this point, we've been writing functions like this:

```javascript
var someFunction = function someFunction(){}
```

While it's clear what's going on here, we have another way writing functions that's a bit cleaner. It's called a _named functional expression_, and it looks like this:

```javascript
function someFunction(){}
```

While there are some technical differences between the two ways of declaring functions, the latter is used much more widely than the former, and is generally a bit easier to read. As long as we treat the functional expression the same way we were treating it's `var`-based cousin, we should be fine (and save ourselves a few keystrokes in the process).


### the `return` keyword

Here's a function that `return`s a value without any side effects:

```javascript
function greeter() {
  return 'Hello'
}

// saving the return value
var greeting = greeter();

// using the return value to compose larger expressions
console.log( greeting + ", nice to meet you." )

// what's the difference here?
console.log( greeter() + ", nice to meet you." )
```
The result of evaluating an expression consisting of a function reference followed by an invocation operator is the value to the right of the keyword `return` inside the function. Easy peasy, right?

```javascript
function sayingGenerator() {
  var phrase = "Heeey, " + "it's the " + " Fonz."
  return phrase
}

// What is the return value?
var saying = sayingGenerator()

function brokenSayingGenerator() {
  var phrase = "Heeey, " + "it's the " + " Fonz."
  phrase
}

// What about now?
var brokenSaying = brokenSayingGenerator()
```

### Exercise 1
### Testing Your Choose-Your-Own-Adventure Choices

When we left our Choose-Your-Own-Adventure game, we had a `runStory` function that looked like this:

```javascript
function runStory( branch ){
    var chapter = story[branch];
    var choices = chapter.choices;
    var isValidChoice = false;
    var choice;

    if( choices ){
        choice = prompt( chapter.text );

        for( var i = 0; i < choices.length; i++ ){
            if( choice === choices[i] ){
                isValidChoice = true;
            }
        }

        if( isValidChoice ){
            runStory( choice );
        }
        else{
            runStory( branch );
        }
    }
    else{
        document
            .querySelector( "#output" )
            .textContent = chapter.text;
    }
};
```

While this works, it has a complexity (or number of possible branches) of more than 4. This is tough to read and tough to debug. How can we reduce the complexity of this function through `return` values?

1. Let's start with choice validation. How can we wrap up the choice-checking logic in a function that `return`s a single Boolean value? How about:

```javascript
function validateChoice( choice, choices ){
  var isValidChoice = false;

  for( var i = 0; i < choices.length; i++ ){
      if( choice === choices[i] ){
          isValidChoice = true;
      }
  }

  return isValidChoice;
}
```

2. Once we've re-written our `validateChoice` logic, we can refactor `runStory` into something like this:

```javascript
function runStory( branch ){
    var chapter = story[branch];
    var choices = chapter.choices;
    var choice;

    if( choices ){
        choice = prompt( chapter.text );

        if( validateChoice( choice, choices ) ){
            runStory( choice );
        }
        else{
            runStory( branch );
        }
    }
    else{
        document
            .querySelector( "#output" )
            .textContent = chapter.text;
    }
};

```

Notice how we're able to use the `return`ed value from `validateChoice` as the truthy (or falsey) value in our second `if` statement. That should knock down our complexity a notch while letting us abstract away our choice logic for the future. Now we can manipulate our choice-checking logic however we'd like without touching our original `runStory` function. Pretty cool! But what else can we do to make this function simpler?

How about getting rid of the nested `if` statement entirely? Let's try it!

```javascript
function handleChoices( choices ){
    var choice = prompt( chapter.text );

    if( validateChoice( choice, choices ) ){
        runStory( choice );
    }
    else{
        runStory( branch );
    }
}

function runStory( branch ){
    var chapter = story[branch];
    var choices = chapter.choices;

    if( choices ){
        handleChoices( choices );
    }
    else{
        document
            .querySelector( "#output" )
            .textContent = chapter.text;
    }
};
```

Now we have the additional mental overhead of multiple functions, with the added benefit of clearer intent and less per-function complexity. What do you think?

---

### Arguments

During every function invocation, you have access to the `arguments` keyword, which contains all the inputs to the function invocation. Play with this concept until you're sure you understand it.

```javascript
function inspector() {
  console.log( arguments )
}

// try each invocation individually and ponder the result
inspector(3)

inspector(3 + 7)
inspector(3, 7)

inspector("hello")
inspector("hello" + " " + "how are you")
inspector("hello", "how are you")

inspector("hello", 7, true, undefined, null, 3 + 12, "nice to" + " meet you")
```

### Exercise 2:

1. In your dev console, create a function `logAndReturn` that `console.log`s all of its inputs and then `return`s them. HINT:

```javascript
function logAndReturn(){
  console.log(arguments);

  return arguments;
}
```

2. Store the `return` value as a variable `returnedValues`. HINT:

```javascript
var returnedValues = logAndReturn();
```

3. Pass that variable as an argument to a second invocation of `logAndReturn`. HINT:

```javascript
logAndReturn( returnedValues );
```

---

### Parameters
It's unwieldy to work with the arguments keyword directly. Usually we use named parameters to give our inputs (arguments) variable names for the length of the function invocation

```javascript
function valueLogger(value) {
  console.log(value)
}

valueLogger("Howdy ho, neighborino!")

// parameters and variables defined in function invocations are local to that invocation
value     // ReferenceError: No variable 'value' exists


valueLogger(3 + 7)

// where's the seven?
valueLogger(3, 7)

function doubler(num) {
  return num * 2
}

// is it ten?
var shouldBeTen = doubler(5)

function doubleValueLogger(value1, value2) {
  console.log(value1, value2)
}

doubleValueLogger("hello", "how are you")

// what is value2?
doubleValueLogger("hello")

function add(num1, num2){
  return num1 + num2
}

var sum = add(7, 12)
```

### Exercise 3
#### Simple Math

1. Write a function called `tripler` that takes a number and returns triple the value. HINT:

```javascript
function tripler( num ){
  return num * 3;
}
```
2. Create a function `multiply` that takes two numbers as inputs and returns their product. HINT:

```javascript
function multiply( num1, num2 ){
  return num1 * num2;
}
```
3. Create a function `divide` that takes two numbers as inputs and returns the result of dividing the first by the second

```javascript
function divide( num1, num2 ){
  return num1 / num2;
}
```

4. Create a function `remainder` that takes two numbers as inputs and returns the result of modulo the first by the second

```javascript
function remainder( num1, num2 ){
  return num1 % num2;
}
```

5. Using only the functions you wrote above, and no operators, calculate the value of tripling 5, multiplying that by 12, dividing by 2 and then finding the remainder of dividing that by 3.

---

### Portfolio Project 1
#### Sentence Scrambler

Nice work with functions today! For our last activity, we'll implement a Sentence Scrambler as one of our Portfolio Exercises. Build a new page with a `<div id="output">`, and then add the following in a `scrambler.js` file attached to your new page:

1. Write a function called `stringPrinter` that takes a string as an argument and uses `textContent` to place it into a specific `<div>` on the web page. HINT:

```javascript
function stringPrinter( starterString ){
  document.querySelector('#output').textContent = starterString;
}
```
2. Call `starterString` multiple times with different strings from the console.
3. Does `starterString` use a side effect or a return value?
4. Write a function called `funnySentence` that takes a noun, an adjective, a verb, and an adverb as inputs, and constructs a string of html text and uses `$('#output').append()` to place it on the page. HINT:

```javascript
function funnySentence( noun, adjective, verb, adverb ){
  var sentence = "The " + adjective + " " + noun + " " + verb + " " + adverb + ".";

  stringPrinter(sentence);
};

```
5. Put each word argument you pass in into spans that have css rules that styles them differently to make them stand out.
6. Invoke `funnySentence` 5 times.
Extra Credit: Create a version of `funnySentence` that takes no inputs, but rather constructs a funny sentence on its own from an array of randomly-chosen words
