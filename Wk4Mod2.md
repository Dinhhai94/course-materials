## Advanced Functions
### `this`, closures, and callbacks

We've used quite a few functions up to this point in the course, and should have a good handle on how to create, modify, and invoke functions (with and without parameters), as well as understanding the differences between _side effects_ and _returned values_. But there's still more to learn!

---

### Functions as inputs

Functions are values, just like numbers, strings, arrays and objects. They can be saved to variables:

```javascript
var say_hi = function () {
  console.log('hi')
}

var greeter = say_hi

say_hi()
greeter()

say_hi = function () {
  console.log('meh')
}

say_hi() // ??
greeter() // ??
```

They can be passed as arguments (inputs) to functions:

```javascript
var runner = function (fn) {
  console.log('Invoking a function now!')
  fn()
}

runner( function(){ console.log('okay') } )
runner(say_hi)
runner(greeter)

runner( say_hi() ) // ??
```

---

### Exercise 1
#### `answerLogger`

Write a function `answerLogger` that takes a function as input, runs it, and places the return value from that function invocation into a `div#answer`.

1. We can test `answerLogger` using the following code, we should not need to change it at all.

  ```javascript
  // this should run if your answerLogger is correct!
  answerLogger(function(){
    return "I should appear in div#answer!"
  })
  ```

  HINT:
  ```javascript
  var answerLogger = function(fn){
    var answer = fn();

    $("#answer").text(answer);
  };
  ```

2. Expand your `answerLogger` function to allow for an array of functions, then run and append each of them. HINT:

  ```javascript
  var answerLogger = function(arr){
    $("#answer").html("<ol></ol>");

    arr.forEach( function(fn){
      var answer = fn();

      $("#answer > ol").append("<li>" + answer + "</li>");
    });
  };
  ```
---

### Functions as outputs

Not only can functions be passed as inputs, they can also be returned as outputs.

```javascript
var returnsFunction = function () {
  return function(){ console.log('BOOP!') }
}

// have we booped yet?
var booper = returnsFunction()

// how about now?
booper()
```

---

### Function Scope

Function define their own local scope. Variables declared within a function invocation are available only inside of that function. It's as if invocations are surrounded by one-way mirrors, they can see out and access variables named in their parent scope, but code running outside can't see in to access parameters or variables defined inside.

```javascript
var word = 'original'
var phrase = " is the word"

var word_changer = function (new_word) {
    var word = new_word
    console.log(word + phrase)
}

console.log(word + phrase) // ??
console.log(new_word + phrase) // ??
word_changer('changed')
console.log(word + phrase) // ??
console.log(new_word + phrase) // ??

// what's different here?
var leaky_word_changer = function (new_word) {
    word = new_word
    console.log(word + phrase)
}

leaky_word_changer('changed')
console.log(word + phrase) // ??
console.log(new_word + phrase) // ??
```

---

### Exercise 2
#### Secret Keeper

Use the same document or JSBin from Exercise 1 to try this out:

1. Write a function `secretKeeper` that defines a variable `secret` inside its code block. Try to access the secret variable from outside the function scope using your JS console. Make sure it's safe! HINT:
  ```javascript
  var secretKeeper = function(){
    var secret = "You can't find meeee";
  };
  ```
2. Allow the user to invoke `secretKeeper` with two strings as arguments. HINT:
  ```javascript
  var secretKeeper = function(string1, string2){
    var secret = "You can't find meeee";
  };
  ```
3. `append()` the two strings to the page with the secret word in between. HINT:
  ```javascript
  var secretKeeper = function(string1, string2){
    var secret = "You can't find meeee";
    var publicPhrase = string1 + " " + secret + " " + string2;

    $("#answer").append(publicPhrase);
  };
  ```

---

### Closure

Returned functions retain scope access at the point they were defined. This is called closure. The scope chain is established at the point WHERE THE KEYWORD `function` IS WRITTEN, not where it is invoked.

```javascript
var returnsFunction = function () {
  var word = 'I can see inside'
  return function(){ console.log('BOOP! ' + word) }
}

var word = 'I can see outside'

var newBooper = returnsFunction()
newBooper() // what does this log? why?

var returnsFunction = function () {
  var number = 5
  return function(){ console.log( "The number is: " + number) }
}

var number = 4
var fn = returnsFunction()
fn() // what will this log? why?

var runner = function(func){
  var number = 3
  func()
}

runner(fn) // what will this log? why?
```

---

### Exercise 3
#### Multipliers!

Write a function `multipliesBy` that takes a number as input and returns a function that, when invoked with a second number as an argument multiplies the two numbers together.

We can test `multipliesBy` with this code, we should not need to change it at all.
```javascript
var times5 = multipliesBy(5)
times5(4) // 20

var times10 = multipliesBy(10)
times10(32) // 320
```
If you need a HINT:

```javascript
var multipliesBy = function(num1){
  return function(num2) {
    return num1 * num2;
  }
};
```

---
