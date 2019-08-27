# npm and Advanced Modules

## Advanced modules and library usage

One of the wonderful things about the modern JavaScript ecosystem is that there are literally _thousands_ of libraries for us to use, solving any number of complex problems we might encounter in the realm of web development. Learning how to install, manage, and `import` these third-party dependencies is a key part of being an effective web developer.

## More Modules

You'll recall that we've been working with our own library of components through by `import`-ing and `export`-ing `default` chunks of JavaScript. But there are a few variations on this these syntaxes that will help us keep our code organized as our applications begin to pull in third-party dependencies. Here's a quick overview:

```javascript
// import the default export from a module
import toolbox from 'toolbox';

// import a single export (of many) from a module
import { tool } from 'toolbox';

// import many exports at once from a module
import * from 'toolbox';

// import many exports as a named Object from a module
import * as tools from 'toolbox';

// export a single, default chunk from a module
export default 'toolbox';

// export a single chunk (of many) from a module
export 'tool';
```

Let's see how these `import`/`export` variations might help us organize our large state and content trees in our portfolio projects.

## Portfolio Project 1

### Modular State and Content

When last we left our state tree, it was beginning to look something like this:

```javascript
var states = {
  Home: {
    links: ["Blog", "Contact", "Projects"],
    title: "Welcome to my Portfolio"
  },
  Blog: {
    links: ["Home", "Contact", "Projects"],
    title: "Welcome to my Blog"
  },
  Contact: {
    links: ["Home", "Blog", "Projects"],
    title: "Contact Me"
  },
  Projects: {
    links: [
      "Home",
      "Blog",
      "Contact",
      "Choose-Your-Own-Adventure",
      "Rock-Paper-Scissors"
    ],
    title: "Check out some of my projects"
  }
};
```

This is pretty ungainly. Let's see if we can clean this up by extracting all of these disparate states into their own modules.

1. To start, let's create a directory called `store` that will contain all of our `state`s. Inside that `store` directory, create a single `index.js` file. This file will act similarly to the way the `index.html` does for HTML documents: our bundler will, by default, look for that `index` if no explicit file path is provided.
2. Inside of `store`, let's create a separate JavaScript file for each part of our state tree, That means new `Home`, `Blog`, `Contact`, and `Projects` files. Each of these files should have a single `default` export of a single Object. That Object should represent that single piece of the original state tree. So, for example, the `Blog` module would look like this:

```javascript
export default {
  links: ["Home", "Contact", "Projects"],
  title: "Welcome to my Blog"
};
```

1. Once every state module has been created, we can re-export each of those modules with a name in `store/index.js`. The syntax for one of those re-exports would be `export { default as SomeName } from './some-location';`. See if you can re-export all of these pieces of our state tree with this syntax! HINT:

```javascript
export { default as Blog } from "./Blog";
export { default as Contact } from "./Contact";
export { default as Home } from "./Home";
export { default as Projects } from "./Projects";
```

1. Now that this base module has been set up we should be able to `import` our states through the module system. In this case, we would like to `import` _all_ of the states in one big glob using the `* as name` syntax. Try the following in your root-level `index.js` file, and see if you can figure out what the data type of `states` will be:

```javascript
import * as states from "./store";

console.log(states); // what's the data type here?
```

1. We should now be able to access any piece of our `states` tree, just as before! Except that this time, all of the complexity of our application state is hidden away behind our module system \(which is a _good_ thing\).
2. Now that we've ironed out navigation, let's see if we can finally get our _content_ to change in response to our user input! You should still have HTML files that represent content for your `Blog`, `Content`, and `Projects` landing pages that we haven't yet incorporated into our new Single-Page architecture. Let's convert those pieces of HTML into their own `component`s. To start, let's create a `Pages` directory inside our `components` directory. This is a common pattern when dealing with a group of similar components. In this case, we're grouping all of the different page-level \(or content-level\) templates.
3. Let's repeat the export pattern from our `states`. That means creating an `index.js` file next to a `Blog.js`, `Contact.js`, `Home.js`, and `Projects.js` file inside of `components/Pages`. Each Page component should `export` some HTML as a template literal, e.g.:

```javascript
export default `
  <form>
    <input type="text" name="test">
    <input type="submit">
  </form>
`;
```

...and re-`export` those `default`s with a name from `components/Pages/index.js`, e.g.:

```text
export { default as Contact } from './Contact';
```

1. Now each `state` component can point to a component from the `components/Pages` directory. Let's use a String to connect that content to each state component as a `body` property. For example, our `Blog` state might become:

