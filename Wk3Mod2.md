## `while`
### Fun with loops!

The `while` loop looks a lot like an `if` statement. They both execute their associated code block based on the result of their conditional expression. The difference being, the `while` loop will repeatedly check its conditional expression and continue to run its code block as long as it evaluates to `true`. Give it a try:

 ```javascript
 var n = 0

 console.log("I am called the Count... because I really love to count!")

 while (n < 10) {
   console.log(n, "ha-ha-ha")
   n++
 }

 console.log('fin!')
 ```

### Exercise 1
#### Looping in the developer tools

Work through the following exercises as a group, implementing each in your developer console when viewing your landing page.

1. **EXERCISE 1**: Create a `while` loop that logs numbers 1 through 10 to the console. HINT:

```javascript
var n = 1;

while (n <= 10) {
    console.log(n);
    n++;
}
```

2. **EXERCISE 2**: Create a `while` loop that logs every _even_ number from 2 through 20 to the console. HINT:

```javascript
var n = 2;

while (n <= 20) {
    console.log(n);
    n += 2;
}
```

3. **EXERCISE 3**: Create a `while` loop that `console.log`s a running total of the cumulative sum of numbers from 1 to `n`. HINT:

```javascript
var n = 100;
var i = 1;
var sum = 0;

while (i < n) {
    sum += i;
    console.log(sum);
    i++;
}
```

4. **EXERCISE 4**: Then, in addition to `console.log`-ing each iteration, append all lists to the document body. HINT (for exercise 1... try the others on your own):

```javascript
var n = 1;
var outputHtml = "<ul>";

while (n <= 10) {
    console.log(n);
    ouputHtml += `<li>${n}</li>`;
    n++;
}

outputHtml += "</ul>";

document.body.innerHTML += outputHtml;
```
5. **EXERCISE 5**: We can also combine `if` and `else` statements in our loops to respond to different input states. For this exercise, count _down_ from 15 by ones. For each number, log "even" or "odd" to the console and to a new div for Exercise 5. HINT:

```javascript
var n = 15;
var outputHtml = "<ul>";

while (n > 0) {
    console.log(n);
    if ( n % 2 === 0) {
        outputHtml += "<li>even</li>";
    } else {
        outputHtml += "<li>odd</li>";
    }
    n--;
}

ouputHtml = "</ul>";

document.body.innerHTML += outputHTML;
```
6. **EXERCISE 6**: Let's extend the idea of `if` and `else` in `while` loops with a pretty common exercise called FizzBuzz. For this exercise, log and output "Fizz" if a number is divisible by 3, "Buzz" if a number by 5, and "FizzBuzz" if a number is divisible by both 3 and 5. If a number is not divisible by 3 or 5, then just output the number. For this exercise, count up from 1 to 100. HINT:

```javascript
var n = 1;
var outputHtml = "<ul>";

while (n <= 100) {
    if(n % 3 === 0 && n % 5 == 0){
        console.log("FizzBuzz");
        outputHtml += "<li>FizzBuzz</li>";
    } else if (n % 3 === 0) {
        console.log("Fizz");
        outputHtml += "<li>Fizz</li>";
    } else if (n % 5 === 0) {
        console.log("Buzz");
        outputHtml += "<li>Buzz</li>";
    } else {
        console.log(n);
        ouputHtml += `<li>${n}</li>`;
    }

    n++;
}

ouputHtml = "</ul>";

document.body.innerHTML += outputHTML;
```

## Portfolio Project 1
### Better Navigation with `while`

When we left off, our SPA's navigation code looked something like this:

```javascript
function startapp(state){
    root.innerhtml = `
      ${navigation(state)}
      ${header(state)}
      ${content(state)}
      ${footer(state)}
    `;

    var links = document.queryselectorall('#navigation a')

    links[0].addEventListener(
        'click',
        handlenavigation
    );

    links[1].addEventListener(
        'click',
        handlenavigation
    );

    links[2].addEventListener(
        'click',
        handlenavigation
    );
}
```

Not the worst code in the world, but it had two big problems: first, there could only ever be three navigation links (no more, no less). And those navigation links couldn't change like our page title could. Let's see if we can make this code cleaner and more versatile with a `while` loop.

1. Use a `while` loop to add a `click` event listener to every anchor tag in the `navigation` element.

```javascript
function startapp(state){
    root.innerhtml = `
      ${navigation(state)}
      ${header(state)}
      ${content(state)}
      ${footer(state)}
    `;

    var i = 0;
    var links = document.queryselectorall('#navigation a')

    // every Array has a length property that we can access
    while(i < links.length) {
        links[i].addEventListener(
            'click',
            handlenavigation
        );

        i++;
    }
}
```
2. Much better! And what about varying the links themselves? How about letting our `Navigation` extract those from our `state`s. In `Navigation.js`:

```javascript
function buildLinks(linkArray){
    var i = 0;
    var links = '';

    while(i < linkArray.length){
        links += `
            <li>
                <a href='/${linkArray[i]}'>${linkArray[i]}</a>
            </li>
        `;

        i++;
    }

    return links;
}

export default function Navigation(state){
    return `
    <div id="navigation">
        <ul>
            ${buildLinks(state.links)}
        </ul>
    </div>
    `;
}
```
3. Then we just need to include an Array of `links` in each state Object. Give it a try!
