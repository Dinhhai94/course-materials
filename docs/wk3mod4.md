# Arrays and Functional Programming

We've seen Arrays since our first day of complex data types, and we've been using them in a number of different forms since then. We know that they associate data with _indices_, and we know that Arrays have a `length` property that comes in handy during loops. What other tricks do Arrays have in store for us?

## `Array.prototype.*` methods

Arrays have associated with them some properties, like `.length`, and methods, like `.push()`, to help us use our collections of data more effectively.

```javascript
const arr = ["stuff", "more stuff", "even more stuff"];

arr.length;

arr.push("More on the end!!!");
const lastItem = words.pop();

arr.unshift("More at the beginning!!");
const firstItem = words.shift();
```

## `.forEach()`

Up to this point, we've been using `while` loops to iterate over Arrays. But often it's cleaner to use Array's native `.forEach()` method to run a given function once for each item in the Array, passing that item in as an argument.

```javascript
function logMe(word) {
  console.log(`logging ${word}`);
}

words.forEach(logMe);
```

## Portfolio Project 2

### Replacing `while`

1. Let's turn the `while` loop in our `Navigation` component's `buildLinks` function into a `.forEach` loop instead! HINT:

   ```javascript
   function buildLinks(linkArray) {
     let i = 0;
     let links = "";
     let route = ""; // changed for clarity

     linkArray.forEach(link => {
       if (link !== "Home") {
         route = lowerCase(link);
       }

       links += `
         <li>
           <a href='/${route}' data-navigo>
             ${link}
           </a>
         </li>
       `;
     });

     return links;
   }
   ```

2. See if you can replace some of the other `while` loops you've created in the past with `.forEach`!

## Functional Programming

Since JavaScript treats functions as first-class citizens, it can be treated as more than just an imperative or Object Oriented language. Instead, we can program in a _functional_ paradigm, where all operations are functions that focus on returned values instead of side effects. There are libraries like Underscore, lodash, and Ramda that help expand JavaScript's built-in functional tools, but there are a few that ship with JS that we should know!

### `.map()`

Remember how `while` loops are avoided because of a floating count variable? e.g.

```javascript
let i = 0; // awkward counter
const limit = 10; // or some other number

while (i < limit) {
  // do something
  i++; // increments i outside of scope of while loop.
}
```

This is no good in large applications because that `i` variable could easily get away from us. It's a changing and `mutable` value that can't always be depended on \(i.e. _order matters_, which is generally not good\). One solution was the `forEach` loop, which kept everything nice and tidy!

But `.forEach` doesn't _actually_ solve all of `while`'s problems. Think about how many times we've done something like this:

```javascript
const myArray = [1, 2, 3, 4, 5];
const doubledNumbers = [];

myArray.forEach(function(num) {
  doubledNumbers.push(num * 2);
});
```

See how `doubledNumbers` is separated from the loop that populates it? It's the same order-specific implementation that we generally ought to avoid. What if, instead, we had a function that could create `doubledNumbers` directly? Well, we do! And that function is `.map()`, which is built into the `Array` data type. Try this:

```javascript
const myArray = [1, 2, 3, 4, 5];
const doubledNumbers = myArray.map(num => num * 2);

console.log(doubledNumbers);
```

Now there's no doubt that `doubledNumbers` comes from `myArray`, and there's no issue of order. The only state to keep track of is that of `myArray`, and that value should never change if we're programming functionally!

### `.filter()`

How about this scenario:

```javascript
const myArray = [1, 2, 3, 4, 5];
const oddNumbers = [];

myArray.forEach(num => {
  if (num % 2 !== 0) {
    oddNumbers.push(num);
  }
});
```

We can _filter_ values in the same way using the `.filter()` method! `.filter()` expects a `return` value that filters out some results.

```javascript
const myArray = [1, 2, 3, 4, 5];
const oddNumbers = myArray.filter(num => num % 2 !== 0);
```

## `.reduce()`

Of the three functions we're learning today, `reduce` is the most complex, but it's so useful that it's important to learn it! Let's think about this situation:

```javascript
const myArray = [1, 2, 3, 4, 5];
let myArraySum = 0; // variable that keeps a sum of all values in myArray

myArray.forEach(num => {
  myArraySum += num;
});
```

Now let's try to `.reduce()` this array from left to right in a similar way. `.reduce()` takes four possible arguments, but we're going to use the first two \(the running total, and the next value to add to that running total... [see the docs for more information](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/Reduce)\).

```javascript
const myArray = [1, 2, 3, 4, 5];
const myArraySum = myArray.reduce((total, currentValue) => {
  return total + currentValue;
});
```

## More Exercises:

1. Write a function that takes an array of values and returns an boolean representing if the word "hello" exists in the array.
2. Write a function that takes an array of values and a target value and returns how many times that target value exists in the array.
3. Write a function that takes an array and returns a new array containing only the values at odd indexes in that array.
4. Write a function called sumArray that takes an array of numbers and returns the sum of all of those numbers added together.