```javascript
export default {
  body: "Blog",
  links: ["Home", "Contact", "Projects"],
  title: "Welcome to my Blog"
};
```

1. Once you've associated some content with each piece of the state tree, it's time to change our `Content` component to allow for variation in the `body` property of a `state` parameter. That means our `Content` component becomes:

```javascript
import * as pages from "./Pages";

export default function Content(state) {
  return `
        <div id="content">
            ${pages[state.body]} // why do we need square brackets?
        </div>
    `;
}
```

Now you should have a Single-Page application that behaves almost exactly like our old HTML page-based site, but with a lot more flexibility and some real performance wins for our users.

## Dependencies

We've already worked with "dependencies" during our time with CSS. A _dependency_ is any piece of code \(regardless of language\) provided by a third-party upon which our project depends. Previous dependencies were included through `<link>` tags in our HTML files, and were retrieved from a Content Delivery Network \(e.g. CDNJS\). These dependencies included things like CSS reset libraries \(normalize.css\), fonts, and icons.

In the realm of JavaScript, the number of possible dependencies is **much** larger than we've encountered in CSS-land. While we could include many third-party libraries from a CDN using a `<script>` tag, there are a couple of good reasons not to:

1. It's easier to update third-party dependencies through a dedicated _dependency management_ system instead of keeping track of those dependencies by hand. JavaScript's dependency management program is called `npm`.
2. As your application gets more complex, it's not uncommon to have more than 10 JavaScript dependencies, many of which will need to be loaded in a certain order to work correctly. That's a lot of `<script>` tags to keep track of! Instead, we can `install` dependencies with `npm` and `import` those dependencies into a single bundle.
3. Unlike with CSS, it's rare to use every piece of a JavaScript library. With our module bundler, we can use a process called [tree-shaking](https://developer.mozilla.org/en-US/docs/Glossary/Tree_shaking) to get rid of un-unsed parts of our dependencies. This means that our users don't need to download nearly as many bytes of data as they would if the entire dependency were included.

Let's go through two practical examples of using third-party dependencies to improve navigation for our users!

## `lodash`

