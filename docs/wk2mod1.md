# Intro to JavaScript

## Primitive Data Types

So, we've been at this for a week now, and we've certainly done some cool stuff. But we haven't really done much _programming_ yet: we've worked with text content, we've worked with styles, and we've worked with commands through the terminal, but we haven't yet created our own directives for a computer or browser to execute. That changes today!

There are quite a few programming languages in use today, in a variety of contexts. From low-level hardware languages, to languages at the OS level, to server-side frameworks, to client-side scripting languages for the Web. It's this last one that we'll be focusing on for the remainder of the course: JavaScript!

## Exercise 1

### Primitive Data Types

JavaScript was originally built to add dynamic content to websites \(like adding the date or the number of visitors to a site's landing page\). Since those inauspicious beginnings, JavaScript has now grown into a full-stack language for use in servers, browsers, and even native applications. We can still see those browser-based beginnings by running JavaScript directly in Chrome, through the Developer Tools console.

![The Dev Console](http://reactorprep.herokuapp.com/assets/images/console.png)

The Dev Console is a JavaScript REPL \("Read Evaluate Print Loop"\) that is just waiting for us to interact with it. Let's give it a try!

1. Remember the DOM? Let's see if we have access to it by typing `window.document` into the REPL. What's the output?
2. We also have access to data outside of the DOM \(in the BOM or "Browser Object Model"\). This information is held in the `window` object. Try out a few of these:

   ```javascript
   window.location;
   window.history;
   ```

3. While that's pretty neat, we're still just looking around. Let's try interacting with the REPL! Try out the following:

   ```javascript
   2 + 2;
   2 * 5;
   1e4 * 2;
   ```

Now we're programming! The browser is responding to our demands when we give it an input with a **data type** of _Number_. The Number data type includes integers, floating-point numbers \(i.e. decimals\), and exponent notation \(e.g. 1e4\).

1. Mathematic operations are called using **operators** that we are all familiar with. These operators do different things for different data types, though. Try this:

   ```javascript
   "2" + "2";
   ```

What's the answer? It's definitely NOT 4 like you or I might expect. And that's because 2 is not the same thing as '2'. 2 is a number, while '2' is a string of text, or the _character_ 2. And for text \(with a data type of _String_\), the + operator is actually for _concatenation_. It turns multiple Strings into one output string. Try the following:

```javascript
"JavaScript is " + "FUN" + "!!";
"1, 2, 3, and 4 are " + "numbers" + " (sort of)";
```

Note that all strings have to have quotes \(either single or double\) around them. Words written without quotes are something else entirely...

1. In the 'real world', programming implies that you can create a program to be used later, rather than simply typing in commands. To do that, we need a way to save these bits of data to memory. JavaScript lets us save values to **variables** using either the `const`, `let` or `var` **keywords.** Try the following:

   ```javascript
   const currentYear = 2016;
   let myCountry = "USA";
   var myPhrase = currentYear + " is an election year in the " +    myCountry;
   console.log(myPhrase);
   ```

A couple of things to notice about these commands:

* Our **keyword** and the name of the variable are separated by a space, and the variable name can't include spaces
* variable values can be any data type \(that we've covered so far\)
* variable values are assigned using the _assignment operator_ \(which looks like an equals sign to you and I\).
* the assignment 'phrase' ends with a semicolon. We end JavaScript 'sentences' with semicolons... always!
* the REPL outputs _undefined_ after we define the variable. That's expected, since we're only saving that variable to memory.
* We can access the value stored to the variable name by typing in that variable's name to the REPL.
* To actually log the value to the Dev Console \(much more useful in real-world applications\), we can use the built in function `console.log([variable name])`
* When we use the variable, we DON'T use quotation marks. Quotes mean Strings, and variables are variables, not strings of text.
* `const` indicates a value that can't be reassigned. For example if we do: `const x = 3` and then try to do `x = 4` - that will not work. We can't replace the value in memory, although we'll see that we can change parts of complex data later on.
* `let` and `var` **do** allow the value to be replaced.
* All variables start off as `undefined` until we use the _assignment operator:_ `=`.
* In this course, we will focus on using `const` and `let`, and we will consider `var` for legacy purposes.

1. So now we have some saved data. Wouldn't it be nice if we could test that data? We can, in fact, using the _Boolean_ data type. Booleans only have two values: `true` or `false`. They can be stored as a variable of their own, or can be returned as a result of a test. Try the following:

   ```javascript
   const isTrue = true; //notice: no quotes around true!
   const isFalse = false;
   2 === 2
   2 === '2'
   2 > 3
   2 < 3
   2 !== 3
   2 <= 2
   2 >= 2
   'hello' === 'hello'
   'hello' === 'Hello'
   console.log(isTrue === isFalse);
   ```

## Exercise 2

### functions and control flow

Now we have bits of data stored in memory for us to manipulate, which is nice. But up to now, there's been no way to make our programs adapt to inputs. To do that, we'll need functions and control flow.

1. The key to control flow are `if`, `else`, and `else if` statements, built on the Boolean data type. These statements allow us to perform a Boolean test, then give different outputs based on the results of that test. Try the following in your console:

   ```javascript
   if (myCountry === "USA") {
     console.log("Sweet Land of Liberty");
   }
   ```

This is a Boolean test that should output a string to the console when `myCountry` is set to `'USA'`. If there's any other value stored to `myCoutry`, then nothing will be output at all.

1. Let's try to account for every other condition with an `else` clause, like so:

   ```javascript
   if (myCountry === "USA") {
     console.log("Sweet Land of Liberty");
   } else {
     console.log("Sounds like you need some DEMOCRACY");
   }
   ```

Now something should output each time that block of code is run, since it covers every possible condition!

1. But this can be a real pain to re-type every time you want to check out your current country. What if we could save this block of code just like we could save chunks of data to variables? Luckily, we can do exactly that by creating a new function! Try this:

   ```javascript
   const freedomCheck = function() {
     if (myCountry === "USA") console.log("Sweet Land of Liberty");
     else console.log("Sounds like you need some DEMOCRACY");
   };
   ```

Now we have our test available whenever we'd like to call it again, saved just like any other variable. Now try the following, and see what happens:

```javascript
freedomCheck;
freedomCheck();
```

The first just accesses the data stored in the variable, which includes the whole `function()` phrase. But we really want to _invoke_ the function instead, which is what happens when we use the parens after the name of the stored function \(e.g. `freedomCheck()`\). Now we actually run the code inside of the curly braces instead of just displaying it in the REPL.

## Exercise 3

### built-in functions, recursion, and your first JavaScript-enabled web page

So the console is fun, but it's still not connected to the HTML that we know and love in a way that end-users could ever see. How can we add JavaScript to one of our web pages?

1. In your landing page, at the bottom of the `<body>` tag, add the following:

   ```markup
   <script>
     console.log('Hello world!');
   </script>
   ```

When you reload your preview page, you should see 'Hello world!' in your console. You've now added JavaScript to your page!

1. The function `console.log()` is a built-in function recognized by browsers everywhere. Some functions are so commonly used that they're simply a part of the language spec... otherwise we'd have to replicate those functions in nearly every JavaScript project. Let's make our greeting a bit more obnoxious using the built-in function `alert()`.

   ```markup
   <script>
     alert('Hello world!');
   </script>
   ```

You should notice that, just like `console.log()`, `alert()` takes a String of data as an _argument_, listed between the parens when the function is invoked. We'll learn much more about arguments later, but just remember for the time being that arguments are the bits of data that are passed directly into a function without needing to be saved to a _global_ variable accessible by every other function \(like `myCountry` was in the previous example\).

1. What about user input? Luckily, we have another obnoxious built-in function called `prompt()`. This function can also take a String as an argument. Try this:

   ```markup
   <script>
     prompt('What is your name?');
     alert('Hello World!');
   </script>
   ```

What happened to the user input here? As of right now, nothing! Let's try this instead:

```markup
<script>
  let name = prompt('What is your name?');

  alert('Hello ' + name);
</script>
```

Neat, huh? `prompt()` actually returns a String for us to play around with. We just need to use that value instead of letting it float off into space. In this example, we saved the String from our `prompt()` into a variable called `name`. Then, because it's a String, we can concatenate the value of `name` into the String used in `alert()`.

1. This works great, but what happens when a user neglects to actually enter a value in the `prompt()`? Try it out! ... you should see that we still have an output of `Hello` \(that's the word `Hello` with a single space after it\). How could we check to make sure that a user isn't entering a blank name into the `prompt()`? How about something like this:

   ```markup
   <script>
     let name = prompt('What is your name?');

     if(name === "") { // checks for an empty string
       name = prompt('What is your name, for real this time?');
     }

     alert('Hello ' + name);
   </script>
   ```

2. Notice that we can over-write the value of `name` at any point in our codebase, including when the `prompt()` returns an empty String. But what are some gaps in this implementation? For one, we probably want to check that the user is actually giving us a value _even if the user repeatedly chooses that empty value_. To do that, we need to do two things: First, we need to abstract our name-checking logic to a `function`, then we need to re-write our code such that the `function` calls itself until a condition is met. This is called recursion, and it looks like this:

   ```markup
   <script>
     let name = prompt('What is your name?');

     const checkName = function(){
       if(name === "") {
         name = prompt('What is your name, for real this time?');

         checkName(); // repeats until a name exists
       }
     }

     checkName(); // kicks off the name-checking the first time

     alert('Hello ' + name);
   </script>
   ```

3. Now we've implemented a bit of 'inline' JavaScript on our page! Just like working with CSS, though, it's more typical to see scripts in their own separate document. This is especially important for large codebases with thousands of lines of JavaScript code. Let's try it with our greeter page:

   1. Just like saving HTML files as `.html` and CSS files as `.css`, JavaScript files are saved as `.js`. Create a file called `index.js`.
   2. Copy the contents of the `<script>` tag \(NOT the `<script>` tag itself!\) over to `index.js`. HINT: the entire document should look like:

   ```javascript
   let name = prompt("What is your name?");

   const checkName = function() {
     if (name === "") {
       name = prompt("What is your name, for real this time?");

       checkName(); // repeats until a name exists
     }
   };

   checkName(); // kicks off the name-checking the first time

   alert("Hello " + name);
   ```

   1. Modify the rest of your `<script>` tag in your landing page to look like this:

   ```markup
   <script src="index.js"></script>
   ```

   Now, when you reload the page, you should get the same result as when you in-lined all of your JavaScript.

4. Once you page is complete, try adding more prompts, alerts, and console.logs. When you're satisfied with your progress, stage, commit, and push your changes!

