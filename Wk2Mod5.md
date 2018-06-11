## Single Page Applications
### and Stateless Functional Components

You may have noticed that we're only able to view our _landing_ page when serving content with `parcel`. That's because `parcel` assumes that all of your content will be rendered dynamically with JavaScript... it isn't built to handle multiple HTML files.

This kind of application is called a Single-Page Application, or SPA. The idea is to listen for user interaction and respond quickly, without needing to make another network request for a set of assets. Let's see if we can get this to work with our current portfolio project! But before we do, there's a bit more that we need to learn about _callbacks_ and the `event` Object.

---

### Callbacks

With events, we've come across our very first __callback functions__. This is a common pattern in JavaScript based on the idea that functions are first-class citizens; functions can be `return`ed from other functions, can be invoked at any time, and can be passed in as arguments to other functions. When a function is given to another function as an argument for later invocation, that function argument is called a callback. Here's a simple example:

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

Now we've created a wrapper that passes a `state` Object to any functional `Component`. We could implement this in our portfolio right now, although we're going to hold off for a minute. Instead, think about how this might relate to the `addEventListener` function. As you might recall, the second argument to `addEventListener` is a callback function that's executed whenever the first argument (e.g. `click`) occurs. If you understand that, you might be wondering: are there any arguments passed to the event handler/callback when the associated event is triggered? The answer is __yes__, and that argument is an Object called the `event` Object.

---

### `event` Object

Try the following in your developer console:

```javascript
function logEventObject(event) {
  console.log(event);
}

document.body.addEventListener('click', logEventObject);
```

You should now see a very large Object logged to the console whenever you click on a page. Let's take a look at two of the most important properties of this Object.

#### `event.preventDefault`

In a previous exercise, you were tasked with adding event listeners to some of the links in your `Navigation` component. You might have done so like this:

```javascript
document
  .querySelector('#navigation a')
  .addEventListener(
    'click',
    () => console.log('the first link was clicked!')
  );

```

You may have noticed, however, that the default link behavior took over in this case, and that the phrase `the first link was clicked!` was never output to the console. How could we prevent that default anchor tag action of reloading the page? Try something like this:

```javascript
document
  .querySelector('#navigation a')
  .addEventListener(
    'click',
    (event) => {
      event.preventDefault();

      console.log('the first link was clicked!');
    }
  );
```

`preventDefault` is a function that can be invoked to make sure that the built-in event behavior of a particular HTML element doesn't occur. This allows us to change the way that things like anchor tags and forms behave in the context of a Single-Page Application. Try it out in your portfolio project!