[`lodash`](https://lodash.com/docs/4.17.10) is a library of useful utility functions that make working with collections of data much easier. On top of the collections helpers, though, there are a number of functions that make working with Strings just a bit easier.

## Portfolio Project 2

### lowercased routes

1. Install `lodash` by typing the following into your terminal:

```text
npm install --save lodash
```

1. And just like that, we should be able to `import` individual helper functions in any of our own modules. Try adding this to the top of `Navigation.js`:

```javascript
import { lowerCase } from "lodash";
```

1. `lowerCase` is a function that turns any String into its lower-cased variant. Since lower-case routes are much more common than the upper-case routes that we've been using so far, let's turn our `buildLinks` function into something that looks like this instead:

```javascript
import { lowerCase } from "lodash";

function buildLinks(linkArray) {
  var i = 0;
  var links = "";
  var link = "";

  while (i < linkArray.length) {
    link = lowerCase(linkArray[i]);

    links += `
        <li>
          <a href='/${link}'>${linkArray[i]}</a>
        </li>
      `;

    i++;
  }

  return links;
}
```

1. Along with the changes to `buildLinks`, we'll also need to capitalize our component names in `handleNavigation` in our `index.js` file. That's as simple as adding `import { capitalize } from 'lodash';` to the top of the file before modifying `handleNavigation` to be:

```javascript
function handleNavigation(event) {
  var component = event.target.textContent;

  event.preventDefault();

  startApp(state[capitalize(component)]);
}
```

Not a bad way to offload some of that complexity to a library maintainer, right?

## Routing and `navigo`

While our SPA has some nice performance benefits for users \(once our JavaScript has loaded\) and some nice features during development \(from automatic re-bundling and hot-module reloading\), there's a major drawback for those visiting our application for the first time: as written, there's no way to navigate _directly_ to any "page" other than the landing page/`Home` component. That's because our JavaScript application no longer differentiates between any URL paths; `localhost:1234` is treated the same as `localhost:1234/blog` and `localhost:1234/whatever`. To capture these URLs and treat them correctly, we need a [client-side router](https://medium.com/@wilbo/server-side-vs-client-side-routing-71d710e9227f) that listens for changes to the URL and responds with our `startApp` function called with the correct `state`.

It's very possible \(and a fun bonus exercise\) to use `window.location.pathname` to create a very basic client-side router, but we can make things easier on ourselves by leveraging the work of others. For this project, we'll use [navigo](https://github.com/krasimir/navigo).

## Portfolio Project 3

### Routing with `navigo`

1. Let's start by installing the `navigo` library with `npm install --save navigo`
2. We should now be able to import the default `Navigo` [constructor](https://css-tricks.com/understanding-javascript-constructors/) at the top of our `index.js` file with:

```javascript
import Navigo from "navigo";
```

1. `Navigo` is a special type of function that can be used to create a new Object \(more on these later\). To create the `router` Object that we'll use to route requests, create a `router` variable like so:

```javascript
// origin is required to help our router handle localhost addresses
var router = new Navigo(window.location.origin);
```

1. `router` works by chaining a number of different functions together \(more on this idea of chaining functions later, too\). The two that we'll use are `on` and `resolve`. `on` uses a callback structure: whenever a URL matches the pattern given to `on` as its first argument, the function provided as the second argument is called. We use `resolve` at the end of the chain to kick off the client-side routing process. Try this on `index.js`:

```javascript
router.on("/", () => console.log("hello home page!")).resolve();
```

You should see `hello home page!` whenever you visit the landing page of your application.

1. `on` also allows us to capture routes as something called _params_ \(short for parameters\) using a special syntax \(but one that's common among routers of all types\). Try experimenting with this setup:

```javascript
router
  .on(":path", params => console.log(params.page))
  .on("/", () => console.log("hello home page!"))
  .resolve();
```

1. Now we have the ability to execute JavaScript in response to the URL. But what is it we actually want to do? Previously, we were using `handleNavigation` to navigate around through click events targets. Now, we can handle _routes_ a bit more fluidly. Let's refactor `handleNavigation` into a `handleRoute` function that looks something like this:

```javascript
function handleRoute(params) {
  var page = capitalize(params.page);

  startApp(states[page]);
}
```

...which we can apply to the `:pages` route as a callback, like so:

```javascript
router
  .on("/:path", handleRoute)
  .on("/", () => console.log("hello home page!"))
  .resolve();
```

1. We should now be able to use the URL to navigate between application states... pretty cool! But we're not done yet. What if we want to be able to navigate to different URLs using the links in our `Navigation` component? Right now, we're hijacking that process with custom event listeners, so our URL isn't changing at all. Luckily, `navigo` gives us a helper function to let us handle those anchor tags without reloading the page \(and without the custom event listeners\). Let's start by refactoring your `startApp` function to something a bit more simple:

```javascript
function startApp(state) {
  rooter.innerHTML = `
      ${Navigation(state)}
      ${Header(state)}
      ${Content(state)}
      ${Footer(state)}
    `;

  router.updatePageLinks(); // much simpler!
}
```

Now we can add a special attribute to our generated links called `data-navigo` to allow our `router` to "hijack" these anchor tags. That would mean that our `buildLinks` function in `Navigation` is as simple as:

```javascript
function buildLinks(linkArray) {
  var i = 0;
  var links = "";
  var link = "";

  while (i < linkArray.length) {
    link = lowerCase(link);

    links += `
            <li>
                <a href='/${link}' data-navigo> // new attribute
                    ${linkArray[i]}
                </a>
            </li>
        `;

    i++;
  }

  return links;
}
```

Now most of our links should be navigable using client-side routing!

1. You may have noticed that "most" from above. What's the bug? You'll notice that we're currently handling our landing page \(the `/` route\) with a `console.log` statement. What we'd _really_ like to do is start our application with the `Home` branch of the `state` tree. So let's modify our routing to account for users navigating to our landing page:

```javascript
router
  .on("/:page", handleRoute)
  .on("/", () => startApp(states["Home"]))
  .resolve();
```

1. Almost done now! The last bug: you'll notice that any `Home` link actually links to `/home` on click. Instead of doing that, let's route all `Home` links to `/`, which is our actual home page. We'll do that over in `Navigation.js`'s `buildLinks` function by doing a quick refactor to:

```javascript
function buildLinks(linkArray) {
  var i = 0;
  var links = "";
  var link = "";

  while (i < linkArray.length) {
    if (linkArray[i] !== "Home") {
      link = linkArray[i];
    }

    // what's the value of link here?

    links += `
            <li>
                <a href='/${lowerCase(link)}' data-navigo>
                    ${linkArray[i]}
                </a>
            </li>
        `;

    i++;
  }

  return links;
}
```

And there you have it! Now you have a fully-operational SPA, ready for your users with lightning-fast navigation.

