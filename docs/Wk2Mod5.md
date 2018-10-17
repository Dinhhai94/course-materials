## Single Page Applications

### and Stateless Functional Components

You may have noticed that we're only able to view our _landing_ page when serving content with `parcel`. That's because `parcel` assumes that all of your content will be rendered dynamically with JavaScript... it isn't built to handle multiple HTML files.

This kind of application is called a Single-Page Application, or SPA. The idea is to listen for user interaction and respond quickly, without needing to make another network request for a set of assets. Let's see if we can get this to work with our current portfolio project! But before we do, there's a bit more that we need to learn about _callbacks_ and the `event` Object.

---

### Callbacks

With events, we've come across our very first **callback functions**. This is a common pattern in JavaScript based on the idea that functions are first-class citizens; functions can be `return`ed from other functions, can be invoked at any time, and can be passed in as arguments to other functions. When a function is given to another function as an argument for later invocation, that function argument is called a callback. Here's a simple example:

```javascript
function callWithFive(callback) {
  return callback(5);
}
```

We've now created a function that calls its argument with `5`, come hell or high water. That `callback` could be _any_ function... maybe it's `console.log`, maybe it's a `multiplyByThree` function that multiplies its argument by `3`, maybe it's a function that doesn't do anything at all. The only thing we can be certain of is that the `callback` function will _always_ be called with `5` as its first (and only) argument.

This pattern might eventually help us out with rendering components! Think about how this might work:

```javascript
function invokeWithState(state, Component) {
  return Component(state);
}
```

Now we've created a wrapper that passes a `state` Object to any functional `Component`. We could implement this in our portfolio right now, although we're going to hold off for a minute. Instead, think about how this might relate to the `addEventListener` function. As you might recall, the second argument to `addEventListener` is a callback function that's executed whenever the first argument (e.g. `click`) occurs. If you understand that, you might be wondering: are there any arguments passed to the event handler/callback when the associated event is triggered? The answer is **yes**, and that argument is an Object called the `event` Object.

---

### `event` Object

Try the following in your developer console:

```javascript
function logEventObject(event) {
  console.log(event);
}

document.body.addEventListener("click", logEventObject);
```

You should now see a very large Object logged to the console whenever you click on a page. Let's take a look at two of the most important properties of this Object.

#### `event.preventDefault`

In a previous exercise, you were tasked with adding event listeners to some of the links in your `Navigation` component. You might have done so like this:

```javascript
document
  .querySelector("#navigation a")
  .addEventListener("click", () => console.log("the first link was clicked!"));
```

You may have noticed, however, that the default link behavior took over in this case, and that the phrase `the first link was clicked!` was never output to the console. How could we prevent that default anchor tag action of reloading the page? Try something like this:

```javascript
document.querySelector("#navigation a").addEventListener("click", event => {
  event.preventDefault();

  console.log("the first link was clicked!");
});
```

`preventDefault` is a function that can be invoked to make sure that the built-in event behavior of a particular HTML element doesn't occur. This allows us to change the way that things like anchor tags and forms behave in the context of a Single-Page Application. Try it out in your portfolio project!

### Portfolio Project 1

#### SPA navigation

Up to this point, we haven't been able to see any of our other pages. Let's see if we can render the contents of these other by mimicking the routing behavior of the browser!

1. Let's start by wrapping all of our rendering logic into a single function:

```javascript
// change our original state to home-specific state
var home = {
  title: "Welcome to my Savvy Coders Portfolio"
};

var root = document.querySelector("#root"); // this doesn't need to be queried every time we re-render

function startApp(state) {
  root.innerHTML = `
    ${Navigation(state)}
    ${Header(state)}
    ${Content(state)}
    ${Footer(state)}
  `;
}

startApp(home); // start by rendering the landing page
```

2. If everything from part 1 went as planned, you should see no difference on your landing page. Let's start by coming up with a new state for your first link. Perhaps:

```javascript
// assuming your first link is to your blog page
var blog = {
  title: "Welcome to my blog!"
};
```

3. Now where should put our event listeners? We can't put them _before_ `startApp`, since we can't apply listeners to elements before they've been rendered. And we also need to _re-apply_ listeners after each render. That means that we should include the event listeners inside of `startApp`, but after `innerHTML` has been overwritten, _a la_:

