## Intro to JavaScript pt. 2
### complex data types and DOM interactions

After the last module, we've mastered the art of the irritating pop-up. But how do we add more complex functionality to our `.js` projects? And how do we make that added complexity appear in the visible fold?

### Exercise 0
#### Setting up your Linter

Now that we're editing standalone JavaScript files, we get to use one of the most important tools in the developer's arsenal: the _linter_. This tool will point at grammatical and syntactical errors in our JavaScript as we write it, and fix most errors on save (rather than forcing us to chase down wayward commas, parens, or curly brackets).

We already downloaded the `linter-eslint` package, but this package needs a special configuration file to work. This file is called `.eslintrc.json`, and provides hundreds of customizeable rules to help you maintain a consistent JavaScript style. For the remainder of this course, we'll use the `.eslintrc` file found [here](./.eslintrc.json). You may copy this file into your own project directory, and you should immediately start getting hints from your editor as you type. Pay attention to these warnings, and your code should be free of an entire class of basic typing errors!

### Exercise 1
#### Complex Data Types

Let's revisit some of the Primitive Data types we covered in the last module:

1. __String__, e.g. `"Hello", "1", or ""`
2. __Number__, e.g. `1`, `1239`, `1.2`, or `1e4`
3. __Boolean__, e.g. `true` or `false`
4. `undefined` <- that's, right _undefined_. In JavaScript, undefined values have their own data type!

Primitive data types like we covered in the last module are meant to represent a single piece of discrete data. It can be a large piece (think of War and Peace as a single String), but it's still just one item.

Complex or Composite data types represent **Collections** of data. The Complex data types of JavaScript are Array and Object. We'll dig much deeper into both of these data types later, but for now, let's learn how to construct them using *Literal Notation*.

**Arrays** are ordered lists of data. The data can be of any type, including String, Number, Boolean, `undefined`, or even variables and functions. We can create a variable of type Array like so:

```javascript
//try this out in your console!
var myArray = [ 'String', 23, 'Another String', true, false ];
console.log( myArray );
```

Now try same thing with a mixture of variables and literals:

```javascript
var myString = 'String';
var myNum = 23;
var myBoo = true;
var myUndef;

var myArray =  [myString, myNum, 'Another String', myBoo, myUndef, false ];
console.log( myArray );
```
The output should be exactly the same for both of those examples!

Just like we can invoke a function using parens (e.g. `prompt()`), we can access data in an array using *bracket notation*. Try it out on `myArray`:

```javascript
console.log( myArray[0] + ' and ' + myArray[2] );
```
Arrays are also *zero-indexed*, which means that the first piece of data in the collection has a position of 0 (instead of 1). We'll see a lot more of this later. For now, it's enough to just recognize an array when you see one!

**Objects** are collections of data just like Arrays, but we can access data by *name* instead of *sequence*. All names are themselves arbitrary Strings that you're free to make up as you see fit. Let's try to re-write part of `myArray` as an Object:

```javascript
var myObject = {
  "myString": 'String',
  "myNum": 23,
  "myBoo": true
};

console.log( myObject[ "myString" ] );
```
Notice that, just like Arrays, we can access parts of Object by the things with which that part is associated... in this case, the String we used to name our data.

Objects are the foundation of an entire programming paradigm known as **Object Oriented Programming**, which we'll definitely be revisiting. For right now, it's enough to understand that we can store data in Objects and access them by name using either _bracket notation_ or a shortcut called *dot notation*.

Dot notation for the above example would be something like:

```javascript
console.log( myObject.myNum ); // 23
```

Hopefully you recognize that we've already been working with built-in Objects, including `window` and `console`. Typing `window.location` was accessing the `location` property of the `window` Object provided by the browser. `console.log()` invokes the `log` function contained in a `console` Object provided by the browser. `window` and `console` are part of the BOM, or Browser Object Model (notice the 'Object' part of that). It's the collection of all of the data and built-in functions provided by the browser, that we can access at any time.

### Exercise 2
#### JavaScript, the DOM, and YOU

While using BOM data is extremely useful, most of what users really care about happens inside the DOM: the *Document Object Model*. We can access the DOM by using the provided `document` Object.

![the DOM](http://reactorprep.herokuapp.com/assets/images/dom2.png)

Let's try exploring your Portfolio project through the `document` Object!

1. Navigate to the latest deployed version of your Portfolio Project in a browser, go to your blog page, then open up the developer console.
2. Try the following commands from the browser's REPL:

    ```javascript
    document.body;
    document.querySelector('p');
    document.querySelectorAll('p');
    document.querySelector('#nav');
    document.querySelector('.container');
    document.querySelector('#nav li').textContent;
    document.querySelector('h1').textContent = "I'm on the page!";
    ```
3. `querySelector()` and `querySelectorAll()` are both functions accessible through the `document` Object. Every modern browser will expose these functions for you to use! You'll also notice that they each return a different type of complex data type:
    + `querySelector()` returns a single DOM node, which is an Object that contains all of the same useful functions that we saw in the `document` Object (including `querySelector()`!)
    + `querySelectorAll()` returns an array-like list of DOM nodes (where `querySelector()` only returns the first node that matches the selector).
  This means that we can assign these DOM nodes to variables and treat them just like any other Object or Array. To see how that works in action, try the following from the console:

  ```javascript
  var nav = document.querySelector('#nav');
  var navLinkArr = nav.querySelectorAll('li');
  var firstNavLink = navLinkArr[0];
  var secondNavLink = navLinkArr[1];

  firstNavLink.textContent;
  secondNavLink.textContent = "New Link Text";
  ```

### Portfolio Project 1
#### Greeter 2.0

Just like we did with the first `greeter` exercise, we can also manipulate the DOM through JavaScript files (instead of the console). To explore this further, let's add a new-and-improved greeter to your landing page in your Portfolio Project!

1. At the top of your content section, add a new `<div>` with the attribute `id='greeting'`.
2. Then we need to pick out the `#greeting` element of our HTML document and change its `.textContent` to include a greeting for our visitor. HINT:

  ```javascript
  var name = prompt("Hi there! What's your name?");
  var output = document.querySelector('#greeting');
  output.textContent = "Thanks for visiting, " + name + ".";
  ```
3. While `.textContent` works, it would be nice if we could wrap our greeting in a `<p>` element to keep styling consistent. To do that, we'll use a different method attached to DOM nodes called `.innerHTML`. Try this:

  ```javascript
  var name = prompt("Hi there! What's your name?");
  var output = document.querySelector('#greeting');
  output.innerHTML = "<p>Thanks for visiting, " + name + ".</p>";
  ```
4. Now you can add some specific styles to `#greeting p` to make your greeting section look nice! Once your greeting area looks good, `add`, `commit`, `push`, and `deploy` your changes.
