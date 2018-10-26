## Basic DOM review, String Interpolation, modules, and bundlers

### ...plus type coercion and booleans!

Up to this point, our JavaScript exercises have added a bit of flair to some existing websites, but haven't really been 'programs' in the their own right. Today we change that! But first, a bit more info about the Boolean data type:

### More Boolean!

While `if`, `else`, and `else if` combined with `===`, `<==`, `>==`, and `!==` can go a long way, we sometimes need to test for multiple conditions at the same time. To help us out with that, we can use the `||` or `&&` operators.

`||` means "or"... it returns `true` if either the first term _or_ the second term _or_ both are true.
`&&` means "and"... it returns `true` if (and only if) both tested terms are true.

Try out some of the following in your console to see the results:

```
!true
!false
!!false
!!true

true && true
true && false
true || true
true || false
false || true
false || false
```

But wait, there's more! While `true` and `false` are the only truly Boolean values, statements like `if` or the no-so-strict equality operator `==` are a bit more flexible. They're looking for values that are "truthy" or "falsey". These are values that are _coerced_ into `true` or `false` (respectively). We can see this coercion in action by using the negation operator `!` twice. Try a few of the following to see if they're "truthy" or "falsey":

```javascript
!!"";
!!"Hello";
!!0;
!!123;
!![];
!![1, 2, 3];
!!{};
!!{ foo: "bar" };

0 == false;
1 == "1";
2 == {};
```

These are perhaps a bit strange, but they allow us to write some fairly terse conditional expressions. As an example: can you see where we can re-write our `greeter.js` from a previous module with one of these "falsey" values?

### Portfolio Project 1

#### Greeter 3.0

In the last class, we worked on making a greeter for visitors to our website. Now let's add some extra logic to make our program more useful!

1. First, open up your `FirstnameLastname` directory in VSCode, serve with `http-server`, and take a look at your landing page.
2. Make sure that you've styled the `#greeting` section and have a `index.js` document that contains the following:

```javascript
var name = prompt("Hi there! What's your name?");
var output = document.querySelector("#greeting");
output.innerHTML = "<p>Thanks for visiting, " + name + ".</p>";
```

3. Now let's make sure that users have actually input a name! We'll do that using a neat trick of JavaScript, where strings evaluate to `true`, but _empty_ strings evaluate to `false`. Try the following in `index.js`:

```javascript
var name = prompt("Hi there! What's your name?");
var output = document.querySelector("#greeting");

if (name) {
  output.innerHTML = "<p>Thanks for visiting, " + name + ".</p>";
} else {
  output.innerHTML = "<p>Please tell us your name!</p>";
}
```

4. Let's make things a little more complicated by asking users for their first _and_ last names. The following will only output a visitor's name if they provide both a first _and_ last name. Try this:

```javascript
var firstName = prompt("Hi there! What's your first name?");
var lastName = prompt("What's your last name?");
var output = document.querySelector("#greeting");

if (firstName && lastName) {
  output.innerHTML =
    "<p>Thanks for visiting, " + firstName + " " + lastName + ".</p>";
} else {
  output.innerHTML = "<p>Please tell us your first and last names!</p>";
}
```

5. We can use the 'or' operator (`||`) to give users a default name, instead of just pleading with them to respond to our prompts. With this, we can also get rid of the `if` and `else` behavior to simplify our code! Make sure you understand how this 'default' behavior works:

```javascript
var firstName = prompt("Hi there! What's your first name?") || "Visitor";
var lastName = prompt("What's your last name?") || "McDefaultson";
var output = document.querySelector("#greeting");

output.innerHTML =
  "<p>Thanks for visiting, " + firstName + " " + lastName + ".</p>";
```

---

### String Interpolation

As we dig deeper into HTML-in-JavaScript, you'll notice that standard String concatenation gets to be a bit cumbersome. Instead of using the concatenation operator (`+`), most String manipulation in modern JS is done with [**template literals**](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Template_literals) and String interpolation. The idea is that we can inject variables or expressions directly into a _template_, rather than piecing together substrings manually. The template literal version of the exercise above would look like this:

```javascript
var firstName = prompt("Hi there! What's your first name?") || "Visitor";
var lastName = prompt("What's your last name?") || "McDefaultson";
var output = document.querySelector("#greeting");

output.innerHTML = `<p>Thanks for visiting, ${firstName} ${lastName}.</p>`;
```

Notice how this syntax maintains the structure of our HTML more accurately. This is true of multi-line HTML chunks as well, since template strings take newlines into account! If we wanted to make our `output`'s `innerHTML`' a bit more fancy, we could have re-written that last line like so:

```javascript
output.innerHTML = `
  <div>
    <p>
      Thanks for visiting,
      <span class="some-class">
        ${firstName} ${lastName}
      </span>
    </p>
  </div>
`;
```

Which is much nicer, don't you think? You can imagine how we might be able to turn all of our existing HTML into a set of fancier templates using this method. Try refactoring all of your concatenated Strings into interpolated template literals instead!

> NOTE: missing `emmet` support and HTML syntax highlighting? Try using the [Template Literal Editor Extension](https://marketplace.visualstudio.com/items?itemName=plievone.vscode-template-literal-editor) for Visual Studio Code

---

### Modules and bundlers

If we can divide up our markup into different pieces with template literals, hopefully you can imagine a world where we can divide our JavaScript into different pieces at the file level as well. This idea of abstracting pieces of your application into **modules** is one that's prevalent in the programming world across a variety of languages. For a long time, though, JavaScript lacked a module system of any kind! To get around this issue, JavaScript developers came up with a syntax for `import`-ing and `export`-ing pieces of JavaScript with the use of a command-line tool called a **bundler**.

After many years of back-and-forth, the JavaScript module syntax has [finally settled](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/import) and is the default module system supported by the many bundlers that are used by developers.

To start working with modules in our own application, we're going to use a bundler called [`parcel`](//parceljs.com). You might recognize this from the first week of class, as it was one of the first dependencies installed by our initialization script as we set up our developer environment.

> NOTE: to double-check that you've still got `parcel` installed correctly, look at the `package.json` file that was generated for you earlier. You should see `parcel` listed under something called `devDependencies`. To double-double-check, you can also run `npx parcel --version` from the command line to check for errors/output.

Let's use `parcel` to serve our content instead of `http-server` to see what happens! Since `parcel` is what we call a _local_ dependency, we need to call it with a special `npm` command named `npx` (think of it as '`npm` execute `$some-local-dependency`'). You can start bundling and serving your project with the command `npx parcel index.html`. If everything is working correctly, you should see something like this output to the terminal:

```shell
Server running at http://localhost:1234
✨  Built in 3.41s.
```

This should look similar to the output we've gotten from `http-server`, just running on a different port. When you visit `localhost:1234` in your browser, everything should look the same as when served up by `http-server`. So what's the big deal? Let's do a bit of refactoring to find out!

### Portfolio Project 2

#### Building a component library

At this point, your landing page should include four top-level components: navigation, header, content, and footer. These pieces should be static HTML, but you'll notice that they are components that can be shared across your entire application (for the most part). Let's see if we can turn these HTML components into something that we share across our application with JavaScript!

1. First, let's create a new directory to handle these components. How about `components`?
2. Inside of that `components` directory, let's create a `Navigation.js` component (notice the capitalization). The capitalized first letter is a convention in most JS component systems.
3. Your navigation bar probably has markup that looks something like this (very simplified):

```html
  <div id="navigation">
      <ul>
          <li>First</li>
          <li>Second</li>
          <li>Third</li>
      </ul>
  </div>
```

Let's take that markup and turn it into an JS module! In `Navigation.js`, convert your navigation bar markup to something like this:

```javascript
export default `
  <div id="navigation">
      <ul>
          <li>First</li>
          <li>Second</li>
          <li>Third</li>
      </ul>
  </div>
`;
```

4. We should recognize the template literal here (although we aren't yet doing any sort of interpolation). The two keywords are part of JavaScript's module syntax: `export` is defining the stuff to be exposed to be other parts of our application, `default` is saying that this module should `export` the template by default in one big chunk (rather than a set of pieces... more on that later). To verify that this `export` statement is working as expected let's try `import`-ing this component into our top-level `index.js` file:

```javascript
import Navigation from "./components/Navigation";

console.log(Navigation); // just to test that our import is working
```

5. This should be spitting a String of HTML to the console, but how do prepend this content to the `document.body`? If we remember that this new component is just a string, it becomes a bit clearer:

```javascript
import Navigation from "./components/Navigation";

var initialHTML = document.body.innerHTML; // store the original HTML from the body

document.body.innerHTML = `${Navigation}${initialHTML}`;
```

6. Repeat the process above for the rest of your components! In the end, you should have something like this:

```javascript
import Navigation from "./components/Navigation";
import Header from "./components/Header";
import Content from "./components/Content";
import Footer from "./components/Footer";

var initialHTML = document.body.innerHTML;

document.body.innerHTML = `
      ${Navigation}
      ${Header}
      ${Content}
      ${Footer}
      ${initialHTML} // we still need this
    `;
```

7. You'll notice that we need to perform that somewhat-hacky `initialHTML` trick to make sure that our `<script>` tag isn't clobbered by our over-writing of the `body`'s `innerHTML`. Instead of doing that, let's wrap our visible application in a placeholder `div` with an `id` of `root`. That means adding `<div id="root"></div>` to your `index.html` and modifying your `index.js` to look something like:

```javascript
import Navigation from "./components/Navigation";
import Header from "./components/Header";
import Content from "./components/Content";
import Footer from "./components/Footer";

document.querySelector("#root").innerHTML = `
      ${Navigation}
      ${Header}
      ${Content}
      ${Footer}
    `;
```

> NOTE: don't forget to modify your CSS to keep your fancy grid aligned!

Pretty cool, huh? Now imagine that we could re-use these components across multiple "pages" of content. I say "pages", because we're beginning to refactor this project into what's called a Single-Page Application: a web application that uses JavaScript to modify the state through components rather than a set of HTML documents. More on this concept later!

---

### Continuous Delivery

So far, our Netlify/GitHub integration has allowed us to seamlessly serve a new set of static assets (HTML files) without needing to directly access the server or infrastructure. But now, by bundling our applications from multiple modules into a single, distributable file, we've introduced a _build step_. This build step is required if we want to generate the same sorts of static assets that we've been writing by hand up to this point. To see what happens when we build static assets with `parcel`, try:

```
npx parcel build index.html
```

If you've done this correctly, you should see a new `/dist/` directory that contains all of the HTML, CSS, and JavaScript that our project will need! 

> NOTE: if the command above failed, it's almost certainly due to filepath issues. Make sure that your asset paths are _relative_ instead of absolute! Since Netlify's build process takes place on another machine, we can't be sure that that machine will treat the `/` the same way that we've come to expect from `http-server` and `parcel` on our local machines.

We'll want Netlify to be able to run a similar command on our behalf during the deployment process, too. To do this, we need to configure our project in a couple of different places:

1. First, we can leverage another feature of `npm`: the `scripts` hash. This piece of our `package.json` file allows us to run otherwise long commands from the command line using local project dependencies. So let's add a `build` command to `package.json`, such that your `scripts` configuration looks like this:

```json
{
  "build": "parcel build index.html && cp _redirects ./dist/",
}
```

> NOTE: we need to include `cp _redirects ./dist/` for reasons that will become clear soon.

You can run the above command with `npm run build`. This should be a bit more ergonomic than typing out the entire command by hand!

2. Next, we'll modify our deploy settings on Netlify! You can find those settings at `https://app.netlify.com/sites/$YOUR_SITE_NAME/settings/deploys`. You'll need to add a build command of `npm run build` and a publish directory of `dist`. All of your other settings should be able to stay the same.

Once both steps are done, try staging, committing, and pushing your newly-configured application to Netlify!