```javascript
function startApp(state) {
  root.innerHTML = `
    ${Navigation(state)}
    ${Header(state)}
    ${Content(state)}
    ${Footer(state)}
  `;

  document
    .querySelector("#navigation a") // grabs first link only
    .addEventListener("click", event => {
      event.preventDefault(); // stops page reload

      startApp(blog); // re-render on click
    });
}
```

4. Let's repeat the process for your `contact` and `projects` links! As you work through this problem set, can you think of some limitations with this approach? Before we progress much further, we need to learn about `event.target`.

#### `event.target`

The SPA navigation implementation above is certainly working, but it doesn't scale very well, and certainly isnt very `DRY` (i.e. it fails the first law of programming: Don't Repeat Yourself). To make this more abstract, though, we need to be able to get some information out of the anchor tag that was the source of the `click` event in the first place. We can extract this information with `event.target`. Try the following in your dev tools:

```javascript
document.querySelector("#navigation a").addEventListener("click", event => {
  event.preventDefault();

  console.log(event.target);
});
```

You should find that the DOM representation of anchor tag is logged out to the console! This is the exact same JavaScript Object that's returned from something like `document.querySelector` in the first place, so you can get all sorts of information out of `event.target`. Try the following:

```javascript
document.querySelector("#navigation a").addEventListener("click", event => {
  event.preventDefault();

  console.log(event.target.textContent);
  console.log(event.target.outerHTML);
  console.log(event.target.href);
});
```

Let's use this new tool to improve our SPA navigation.

### Portfolio Project 2

#### Better SPA Navigation

At the end of the last exercise, your `startApp` function probably looked something like this:

```javascript
function startApp(state) {
  root.innerHTML = `
      ${Navigation(state)}
      ${Header(state)}
      ${Content(state)}
      ${Footer(state)}
    `;

  document.querySelector("#navigation a").addEventListener("click", event => {
    event.preventDefault();

    startApp(blog);
  });

  document
    .querySelector("#navigation li:nth-child(2) > a")
    .addEventListener("click", event => {
      event.preventDefault();

      startApp(contact);
    });

  document
    .querySelector("#navigation li:nth-child(3) > a")
    .addEventListener("click", event => {
      event.preventDefault();

      startApp(projects);
    });
}
```

That's neither `DRY` nor pretty... just look as those nasty selectors that we need to select each anchor tag in turn. Let's see if we can clean this up using the power of `event.target`.

1. First, let's refactor our states. You probably have four separate state Objects by this point. If we combine them into one flat state Object, then it will be easier to leverage the power of `event.target`. Let's do something like this:

```javascript
// notice the capitalized property names!

var state = {
  Blog: {
    title: "Welcome to my Blog"
  },
  Home: {
    title: "Wecome to my Portfolio"
  },
  Contact: {
    title: "Contact Me"
  },
  Projects: {
    title: "Check out my Projects"
  }
};
```

2. Now we can extract the click event handler into its own function:

```javascript
function handleNavigation(event) {
  // pull the component name from the text in the anchor tag
  var component = event.target.textContent;

  event.preventDefault();

  // select a piece of the state tree by component
  startApp(state[component]);
}
```

3. This already helps us clean things up. Check out our new `startApp` function:

```javascript
function startApp(state) {
  root.innerHTML = `
      ${Navigation(state)}
      ${Header(state)}
      ${Content(state)}
      ${Footer(state)}
    `;

  document
    .querySelector("#navigation a")
    .addEventListener("click", handleNavigation);

  document
    .querySelector("#navigation li:nth-child(2) > a")
    .addEventListener("click", handleNavigation);

  document
    .querySelector("#navigation li:nth-child(3) > a")
    .addEventListener("click", handleNavigation);
}
```

4. Our last optimization will be to reduce the number of DOM queries every re-render. We're currently querying the entire `document` three times every time `startApp` is called. We can do better by using `querySelectorAll`, like so:

```javascript
function startApp(state) {
  root.innerHTML = `
      ${Navigation(state)}
      ${Header(state)}
      ${Content(state)}
      ${Footer(state)}
    `;

  var links = document.querySelectorAll("#navigation a");

  links[0].addEventListener("click", handleNavigation);

  links[1].addEventListener("click", handleNavigation);

  links[2].addEventListener("click", handleNavigation);
}
```

Now we have a pretty clean navigation system that doesn't require page refreshes! How else can we improve on this system?
